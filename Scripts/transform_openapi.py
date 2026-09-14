#!/usr/bin/env python3
"""Rewrite the prepared OpenAPI document so the stock Swift OpenAPI Generator produces the types we need.

This step replaces the patches that used to live in a private fork of swift-openapi-generator. It runs after
`prepare_openapi.py` and `remove_required_properties.py` (which are line-based and keep the document text
intact) and before the generator. It reads and writes YAML through PyYAML, so its output is a working copy
for the generator only and is never committed.

1. Nullability.
   OpenAI expresses "nullable" as `anyOf: [X, {type: 'null'}]`. Swift OpenAPI Generator does not support that
   form (apple/swift-openapi-generator#906) and *skips* every such property with "Schema null is not supported".
   The upstream maintainer's recommended workaround is applied here: the null branch is dropped, the `anyOf`
   collapses to X (or to the remaining `anyOf` when several non-null members exist), and the property is removed
   from the enclosing `required` list so it is generated as optional. A property that references a component
   which is nullable at its root (for example `ResponseError`) is removed from `required` for the same reason:
   `null` is a valid value for it on the wire.

2. Discriminators.
   Every `oneOf` with `discriminator: {propertyName: type}` lacks a `mapping`, so the generator compares the
   schema *name* with the wire value and fails to decode real payloads (openai/openai-openapi#542). Adding a
   `mapping` is not an option: the generator then names enum cases after the mapping keys, which renames public
   API. Instead this script records, for every discriminated union (component-level or nested), each member's
   wire values, taken from the member's discriminator property (`enum`, `const`, or `x-stainless-const`,
   resolved through `$ref` and `allOf`), and the values that several members share. `postprocess_components.py`
   applies them to the generated Swift.

Usage:
    transform_openapi.py <prepared.yaml> <transformed.yaml> <discriminators.json>
"""

from __future__ import annotations

import argparse
import json
from collections import Counter
from pathlib import Path
from typing import Any

import yaml

Loader = getattr(yaml, "CSafeLoader", yaml.SafeLoader)
Dumper = getattr(yaml, "CSafeDumper", yaml.SafeDumper)

REF_PREFIX = "#/components/schemas/"


def is_null_schema(member: Any) -> bool:
    if not isinstance(member, dict):
        return False
    # `type: 'null'` is the form OpenAI uses; a bare unquoted `type: null` parses to None.
    return member.get("type") == "null" or (list(member) == ["type"] and member["type"] is None)


def has_null_member(node: Any) -> bool:
    return isinstance(node, dict) and isinstance(node.get("anyOf"), list) and any(
        is_null_schema(m) for m in node["anyOf"]
    )


def ref_name(node: Any) -> str | None:
    if isinstance(node, dict) and isinstance(node.get("$ref"), str) and node["$ref"].startswith(REF_PREFIX):
        return node["$ref"][len(REF_PREFIX):]
    return None


