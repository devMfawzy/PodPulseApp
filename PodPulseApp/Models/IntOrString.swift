//
//  IntOrString.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 06/03/2026.
//

import Foundation

enum IntOrString: Codable, Equatable {
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intVal = try? container.decode(Int.self) {
            self = .int(intVal)
        } else if let strVal = try? container.decode(String.self) {
            self = .string(strVal)
        } else {
            throw DecodingError.typeMismatch(
                IntOrString.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected Int or String")
            )
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let val): try container.encode(val)
        case .string(let val): try container.encode(val)
        }
    }
}

extension IntOrString: Comparable {
    static func < (lhs: IntOrString, rhs: IntOrString) -> Bool {
        lhs.stringValue < rhs.stringValue
    }
    
    var intValue: Int? {
        switch self {
        case .int(let val):
            return val
        case .string(let val):
            return Int(val)
        }
    }
    
    var stringValue: String {
        switch self {
        case .int(let val):
            return String(val)
        case .string(let val):
            return val
        }
    }
}

extension IntOrString: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self = .int(value)
    }
}

extension IntOrString: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self = .string(value)
    }
}
