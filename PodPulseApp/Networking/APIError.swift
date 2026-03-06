//
//  APIError.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 06/03/2026.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid response from server"
        case .httpError(let code): return "Server error (\(code))"
        }
    }
}
