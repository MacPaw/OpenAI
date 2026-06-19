#!/usr/bin/env python3
"""Replace the unsupported CompoundFilter recursive reference.

Symptom:
    Validation warns that CompoundFilter's second item union member contains
    nothing but unsupported attributes.

Cause:
    Swift OpenAPI Generator does not support JSON Schema `$recursiveRef`.

Fix:
    Replace the one known `$recursiveRef: '#'` with an ordinary component
    reference to `CompoundFilter`, preserving the intended recursion.

Semantic limitation:
    This is not a general equivalent of `$recursiveRef`. `$recursiveRef` can
    resolve through the active recursive-anchor scope, while `$ref` always
    targets the named `CompoundFilter` component. They behave the same for this
    self-contained document because CompoundFilter is the only recursive anchor
    and the reference represents nested CompoundFilter values. Reassess this
    workaround if the schema gains another recursive anchor, an external schema,
    or recursive extension/composition.

Removal condition:
    Remove this workaround when the generator supports `$recursiveRef`, or when
    the upstream spec no longer contains this exact reference.
"""

from __future__ import annotations

import argparse
from pathlib import Path


OLD_REFERENCE = "$recursiveRef: '#'"
NEW_REFERENCE = "$ref: '#/components/schemas/CompoundFilter'"


def fix_recursive_reference(document: str) -> tuple[str, int]:
    count = document.count(OLD_REFERENCE)
    if count > 1:
        raise ValueError(
            "Expected at most one CompoundFilter recursive reference; "
            f"found {count}."
        )
    return document.replace(OLD_REFERENCE, NEW_REFERENCE), count


def report_result(replacement_count: int) -> None:
    if replacement_count:
        print("Recursive reference workaround applied: 1 replacement.")
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
