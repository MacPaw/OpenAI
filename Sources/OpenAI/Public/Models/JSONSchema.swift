//
//  JSONSchema.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 21.04.2025.
//

import Foundation

public final class JSONSchema: Codable, Hashable, Sendable {    
    public enum InstanceType: Codable, Hashable, Sendable {
        case integer
        case string
        case boolean
        case array
        case object
        case number
        case null
        case types([String])
        
        private enum CodingKeys: String {
            case integer, string, boolean, array, object, number, null, types
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            
            if let single = try? container.decode(String.self) {
                switch single {
                case "integer": self = .integer
                case "string": self = .string
                case "boolean": self = .boolean
                case "array": self = .array
                case "object": self = .object
                case "number": self = .number
                case "null": self = .null
                default:
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown instance type: \(single)")
                }
            } else if let array = try? container.decode([String].self) {
                self = .types(array)
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "InstanceType must be a string or array of strings")
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            
            switch self {
            case .integer: try container.encode("integer")
            case .string: try container.encode("string")
            case .boolean: try container.encode("boolean")
            case .array: try container.encode("array")
            case .object: try container.encode("object")
            case .number: try container.encode("number")
            case .null: try container.encode("null")
            case .types(let types): try container.encode(types)
            }
        }
    }
        
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Validation succeeds if the type of the instance matches the type represented by the given type, or matches at least one of the given types.
    public let type: InstanceType?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Validation succeeds if the instance is equal to one of the elements in this keyword’s array value.
    public let enumValues: [CodableValue]?
    /// - Note: Maps from `enum` to `enumValues` in Swift.
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// Validation succeeds if the instance is equal to this keyword’s value.
    public let const: CodableValue?
    
    // MARK: Core
    
    /// ### Kind
    /// Identifier
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword declares an identifier for the schema resource.
    ///
    /// - Note: Maps from `$id` to `id` in Swift.
    public let id: String?
    
    /// ### Kind
    /// Identifier
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword is both used as a JSON Schema dialect identifier and as a reference to a JSON Schema which describes the set of valid schemas written for this particular dialect.
    ///
    /// - Note: Maps from `$schema` to `schema` in Swift.
    public let schema: String?
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword is used to reference a statically identified schema.
    ///
    /// - Note: Maps from `$ref` to `ref` in Swift.
    public let ref: String?
    
    /// ### Kind
    /// Reserved Location
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword reserves a location for comments from schema authors to readers or maintainers of the schema.
    ///
    /// - Note: Maps from `$comment` to `comment` in Swift.
    public let comment: String?
    
    /// ### Kind
    /// Reserved Location
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword reserves a location for schema authors to inline re-usable JSON Schemas into a more general schema.
    ///
    /// - Note: Maps from `$defs` to `defs` in Swift.
    public let defs: [String: JSONSchema]?
    
    /// ### Kind
    /// Identifier
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword is used to create plain name fragments that are not tied to any particular structural location for referencing purposes, which are taken into consideration for static referencing.
    ///
    /// - Note: Maps from `$anchor` to `anchor` in Swift.
    public let anchor: String?
    
    /// ### Kind
    /// Identifier
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword is used to create plain name fragments that are not tied to any particular structural location for referencing purposes, which are taken into consideration for dynamic referencing.
    ///
    /// - Note: Maps from `$dynamicAnchor` to `dynamicAnchor` in Swift.
    public let dynamicAnchor: String?
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword is used to reference an identified schema, deferring the full resolution until runtime, at which point it is resolved each time it is encountered while evaluating an instance.
    ///
    /// - Note: Maps from `$dynamicRef` to `dynamicRef` in Swift.
    public let dynamicRef: String?
    
