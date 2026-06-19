# Requires a local fork of swift-openapi-generator to be checked out as a
# sibling directory named `swift-openapi-generator` (i.e. ../swift-openapi-generator).
# See https://github.com/apple/swift-openapi-generator for the upstream repo.
#
# The fork must include these changes, which are not available in the official
# generator at the time of writing:
#
# - Handle OpenAPI 3.1 nullable schemas expressed as
#   `anyOf: [<schema>, { type: null }]`. The generator must ignore the null
#   branch while assigning the Swift type, then make the resulting type
#   optional. Without this change, nullable properties are unsupported or are
#   generated as an anyOf wrapper instead of the expected optional Swift type.
#   This is implemented by local commit fe49fc3f7e17b255012ab11925f53863e4972933.
#
# - When a oneOf discriminator has no explicit mapping, also match the string
#   enum values declared by the referenced schemas' discriminator property.
#   The OpenAI spec uses runtime values such as `input_text`, which do not match
#   schema names such as `InputTextContent`; without this change, decoding a
#   valid response throws unknownOneOfDiscriminator. This is implemented by
#   local commit 33a4f7ccdc4adb577e20033562858ffc657a589a and corresponds to
#   https://github.com/openai/openai-openapi/issues/542.
#
# Expected diagnostic:
# The generator warns that `InputMessageResource/value2` requires `type` even
# though that property is declared by the sibling `InputMessage` schema in the
# same `allOf`. JSON Schema applies both members to the same object, while the
# generator validates each generated allOf payload independently. The property
# remains available through the generated `InputMessage` payload, so this
# warning is intentionally ignored.
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
	python3 -B "$(PROJECT_DIR)/Scripts/prepare_openapi.py" \
		"$(PROJECT_DIR)/openapi.yaml" \
		"$(PREPARED_OPENAPI)"
	python3 -B "$(PROJECT_DIR)/Scripts/remove_required_properties.py" \
		"$(PREPARED_OPENAPI)" \
		"$(PREPARED_OPENAPI)" \
		--remove-required "LocalShellToolCallOutput" "call_id" \
		--remove-required "MCPApprovalResponse" "request_id" \
		--remove-required "MCPApprovalResponseResource" "request_id" \
		--remove-required "ResponseAudioDoneEvent" "response_id" \
		--remove-required "ResponseAudioTranscriptDeltaEvent" "response_id" \
		--remove-required "ResponseAudioTranscriptDoneEvent" "response_id" \
		--diff-source "$(PROJECT_DIR)/openapi.yaml" \
		--diff-output "$(OPENAPI_DIFF)"
	cd "$(GENERATOR_DIR)" && swift run swift-openapi-generator generate \
		--config "$(PROJECT_DIR)/openapi-generator-config.yaml" \
		"$(PREPARED_OPENAPI)"
	python3 -B "$(PROJECT_DIR)/Scripts/extract_components.py" \
		"$(TYPES_SWIFT)" \
		"$(COMPONENTS_SWIFT)"
