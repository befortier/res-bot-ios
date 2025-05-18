# DesignSystem

The `DesignSystem` Swift package defines reusable UI components, modifiers, and styles for your app.
It promotes consistency across your SwiftUI views and helps maintain a cohesive design language.

## Features

- Buttons and ButtonStyles
- Progress indicators
- Image carousels
- Card modifiers
- Date selection views
- Error views
- Text fields with icons

## Usage

```swift
import DesignSystem

DefaultProgressView()
SelectDateRangeView(...)
```

### Installation

Add the package to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(path: "Packages/DesignSystem")
]
```

Then add `DesignSystem` to your target dependencies.

### Previews

All components include SwiftUI previews to speed up development. Use the `#Preview` macros in Xcode to explore layouts and styles interactively.