    /// ### Kind
    /// Identifier
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword is used in dialect meta-schemas to identify the required and optional vocabularies available for use in schemas described by that dialect.
    ///
    /// - Note: Maps from `$vocabulary` to `vocabulary` in Swift.
    public let vocabulary: [String: Bool]?
    
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
    public let allOf: [JSONSchema]?
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// An instance validates successfully against this keyword if it validates successfully against at least one schema defined by this keyword’s value.
    public let anyOf: [JSONSchema]?
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// An instance validates successfully against this keyword if it validates successfully against exactly one schema defined by this keyword’s value.
    public let oneOf: [JSONSchema]?
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword declares a condition based on the validation result of the given schema.
    public let ifCondition: JSONSchema?
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// When `if` is present, and the instance successfully validates against its subschema, then validation succeeds if the instance also successfully validates against this keyword’s subschema.
    public let thenCondition: JSONSchema?
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// When `if` is present, and the instance fails to validate against its subschema, then validation succeeds if the instance successfully validates against this keyword’s subschema.
    public let elseCondition: JSONSchema?
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// An instance is valid against this keyword if it fails to validate successfully against the schema defined by this keyword.
    public let not: JSONSchema?
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validation succeeds if, for each name that appears in both the instance and as a name within this keyword’s value, the child instance for that name successfully validates against the corresponding schema.
    public let properties: [String: JSONSchema]?
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validation succeeds if the schema validates against each value not matched by other object applicators in this vocabulary.
    public let additionalProperties: JSONSchema?
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validation succeeds if, for each instance name that matches any regular expressions that appear as a property name in this keyword’s value, the child instance for that name successfully validates against each schema that corresponds to a matching regular expression.
    public let patternProperties: [String: JSONSchema]?
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// This keyword specifies subschemas that are evaluated if the instance is an object and contains a certain property.
    public let dependentSchemas: [String: JSONSchema]?
    
    /// ### Kind
    /// Applicator
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validation succeeds if the schema validates against every property name in the instance.
    public let propertyNames: JSONSchema?
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// Validation succeeds if the instance contains an element that validates against this schema.
    public let contains: JSONSchema?
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// Validation succeeds if each element of the instance not covered by `prefixItems` validates against this schema.
    public let items: JSONSchema?
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// Validation succeeds if each element of the instance validates against the schema at the same position, if any.
    public let prefixItems: [JSONSchema]?
    
    // MARK: - Validation
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// A string instance is valid against this keyword if its length is less than, or equal to, the value of this keyword.
    public let maxLength: Int?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// A string instance is valid against this keyword if its length is greater than, or equal to, the value of this keyword.
    public let minLength: Int?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// A string instance is considered valid if the regular expression matches the instance successfully.
    public let pattern: String?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Number
    ///
    /// ### Summary
    /// Validation succeeds if the numeric instance is less than the given number.
    public let exclusiveMaximum: Double?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Number
    ///
    /// ### Summary
    /// Validation succeeds if the numeric instance is greater than the given number.
    public let exclusiveMinimum: Double?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Number
    ///
    /// ### Summary
    /// Validation succeeds if the numeric instance is less than or equal to the given number.
    public let maximum: Double?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Number
    ///
    /// ### Summary
    /// Validation succeeds if the numeric instance is greater than or equal to the given number.
    public let minimum: Double?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Number
    ///
    /// ### Summary
    /// A numeric instance is valid only if division by this keyword’s value results in an integer.
    public let multipleOf: Double?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validation succeeds if, for each name that appears in both the instance and as a name within this keyword’s value, every item in the corresponding array is also the name of a property in the instance.
    public let dependentRequired: [String: [String]]?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// An object instance is valid if its number of properties is less than, or equal to, the value of this keyword.
    public let maxProperties: Int?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// An object instance is valid if its number of properties is greater than, or equal to, the value of this keyword.
    public let minProperties: Int?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// An object instance is valid against this keyword if every item in the array is the name of a property in the instance.
    public let required: [String]?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// An array instance is valid if its size is less than, or equal to, the value of this keyword.
    public let maxItems: Int?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// An array instance is valid if its size is greater than, or equal to, the value of this keyword.
    public let minItems: Int?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// The number of times that the contains keyword (if set) successfully validates against the instance must be less than or equal to the given integer.
    public let maxContains: Int?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// The number of times that the contains keyword (if set) successfully validates against the instance must be greater than or equal to the given integer.
    public let minContains: Int?
    
    /// ### Kind
    /// Assertion
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// If this keyword is set to the boolean value true, the instance validates successfully if all of its elements are unique.
    public let uniqueItems: Bool?
    
    // MARK: - Meta Data
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// A preferably short description about the purpose of the instance described by the schema.
    public let title: String?
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// An explanation about the purpose of the instance described by the schema.
    public let description: String?
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword can be used to supply a default JSON value associated with a particular schema.
    public let defaultValue: CodableValue?
    /// - Note: Maps from default to defaultValue in Swift.
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword indicates that applications should refrain from using the declared property.
    public let deprecated: Bool?
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword is used to provide sample JSON values associated with a particular schema, for the purpose of illustrating usage.
    public let examples: [CodableValue]?
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword indicates that the value of the instance is managed exclusively by the owning authority, and attempts by an application to modify the value of this property are expected to be ignored or rejected by that owning authority.
    public let readOnly: Bool?
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// Any
    ///
    /// ### Summary
    /// This keyword indicates that the value is never present when the instance is retrieved from the owning authority.
    public let writeOnly: Bool?
    
