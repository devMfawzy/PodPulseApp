//
//  QueueItemView.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import SwiftUI

struct QueueItemView: View {
    let item: ContentItem

    var body: some View {
        HStack(spacing: 12) {
            CachedAsyncImage(url: item.avatarURL, cornerRadius: 10)
                .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(AppFont.medium(size: 15))
                    .lineLimit(2)
                    .foregroundColor(.primary)

                if let subtitle = item.subtitle ?? item.episodeCountText {
                    Text(subtitle)
                        .font(AppFont.regular(size: 12))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }

                if !item.formattedDuration.isEmpty {
                    Text(item.formattedDuration)
                        .font(AppFont.regular(size: 11))
                        .foregroundColor(.secondary)
                }
            }

            Spacer()
        }
        .frame(width: 300)
    }
}