class Transformer:
    def __init__(self, schemas: dict[str, Any]) -> None:
        self.schemas = schemas
        self.stats: Counter[str] = Counter()
        self.root_nullable = {name for name, schema in schemas.items() if has_null_member(schema)}
        self.stats["root_nullable_schemas"] = len(self.root_nullable)
        self.discriminators: dict[str, dict[str, Any]] = {}

    # -- nullability ---------------------------------------------------------------------------------------

    def strip_null(self, node: dict[str, Any]) -> dict[str, Any]:
        members = [m for m in node["anyOf"] if not is_null_schema(m)]
        if len(members) == len(node["anyOf"]):
            return node
        self.stats["nullable_anyof"] += 1
        rest = {k: v for k, v in node.items() if k != "anyOf"}
        if len(members) == 1:
            member = members[0]
            if "$ref" in member:
                collapsed: dict[str, Any] = {"$ref": member["$ref"]}
                if "description" in rest:
                    collapsed["description"] = rest["description"]
                return collapsed
            # Inline member: it wins over the wrapper's keys, the wrapper's description/default are kept.
            return {**rest, **member}
        return {**rest, "anyOf": members}

    def property_is_nullable(self, schema: Any) -> bool:
        if not isinstance(schema, dict):
            return False
        if has_null_member(schema):
            return True
        if ref_name(schema) in self.root_nullable:
            return True
        if isinstance(schema.get("anyOf"), list):
            members = [m for m in schema["anyOf"] if not is_null_schema(m)]
            if len(members) == 1 and ref_name(members[0]) in self.root_nullable:
                return True
        return False

    def walk(self, node: Any) -> Any:
        if isinstance(node, list):
            return [self.walk(item) for item in node]
        if not isinstance(node, dict):
            return node
        if isinstance(node.get("anyOf"), list):
            node = self.strip_null(node)
        properties = node.get("properties")
        if isinstance(properties, dict) and isinstance(node.get("required"), list):
            nullable = {name for name, schema in properties.items() if self.property_is_nullable(schema)}
            if nullable:
                before = len(node["required"])
                node = dict(node)
                node["required"] = [name for name in node["required"] if name not in nullable]
                self.stats["required_relaxed"] += before - len(node["required"])
                if not node["required"]:
                    del node["required"]
        return {key: self.walk(value) for key, value in node.items()}

    # -- discriminators ------------------------------------------------------------------------------------

    def resolve(self, node: Any) -> Any:
        for _ in range(10):
            name = ref_name(node)
            if name is None:
                break
            node = self.schemas.get(name)
        return node

    def discriminator_values(self, member: Any, property_name: str) -> list[str]:
        schema = self.resolve(member)
        if not isinstance(schema, dict):
            return []
        properties: dict[str, Any] = {}
        for part in schema.get("allOf") or []:
            resolved = self.resolve(part)
            if isinstance(resolved, dict):
                properties.update(resolved.get("properties") or {})
        properties.update(schema.get("properties") or {})
        declared = self.resolve(properties.get(property_name))
        if not isinstance(declared, dict):
            return []
        if isinstance(declared.get("enum"), list):
            return [str(value) for value in declared["enum"]]
        for key in ("const", "x-stainless-const"):
            if key in declared:
                return [str(declared[key])]
        return []

    def collect(self, node: Any, path: str) -> None:
        if isinstance(node, list):
            for index, item in enumerate(node):
                self.collect(item, f"{path}[{index}]")
            return
        if not isinstance(node, dict):
            return
        discriminator = node.get("discriminator")
        if isinstance(node.get("oneOf"), list) and isinstance(discriminator, dict) and not discriminator.get("mapping"):
            property_name = discriminator["propertyName"]
            by_value: dict[str, list[str]] = {}
            for member in node["oneOf"]:
                name = ref_name(member)
                if name is None:
                    continue
                for value in self.discriminator_values(member, property_name):
                    members = by_value.setdefault(value, [])
                    if name not in members:
                        members.append(name)
            values: dict[str, list[str]] = {}
            collisions: dict[str, list[str]] = {}
            for value, members in by_value.items():
                if len(members) == 1:
                    values.setdefault(members[0], []).append(value)
                else:
                    collisions[value] = members
            self.stats["unions"] += 1
            self.stats["wire_values"] += sum(len(v) for v in values.values())
            self.stats["collisions"] += len(collisions)
            self.discriminators[path] = {"values": values, "collisions": collisions}
        for key, value in node.items():
            self.collect(value, f"{path}/{key}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("input", type=Path, help="Prepared OpenAPI document")
    parser.add_argument("output", type=Path, help="Transformed working copy for the generator")
    parser.add_argument("discriminators", type=Path, help="JSON sidecar consumed by postprocess_components.py")
    args = parser.parse_args()

    with args.input.open(encoding="utf-8") as handle:
        spec = yaml.load(handle, Loader=Loader)

    transformer = Transformer(spec["components"]["schemas"])
    spec["components"]["schemas"] = transformer.walk(spec["components"]["schemas"])
    transformer.schemas = spec["components"]["schemas"]
    for name, schema in spec["components"]["schemas"].items():
        transformer.collect(schema, name)

    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", encoding="utf-8") as handle:
        yaml.dump(spec, handle, Dumper=Dumper, sort_keys=False, allow_unicode=True, width=4096)
    args.discriminators.write_text(json.dumps(transformer.discriminators, indent=2) + "\n", encoding="utf-8")

    stats = transformer.stats
    print(
        "Transform applied: "
        f"{stats['nullable_anyof']} nullable anyOf collapsed, {stats['required_relaxed']} required entries relaxed "
        f"({stats['root_nullable_schemas']} root-nullable components), {stats['unions']} discriminated unions with "
        f"{stats['wire_values']} wire values and {stats['collisions']} colliding values."
    )
    collisions = {
        path: info["collisions"] for path, info in transformer.discriminators.items() if info["collisions"]
    }
    for path, values in collisions.items():
        for value, members in values.items():
            print(f"  collision: {path} value {value!r} -> {' | '.join(members)}")


if __name__ == "__main__":
    main()
