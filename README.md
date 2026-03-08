# PodPulse

A podcast browsing app built for a mobile developer assessment. Displays categorized content (podcasts, episodes, audiobooks, audio articles) from a remote API with search functionality.

## Build & Run

```bash
git clone https://github.com/devMfawzy/PodPulseApp.git
cd PodPulseApp
open PodPulseApp.xcodeproj
```

Then press **Cmd + R** in Xcode to build and run.

## Solution Approach

**MVVM** architecture with protocol-based dependency injection, **SwiftUI** for the Home screen and **UIKit** for the Search screen.

- **Home Screen** (SwiftUI): Fetches sections from API, each rendered with a layout based on its type (square, big square, two-line grid, queue). Supports pull-to-refresh.
- **Search Screen** (UIKit + SwiftUI): `UISearchController` with 200ms debounce, cancels previous requests to avoid redundant calls. Results displayed using the same section components.
- **Networking**: Async/await with `APIServiceProtocol` for testability. SDWebImageSwiftUI for cached image loading.
- **Localization**: English and Arabic via String Catalogs.
- **Custom Fonts**: IBMPlexSansArabic family via `AppFont` helper.

## Challenges

1. **Inconsistent API types**: Fields like `order` and `duration` return either `Int` or `String`. Solved with an `IntOrString` enum that decodes both.
2. **Pull-to-refresh cancellation**: SwiftUI's `.refreshable` cancels the URLSession task on view updates. Solved by wrapping the network call in an unstructured `Task` via `withCheckedContinuation`.

## Suggestions for Improvement

- Pagination for large content lists
- Offline caching: to cache API responses locally (Core Data, SwiftData, or Realm)
- Content detail screen with playback controls

## Tech Stack

- iOS 16+ | Swift 5.0 | MVVM
- SwiftUI + UIKit | Async/Await + Combine
- SDWebImageSwiftUI (SPM)
