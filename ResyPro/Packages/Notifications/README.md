# Notifications

The `Notifications` Swift package powers the bulk reservation notification creation flow in the app. It provides a multi-step SwiftUI interface for selecting venues, times, and party sizes, then submitting a request to the backend.

## Includes

- Step-based UI for scheduling reservation alerts across multiple venues
- Filters and venue selection UI
- Date + party size range configuration
- Submission model and result parsing

## Dependencies

- `Venues`: for venue data
- `Network`: for submitting requests
- `DesignSystem`: for reusable styling
- `Nuke` + `NukeUI`: for image loading

## Usage

Create a ``BulkNotificationFlowViewModel`` with your list of venues and a submitter closure, then present ``BulkNotificationFlowView``:

```swift
let viewModel = BulkNotificationFlowViewModel(
    allVenues: venues,
    submitter: { request in
        // Submit the request to your backend
        try await api.submit(request)
    }
)

BulkNotificationFlowView(viewModel: viewModel)
```

## Tests

Unit tests live under `Tests/NotificationsTests`. They can be executed from Xcode. Running `swift test` is not currently supported because the package requires iOS.
