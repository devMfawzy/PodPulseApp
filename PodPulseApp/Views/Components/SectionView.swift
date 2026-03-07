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
            sectionHeader
            
            sectionContent
        }
        .padding(.vertical, 8)
    }
    
    private var sectionHeader: some View {
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
    }
    
    private var sectionContent: some View {
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
        let rows = [
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10)
        ]
        return LazyHGrid(rows: rows, spacing: 12) {
            ForEach(section.content) { item in
                TwoLinesGridItemView(item: item)
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
