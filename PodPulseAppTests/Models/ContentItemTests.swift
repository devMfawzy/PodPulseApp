//
//  ContentItemTests.swift
//  PodPulseAppTests
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import XCTest
@testable import PodPulseApp

@MainActor
final class ContentItemTests: XCTestCase {

    func testFormattedDurationHoursOnly() {
        let item = ContentItem.mockPodcast()
        let expected = String(format: String(localized: "hours_short"), 1)
        XCTAssertEqual(item.formattedDuration, expected)
    }

    func testFormattedDurationHoursAndMinutes() {
        let item = ContentItem(
            name: "Test", description: nil, avatarURL: nil, duration: .int(5400),
            podcastID: "1", episodeCount: nil, language: nil,
            episodeID: nil, podcastName: nil, authorName: nil,
            releaseDate: nil, audioURL: nil, audiobookID: nil, articleID: nil
        )
        let expected = String(format: String(localized: "hours_minutes_short"), 1, 30)
        XCTAssertEqual(item.formattedDuration, expected)
    }

    func testFormattedDurationMinutesOnly() {
        let item = ContentItem(
            name: "Test", description: nil, avatarURL: nil, duration: .int(300),
            podcastID: "1", episodeCount: nil, language: nil,
            episodeID: nil, podcastName: nil, authorName: nil,
            releaseDate: nil, audioURL: nil, audiobookID: nil, articleID: nil
        )
        let expected = String(format: String(localized: "minutes_short"), 5)
        XCTAssertEqual(item.formattedDuration, expected)
    }

    func testFormattedDurationEmpty() {
        let item = ContentItem(
            name: "Test", description: nil, avatarURL: nil, duration: nil,
            podcastID: "1", episodeCount: nil, language: nil,
            episodeID: nil, podcastName: nil, authorName: nil,
            releaseDate: nil, audioURL: nil, audiobookID: nil, articleID: nil
        )
        XCTAssertEqual(item.formattedDuration, "")
    }

    func testIDIsUniquePerInstance() {
        let item1 = ContentItem.mockPodcast(id: "podcast123")
        let item2 = ContentItem.mockPodcast(id: "podcast123")
        XCTAssertNotEqual(item1.id, item2.id)
        XCTAssertFalse(item1.id.isEmpty)
    }

    func testSubtitleForEpisode() {
        let item = ContentItem.mockEpisode()
        XCTAssertEqual(item.subtitle, "Parent Podcast")
    }

    func testSubtitleFallsBackToAuthorName() {
        let item = ContentItem(
            name: "Test", description: nil, avatarURL: nil, duration: nil,
            podcastID: nil, episodeCount: nil, language: nil,
            episodeID: "1", podcastName: nil, authorName: "John",
            releaseDate: nil, audioURL: nil, audiobookID: nil, articleID: nil
        )
        XCTAssertEqual(item.subtitle, "John")
    }

    func testSubtitleNilWhenNoPodcastNameOrAuthor() {
        let item = ContentItem(
            name: "Test", description: nil, avatarURL: nil, duration: nil,
            podcastID: nil, episodeCount: nil, language: nil,
            episodeID: nil, podcastName: nil, authorName: nil,
            releaseDate: nil, audioURL: nil, audiobookID: nil, articleID: nil
        )
        XCTAssertNil(item.subtitle)
    }

    func testEpisodeCountText() {
        let item = ContentItem.mockPodcast()
        let expected = String(format: String(localized: "episodes_count"), 10)
        XCTAssertEqual(item.episodeCountText, expected)
    }

    func testEpisodeCountTextNilWhenNoCount() {
        let item = ContentItem.mockEpisode()
        XCTAssertNil(item.episodeCountText)
    }

    func testDurationValueFromString() throws {
        let json = #"{"name":"Test","duration":"7200","podcast_id":"1"}"#
        let data = json.data(using: .utf8)!
        let item = try JSONDecoder().decode(ContentItem.self, from: data)
        XCTAssertEqual(item.duration?.intValue, 7200)
    }

    func testDurationValueFromInt() throws {
        let json = #"{"name":"Test","duration":3600,"podcast_id":"1"}"#
        let data = json.data(using: .utf8)!
        let item = try JSONDecoder().decode(ContentItem.self, from: data)
        XCTAssertEqual(item.duration?.intValue, 3600)
    }
}
