//
//  CachedAsyncImage.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import SwiftUI
import SDWebImageSwiftUI

struct CachedAsyncImage: View {
    let url: String?
    var cornerRadius: CGFloat = 8

    var body: some View {
        WebImage(url: url.flatMap { URL(string: $0) }) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .overlay(ProgressView().tint(.gray))
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.primary.opacity(0.1))
        )
    }
}
