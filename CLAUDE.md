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