    // MARK: - Format Annotation
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// Define semantic information about a string instance.
    public let format: String?
    
    // MARK: - Content
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// The string instance should be interpreted as encoded binary data and decoded using the encoding named by this property.
    public let contentEncoding: String?
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// This keyword declares the media type of the string instance.
    public let contentMediaType: String?
    
    /// ### Kind
    /// Annotation
    ///
    /// ### Instance
    /// String
    ///
    /// ### Summary
    /// This keyword declares a schema which describes the structure of the string.
    public let contentSchema: String?
    
    // MARK: - Unevaluated
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Array
    ///
    /// ### Summary
    /// Validates array elements that did not successfully validate against other standard array applicators.
    public let unevaluatedItems: JSONSchema?
    
    /// ### Kind
    /// Applicator Annotation
    ///
    /// ### Instance
    /// Object
    ///
    /// ### Summary
    /// Validates object properties that did not successfully validate against other standard object applicators.
    public let unevaluatedProperties: JSONSchema?
    
    public init(
        type: InstanceType? = nil,
        enumValues: [CodableValue]? = nil,
        const: CodableValue? = nil,
        // Core
        id: String? = nil,
        schema: String? = nil,
        ref: String? = nil,
        comment: String? = nil,
        defs: [String: JSONSchema]? = nil,
        anchor: String? = nil,
        dynamicAnchor: String? = nil,
        dynamicRef: String? = nil,
        vocabulary: [String: Bool]? = nil,
        
        // Applicator
        allOf: [JSONSchema]? = nil,
        anyOf: [JSONSchema]? = nil,
        oneOf: [JSONSchema]? = nil,
        ifCondition: JSONSchema? = nil,
        thenCondition: JSONSchema? = nil,
        elseCondition: JSONSchema? = nil,
        not: JSONSchema? = nil,
        properties: [String: JSONSchema]? = nil,
        additionalProperties: JSONSchema? = nil,
        patternProperties: [String: JSONSchema]? = nil,
        dependentSchemas: [String: JSONSchema]? = nil,
        propertyNames: JSONSchema? = nil,
        contains: JSONSchema? = nil,
        items: JSONSchema? = nil,
        prefixItems: [JSONSchema]? = nil,
        
        // Validation
        maxLength: Int? = nil,
        minLength: Int? = nil,
        pattern: String? = nil,
        exclusiveMaximum: Double? = nil,
        exclusiveMinimum: Double? = nil,
        maximum: Double? = nil,
        minimum: Double? = nil,
        multipleOf: Double? = nil,
        dependentRequired: [String: [String]]? = nil,
        maxProperties: Int? = nil,
        minProperties: Int? = nil,
        required: [String]? = nil,
        maxItems: Int? = nil,
        minItems: Int? = nil,
        maxContains: Int? = nil,
        minContains: Int? = nil,
        uniqueItems: Bool? = nil,
        
        // Meta Data
        title: String? = nil,
        description: String? = nil,
        defaultValue: CodableValue? = nil,
        deprecated: Bool? = nil,
        examples: [CodableValue]? = nil,
        readOnly: Bool? = nil,
        writeOnly: Bool? = nil,
        format: String? = nil,
        
        // Content
        contentEncoding: String? = nil,
        contentMediaType: String? = nil,
        contentSchema: String? = nil,
        
        // Unevaluated
        unevaluatedItems: JSONSchema? = nil,
        unevaluatedProperties: JSONSchema? = nil
    ) {
        self.type = type
        self.enumValues = enumValues
        self.const = const
        
        // Core
        self.id = id
        self.schema = schema
        self.ref = ref
        self.comment = comment
        self.defs = defs
        self.anchor = anchor
        self.dynamicAnchor = dynamicAnchor
        self.dynamicRef = dynamicRef
        self.vocabulary = vocabulary
        
        // Applicator
        self.allOf = allOf
        self.anyOf = anyOf
        self.oneOf = oneOf
        self.ifCondition = ifCondition
        self.thenCondition = thenCondition
        self.elseCondition = elseCondition
        self.not = not
        self.properties = properties
        self.additionalProperties = additionalProperties
        self.patternProperties = patternProperties
        self.dependentSchemas = dependentSchemas
        self.propertyNames = propertyNames
        self.contains = contains
        self.items = items
        self.prefixItems = prefixItems
        
        // Validation
        self.maxLength = maxLength
        self.minLength = minLength
        self.pattern = pattern
        self.exclusiveMaximum = exclusiveMaximum
        self.exclusiveMinimum = exclusiveMinimum
        self.maximum = maximum
        self.minimum = minimum
        self.multipleOf = multipleOf
        self.dependentRequired = dependentRequired
        self.maxProperties = maxProperties
        self.minProperties = minProperties
        self.required = required
        self.maxItems = maxItems
        self.minItems = minItems
        self.maxContains = maxContains
        self.minContains = minContains
        self.uniqueItems = uniqueItems
        
        // Meta Data
        self.title = title
        self.description = description
        self.defaultValue = defaultValue
        self.deprecated = deprecated
        self.examples = examples
        self.readOnly = readOnly
        self.writeOnly = writeOnly
        self.format = format
        
        // Content
        self.contentEncoding = contentEncoding
        self.contentMediaType = contentMediaType
        self.contentSchema = contentSchema
        
        // Unevaluated
        self.unevaluatedItems = unevaluatedItems
        self.unevaluatedProperties = unevaluatedProperties
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case enumValues = "enum"
        case const
        
        // Core
        case id = "$id"
        case schema = "$schema"
        case ref = "$ref"
        case comment = "$comment"
        case defs = "$defs"
        case anchor = "$anchor"
        case dynamicAnchor = "$dynamicAnchor"
        case dynamicRef = "$dynamicRef"
        case vocabulary = "$vocabulary"
        
        // Applicator
        case allOf
        case anyOf
        case oneOf
        case ifCondition = "if"
        case thenCondition = "then"
        case elseCondition = "else"
        case not
        case properties
        case additionalProperties
        case patternProperties
        case dependentSchemas
        case propertyNames
        case contains
        case items
        case prefixItems
        
        // Validation
        case maxLength
        case minLength
        case pattern
        case exclusiveMaximum
        case exclusiveMinimum
        case maximum
        case minimum
        case multipleOf
        case dependentRequired
        case maxProperties
        case minProperties
        case required
        case maxItems
        case minItems
        case maxContains
        case minContains
        case uniqueItems
        
        // Meta Data
        case title
        case description
        case defaultValue = "default"
        case deprecated
        case examples
        case readOnly
        case writeOnly
        
        // Format Annotation
        case format
        
        // Content
        case contentEncoding
        case contentMediaType
        case contentSchema
        
        // Unevaluated
        case unevaluatedItems
        case unevaluatedProperties
    }
    
