# Contributor Guide

This repository contains the **ResyPro** iOS application along with several local Swift packages in `ResyPro/Packages/`. The project is licensed under the MIT license.

## Development Requirements

- Xcode 16.3 or later with the Swift 6 toolchain.
- Open `ResyPro.xcodeproj` (or a workspace that includes it) to work in Xcode.
- All new features should preferably live in local Swift packages under `ResyPro/Packages`.

## Building

Validate your changes by building from the command line:

```bash
/Applications/Xcode-16.3.0.app/Contents/Developer/usr/bin/xcodebuild \
  -scheme ResyPro \
  -destination "platform=iOS Simulator,name=iPhone 15" build
```

There are currently **no unit tests**. Focus on compiling successfully.

## Conventions

- Keep generated files such as `.DS_Store` out of version control.
- Follow standard Swift style. No formatter or linter is enforced yet.
- Provide a clear summary of changes and manual testing steps in pull request descriptions.
