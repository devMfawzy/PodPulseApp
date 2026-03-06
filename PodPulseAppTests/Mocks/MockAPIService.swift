//
//  MockAPIService.swift
//  PodPulseAppTests
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

@testable import PodPulseApp

final class MockAPIService: APIServiceProtocol {
    var homeSectionsResult: Result<[Section], Error> = .success([])
    var searchResult: Result<[Section], Error> = .success([])

    var fetchHomeSectionsCallCount = 0
    var searchCallCount = 0
    var lastSearchQuery: String?

    func fetchHomeSections() async throws -> [Section] {
        fetchHomeSectionsCallCount += 1
        return try homeSectionsResult.get()
    }

    func search(query: String) async throws -> [Section] {
        searchCallCount += 1
        lastSearchQuery = query
        return try searchResult.get()
    }
}