    public enum CodableValue: Codable, Hashable, Sendable {
        case null
        case bool(Bool)
        case number(Double)
        case string(String)
        case array([CodableValue])
        case object([String: CodableValue])
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            
            if container.decodeNil() {
                self = .null
            } else if let bool = try? container.decode(Bool.self) {
                self = .bool(bool)
            } else if let number = try? container.decode(Double.self) {
                self = .number(number)
            } else if let string = try? container.decode(String.self) {
                self = .string(string)
            } else if let array = try? container.decode([CodableValue].self) {
                self = .array(array)
            } else if let object = try? container.decode([String: CodableValue].self) {
                self = .object(object)
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported JSON value")
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .null:
                try container.encodeNil()
            case .bool(let value):
                try container.encode(value)
            case .number(let value):
                try container.encode(value)
            case .string(let value):
                try container.encode(value)
            case .array(let value):
                try container.encode(value)
            case .object(let value):
                try container.encode(value)
            }
            
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(schema)
        hasher.combine(ref)
        hasher.combine(comment)
        hasher.combine(defs)
        hasher.combine(anchor)
        hasher.combine(dynamicAnchor)
        hasher.combine(dynamicRef)
        hasher.combine(vocabulary)
        
        hasher.combine(allOf)
        hasher.combine(anyOf)
        hasher.combine(oneOf)
        hasher.combine(ifCondition)
        hasher.combine(thenCondition)
        hasher.combine(elseCondition)
        hasher.combine(not)
        hasher.combine(properties)
        hasher.combine(additionalProperties)
        hasher.combine(patternProperties)
        hasher.combine(dependentSchemas)
        hasher.combine(propertyNames)
        hasher.combine(contains)
        hasher.combine(items)
        hasher.combine(prefixItems)
        
