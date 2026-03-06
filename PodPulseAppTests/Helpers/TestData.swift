//
//  TestData.swift
//  PodPulseAppTests
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import Foundation
@testable import PodPulseApp

extension Section {
    static func mock(
        name: String = "Test Section",
        type: String = "square",
        contentType: String = "podcast",
        order: IntOrString = 1,
        content: [ContentItem] = []
    ) -> Section {
        Section(name: name, type: type, contentType: contentType, order: order, content: content)
    }
}

extension ContentItem {
    static func mockPodcast(
        id: String = "1",
        name: String = "Test Podcast"
    ) -> ContentItem {
        ContentItem(
            name: name,
            description: "A test podcast",
            avatarURL: "https://example.com/image.png",
            duration: .int(3600),
            podcastID: id,
            episodeCount: .int(10),
            language: "en",
            episodeID: nil,
            podcastName: nil,
            authorName: nil,
            releaseDate: nil,
            audioURL: nil,
            audiobookID: nil,
            articleID: nil
        )
    }

    static func mockEpisode(
        id: String = "1",
        name: String = "Test Episode"
    ) -> ContentItem {
        ContentItem(
            name: name,
            description: "A test episode",
            avatarURL: "https://example.com/image.png",
            duration: .int(1800),
            podcastID: nil,
            episodeCount: nil,
            language: nil,
            episodeID: id,
            podcastName: "Parent Podcast",
            authorName: "Author",
            releaseDate: "2025-01-01",
            audioURL: "https://example.com/audio.mp3",
            audiobookID: nil,
            articleID: nil
        )
    }
}
