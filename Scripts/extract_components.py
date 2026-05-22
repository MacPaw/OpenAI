#!/usr/bin/env python3
"""
Extracts `public enum Components { ... }` from a generated Types.swift and
splices it into Components.swift, preserving the existing file header.
"""

import sys
import re

TYPES_SWIFT = sys.argv[1]   # path to generated Types.swift
COMPONENTS_SWIFT = sys.argv[2]  # path to Components.swift in the project

# --- Extract the Components enum from Types.swift ---

with open(TYPES_SWIFT, "r") as f:
    lines = f.readlines()

start_index = None
for i, line in enumerate(lines):
    if re.match(r"^public enum Components \{", line):
        start_index = i
        break

if start_index is None:
    print("ERROR: could not find 'public enum Components {' in " + TYPES_SWIFT, file=sys.stderr)
    sys.exit(1)

depth = 0
end_index = None
for i in range(start_index, len(lines)):
    depth += lines[i].count("{") - lines[i].count("}")
    if depth == 0:
        end_index = i
        break

if end_index is None:
    print("ERROR: could not find closing brace for Components enum", file=sys.stderr)
    sys.exit(1)

# --- Strip typealiases that shadow Swift built-in type names ---
# The generator emits e.g. `public typealias String = Swift.String` inside nested
# types when a schema property clashes with a Swift built-in. These are always
# redundant and cause "redeclaration" build errors.

SWIFT_BUILTINS = {
    "Bool", "String", "Int", "Double", "Float",
    "UInt", "Character",
    "Int8", "Int16", "Int32", "Int64",
    "UInt8", "UInt16", "UInt32", "UInt64",
}
TYPEALIAS_RE = re.compile(r"^\s+public typealias\s+(\w+)\s*=")

filtered = []
removed = 0
for line in lines[start_index : end_index + 1]:
    m = TYPEALIAS_RE.match(line)
    if m and m.group(1) in SWIFT_BUILTINS:
        removed += 1
        continue
    filtered.append(line)

components_block = "".join(filtered)

# --- Read the existing header from Components.swift (up to and including #endif) ---

with open(COMPONENTS_SWIFT, "r") as f:
    existing = f.readlines()

header_end = None
for i, line in enumerate(existing):
    if line.strip() == "#endif":
        header_end = i
        break

if header_end is None:
    print("ERROR: could not find '#endif' header boundary in " + COMPONENTS_SWIFT, file=sys.stderr)
    sys.exit(1)

header = "".join(existing[: header_end + 1])

# --- Write the result ---

with open(COMPONENTS_SWIFT, "w") as f:
    f.write(header)
    f.write("\n")
    f.write(components_block)
    f.write("\n")

print(f"Written {len(filtered)} lines of Components enum to {COMPONENTS_SWIFT}")
if removed > 0:
    print(
        f"Note: stripped {removed} typealias line(s) that shadow Swift built-in type names "
        f"(e.g. `public typealias String = Swift.String`). "
        f"These are emitted as duplicates by swift-openapi-generator for certain schemas, "
        f"causing 'invalid redeclaration' build errors. "
        f"Check https://github.com/apple/swift-openapi-generator/issues for a related bug report — "
        f"if it has been fixed, this stripping step may no longer be necessary."
    )
