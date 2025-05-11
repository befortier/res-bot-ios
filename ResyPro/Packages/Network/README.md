# Network

This package provides a simple abstraction layer for networking in Swift-based apps, including:

- `NetworkClient` – the core request interface
- `NetworkService` – a default implementation
- `NetworkError` – standard error definitions

## Usage

Import the package and use `NetworkService` for making HTTP calls.

```swift
import Network

let client = NetworkService()
```
