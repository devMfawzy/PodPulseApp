//
//  ContentView.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 06/03/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("home_title", systemImage: "house")
                }
            
            SearchView()
                .tabItem {
                    Label("search_title", systemImage: "magnifyingglass")
                }
        }
        .environment(\.locale, Locale(identifier: "ar@numbers=latn"))
    }
}

#Preview {
    ContentView()
}
