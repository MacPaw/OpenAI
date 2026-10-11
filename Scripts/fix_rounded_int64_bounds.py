#!/usr/bin/env python3
"""Fix rounded Int64 constraints in an OpenAPI document.

Symptom:
    "Expected an Integer literal but found a floating point value
    (9.223372036854776e+18)" while parsing an integer minimum/maximum.

Cause:
    The spec contains 9223372036854776000 and -9223372036854776000. Those
    rounded values lie just outside Swift's Int64 range, so the YAML parser
    represents them as floating point values before the generator validates
    the integer schema.

Fix:
    Replace only those exact constraint values with Int64.max and Int64.min.

Removal condition:
    When neither rounded value is present upstream, this script is a no-op. It
    can be removed from prepare_openapi.py after generation is verified with
    the new spec.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


ROUNDED_INT64_BOUNDS = {
    "-9223372036854776000": "-9223372036854775808",
    "9223372036854776000": "9223372036854775807",
}

# Match YAML constraint lines rather than replacing the same digits in examples,
# descriptions, or unrelated extension data.
CONSTRAINT_RE = re.compile(
    r"^(?P<prefix>\s*(?:minimum|maximum):\s*)"
    r"(?P<value>-?9223372036854776000)"
    r"(?P<suffix>\s*(?:#.*)?(?:\r?\n)?)$",
    re.MULTILINE,
)


def fix_rounded_int64_bounds(document: str) -> tuple[str, int]:
    """Return the normalized document and the number of replaced constraints."""

    def replace(match: re.Match[str]) -> str:
        value = ROUNDED_INT64_BOUNDS[match.group("value")]
        return f'{match.group("prefix")}{value}{match.group("suffix")}'

    return CONSTRAINT_RE.subn(replace, document)


def report_result(replacement_count: int) -> None:
    if replacement_count:
        print(
            "Rounded Int64 bounds workaround applied: "
            f"{replacement_count} replacement(s)."
        )
    else:
        print(
            "Rounded Int64 bounds workaround not needed. The upstream spec may "
            "be fixed; consider removing this workaround after generation succeeds."
        )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="Input OpenAPI document")
    parser.add_argument("output", type=Path, help="Fixed OpenAPI document")
    args = parser.parse_args()

    document = args.input.read_text(encoding="utf-8")
    fixed_document, replacement_count = fix_rounded_int64_bounds(document)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(fixed_document, encoding="utf-8")
    report_result(replacement_count)


if __name__ == "__main__":
    main()
