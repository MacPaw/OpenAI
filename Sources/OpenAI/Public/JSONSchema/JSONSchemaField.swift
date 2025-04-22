//
//  JSONSchemaField.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//

import Foundation

public struct JSONSchemaField {
    let keyword: String
    let value: AnyJSONDocument
    
    // MARK: Validation Keywords for Any Instance Type
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Validation succeeds if the type of the instance matches the type represented by the given type, or matches at least one of the given types.
    public static func type(_ type: JSONSchemaInstanceType) -> JSONSchemaField {
        .init(keyword: "type", value: .init(type))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Validation succeeds if the instance is equal to one of the elements in this keyword’s array value.
    public static func enumValues(_ values: [any JSONDocument]) -> JSONSchemaField {
        .init(
            keyword: "enum",
            value: .init(
                values.map { AnyJSONDocument($0) }
            )
        )
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Validation succeeds if the instance is equal to this keyword’s value.
    public static func const(_ value: any JSONDocument) -> JSONSchemaField {
        .init(keyword: "const", value: .init(value))
    }
    
    // MARK: - Core
    /// ### Kind
    /// Identifier
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword declares an identifier for the schema resource.
    public static func id(_ value: String) -> JSONSchemaField {
        .init(keyword: "$id", value: .init(value))
    }
    
    /// ### Kind
    /// Identifier
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Declares a JSON Schema dialect or links to a valid schema for a dialect.
    public static func schema(_ value: String) -> JSONSchemaField {
        .init(keyword: "$schema", value: .init(value))
    }
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// References another schema.
    public static func ref(_ value: String) -> JSONSchemaField {
        .init(keyword: "$ref", value: .init(value))
    }
    
    /// ### Kind
    /// Reserved Location
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Holds comments from schema authors.
    public static func comment(_ value: String) -> JSONSchemaField {
        .init(keyword: "$comment", value: .init(value))
    }
    
    /// ### Kind
    /// Reserved Location
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Inline reusable schema definitions.
    public static func defs(_ value: [String: AnyJSONSchema]) -> JSONSchemaField {
        .init(keyword: "$defs", value: .init(value))
    }
    
    /// ### Kind
    /// Identifier
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Used to create plain name fragments for referencing.
    public static func anchor(_ value: String) -> JSONSchemaField {
        .init(keyword: "$anchor", value: .init(value))
    }
    
    /// ### Kind
    /// Identifier
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Used for dynamic referencing.
    public static func dynamicAnchor(_ value: String) -> JSONSchemaField {
        .init(keyword: "$dynamicAnchor", value: .init(value))
    }
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Runtime-resolved reference.
    public static func dynamicRef(_ value: String) -> JSONSchemaField {
        .init(keyword: "$dynamicRef", value: .init(value))
    }
    
    /// ### Kind
    /// Identifier
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Vocabulary declaration for dialects.
    public static func vocabulary(_ value: [String: Bool]) -> JSONSchemaField {
        .init(keyword: "$vocabulary", value: .init(value))
    }
    
    // MARK: - Applicator
    // https://www.learnjsonschema.com/2020-12/applicator/
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// An instance validates successfully against this keyword if it validates successfully against all schemas defined by this keyword’s value.
    public static func allOf(_ schemas: [AnyJSONSchema]) -> JSONSchemaField {
        .init(keyword: "allOf", value: .init(schemas))
    }
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// An instance validates successfully against this keyword if it validates successfully against at least one schema defined by this keyword’s value.
    public static func anyOf(_ schemas: [AnyJSONSchema]) -> JSONSchemaField {
        .init(keyword: "anyOf", value: .init(schemas))
    }
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// An instance validates successfully against this keyword if it validates successfully against exactly one schema defined by this keyword’s value.
    public static func oneOf(_ schemas: [AnyJSONSchema]) -> JSONSchemaField {
        .init(keyword: "oneOf", value: .init(schemas))
    }
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword declares a condition based on the validation result of the given schema.
    public static func ifCondition(_ schema: any JSONSchema) -> JSONSchemaField {
        .init(keyword: "if", value: .init(schema))
    }
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// When `if` is present, and the instance successfully validates against its subschema, then validation succeeds if the instance also successfully validates against this keyword’s subschema.
    public static func thenCondition(_ schema: any JSONSchema) -> JSONSchemaField {
        .init(keyword: "then", value: .init(schema))
    }
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// When `if` is present, and the instance fails to validate against its subschema, then validation succeeds if the instance successfully validates against this keyword’s subschema.
    public static func elseCondition(_ schema: any JSONSchema) -> JSONSchemaField {
        .init(keyword: "else", value: .init(schema))
    }
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// An instance is valid against this keyword if it fails to validate successfully against the schema defined by this keyword.
    public static func not(_ schema: any JSONSchema) -> JSONSchemaField {
        .init(keyword: "not", value: .init(schema))
    }
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validation succeeds if, for each name that appears in both the instance and as a name within this keyword’s value, the child instance for that name successfully validates against the corresponding schema.
    public static func properties(_ object: [String: AnyJSONSchema]) -> JSONSchemaField {
        .init(keyword: "properties", value: .init(object))
    }
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validation succeeds if the schema validates against each value not matched by other object applicators in this vocabulary.
    public static func additionalProperties(_ object: [String: AnyJSONSchema]) -> JSONSchemaField {
        .init(keyword: "additionalProperties", value: .init(object))
    }
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validation succeeds if, for each instance name that matches any regular expressions that appear as a property name in this keyword’s value, the child instance for that name successfully validates against each schema that corresponds to a matching regular expression.
    public static func patternProperties(_ object: [String: AnyJSONSchema]) -> JSONSchemaField {
        .init(keyword: "patternProperties", value: .init(object))
    }
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// This keyword specifies subschemas that are evaluated if the instance is an object and contains a certain property.
    public static func dependentSchemas(_ object: [String: AnyJSONSchema]) -> JSONSchemaField {
        .init(keyword: "dependentSchemas", value: .init(object))
    }
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validation succeeds if the schema validates against every property name in the instance.
    public static func propertyNames(_ schema: any JSONSchema) -> JSONSchemaField {
        .init(keyword: "propertyNames", value: .init(schema))
    }
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// Validation succeeds if the instance contains an element that validates against this schema.
    public static func contains(_ schema: any JSONSchema) -> JSONSchemaField {
        .init(keyword: "contains", value: .init(schema))
    }
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// Validation succeeds if each element of the instance not covered by `prefixItems` validates against this schema.
    public static func items(_ schema: any JSONSchema) -> JSONSchemaField {
        .init(keyword: "items", value: .init(schema))
    }
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// Validation succeeds if each element of the instance validates against the schema at the same position, if any.
    public static func prefixItems(_ schema: any JSONSchema) -> JSONSchemaField {
        .init(keyword: "prefixItems", value: .init(schema))
    }
    
    // MARK: - Validation
    // https://json-schema.org/draft/2020-12/json-schema-validation#name-a-vocabulary-for-structural
    
    // MARK: Validation Keywords for Numeric Instances (number and integer)
    // https://json-schema.org/draft/2020-12/json-schema-validation#name-validation-keywords-for-num
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Number
    ///
    /// ### Summary
    /// A numeric instance is valid only if division by this keyword’s value results in an integer.
    public static func multipleOf(_ value: Decimal) -> JSONSchemaField {
        .init(keyword: "maximum", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Number
    ///
    /// ### Summary
    /// Validation succeeds if the numeric instance is less than or equal to the given number.
    public static func maximum(_ value: Decimal) -> JSONSchemaField {
        .init(keyword: "maximum", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Number
    ///
    /// ### Summary
    /// Validation succeeds if the numeric instance is less than the given number.
    public static func exclusiveMaximum(_ value: Decimal) -> JSONSchemaField {
        .init(keyword: "exclusiveMaximum", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Number
    ///
    /// ### Summary
    /// Validation succeeds if the numeric instance is greater than or equal to the given number.
    public static func minimum(_ value: Decimal) -> JSONSchemaField {
        .init(keyword: "minimum", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Number
    ///
    /// ### Summary
    /// Validation succeeds if the numeric instance is greater than the given number.
    public static func exclusiveMinimum(_ value: Decimal) -> JSONSchemaField {
        .init(keyword: "exclusiveMinimum", value: .init(value))
    }
    
    // MARK: Validation Keywords for Strings
    // https://json-schema.org/draft/2020-12/json-schema-validation#name-validation-keywords-for-str
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// A string instance is valid against this keyword if its length is less than, or equal to, the value of this keyword.
    public static func maxLength(_ value: Int) -> JSONSchemaField {
        .init(keyword: "maxLength", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// A string instance is valid against this keyword if its length is greater than, or equal to, the value of this keyword.
    public static func minLength(_ value: Int) -> JSONSchemaField {
        .init(keyword: "minLength", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// A string instance is considered valid if the regular expression matches the instance successfully.
    public static func pattern(_ value: String) -> JSONSchemaField {
        .init(keyword: "pattern", value: .init(value))
    }
    
    // MARK: Validation Keywords for Arrays
    // https://json-schema.org/draft/2020-12/json-schema-validation#name-validation-keywords-for-arr
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// An array instance is valid if its size is less than, or equal to, the value of this keyword.
    public static func maxItems(_ value: Int) -> JSONSchemaField {
        .init(keyword: "maxItems", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// An array instance is valid if its size is greater than, or equal to, the value of this keyword.
    public static func minItems(_ value: Int) -> JSONSchemaField {
        .init(keyword: "minItems", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// If this keyword is set to the boolean value true, the instance validates successfully if all of its elements are unique.
    public static func uniqueItems(_ value: Bool) -> JSONSchemaField {
        .init(keyword: "uniqueItems", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// The number of times that the contains keyword (if set) successfully validates against the instance must be less than or equal to the given integer.
    public static func maxContains(_ value: Int) -> JSONSchemaField {
        .init(keyword: "maxContains", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// The number of times that the contains keyword (if set) successfully validates against the instance must be greater than or equal to the given integer.
    public static func minContains(_ value: Int) -> JSONSchemaField {
        .init(keyword: "minContains", value: .init(value))
    }
    
    // MARK: Validation Keywords for Objects
    // https://json-schema.org/draft/2020-12/json-schema-validation#name-validation-keywords-for-obj
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// An object instance is valid if its number of properties is less than, or equal to, the value of this keyword.
    public static func maxProperties(_ value: Int) -> JSONSchemaField {
        .init(keyword: "maxProperties", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// An object instance is valid if its number of properties is greater than, or equal to, the value of this keyword.
    public static func minProperties(_ value: Int) -> JSONSchemaField {
        .init(keyword: "minProperties", value: .init(value))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// An object instance is valid against this keyword if every item in the array is the name of a property in the instance.
    public static func required(_ values: [String]) -> JSONSchemaField {
        .init(keyword: "required", value: .init(values))
    }
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validation succeeds if, for each name that appears in both the instance and as a name within this keyword’s value, every item in the corresponding array is also the name of a property in the instance.
    public static func dependentRequired(_ value: [String: [String]]) -> JSONSchemaField {
        .init(keyword: "dependentRequired", value: .init(value))
    }
    
    // MARK: - Meta Data
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// A preferably short description about the purpose of the instance described by the schema.
    public static func title(_ value: String) -> JSONSchemaField {
        .init(keyword: "title", value: .init(value))
    }
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// A detailed explanation about the schema.
    public static func description(_ value: String) -> JSONSchemaField {
        .init(keyword: "description", value: .init(value))
    }
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Supplies a default value for the instance.
    public static func defaultValue(_ value: any JSONDocument) -> JSONSchemaField {
        .init(keyword: "default", value: .init(value))
    }
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Indicates that this value should not be used.
    public static func deprecated(_ value: Bool) -> JSONSchemaField {
        .init(keyword: "deprecated", value: .init(value))
    }
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Provides sample values for illustrative purposes.
    public static func examples(_ values: [AnyJSONDocument]) -> JSONSchemaField {
        .init(keyword: "examples", value: .init(values))
    }
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Specifies that the instance is read-only.
    public static func readOnly(_ value: Bool) -> JSONSchemaField {
        .init(keyword: "readOnly", value: .init(value))
    }
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Specifies that the instance is write-only.
    public static func writeOnly(_ value: Bool) -> JSONSchemaField {
        .init(keyword: "writeOnly", value: .init(value))
    }
    
    // MARK: - Format Annotation
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// Define semantic information about a string instance.
    public static func format(_ value: String) -> JSONSchemaField {
        .init(keyword: "format", value: .init(value))
    }
    
    // MARK: - Content
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// The encoding of the string.
    public static func contentEncoding(_ value: String) -> JSONSchemaField {
        .init(keyword: "contentEncoding", value: .init(value))
    }
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// The media type of the string instance.
    public static func contentMediaType(_ value: String) -> JSONSchemaField {
        .init(keyword: "contentMediaType", value: .init(value))
    }
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// Schema describing the structure of the string.
    public static func contentSchema(_ value: String) -> JSONSchemaField {
        .init(keyword: "contentSchema", value: .init(value))
    }
    
    // MARK: - Unevaluated
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// Validates array elements that did not successfully validate against other standard array applicators.
    public static func unevaluatedItems(_ schema: any JSONSchema) -> JSONSchemaField {
        .init(keyword: "unevaluatedItems", value: .init(schema))
    }
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validates object properties that did not successfully validate against other standard object applicators.
    public static func unevaluatedProperties(_ schema: any JSONSchema) -> JSONSchemaField {
        .init(keyword: "unevaluatedProperties", value: .init(schema))
    }
}
