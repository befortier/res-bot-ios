# Network

The **Network** package provides a lightweight abstraction over ``URLSession`` and utilities for building HTTP requests.
It works on both iOS and macOS.

Included components:

- `NetworkClient` – the core request interface
- `NetworkService` – a default implementation
- `NetworkError` – standard error definitions
- ``BasicHTTPClient`` and ``BearerHTTPClient`` – lightweight clients for
  unauthenticated and authenticated requests

## Usage

Import the package and use `NetworkService` for making HTTP calls.

```swift
import Network

let client = BearerHTTPClient(
    configuration: ResyHeaderConfiguration(
        bearerToken: "<user-token>",
        resyAuthToken: "<resy-token>"
    )
)
let service = NetworkServiceLive(client: client)
```

`NetworkServiceLive` automatically loads bundled fixture JSON when an ``Endpoint`` defines a `fixturesPath`, enabling reliable testing.

## Running Tests

```
cd ResyPro/Packages/Network
swift test
```
