#!/usr/bin/env python3
"""Decode `ResponseErrorCode` as an open string instead of a closed enum.

Symptom:
    A `response.failed` stream event whose `response.error.code` is not one of
    the values enumerated in the spec fails to decode, so the client surfaces a
    decoding error instead of the failed response and its human-readable
    message.

Cause:
    The spec declares `ResponseErrorCode` as a string enum and the generator
    emits a `@frozen` Swift enum with one case per value. OpenAI adds codes
    without a spec bump, and OpenAI-compatible servers (for example the Tinfoil
    model router) emit their own codes such as `server_is_overloaded`,
    `model_unavailable`, and `upstream_error`. Any value outside the list is a
    hard decode failure.

Fix:
    Drop the `enum` list from `ResponseErrorCode` in the prepared working copy
    so the property is generated as `Swift.String`. Callers compare against the
    documented string values; unknown values round-trip intact.

Removal condition:
    Remove this workaround if the upstream spec stops enumerating the codes or
    if the generator gains an open-enum option.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


SCHEMA_RE = re.compile(r"^    ResponseErrorCode:[ \t]*(?:\r?\n)?$")
ENUM_KEY_RE = re.compile(r"^      enum:[ \t]*(?:#.*)?(?:\r?\n)?$")
ENUM_ITEM_RE = re.compile(r"^        - [^\s#]+[ \t]*(?:#.*)?(?:\r?\n)?$")
SCHEMA_KEY_RE = re.compile(r"^    [^\s]")


def open_response_error_code(document: str) -> tuple[str, int]:
    """Return the document with the ResponseErrorCode enum list removed."""

    lines = document.splitlines(keepends=True)
    starts = [index for index, line in enumerate(lines) if SCHEMA_RE.match(line)]
    if len(starts) != 1:
        raise ValueError(
            f"Expected exactly one ResponseErrorCode schema; found {len(starts)}."
        )

    start = starts[0]
    end = next(
        (i for i in range(start + 1, len(lines)) if SCHEMA_KEY_RE.match(lines[i])),
        len(lines),
    )
    enum_starts = [i for i in range(start, end) if ENUM_KEY_RE.match(lines[i])]
    if not enum_starts:
        return document, 0
    if len(enum_starts) != 1:
        raise ValueError("Expected at most one enum list under ResponseErrorCode.")

    enum_start = enum_starts[0]
    enum_end = enum_start + 1
    while enum_end < end and ENUM_ITEM_RE.match(lines[enum_end]):
        enum_end += 1
    removed = enum_end - enum_start
    del lines[enum_start:enum_end]
    return "".join(lines), removed


def report_result(removed_lines: int) -> None:
    if removed_lines:
        print(
            f"open_response_error_code: removed {removed_lines} enum line(s) "
            "from ResponseErrorCode"
        )
    else:
        print("open_response_error_code: ResponseErrorCode has no enum list (no-op)")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("input", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()

    document, removed = open_response_error_code(args.input.read_text())
    args.output.write_text(document)
    report_result(removed)


if __name__ == "__main__":
    main()
