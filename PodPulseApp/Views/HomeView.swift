//
//  HomeView.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 06/03/2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()

                if viewModel.isLoading && viewModel.sections.isEmpty {
                    ProgressView("loading")
                } else if let error = viewModel.errorMessage, viewModel.sections.isEmpty {
                    errorView(error)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.sections) { section in
                                SectionView(section: section)
                            }
                        }
                        .padding(.vertical)
                    }
                    .refreshable {
                        await viewModel.refresh()
                    }
                }
            }
            .navigationTitle(String(localized: "home_title"))
            .navigationBarTitleDisplayMode(.inline)
            .accessibilityIdentifier("homeScreen")
            .task {
                if viewModel.sections.isEmpty {
                    await viewModel.loadSections()
                }
            }
        }
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text(message)
                .font(AppFont.regular(size: 15))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Button("retry") {
                Task {
                    await viewModel.loadSections()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