        hasher.combine(type)
        hasher.combine(enumValues)
        hasher.combine(const)
        hasher.combine(maxLength)
        hasher.combine(minLength)
        hasher.combine(pattern)
        hasher.combine(exclusiveMaximum)
        hasher.combine(exclusiveMinimum)
        hasher.combine(maximum)
        hasher.combine(minimum)
        hasher.combine(multipleOf)
        hasher.combine(dependentRequired)
        hasher.combine(maxProperties)
        hasher.combine(minProperties)
        hasher.combine(required)
        hasher.combine(maxItems)
        hasher.combine(minItems)
        hasher.combine(maxContains)
        hasher.combine(minContains)
        hasher.combine(uniqueItems)
        
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(defaultValue)
        hasher.combine(deprecated)
        hasher.combine(examples)
        hasher.combine(readOnly)
        hasher.combine(writeOnly)
        hasher.combine(format)
        
        hasher.combine(contentEncoding)
        hasher.combine(contentMediaType)
        hasher.combine(contentSchema)
        
        hasher.combine(unevaluatedItems)
        hasher.combine(unevaluatedProperties)
    }
    
    public static func == (lhs: JSONSchema, rhs: JSONSchema) -> Bool {
        return lhs.id == rhs.id &&
            lhs.schema == rhs.schema &&
            lhs.ref == rhs.ref &&
            lhs.comment == rhs.comment &&
            lhs.defs == rhs.defs &&
            lhs.anchor == rhs.anchor &&
            lhs.dynamicAnchor == rhs.dynamicAnchor &&
            lhs.dynamicRef == rhs.dynamicRef &&
            lhs.vocabulary == rhs.vocabulary &&
            
            lhs.allOf == rhs.allOf &&
            lhs.anyOf == rhs.anyOf &&
            lhs.oneOf == rhs.oneOf &&
            lhs.ifCondition == rhs.ifCondition &&
            lhs.thenCondition == rhs.thenCondition &&
            lhs.elseCondition == rhs.elseCondition &&
            lhs.not == rhs.not &&
            
            lhs.properties == rhs.properties &&
            lhs.additionalProperties == rhs.additionalProperties &&
            lhs.patternProperties == rhs.patternProperties &&
            lhs.dependentSchemas == rhs.dependentSchemas &&
            lhs.propertyNames == rhs.propertyNames &&
            lhs.contains == rhs.contains &&
            lhs.items == rhs.items &&
            lhs.prefixItems == rhs.prefixItems &&
            
            lhs.type == rhs.type &&
            lhs.enumValues == rhs.enumValues &&
            lhs.const == rhs.const &&
            lhs.maxLength == rhs.maxLength &&
            lhs.minLength == rhs.minLength &&
            lhs.pattern == rhs.pattern &&
            lhs.exclusiveMaximum == rhs.exclusiveMaximum &&
            lhs.exclusiveMinimum == rhs.exclusiveMinimum &&
            lhs.maximum == rhs.maximum &&
            lhs.minimum == rhs.minimum &&
            lhs.multipleOf == rhs.multipleOf &&
            lhs.dependentRequired == rhs.dependentRequired &&
            lhs.maxProperties == rhs.maxProperties &&
            lhs.minProperties == rhs.minProperties &&
            lhs.required == rhs.required &&
            lhs.maxItems == rhs.maxItems &&
            lhs.minItems == rhs.minItems &&
            lhs.maxContains == rhs.maxContains &&
            lhs.minContains == rhs.minContains &&
            lhs.uniqueItems == rhs.uniqueItems &&
            
            lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.defaultValue == rhs.defaultValue &&
            lhs.deprecated == rhs.deprecated &&
            lhs.examples == rhs.examples &&
            lhs.readOnly == rhs.readOnly &&
            lhs.writeOnly == rhs.writeOnly &&
            lhs.format == rhs.format &&
            
            lhs.contentEncoding == rhs.contentEncoding &&
            lhs.contentMediaType == rhs.contentMediaType &&
            lhs.contentSchema == rhs.contentSchema &&
            
            lhs.unevaluatedItems == rhs.unevaluatedItems &&
            lhs.unevaluatedProperties == rhs.unevaluatedProperties
    }
}
