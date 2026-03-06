//
//  SectionTests.swift
//  PodPulseAppTests
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import XCTest
@testable import PodPulseApp

@MainActor
final class SectionTests: XCTestCase {

    func testDisplayTypeSquare() {
        let section = Section.mock(type: "square")
        XCTAssertEqual(section.displayType, .square)
    }

    func testDisplayTypeBigSquare() {
        let section = Section.mock(type: "big_square")
        XCTAssertEqual(section.displayType, .bigSquare)
    }

    func testDisplayTypeBigSquareWithSpace() {
        let section = Section.mock(type: "big square")
        XCTAssertEqual(section.displayType, .bigSquare)
    }

    func testDisplayTypeTwoLinesGrid() {
        let section = Section.mock(type: "2_lines_grid")
        XCTAssertEqual(section.displayType, .twoLinesGrid)
    }

    func testDisplayTypeQueue() {
        let section = Section.mock(type: "queue")
        XCTAssertEqual(section.displayType, .queue)
    }

    func testDisplayTypeUnknownDefaultsToSquare() {
        let section = Section.mock(type: "unknown_type")
        XCTAssertEqual(section.displayType, .square)
    }

    func testSectionDecoding() throws {
        let json = """
        {
            "name": "Top Podcasts",
            "type": "square",
            "content_type": "podcast",
            "order": 1,
            "content": [
                {
                    "podcast_id": "123",
                    "name": "NPR News",
                    "description": "News podcast",
                    "avatar_url": "https://example.com/img.png",
                    "episode_count": 50,
                    "duration": 3600
                }
            ]
        }
        """
        let data = json.data(using: .utf8)!
        let section = try JSONDecoder().decode(Section.self, from: data)
        XCTAssertEqual(section.name, "Top Podcasts")
        XCTAssertEqual(section.contentType, "podcast")
        XCTAssertEqual(section.order, 1)
        XCTAssertEqual(section.content.count, 1)
        XCTAssertEqual(section.content.first?.name, "NPR News")
    }

    func testSectionDecodingWithStringOrder() throws {
        let json = """
        {
            "name": "Results",
            "type": "square",
            "content_type": "podcast",
            "order": "3",
            "content": []
        }
        """
        let data = json.data(using: .utf8)!
        let section = try JSONDecoder().decode(Section.self, from: data)
        XCTAssertEqual(section.order, "3")
        XCTAssertEqual(section.order.intValue, 3)
    }
}
