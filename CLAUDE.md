# Agent instructions

## Build the Demo app when it could be affected

Build the Demo app in addition to `swift build` / `swift test` when a change
touches `Demo`'s own code, or the **public** API of `Sources/OpenAI` (public
types/members in generated `Components.Schemas`, the `Edited`/`Facade` types,
streaming events, etc.):

```sh
xcodebuild -project Demo/Demo.xcodeproj -scheme Demo \
  -destination "generic/platform=iOS Simulator" build
```

`Demo` is not covered by any CI workflow, so nothing else catches it when it
falls behind — e.g. an exhaustive `switch` over a `Facade` enum (like
`ResponseStreamEvent`) that doesn't get a new case added, or `DemoChat` code
that still calls a removed/renamed API. The goal is for Demo to stay complete
and up to date with the package, not silently lag behind.

A change confined to the package's internals — `private`/`internal` members,
implementation details behind an unchanged public signature, doc comments,
tests — cannot break a consumer's build, so skip the Demo build for those
(along with docs, CI config, and other changes that plainly can't touch
`Demo`). When in doubt about whether something is really internal-only, build
Demo anyway.

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

## Wait for explicit instructions to commit and push

The user wants to review the diff before it becomes a commit, so don't run
`git commit` or `git push` unless they explicitly ask for it at that point.
Get the working tree ready (changes made, build/tests passing) and say so,
but leave committing to them to request.
