//
//  SquareItemView.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import SwiftUI

struct SquareItemView: View {
    let item: ContentItem

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            CachedAsyncImage(url: item.avatarURL, cornerRadius: 12)
                .frame(height: 140)

            Text(item.name)
                .font(AppFont.medium(size: 12))
                .lineLimit(2)
                .foregroundColor(.primary)

            if let subtitle = item.subtitle ?? item.episodeCountText {
                Text(subtitle)
                    .font(AppFont.regular(size: 11))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .frame(width: 140)
    }
}
