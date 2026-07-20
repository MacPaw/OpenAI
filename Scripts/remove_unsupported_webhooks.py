#!/usr/bin/env python3
"""Remove unsupported top-level webhooks before Swift code generation.

Symptom:
    Validation reports that JSONSchema references under `.webhooks...` cannot
    be found in `components/schemas`, even though they exist in the source spec.

Cause:
    Swift OpenAPI Generator's document filter keeps the top-level `webhooks`
    section while rebuilding `components` with only schemas required by the
    configured paths and explicit schemas. That leaves webhook references
    dangling. This generator version does not generate webhook operations.

Fix:
    Remove exactly the top-level `webhooks` block from the prepared working
    copy. The downloaded source spec remains unchanged.

Removal condition:
    Remove this workaround if a future generator supports or correctly filters
    OpenAPI webhooks. If the upstream spec contains no top-level webhooks, this
    script is a no-op.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


WEBHOOKS_KEY_RE = re.compile(r"^webhooks:[ \t]*(?:#.*)?(?:\r?\n)?$")
TOP_LEVEL_KEY_RE = re.compile(r"^[A-Za-z0-9_.-]+:")


def remove_unsupported_webhooks(document: str) -> tuple[str, int]:
    """Return the document without its top-level webhooks block."""

    lines = document.splitlines(keepends=True)
    starts = [index for index, line in enumerate(lines) if WEBHOOKS_KEY_RE.match(line)]

    if not starts:
        return document, 0
    if len(starts) > 1:
        raise ValueError("Cannot remove webhooks: multiple top-level `webhooks` keys found.")

    start = starts[0]
    end = len(lines)
    for index in range(start + 1, len(lines)):
        line = lines[index]
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        if TOP_LEVEL_KEY_RE.match(line):
            end = index
            break

    del lines[start:end]
    return "".join(lines), 1


def report_result(removal_count: int) -> None:
    if removal_count:
        print("Unsupported webhooks workaround applied: removed 1 top-level block.")
    else:
        print(
            "Unsupported webhooks workaround not needed. The upstream spec may "
            "no longer contain webhooks; consider removing this workaround after "
            "generation succeeds."
        )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="Input OpenAPI document")
    parser.add_argument("output", type=Path, help="Fixed OpenAPI document")
    args = parser.parse_args()

    document = args.input.read_text(encoding="utf-8")
    fixed_document, removal_count = remove_unsupported_webhooks(document)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(fixed_document, encoding="utf-8")
    report_result(removal_count)


if __name__ == "__main__":
    main()
