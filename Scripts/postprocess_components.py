#!/usr/bin/env python3
"""Turn the generator's Types+Components+Schemas.swift into the committed Components.swift.

Swift OpenAPI Generator 1.13 writes one file per namespace. This script takes the schemas file and:

1. keeps the existing Components.swift header (everything up to and including `#endif`) and re-wraps the
   generated `extension Components { public enum Schemas { ... } }` as `public enum Components { ... }`,
   adding the empty sibling namespaces the single-file layout used to declare;
2. strips `public typealias String = Swift.String`-style aliases that shadow Swift built-ins; the generator
   emits them for some schemas and they cause "invalid redeclaration" errors;
3. applies the discriminator sidecar written by `transform_openapi.py`: for every discriminated union it appends
   each member's wire values to the generated `case "Name", "#/components/schemas/Name":` line of that union's
   decoder, and for values shared by several members (`message` in `Item` and `ItemResource`) it inserts a
   fallback that tries each member in turn. This is what the generator would do with an explicit `mapping`,
   minus the enum-case renaming a mapping would cause.

The wire values are applied per union, never globally: `message` is unique in `OutputItem` but ambiguous in
`Item`, and adding it to `Item`'s `OutputMessage` case would shadow the fallback.

Usage:
    postprocess_components.py <Types+Components+Schemas.swift> <discriminators.json> <Components.swift>
"""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

SWIFT_BUILTINS = {
    "Bool", "String", "Int", "Double", "Float", "UInt", "Character",
    "Int8", "Int16", "Int32", "Int64", "UInt8", "UInt16", "UInt32", "UInt64",
}
SIBLING_NAMESPACES = ("Parameters", "RequestBodies", "Responses", "Headers")

TYPEALIAS_RE = re.compile(r"^\s+public typealias\s+(\w+)\s*=")
COMPONENTS_START_RE = re.compile(r"^(extension|public enum) Components\s*\{")
CASE_DECL_RE = re.compile(r"^\s*case (\w+)\(Components\.Schemas\.(\w+)\)")
INIT_RE = re.compile(r"public init\(from decoder: any Swift\.Decoder\) throws \{")
DEFAULT_RE = re.compile(r"^\s*default:\s*$")
ERRORS_DECL = "var errors: [any Swift.Error] = []"


def block_range(lines: list[str], start_pattern: re.Pattern[str]) -> range | None:
    """Return the line range of the first block whose opening line matches, using brace depth."""
    start = next((i for i, line in enumerate(lines) if start_pattern.search(line)), None)
    if start is None:
        return None
    depth = 0
    for offset, line in enumerate(lines[start:]):
        depth += line.count("{") - line.count("}")
        if depth == 0:
            return range(start, start + offset + 1)
    return None


def union_enum_range(lines: list[str], name: str) -> range | None:
    return block_range(lines, re.compile(rf"^\s*@frozen public enum {re.escape(name)}: Codable, Hashable, Sendable \{{"))


def component_range(lines: list[str], name: str) -> range | None:
    # Component-level types sit directly inside `public enum Schemas {`, at eight spaces of indentation.
    return block_range(lines, re.compile(rf"^        (@frozen )?public (struct|enum) {re.escape(name)}[:\s]"))


