#!/usr/bin/env python3
"""Replace unsupported top-level-schema recursive references.

Symptom:
    Validation warns that a filter schema's recursive union member contains
    nothing but unsupported attributes.

Cause:
    Swift OpenAPI Generator does not support JSON Schema `$recursiveRef`.

Fix:
    Replace each `$recursiveRef: '#'` (or `"#"`) with an ordinary component
    reference to the enclosing top-level component schema, preserving the
    intended recursion. The upstream spec currently contains two such
    occurrences: one inside `CompoundFilter`, one inside `BetaCompoundFilter`.

Semantic limitation:
    This is not a general equivalent of `$recursiveRef`. `$recursiveRef` can
    resolve through the active recursive-anchor scope, while `$ref` always
    targets the enclosing top-level component. They behave the same here
    because each affected component is the only recursive anchor within
    itself and the reference represents nested values of that same component.
    Reassess this workaround if a `$recursiveRef` appears nested inside more
    than one component schema, references an external schema, or is used with
    recursive extension/composition.

Removal condition:
    Remove this workaround when the generator supports `$recursiveRef`, or when
    the upstream spec no longer contains any `$recursiveRef` occurrences.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


COMPONENT_SCHEMA_RE = re.compile(r"^    (?P<name>[^\s][^:]*):(?:\r?\n)?$")
# The reference is typically a YAML sequence item (`- $recursiveRef: "#"`), so
# match everything before the key as an opaque prefix rather than assuming no
# `- ` marker.
RECURSIVE_REF_RE = re.compile(
    r"^(?P<prefix>\s*(?:-\s+)?)\$recursiveRef:\s*(?P<quote>['\"])#(?P=quote)"
    r"[ \t]*(?:#.*)?(?P<newline>\r?\n)?$"
)


def fix_recursive_reference(document: str) -> tuple[str, int]:
    lines = document.splitlines(keepends=True)
    schema_starts = [
        (index, match.group("name"))
        for index, line in enumerate(lines)
        if (match := COMPONENT_SCHEMA_RE.match(line)) is not None
    ]

    replacement_count = 0
    for index, line in enumerate(lines):
        match = RECURSIVE_REF_RE.match(line)
        if match is None:
            continue

        enclosing_schema = next(
            (name for start, name in reversed(schema_starts) if start < index),
            None,
        )
        if enclosing_schema is None:
            raise ValueError(
                f"Cannot resolve recursive reference on line {index + 1}: no "
                "enclosing component schema found."
            )

        quote = match.group("quote")
        prefix = match.group("prefix")
        newline = match.group("newline") or ""
        lines[index] = (
            f"{prefix}$ref: {quote}#/components/schemas/{enclosing_schema}{quote}"
            f"{newline}"
        )
        replacement_count += 1

    return "".join(lines), replacement_count


def report_result(replacement_count: int) -> None:
    if replacement_count:
        print(
            "Recursive reference workaround applied: "
            f"{replacement_count} replacement(s)."
        )
    else:
        print(
            "Recursive reference workaround not needed. The upstream spec or "
            "generator may be fixed; consider removing this workaround after "
            "generation succeeds."
        )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    document, count = fix_recursive_reference(args.input.read_text(encoding="utf-8"))
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(document, encoding="utf-8")
    report_result(count)


if __name__ == "__main__":
    main()
