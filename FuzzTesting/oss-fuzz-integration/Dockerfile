# OSS-Fuzz build image for MacPaw/OpenAI.
#
# Apply (alongside build.sh and project.yaml) at
# `projects/macpaw-openai/Dockerfile` in a fork of
# https://github.com/google/oss-fuzz.

FROM gcr.io/oss-fuzz-base/base-builder-swift

# Clone the SDK under $SRC so build.sh can `cd` into it. OSS-Fuzz pins
# the commit per-run from project.yaml; here we just default to main.
RUN git clone --depth=1 https://github.com/MacPaw/OpenAI.git $SRC/OpenAI

WORKDIR $SRC/OpenAI

COPY build.sh $SRC/
