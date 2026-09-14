# Regenerates Sources/OpenAI/Public/Schemas/Generated/Components.swift from openapi.yaml.
#
# No fork of Swift OpenAPI Generator and no sibling checkout are required. The pinned generator release is
# cloned and built under .build/, and the Python dependency (PyYAML) is installed into a virtualenv there.
# Prerequisites: a Swift toolchain, python3 with venv, and network access on the first run.
#
# Pipeline (details in CONTRIBUTING.md, "Implementing using Code Generation"):
#   1. Scripts/prepare_openapi.py             conditional, line-based spec fixes (each script documents its removal
#                                             condition); the combined diff is written to .build/openapi-generator/openapi.patch
#   2. Scripts/remove_required_properties.py  `required` entries the live API does not honour (see below)
#   3. Scripts/transform_openapi.py           nullable `anyOf` -> optional properties; discriminator wire values recorded
#                                             (replaces the patches that used to live in a private generator fork)
#   4. swift-openapi-generator                types only, paths and schemas from openapi-generator-config.yaml
#   5. Scripts/postprocess_components.py      re-wraps the output under the existing header, appends the wire values,
#                                             adds the collision fallbacks -> Components.swift
#
# Expected generator diagnostics: "A property name only appears in the required list, but not in the properties
# map" for InputMessageResource/value2/type and Response/value3/{metadata, model, temperature, tool_choice, tools,
# top_p}. Those properties are declared by a sibling allOf member; the generator validates each member alone and
# the properties remain available through the sibling payload. Harmless.

PROJECT_DIR       := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
BUILD_DIR         := $(PROJECT_DIR)/.build/openapi-generator

GENERATOR_VERSION := 1.13.1
GENERATOR_REPO    := https://github.com/apple/swift-openapi-generator
GENERATOR_DIR     := $(BUILD_DIR)/swift-openapi-generator-$(GENERATOR_VERSION)
# Override on the command line to use an already built generator: make generate GENERATOR_BIN=/path/to/binary
GENERATOR_BIN     ?= $(GENERATOR_DIR)/.build/release/swift-openapi-generator

VENV              := $(BUILD_DIR)/venv
PYTHON            := $(VENV)/bin/python

SPEC              := $(PROJECT_DIR)/openapi.yaml
CONFIG            := $(PROJECT_DIR)/openapi-generator-config.yaml
COMPONENTS_SWIFT  := $(PROJECT_DIR)/Sources/OpenAI/Public/Schemas/Generated/Components.swift
PREPARED_OPENAPI  := $(BUILD_DIR)/openapi.prepared.yaml
TRANSFORMED_OPENAPI := $(BUILD_DIR)/openapi.transformed.yaml
DISCRIMINATORS    := $(BUILD_DIR)/discriminators.json
OPENAPI_DIFF      := $(BUILD_DIR)/openapi.patch
GENERATED_DIR     := $(BUILD_DIR)/generated

.PHONY: generate generator-version clean-generation

generate: $(PYTHON) $(GENERATOR_BIN)
	$(PYTHON) -B "$(PROJECT_DIR)/Scripts/prepare_openapi.py" "$(SPEC)" "$(PREPARED_OPENAPI)"
	# LocalShellToolCallOutput, the MCP approval responses and the response audio events list properties as
	# required that they never declare; the generator would otherwise warn and skip them.
	# WebSearchActionSearch/query is declared but no longer sent by the live API (fixed upstream in July 2026,
	# openai/openai-openapi#544); drop this entry when the vendored spec is updated past that fix.
	$(PYTHON) -B "$(PROJECT_DIR)/Scripts/remove_required_properties.py" \
		"$(PREPARED_OPENAPI)" \
		"$(PREPARED_OPENAPI)" \
		--remove-required "LocalShellToolCallOutput" "call_id" \
		--remove-required "MCPApprovalResponse" "request_id" \
		--remove-required "MCPApprovalResponseResource" "request_id" \
		--remove-required "ResponseAudioDoneEvent" "response_id" \
		--remove-required "ResponseAudioTranscriptDeltaEvent" "response_id" \
		--remove-required "ResponseAudioTranscriptDoneEvent" "response_id" \
		--remove-required "WebSearchActionSearch" "query" \
		--diff-source "$(SPEC)" \
		--diff-output "$(OPENAPI_DIFF)"
	$(PYTHON) -B "$(PROJECT_DIR)/Scripts/transform_openapi.py" "$(PREPARED_OPENAPI)" "$(TRANSFORMED_OPENAPI)" "$(DISCRIMINATORS)"
	rm -rf "$(GENERATED_DIR)" && mkdir -p "$(GENERATED_DIR)"
	"$(GENERATOR_BIN)" generate --config "$(CONFIG)" --output-directory "$(GENERATED_DIR)" "$(TRANSFORMED_OPENAPI)"
	$(PYTHON) -B "$(PROJECT_DIR)/Scripts/postprocess_components.py" "$(GENERATED_DIR)/Types+Components+Schemas.swift" "$(DISCRIMINATORS)" "$(COMPONENTS_SWIFT)"

$(PYTHON): $(PROJECT_DIR)/Scripts/requirements.txt
	python3 -m venv "$(VENV)"
	"$(PYTHON)" -m pip install --quiet --disable-pip-version-check -r "$(PROJECT_DIR)/Scripts/requirements.txt"
	touch "$(PYTHON)"

$(GENERATOR_DIR)/.build/release/swift-openapi-generator:
	rm -rf "$(GENERATOR_DIR)"
	git clone --quiet --depth 1 --branch "$(GENERATOR_VERSION)" "$(GENERATOR_REPO)" "$(GENERATOR_DIR)"
	cd "$(GENERATOR_DIR)" && swift build -c release --product swift-openapi-generator

# Used by the Generation workflow to key its cache of the built generator.
generator-version:
	@echo $(GENERATOR_VERSION)

clean-generation:
	rm -rf "$(BUILD_DIR)"
