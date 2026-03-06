//
//  HomeViewModelTests.swift
//  PodPulseAppTests
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import XCTest
@testable import PodPulseApp

@MainActor
final class HomeViewModelTests: XCTestCase {
    private var mockService: MockAPIService!
    private var viewModel: HomeViewModel!

    override func setUp() {
        mockService = MockAPIService()
        viewModel = HomeViewModel(apiService: mockService)
    }

    override func tearDown() {
        mockService = nil
        viewModel = nil
    }

    // MARK: - Success Cases

    func testLoadSectionsSuccess() async {
        mockService.homeSectionsResult = .success([
            Section.mock(name: "Section A", order: 1),
            Section.mock(name: "Section B", order: 2)
        ])

        await viewModel.loadSections()

        XCTAssertEqual(viewModel.sections.count, 2)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testRefreshUpdatesData() async {
        mockService.homeSectionsResult = .success([Section.mock(name: "Initial")])
        await viewModel.loadSections()
        XCTAssertEqual(viewModel.sections.count, 1)

        mockService.homeSectionsResult = .success([
            Section.mock(name: "Updated A"),
            Section.mock(name: "Updated B", order: 2)
        ])
        await viewModel.refresh()
        XCTAssertEqual(viewModel.sections.count, 2)
    }

    func testLoadSectionsCallsAPIOnce() async {
        mockService.homeSectionsResult = .success([])
        await viewModel.loadSections()
        XCTAssertEqual(mockService.fetchHomeSectionsCallCount, 1)
    }

    // MARK: - Failure Cases

    func testLoadSectionsInvalidResponse() async {
        mockService.homeSectionsResult = .failure(APIError.invalidResponse)

        await viewModel.loadSections()

        XCTAssertTrue(viewModel.sections.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadSectionsHTTPError() async {
        mockService.homeSectionsResult = .failure(APIError.httpError(500))

        await viewModel.loadSections()

        XCTAssertTrue(viewModel.sections.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadSectionsInvalidURL() async {
        mockService.homeSectionsResult = .failure(APIError.invalidURL)

        await viewModel.loadSections()

        XCTAssertTrue(viewModel.sections.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testRefreshAfterFailureRecovery() async {
        mockService.homeSectionsResult = .failure(APIError.invalidResponse)
        await viewModel.loadSections()
        XCTAssertNotNil(viewModel.errorMessage)

        mockService.homeSectionsResult = .success([Section.mock(name: "Recovered")])
        await viewModel.refresh()

        XCTAssertEqual(viewModel.sections.count, 1)
        XCTAssertNil(viewModel.errorMessage)
    }
}
