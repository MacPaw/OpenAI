#!/usr/bin/env python3
"""Convert OpenAPI 3.0 boolean exclusiveMinimum syntax to OpenAPI 3.1.

Symptom:
    "Expected `exclusiveMinimum` value ... to be parsable as Double but it was
    not."

Cause:
    The document declares OpenAPI 3.1 but contains the OpenAPI 3.0 form:
    `minimum: X` together with `exclusiveMinimum: true`. In OpenAPI 3.1,
    `exclusiveMinimum` itself must contain the numeric boundary.

Fix:
    Convert `minimum: X` plus `exclusiveMinimum: true` to
    `exclusiveMinimum: X`. A false boolean is removed while its inclusive
    `minimum` remains unchanged.

Removal condition:
    When no boolean exclusiveMinimum values remain upstream, this script is a
    no-op. It can be removed from prepare_openapi.py after generation is
    verified with the new spec.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


BOOLEAN_EXCLUSIVE_MINIMUM_RE = re.compile(
    r"^(?P<indent>\s*)exclusiveMinimum:\s*(?P<value>true|false)"
    r"[ \t]*(?:#.*)?(?P<newline>\r?\n)?$"
)
NUMERIC_MINIMUM_RE = re.compile(
    r"^(?P<indent>\s*)minimum:\s*"
    r"(?P<value>[-+]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][-+]?\d+)?)"
    r"[ \t]*(?:#.*)?(?:\r?\n)?$"
)


def fix_boolean_exclusive_minimum(document: str) -> tuple[str, int]:
    """Return an OpenAPI 3.1-compatible document and conversion count."""

    lines = document.splitlines(keepends=True)
    replacement_count = 0

    for index, line in enumerate(lines):
        exclusive_match = BOOLEAN_EXCLUSIVE_MINIMUM_RE.match(line)
        if exclusive_match is None:
            continue

        replacement_count += 1
        if exclusive_match.group("value") == "false":
            lines[index] = ""
            continue

        indent = exclusive_match.group("indent")
        minimum_index = None
        minimum_value = None

        # Find a preceding `minimum` sibling in this schema. Other siblings,
        # such as `maximum`, may appear between the two constraints.
        for candidate_index in range(index - 1, -1, -1):
            candidate = lines[candidate_index]
            if not candidate.strip() or candidate.lstrip().startswith("#"):
                continue

            candidate_indent = candidate[: len(candidate) - len(candidate.lstrip())]
            if len(candidate_indent) < len(indent):
                break

            minimum_match = NUMERIC_MINIMUM_RE.match(candidate)
            if minimum_match and minimum_match.group("indent") == indent:
                minimum_index = candidate_index
                minimum_value = minimum_match.group("value")
                break

        if minimum_index is None or minimum_value is None:
            line_number = index + 1
            raise ValueError(
                "Cannot convert `exclusiveMinimum: true` on line "
                f"{line_number}: no numeric sibling `minimum` was found."
            )

        newline = exclusive_match.group("newline") or ""
        lines[minimum_index] = ""
        lines[index] = f"{indent}exclusiveMinimum: {minimum_value}{newline}"

    return "".join(lines), replacement_count


def report_result(replacement_count: int) -> None:
    if replacement_count:
        print(
            "Boolean exclusiveMinimum workaround applied: "
            f"{replacement_count} replacement(s)."
        )
    else:
        print(
            "Boolean exclusiveMinimum workaround not needed. The upstream spec "
            "may be fixed; consider removing this workaround after generation "
            "succeeds."
        )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="Input OpenAPI document")
    parser.add_argument("output", type=Path, help="Fixed OpenAPI document")
    args = parser.parse_args()

    document = args.input.read_text(encoding="utf-8")
    fixed_document, replacement_count = fix_boolean_exclusive_minimum(document)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(fixed_document, encoding="utf-8")
    report_result(replacement_count)


if __name__ == "__main__":
    main()