def case_line_pattern(schema: str) -> re.Pattern[str]:
    escaped = re.escape(schema)
    return re.compile(rf'^(\s*)case "{escaped}", "#/components/schemas/{escaped}":\s*$')


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("schemas_swift", type=Path, help="Generated Types+Components+Schemas.swift")
    parser.add_argument("discriminators", type=Path, help="Sidecar written by transform_openapi.py")
    parser.add_argument("components_swift", type=Path, help="Components.swift to update in place")
    args = parser.parse_args()

    existing = args.components_swift.read_text(encoding="utf-8").splitlines(keepends=True)
    header_end = next((i for i, line in enumerate(existing) if line.strip() == "#endif"), None)
    if header_end is None:
        raise SystemExit(f"error: no '#endif' header boundary in {args.components_swift}")
    header = "".join(existing[: header_end + 1])

    generated = args.schemas_swift.read_text(encoding="utf-8").splitlines(keepends=True)
    start = next((i for i, line in enumerate(generated) if COMPONENTS_START_RE.match(line)), None)
    if start is None:
        raise SystemExit(f"error: no 'extension Components' block in {args.schemas_swift}")
    body = generated[start:]
    body[0] = COMPONENTS_START_RE.sub("public enum Components {", body[0], count=1)

    stripped = 0
    kept: list[str] = []
    for line in body:
        match = TYPEALIAS_RE.match(line)
        if match and match.group(1) in SWIFT_BUILTINS:
            stripped += 1
            continue
        kept.append(line)
    body = kept

    discriminators: dict[str, dict[str, dict[str, list[str]]]] = json.loads(args.discriminators.read_text(encoding="utf-8"))
    wire_values_added = 0
    fallbacks = 0
    problems: list[str] = []

    for path, info in discriminators.items():
        owner = path.split("/", 1)[0]
        block = union_enum_range(body, path) if "/" not in path else component_range(body, owner)
        if block is None:
            continue  # this union is outside the generated paths
        for schema, values in info["values"].items():
            pattern = case_line_pattern(schema)
            hits = 0
            for index in block:
                if pattern.match(body[index]):
                    body[index] = re.sub(r":\s*$", ", " + ", ".join(json.dumps(v) for v in values) + ":\n", body[index], count=1)
                    wire_values_added += len(values)
                    hits += 1
            if hits == 0 and "/" not in path:
                problems.append(f"{path}: no generated case for member {schema}")

        if not info["collisions"]:
            continue
        if "/" in path:
            problems.append(f"{path}: colliding values inside a nested union are not supported")
            continue
        block_lines = body[block.start:block.stop]
        case_names = {m.group(2): m.group(1) for line in block_lines if (m := CASE_DECL_RE.match(line))}
        init_index = next((i for i, line in enumerate(block_lines) if INIT_RE.search(line)), None)
        if init_index is None:
            problems.append(f"{path}: no init(from:) found")
            continue
        if not any(ERRORS_DECL in line for line in block_lines):
            indent = re.match(r"^\s*", block_lines[init_index + 1]).group(0)
            block_lines.insert(init_index + 1, f"{indent}{ERRORS_DECL}\n")
        for value, members in info["collisions"].items():
            default_index = next((i for i, line in enumerate(block_lines) if DEFAULT_RE.match(line)), None)
            if default_index is None:
                problems.append(f"{path}: no default: clause in the discriminator switch")
                break
            indent = re.match(r"^\s*", block_lines[default_index]).group(0)
            attempts = []
            for member in members:
                case_name = case_names.get(member)
                if case_name is None:
                    problems.append(f"{path}: no enum case for {member}")
                    break
                attempts.append(
                    f"{indent}    do {{\n"
                    f"{indent}        self = .{case_name}(try .init(from: decoder))\n"
                    f"{indent}        return\n"
                    f"{indent}    }} catch {{\n"
                    f"{indent}        errors.append(error)\n"
                    f"{indent}    }}\n"
                )
            else:
                fallback = (
                    f"{indent}case {json.dumps(value)}:\n" + "".join(attempts)
                    + f"{indent}    throw Swift.DecodingError.failedToDecodeOneOfSchema(\n"
                    + f"{indent}        type: Self.self,\n"
                    + f"{indent}        codingPath: decoder.codingPath,\n"
                    + f"{indent}        errors: errors\n"
                    + f"{indent}    )\n"
                )
                block_lines.insert(default_index, fallback)
                fallbacks += 1
        body[block.start:block.stop] = block_lines

    closing = max(i for i, line in enumerate(body) if re.match(r"^\}\s*$", line))
    for offset, namespace in enumerate(SIBLING_NAMESPACES):
        body.insert(closing + offset, f"    public enum {namespace} {{}}\n")

    args.components_swift.write_text(header + "\n" + "".join(body) + "\n", encoding="utf-8")
    print(
        f"Written {len(body)} lines to {args.components_swift.name}: stripped {stripped} shadowing typealiases, "
        f"added {wire_values_added} discriminator wire values, inserted {fallbacks} collision fallbacks."
    )
    if problems:
        for problem in problems:
            print(f"error: {problem}")
        raise SystemExit(1)


if __name__ == "__main__":
    main()
