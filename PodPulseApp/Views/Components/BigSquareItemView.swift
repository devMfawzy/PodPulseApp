//
//  BigSquareItemView.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import SwiftUI

struct BigSquareItemView: View {
    let item: ContentItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            CachedAsyncImage(url: item.avatarURL, cornerRadius: 16)
                .frame(height: 200)

            Text(item.name)
                .font(AppFont.semiBold(size: 15))
                .lineLimit(2)
                .foregroundColor(.primary)

            if let subtitle = item.subtitle {
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
        .frame(width: 200)
    }
}
