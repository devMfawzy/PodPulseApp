//
//  Section.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 06/03/2026.
//

import Foundation

struct HomeSectionsResponse: Codable {
    let sections: [Section]
}

struct Section: Codable, Identifiable {
    let name: String
    let type: String
    let contentType: String
    let order: IntOrString
    let content: [ContentItem]

    var id: String { "\(name)-\(order)" }

    var displayType: SectionDisplayType {
        SectionDisplayType(rawValue: type) ?? .square
    }

    enum CodingKeys: String, CodingKey {
        case name, type, order, content
        case contentType = "content_type"
    }
}

enum SectionDisplayType: String {
    case square = "square"
    case twoLinesGrid = "2_lines_grid"
    case bigSquare = "big_square"
    case queue = "queue"

    init?(rawValue: String) {
        switch rawValue {
        case "square": self = .square
        case "2_lines_grid": self = .twoLinesGrid
        case "big_square", "big square": self = .bigSquare
        case "queue": self = .queue
        default: self = .square
        }
    }
}
