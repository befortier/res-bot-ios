# ProjectFoundation

`ProjectFoundation` is a utility Swift package containing shared models, data access layers, 
and Swift extensions commonly used across multiple modules in the app.

## Includes

- `RemoteViewState` model for tracking async states
- Extensions like `DateFormatter+Extensions`
- Abstracted data store protocols
- CoreData-compatible `ModelContextProtocol`

## Usage

```swift
import ProjectFoundation

let state = RemoteViewState.loading
```
