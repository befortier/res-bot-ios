# Venues

The `Venues` package defines core models, networking layers, data mappers, and SwiftUI views
for displaying and interacting with venue data in your app.

## Features

- SwiftData models for persisting venue information
- DTOs and mappers for converting backend responses
- Networking endpoints for loading venues
- Reusable SwiftUI components such as `VerticalVenueCard` and `VenueDetailsView`

## Includes

- Venue and location models with SwiftData support
- DTOs and mappers for backend interaction
- Endpoints for loading venues
- SwiftUI components like:
  - `VenuesListView`
  - `VenueCard`
  - `SeatingOptionSelectionView`

## Adding to Your Project

Add the package as a local dependency in `Package.swift`:

```swift
 .package(path: "Packages/Venues")
```

Then import `Venues` where needed.

## Usage

```swift
import Venues

VenuesListView(viewModel: ...)
```
