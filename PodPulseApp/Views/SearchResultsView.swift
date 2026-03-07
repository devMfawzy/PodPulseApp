//
//  SearchView.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 06/03/2026.
//

import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(2)
            } else if viewModel.sections.isEmpty && !viewModel.query.isEmpty {
                Text("no_results_found")
                    .font(AppFont.regular(size: 16))
                    .foregroundColor(.secondary)
            } else if viewModel.sections.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("search_for_content")
                        .font(AppFont.regular(size: 16))
                        .foregroundColor(.secondary)
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.sections) { section in
                            SectionView(section: section)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
