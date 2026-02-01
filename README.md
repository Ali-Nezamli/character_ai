# CharacterAI

A SwiftUI iOS application for browsing and interacting with AI characters. Built with modern iOS architecture patterns including MVVM, programmatic navigation, and a clean networking layer.

## Screenshots

<!-- Add your screenshots here -->
<!-- ![Home Screen](screenshots/home.png) -->

## Tech Stack

- **SwiftUI** - Declarative UI framework
- **SwiftData** - Local persistence
- **Combine** - Reactive programming for state management
- **async/await** - Modern concurrency for networking
- **iOS 17+** / **Xcode 16+**

## Architecture

This app follows the **MVVM (Model-View-ViewModel)** architecture pattern with a clean separation of concerns:

```
┌─────────────────────────────────────────────────────────────┐
│                         View                                │
│  (SwiftUI Views - observes ViewModel via @StateObject)      │
└─────────────────────────────┬───────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      ViewModel                              │
│  (Holds UI state, handles user actions, calls Services)     │
└─────────────────────────────┬───────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                       Service                               │
│  (Business logic, data transformation)                      │
└─────────────────────────────┬───────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                   NetworkService                            │
│  (HTTP requests via URLSession)                             │
└─────────────────────────────────────────────────────────────┘
```

### Data Flow

```
User Action → View → ViewModel → Service → NetworkService → API
                                                              │
User sees ← View ← ViewModel ← Service ← NetworkService ←────┘
```

## Project Structure

```
characterAi/
├── App/
│   └── Pass2PastiosApp.swift      # App entry point, navigation setup
│
├── Core/
│   ├── Extensions/                 # Swift type extensions
│   │   ├── Color+Extensions.swift
│   │   ├── Date+Extensions.swift
│   │   ├── Router+Extensions.swift
│   │   ├── String+Extensions.swift
│   │   └── View+Extensions.swift
│   │
│   ├── Models/
│   │   └── Item.swift              # SwiftData model
│   │
│   ├── Services/
│   │   ├── Endpoint.swift          # Protocol for API endpoints
│   │   └── NetworkService.swift    # Centralized networking layer
│   │
│   ├── Utilities/
│   │   ├── AppConstants.swift      # App-wide constants
│   │   ├── AppIcons.swift          # Icon assets
│   │   ├── DependencyContainer.swift
│   │   └── Router.swift            # Navigation management
│   │
│   ├── ViewModels/
│   │   └── BaseViewModel.swift     # Base class for all ViewModels
│   │
│   └── Views/
│       └── Components/             # Reusable UI components
│           ├── CachedAsyncImage.swift
│           ├── EmptyStateView.swift
│           ├── ErrorView.swift
│           ├── FloatingButton.swift
│           ├── GradientBackground.swift
│           ├── LoadingView.swift
│           ├── PrimaryButton.swift
│           └── StarRating.swift
│
├── Features/
│   ├── Home/
│   │   ├── Models/
│   │   │   └── Character.swift     # Character data model
│   │   ├── Services/
│   │   │   ├── CharactersEndpoint.swift
│   │   │   └── HomeService.swift
│   │   ├── ViewModels/
│   │   │   └── HomeViewModel.swift
│   │   └── Views/
│   │       ├── CharacterCardView.swift
│   │       ├── CharactersListView.swift
│   │       ├── ExperienceCardView.swift
│   │       ├── ExperienceListView.swift
│   │       ├── HeaderView.swift
│   │       └── HomeView.swift
│   │
│   └── ExperienceDetails/
│       ├── ExperienceDetailView.swift
│       └── ExperienceDetailsHeader.swift
│
├── Resources/                      # Fonts, JSON files, etc.
│
└── Assets.xcassets/               # Images, colors, app icon
```

## Key Components

### Router (Programmatic Navigation)

The app uses a centralized `Router` class for navigation, enabling:
- Programmatic navigation from ViewModels
- Deep linking support
- Type-safe navigation with `Route` enum

```swift
// Define routes
enum Route: Hashable {
    case home
    case experienceDetail(CharacterItemModel)
    case settings
}

// Navigate programmatically
router.navigate(to: .experienceDetail(character))
router.navigateBack()
router.navigateToRoot()
```

### NetworkService (API Layer)

A generic, reusable networking layer using async/await:

```swift
// Make API calls with automatic JSON decoding
let characters: [CharacterItemModel] = try await NetworkService.shared.request(
    CharactersEndpoint.getCharacters
)
```

### Endpoint Protocol

Type-safe API endpoint definitions:

```swift
enum CharactersEndpoint: Endpoint {
    case getCharacters
    case getCharacter(id: String)

    var path: String {
        switch self {
        case .getCharacters: return "characters"
        case .getCharacter(let id): return "characters/\(id)"
        }
    }

    var method: HTTPMethod { .GET }
}
```

### BaseViewModel

All ViewModels inherit from `BaseViewModel` which provides:
- Loading state management
- Error handling
- Combine cancellables

```swift
@MainActor
class HomeViewModel: BaseViewModel {
    @Published var characters: [CharacterItemModel] = []

    func fetchCharacters() async {
        setLoading(true)
        do {
            characters = try await service.fetchCharacters()
            setSuccess()
        } catch {
            setError(error.localizedDescription)
        }
    }
}
```

## Getting Started

### Prerequisites

- Xcode 16.0+
- iOS 17.0+
- macOS Ventura or later

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/characterAi.git
```

2. Open the project in Xcode
```bash
cd characterAi
open characterAi.xcodeproj
```

3. Build and run (⌘+R)

## Adding New Features

### 1. Create a New Feature Module

```
Features/
└── YourFeature/
    ├── Models/
    │   └── YourModel.swift
    ├── Services/
    │   ├── YourEndpoint.swift
    │   └── YourService.swift
    ├── ViewModels/
    │   └── YourViewModel.swift
    └── Views/
        └── YourView.swift
```

### 2. Add Route

```swift
// In Router.swift
enum Route: Hashable {
    // ... existing routes
    case yourFeature(YourModel)
}
```

### 3. Register Navigation Destination

```swift
// In Pass2PastiosApp.swift
.navigationDestination(for: Route.self) { route in
    route.destination()
}

// In Router+Extensions.swift
extension Route {
    @ViewBuilder
    func destination() -> some View {
        switch self {
        // ... existing cases
        case .yourFeature(let model):
            YourFeatureView(model: model)
        }
    }
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Ali Nezamli** - [GitHub](https://github.com/yourusername)
