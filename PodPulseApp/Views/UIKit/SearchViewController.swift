//
//  SearchViewController.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 07/03/2026.
//

import UIKit
import SwiftUI

final class SearchViewController: UIViewController {
    private let viewModel = SearchViewModel()

    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSearchController()
        setupResultsView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.query.isEmpty {
            DispatchQueue.main.async {
                self.searchController.searchBar.becomeFirstResponder()
            }
        }
    }

    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = String(localized: "search_placeholder")
        searchController.searchBar.returnKeyType = .default
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = false
        navigationItem.titleView = searchController.searchBar
    }

    private func setupResultsView() {
        let resultsView = SearchResultsView(viewModel: viewModel)
        let hosting = UIHostingController(rootView: resultsView)
        addChild(hosting)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hosting.view)
        hosting.didMove(toParent: self)

        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        hosting.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
}

// MARK: - SwiftUI Wrapper
struct SearchView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let searchVC = SearchViewController()
        let navController = UINavigationController(rootViewController: searchVC)
        return navController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
