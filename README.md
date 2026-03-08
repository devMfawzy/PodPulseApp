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

## Screenshots 

|       |  |
| :---:       |    :----:   |
| <img width="1320" height="2868" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-03-08 at 18 50 06" src="https://github.com/user-attachments/assets/ee64aa11-697a-43f9-867f-4452e0022c8e" /> | <img width="1320" height="2868" alt="Simulator Screenshot - Clone 5 of iPhone 17 Pro Max - 2026-03-08 at 18 50 10" src="https://github.com/user-attachments/assets/7907b93b-e81e-4947-aac9-3d54939d5729" />|
| <img width="1320" height="2868" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-03-08 at 19 08 07" src="https://github.com/user-attachments/assets/2f652c03-095d-41da-88cf-6d8e6c9a4397" /> | <img width="1320" height="2868" alt="Simulator Screenshot - Clone 5 of iPhone 17 Pro Max - 2026-03-08 at 19 08 12" src="https://github.com/user-attachments/assets/c33bee4b-2a0e-4c27-b51e-34863231746f" />|
|<img width="1320" height="2868" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-03-08 at 19 11 55" src="https://github.com/user-attachments/assets/47549e6f-6b08-44c0-ad51-bd6563193f7c" /> |<img width="1320" height="2868" alt="Simulator Screenshot - Clone 5 of iPhone 17 Pro Max - 2026-03-08 at 19 11 58" src="https://github.com/user-attachments/assets/f6f47e6a-640f-4992-b5c0-3b75bdbf62f8" />|

