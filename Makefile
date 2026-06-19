# Requires a local fork of swift-openapi-generator to be checked out as a
# sibling directory named `swift-openapi-generator` (i.e. ../swift-openapi-generator).
# See https://github.com/apple/swift-openapi-generator for the upstream repo.
GENERATOR_DIR    := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))/../swift-openapi-generator
PROJECT_DIR      := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
TYPES_SWIFT      := $(GENERATOR_DIR)/Types.swift
COMPONENTS_SWIFT := $(PROJECT_DIR)/Sources/OpenAI/Public/Schemas/Generated/Components.swift
PREPARED_OPENAPI := $(PROJECT_DIR)/.build/openapi-generator/openapi.yaml
OPENAPI_DIFF     := $(PROJECT_DIR)/.build/openapi-generator/openapi.patch

.PHONY: generate
generate:
	# Prepare a working copy with conditional, documented upstream-spec fixes.
	# See the scripts called by prepare_openapi.py for each error and its fix.
	python3 "$(PROJECT_DIR)/Scripts/prepare_openapi.py" \
		"$(PROJECT_DIR)/openapi.yaml" \
		"$(PREPARED_OPENAPI)" \
		--diff-output "$(OPENAPI_DIFF)"
	cd "$(GENERATOR_DIR)" && swift run swift-openapi-generator generate \
		--config "$(PROJECT_DIR)/openapi-generator-config.yaml" \
		"$(PREPARED_OPENAPI)"
#	python3 "$(PROJECT_DIR)/Scripts/extract_components.py" \
#		"$(TYPES_SWIFT)" \
#		"$(COMPONENTS_SWIFT)"
