#!/bin/bash -eu
#
# OSS-Fuzz build script for MacPaw/OpenAI.
#
# Apply at `projects/macpaw-openai/build.sh` in a fork of
# https://github.com/google/oss-fuzz.
#
# Builds each libFuzzer harness declared in `FuzzTesting/Package.swift`
# and copies the binary plus a zipped seed corpus into $OUT.
#
# Invoked by OSS-Fuzz with the standard environment:
#   $SRC                project source root
#   $OUT                output directory the platform expects binaries in
#   $CFLAGS / $CXXFLAGS sanitizer flags
#   $LIB_FUZZING_ENGINE static archive providing libFuzzer main

cd "$SRC/OpenAI/FuzzTesting"

HARNESSES=(
  FuzzResponseStreamEventDecoder
  FuzzChatResultDecoder
  FuzzChatStreamResultDecoder
  FuzzResponseObjectDecoder
  FuzzAudioTranscriptionStreamResultDecoder
)

# `-DFUZZING_ENABLED` removes the in-source `@main` replay entry point
# so libFuzzer's own main (provided via -sanitize=fuzzer) drives
# `LLVMFuzzerTestOneInput`.
SWIFT_FLAGS=(
  -Xswiftc -sanitize=fuzzer,address
  -Xswiftc -parse-as-library
  -Xswiftc -DFUZZING_ENABLED
)

swift build -c debug "${SWIFT_FLAGS[@]}"

for harness in "${HARNESSES[@]}"; do
  cp ".build/debug/${harness}" "$OUT/${harness}"

  corpus_dir="FuzzCorpus/${harness}"
  if [ -d "$corpus_dir" ]; then
    (cd "$corpus_dir" && zip -q -r "$OUT/${harness}_seed_corpus.zip" .)
  fi
done
