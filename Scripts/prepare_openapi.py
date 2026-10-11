#!/usr/bin/env python3
"""Apply the documented OpenAPI workarounds required before generation.

Each workaround lives in its own independently runnable script. Keep this file
as the ordered pipeline only: read the upstream spec, apply every conditional
transformation in memory, then write one prepared copy for the generator.
"""

from __future__ import annotations

import argparse
import difflib
from pathlib import Path

from fix_boolean_exclusive_minimum import (
    fix_boolean_exclusive_minimum,
    report_result as report_boolean_exclusive_minimum_result,
)
from fix_rounded_int64_bounds import (
    fix_rounded_int64_bounds,
    report_result as report_rounded_int64_bounds_result,
)
from fix_recursive_reference import (
    fix_recursive_reference,
    report_result as report_recursive_reference_result,
)
from remove_unsupported_webhooks import (
    remove_unsupported_webhooks,
    report_result as report_unsupported_webhooks_result,
)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Create a generator-compatible working copy of an OpenAPI spec."
    )
    parser.add_argument("input", type=Path, help="Upstream OpenAPI document")
    parser.add_argument("output", type=Path, help="Prepared working copy")
    parser.add_argument(
        "--diff-output", type=Path, help="Write a unified diff of input and output"
    )
    args = parser.parse_args()

    original_document = args.input.read_text(encoding="utf-8")
    document = original_document

    document, int64_replacement_count = fix_rounded_int64_bounds(document)
    report_rounded_int64_bounds_result(int64_replacement_count)

    document, exclusive_minimum_replacement_count = fix_boolean_exclusive_minimum(
        document
    )
    report_boolean_exclusive_minimum_result(exclusive_minimum_replacement_count)

    document, webhook_removal_count = remove_unsupported_webhooks(document)
    report_unsupported_webhooks_result(webhook_removal_count)

    document, recursive_reference_replacement_count = fix_recursive_reference(document)
    report_recursive_reference_result(recursive_reference_replacement_count)

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(document, encoding="utf-8")

    if args.diff_output is not None:
        diff = difflib.unified_diff(
            original_document.splitlines(keepends=True),
            document.splitlines(keepends=True),
            fromfile=str(args.input),
            tofile=str(args.output),
        )
        args.diff_output.parent.mkdir(parents=True, exist_ok=True)
        args.diff_output.write_text("".join(diff), encoding="utf-8")
        print(f"Prepared OpenAPI diff written to: {args.diff_output.resolve()}")


if __name__ == "__main__":
    main()
