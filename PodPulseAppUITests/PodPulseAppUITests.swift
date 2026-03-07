//
//  PodPulseAppUITests.swift
//  PodPulseAppUITests
//
//  Created by Mohamed Fawzy on 06/03/2026.
//

import XCTest

final class PodPulseAppUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: - Tab Bar

    @MainActor
    func testTabBarExists() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 5))
        XCTAssertEqual(tabBar.buttons.count, 2)
    }

    @MainActor
    func testSwitchingBetweenTabs() {
        navigateToSearch()
        XCTAssertTrue(app.searchFields.firstMatch.waitForExistence(timeout: 5))

        let tabBar = app.tabBars.firstMatch
        tabBar.buttons.element(boundBy: 0).tap()
        waitForHomeToLoad()
    }

    // MARK: - Home View

    @MainActor
    func testHomeScreenShowsNavigationBar() {
        waitForHomeToLoad()
        let navBar = app.navigationBars.firstMatch
        XCTAssertTrue(navBar.exists)
    }

    @MainActor
    func testHomeScreenLoadsContent() {
        waitForHomeToLoad()

        // Wait for sections to load (either scroll content or error)
        let scrollView = app.scrollViews.firstMatch
        let errorImage = app.images["exclamationmark.triangle"]
        let loaded = scrollView.waitForExistence(timeout: 10) || errorImage.waitForExistence(timeout: 1)
        XCTAssertTrue(loaded, "Home screen should show content or error state")
    }

    @MainActor
    func testHomeScreenSectionsAreScrollable() {
        waitForHomeToLoad()

        let scrollView = app.scrollViews.firstMatch
        guard scrollView.waitForExistence(timeout: 10) else { return }

        scrollView.swipeUp()
        scrollView.swipeDown()
    }

    // MARK: - Search View

    @MainActor
    func testSearchBarExists() {
        navigateToSearch()
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
    }

    @MainActor
    func testSearchBarAcceptsInput() {
        navigateToSearch()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        searchField.tap()
        searchField.typeText("podcast")

        XCTAssertEqual(searchField.value as? String, "podcast")
    }

    @MainActor
    func testSearchShowsResults() {
        navigateToSearch()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        searchField.tap()
        searchField.typeText("test")

        // Wait for results or empty state
        let scrollView = app.scrollViews.firstMatch
        let noResults = app.staticTexts["No results found"]
        let hasResponse = scrollView.waitForExistence(timeout: 10) || noResults.waitForExistence(timeout: 1)
        XCTAssertTrue(hasResponse, "Search should show results or no-results message")
    }

    @MainActor
    func testSearchClearShowsEmptyState() {
        navigateToSearch()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        searchField.tap()
        searchField.typeText("test")

        _ = app.scrollViews.firstMatch.waitForExistence(timeout: 10)

        // Clear the search field
        let clearButton = searchField.buttons.firstMatch
        if clearButton.waitForExistence(timeout: 3) {
            clearButton.tap()
        }

        // Should show the empty state with magnifying glass icon
        let searchIcon = app.images["magnifyingglass"]
        XCTAssertTrue(searchIcon.waitForExistence(timeout: 5))
    }
}

// MARK: - Helpers
extension PodPulseAppUITests {
    private func navigateToSearch() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 5))
        tabBar.buttons.element(boundBy: 1).tap()
    }

    private func waitForHomeToLoad() {
        let navBar = app.navigationBars.firstMatch
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
    }
}
