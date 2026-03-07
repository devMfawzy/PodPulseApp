//
//  TwoLinesGridItemView.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import SwiftUI

struct TwoLinesGridItemView: View {
    let item: ContentItem

    var body: some View {
        HStack(spacing: 10) {
            CachedAsyncImage(url: item.avatarURL, cornerRadius: 8)
                .frame(width: 60, height: 60)

            VStack(alignment: .leading, spacing: 3) {
                Text(item.name)
                    .font(AppFont.medium(size: 12))
                    .lineLimit(2)
                    .foregroundColor(.primary)

                if let subtitle = item.subtitle {
                    Text(subtitle)
                        .font(AppFont.regular(size: 11))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }

                if !item.formattedDuration.isEmpty {
                    Text(item.formattedDuration)
                        .font(AppFont.regular(size: 11))
                        .foregroundColor(.secondary)
                }
            }
        }
        .frame(width: 260, alignment: .leading)
    }
}
