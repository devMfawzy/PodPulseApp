//
//  PodPulseAppApp.swift
//  PodPulseApp
//
//  Created by Mohamed Fawzy on 06/03/2026.
//

import SwiftUI

@main
struct PodPulseAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, .latinLocale)
        }
    }
}


extension Locale {
    static var latinLocale: Locale {
        var components = Locale.Components(locale: .current)
        components.numberingSystem = .init("latn")
        return Locale(components: components)
    }
}
