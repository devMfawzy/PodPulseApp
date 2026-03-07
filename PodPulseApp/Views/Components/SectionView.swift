//
//  SectionView.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import SwiftUI

struct SectionView: View {
    let section: Section
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section header
            HStack {
                Text(section.name)
                    .font(AppFont.bold(size: 20))
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.forward")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            // Section content
            ScrollView(.horizontal, showsIndicators: false) {
                Group {
                    switch section.displayType {
                    case .square:
                        squareLayout
                    case .bigSquare:
                        bigSquareLayout
                    case .twoLinesGrid:
                        twoLinesGridLayout
                    case .queue:
                        queueLayout
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
    }
    
    private var squareLayout: some View {
        LazyHStack(alignment: .top, spacing: 12) {
            ForEach(section.content) { item in
                SquareItemView(item: item)
            }
        }
    }
    
    private var bigSquareLayout: some View {
        LazyHStack(alignment: .top, spacing: 14) {
            ForEach(section.content) { item in
                BigSquareItemView(item: item)
            }
        }
    }
    
    private var twoLinesGridLayout: some View {
        LazyHStack(spacing: 12) {
            // Create columns of 2 items each
            let pairs = stride(from: 0, to: section.content.count, by: 2).map { index in
                let end = min(index + 2, section.content.count)
                return Array(section.content[index..<end])
            }
            ForEach(Array(pairs.enumerated()), id: \.offset) { _, pair in
                VStack(spacing: 10) {
                    ForEach(pair) { item in
                        TwoLinesGridItemView(item: item)
                    }
                    if pair.count == 1 {
                        Spacer()
                    }
                }
            }
        }
    }
    
    private var queueLayout: some View {
        LazyHStack(spacing: 12) {
            ForEach(section.content) { item in
                QueueItemView(item: item)
            }
        }
    }
}
