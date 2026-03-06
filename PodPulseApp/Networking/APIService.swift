//
//  APIService.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 06/03/2026.
//

import Foundation

protocol APIServiceProtocol {
    func fetchHomeSections() async throws -> [Section]
    func search(query: String) async throws -> [Section]
}

final class APIService: APIServiceProtocol {
    static let shared = APIService()

    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()
    }

    func fetchHomeSections() async throws -> [Section] {
        guard let url = URL(string: APIEndpoints.homeSections) else {
            throw APIError.invalidURL
        }
        let (data, response) = try await session.data(from: url)
        try validateResponse(response)
        let result = try decoder.decode(HomeSectionsResponse.self, from: data)
        
        return result.sections.sorted { $0.order < $1.order}
    }

    func search(query: String) async throws -> [Section] {
        guard var components = URLComponents(string: APIEndpoints.search) else {
            throw APIError.invalidURL
        }
        components.queryItems = [URLQueryItem(name: "q", value: query)]
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        let (data, response) = try await session.data(from: url)
        try validateResponse(response)
        let result = try decoder.decode(HomeSectionsResponse.self, from: data)
        return result.sections.sorted { $0.order < $1.order }
    }

    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError(httpResponse.statusCode)
        }
    }
}
