//
//  SearchViewModelTests.swift
//  PodPulseAppTests
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import XCTest
@testable import PodPulseApp

@MainActor
final class SearchViewModelTests: XCTestCase {
    private var mockService: MockAPIService!
    private var viewModel: SearchViewModel!

    override func setUp() {
        mockService = MockAPIService()
        viewModel = SearchViewModel(apiService: mockService)
    }

    override func tearDown() {
        mockService = nil
        viewModel = nil
    }

    // MARK: - Success Cases

    func testEmptyQueryClearsSections() async {
        viewModel.query = ""

        try? await Task.sleep(for: .milliseconds(400))

        XCTAssertTrue(viewModel.sections.isEmpty)
        XCTAssertEqual(mockService.searchCallCount, 0)
    }

    func testSearchCallsAPI() async {
        mockService.searchResult = .success([Section.mock(name: "Result")])

        viewModel.query = "test"

        try? await Task.sleep(for: .milliseconds(500))

        XCTAssertEqual(mockService.searchCallCount, 1)
        XCTAssertEqual(mockService.lastSearchQuery, "test")
        XCTAssertEqual(viewModel.sections.count, 1)
    }

    func testDebounceCancelsRapidQueries() async {
        mockService.searchResult = .success([Section.mock(name: "Result")])

        viewModel.query = "a"
        try? await Task.sleep(for: .milliseconds(50))
        viewModel.query = "ab"
        try? await Task.sleep(for: .milliseconds(50))
        viewModel.query = "abc"

        try? await Task.sleep(for: .milliseconds(500))

        XCTAssertEqual(mockService.searchCallCount, 1)
        XCTAssertEqual(mockService.lastSearchQuery, "abc")
    }

    // MARK: - Failure Cases

    func testSearchInvalidResponseSetsError() async {
        mockService.searchResult = .failure(APIError.invalidResponse)

        viewModel.query = "test"

        try? await Task.sleep(for: .milliseconds(500))

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.sections.isEmpty)
    }

    func testSearchHTTPErrorSetsError() async {
        mockService.searchResult = .failure(APIError.httpError(503))

        viewModel.query = "test"

        try? await Task.sleep(for: .milliseconds(500))

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.sections.isEmpty)
    }

    func testSearchRecoveryAfterError() async {
        mockService.searchResult = .failure(APIError.invalidResponse)
        viewModel.query = "fail"
        try? await Task.sleep(for: .milliseconds(500))
        XCTAssertNotNil(viewModel.errorMessage)

        mockService.searchResult = .success([Section.mock(name: "Recovered")])
        viewModel.query = "success"
        try? await Task.sleep(for: .milliseconds(500))

        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testClearQueryAfterErrorResetsState() async {
        mockService.searchResult = .failure(APIError.invalidResponse)
        viewModel.query = "test"
        try? await Task.sleep(for: .milliseconds(500))

        viewModel.query = ""
        try? await Task.sleep(for: .milliseconds(400))

        XCTAssertTrue(viewModel.sections.isEmpty)
    }
}
