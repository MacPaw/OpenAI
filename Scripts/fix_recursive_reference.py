#!/usr/bin/env python3
"""Replace unsupported `$recursiveRef` references with ordinary component references.

Symptom:
    Validation warns that a filter schema's union member contains nothing but
    unsupported attributes, and the recursion is lost in the generated types.

Cause:
    Swift OpenAPI Generator does not support JSON Schema `$recursiveRef`.

Fix:
    Replace every `$recursiveRef: '#'` with `$ref: '#/components/schemas/<Name>'`,
    where `<Name>` is the component schema that contains the reference. The spec
    uses this construct only inside self-recursive components (`CompoundFilter`,
    and since September 2026 also `BetaCompoundFilter`), so the enclosing
    component is the intended target.

Semantic limitation:
    This is not a general equivalent of `$recursiveRef`. `$recursiveRef` can
    resolve through the active recursive-anchor scope, while `$ref` always
    targets the named component. They behave the same here because each
    occurrence sits inside the component it recurses into. Reassess this
    workaround if a reference appears outside its own component, in an external
    schema, or in recursive extension/composition.

Removal condition:
    Remove this workaround when the generator supports `$recursiveRef`, or when
    the upstream spec no longer contains it. With no occurrences it is a no-op.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


OLD_REFERENCE = "$recursiveRef: '#'"
COMPONENT_SCHEMA_RE = re.compile(r"^    (?P<name>[^\s][^:]*):(?:\r?\n)?$")


def fix_recursive_reference(document: str) -> tuple[str, int]:
    """Return the document with each recursive reference pointed at its component."""

    lines = document.splitlines(keepends=True)
    current_component: str | None = None
    count = 0
    for index, line in enumerate(lines):
        match = COMPONENT_SCHEMA_RE.match(line)
        if match is not None:
            current_component = match.group("name")
        if OLD_REFERENCE not in line:
            continue
        if current_component is None:
            raise ValueError(
                f"Cannot fix `$recursiveRef` on line {index + 1}: it is not inside a component schema."
            )
        lines[index] = line.replace(
            OLD_REFERENCE, f"$ref: '#/components/schemas/{current_component}'"
        )
        count += 1
    return "".join(lines), count


def report_result(replacement_count: int) -> None:
    if replacement_count:
        print(f"Recursive reference workaround applied: {replacement_count} replacement(s).")
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
