//
//  ContentItem.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 06/03/2026.
//

import Foundation

struct ContentItem: Codable, Identifiable {
    let id = UUID().uuidString // using UUIDs because IDs like "article_id" are not unique

    // Common fields
    let name: String
    let description: String?
    let avatarURL: String?
    let duration: IntOrString?
    
    // Podcast fields
    let podcastID: String?
    let episodeCount: IntOrString?
    let language: String?
    
    // Episode fields
    let episodeID: String?
    let podcastName: String?
    let authorName: String?
    let releaseDate: String?
    let audioURL: String?
    let audiobookID: String?
    let articleID: String?
    
    enum CodingKeys: String, CodingKey {
        case name, description, duration, language
        case avatarURL = "avatar_url"
        case podcastID = "podcast_id"
        case episodeCount = "episode_count"
        case episodeID = "episode_id"
        case podcastName = "podcast_name"
        case authorName = "author_name"
        case releaseDate = "release_date"
        case audioURL = "audio_url"
        case audiobookID = "audiobook_id"
        case articleID = "article_id"
    }
}

extension ContentItem {
    var formattedDuration: String {
        guard let seconds = duration?.intValue else { return "" }
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        if hours > 0 && minutes <= 0 {
            return String(format: String(localized: "hours_short"), hours)
        }
        if hours > 0 {
            return String(format: String(localized: "hours_minutes_short"), hours, minutes)
        }
        return String(format: String(localized: "minutes_short"), minutes)
    }
    
    var subtitle: String? {
        podcastName ?? authorName
    }
    
    var episodeCountText: String? {
        guard let count = episodeCount?.intValue else { return nil }
        return String(localized: "\(count) episodes")
    }
}
