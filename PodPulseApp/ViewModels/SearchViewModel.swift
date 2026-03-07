//
//  SearchViewModel.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var sections: [Section] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiService: APIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>?

    init(apiService: APIServiceProtocol? = nil) {
        self.apiService = apiService ?? APIService.shared
        setupDebounce()
    }

    private func setupDebounce() {
        $query
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }

    private func performSearch(query: String) {
        searchTask?.cancel()

        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            sections = []
            errorMessage = nil
            isLoading = false
            return
        }

        searchTask = Task {
            isLoading = true
            do {
                let results = try await apiService.search(query: trimmed)
                guard !Task.isCancelled else { return }
                sections = results
                errorMessage = nil
            } catch {
                guard !Task.isCancelled else { return }
                if !(error is CancellationError) {
                    errorMessage = error.localizedDescription
                }
            }
            isLoading = false
        }
    }
}
