//
//  HomeViewModel.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var sections: [Section] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol? = nil) {
        self.apiService = apiService ?? APIService.shared
    }

    func loadSections() async {
        isLoading = true
        errorMessage = nil
        do {
            sections = try await apiService.fetchHomeSections()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func refresh() async {
        errorMessage = nil
        await withCheckedContinuation { continuation in
            Task {
                do {
                    self.sections = try await apiService.fetchHomeSections()
                } catch {
                    self.errorMessage = error.localizedDescription
                }
                continuation.resume()
            }
        }
    }
}
