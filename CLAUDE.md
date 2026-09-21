# Agent instructions

## Always build the Demo app too

Whenever a change touches anything the `Demo` app could depend on (public API
in `Sources/OpenAI`, generated `Components.Schemas`, the `Edited`/`Facade`
types, streaming events, etc.), don't stop at `swift build` / `swift test`
passing for the package. Also build the Demo app:

```sh
xcodebuild -project Demo/Demo.xcodeproj -scheme Demo \
  -destination "generic/platform=iOS Simulator" build
```

`Demo` is not covered by any CI workflow, so nothing else catches it when it
falls behind — e.g. an exhaustive `switch` over a `Facade` enum (like
`ResponseStreamEvent`) that doesn't get a new case added, or `DemoChat` code
that still calls a removed/renamed API. The goal is for Demo to stay complete
and up to date with the package, not silently lag behind. Only skip this
build when the change clearly cannot affect Demo (docs, CI config, tests-only
changes, etc.).

## Foundation types that don't exist on Linux

CI builds and tests this package on Linux (Swift 5.10, 6.0, 6.3) in addition
to Apple platforms. Several `Foundation` types you'd normally reach for
without a second thought — `HTTPURLResponse`, `URLSession.*` nested types
(e.g. `ResponseDisposition`), `URLRequest` in some contexts, etc. — live in
the separate `FoundationNetworking` module on Linux, not in `Foundation`
itself. Code that uses them compiles fine on macOS and fails on Linux CI
only, with an error like `'HTTPURLResponse' is unavailable: This type has
moved to the FoundationNetworking module.`

Whenever a new file (source *or* test) references one of these types, guard
the import the way existing files already do:

```swift
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
```

`swift build` / `swift test` passing locally on macOS does not confirm this —
the failure only shows up on Linux. If you can't run the Linux job yourself,
at least double-check new files against this pattern before considering the
change done.
