# Requires a local fork of swift-openapi-generator to be checked out as a
# sibling directory named `swift-openapi-generator` (i.e. ../swift-openapi-generator).
# See https://github.com/apple/swift-openapi-generator for the upstream repo.
GENERATOR_DIR    := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))/../swift-openapi-generator
PROJECT_DIR      := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
TYPES_SWIFT      := $(GENERATOR_DIR)/Types.swift
COMPONENTS_SWIFT := $(PROJECT_DIR)/Sources/OpenAI/Public/Schemas/Generated/Components.swift

.PHONY: generate
generate:
	cd "$(GENERATOR_DIR)" && swift run swift-openapi-generator generate \
		--config "$(PROJECT_DIR)/openapi-generator-config.yaml" \
		"$(PROJECT_DIR)/openapi.with-code-samples.yml"
	python3 "$(PROJECT_DIR)/Scripts/extract_components.py" \
		"$(TYPES_SWIFT)" \
		"$(COMPONENTS_SWIFT)"
