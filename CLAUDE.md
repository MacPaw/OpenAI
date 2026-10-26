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

## Running `xcodebuild test` without the post-failure diagnostics

`DemoChat`'s tests (and anything else run on a simulator) are run with
`xcodebuild test`. By default, pass `-collect-test-diagnostics never`:

```sh
cd Demo/DemoChat
xcodebuild test -scheme DemoChat \
  -destination "platform=iOS Simulator,name=<booted simulator>" \
  -collect-test-diagnostics never
```

Without it, a run with **any failing test** prints its results and then
doesn't exit: `xcodebuild` runs `simctl diagnose` on the simulator to collect
a sysdiagnose-style bundle and waits for it, with no output in the meantime.
That usually takes under a minute, but it's allowed up to 10 minutes and
sometimes uses all of them. It looks like a hang, and it slows down every
deliberate "does this test fail without the fix?" check. Passing runs aren't
affected.

The bundle (simulator logs, crash reports, system state) is worth having when
a failure's cause is outside the test code: a crash or a hang in the app or
test process, simulator- or system-level behavior, or a UI test. Leave the
option out for those runs. A failing `#expect` in a unit test already says
what went wrong, and the bundle adds nothing to it.

Killing a waiting `xcodebuild` doesn't stop its `simctl diagnose`. If one was
interrupted, check for leftovers with `pgrep -fl "simctl diagnose"` and stop
them before the next run.

## Make a type testable by injecting its dependencies

When a test needs to control something a type depends on, such as an API
client, a clock, a delay or a file read, pass it in explicitly: an
initializer parameter, typed as a protocol or a closure. `FilesStore` in
`DemoChat` is an example: it takes a `FilesEndpointProtocol` client and a
`readFile` closure.

Prefer that over workarounds such as test-only flags or hooks, `#if DEBUG`
branches, subclassing to override behavior, or global state a test swaps
out. Don't make a type's `private` members less private for a test either:
test the type through the API its callers use, and inject whatever the test
needs to control.

Injection is the default, not a hard rule: where another technique clearly
fits a case better, use that instead.

## Handle errors instead of discarding them with `try?`

Don't use `try?` to make an error go away. Catch it and decide what it
means:

- **Propagate it** (`throws`) when the caller is in a better position to
  handle it, for example to show it to the user.
- **Ignore an expected error explicitly:** check for its type or code, ignore
  only that one, and say why. `FilesStore` is an example: it returns without
  throwing when a request is cancelled (`CancellationError` or
  `URLError.cancelled`), since that isn't a failure to report, and throws any
  other error.
- **Log it** when there's nothing meaningful to do with it, in the project's
  preferred way of logging errors.

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

## Commit when it's time, never push

Commit when you judge a coherent piece of work is done (changes made,
build/tests passing), in logical commits with clear messages. When on `main`,
create a branch first. Never run `git push` (or open a PR) unless the user
explicitly asks for it at that point; the user decides what leaves their
machine.

## Documentation comments come from official sources

When a public declaration mirrors part of the OpenAI API (a type, property,
method, parameter or enum case), take its documentation comment from an
official source instead of writing your own description. Official text is up
to date and well formatted (lists, links, bold, `code`), and that Markdown
works in Swift documentation comments too, so copy both the wording and the
formatting. In order of preference:

1. The `description` fields in this repository's `openapi.yaml`. They are the
   text of the [API Reference](https://platform.openai.com/docs/api-reference)
   in a form that is easy to search. The vendored copy can lag behind; the
   latest is at https://github.com/openai/openai-openapi.
2. The official SDKs generated from the same spec, such as
   [openai-python](https://github.com/openai/openai-python) and
   [openai-java](https://github.com/openai/openai-java).
3. The API Reference web page itself.

Adapt or rephrase it only where it doesn't fit as is: property and parameter
names (`expires_after` → `expiresAfter`), relative links made absolute,
formatting Swift documentation comments can't render, or wording that doesn't
hold for the Swift declaration. Text that fits stays unchanged.

Text that is about this SDK rather than the API, such as which method to use
instead, why a type is hand-written, or what a Swift-only convenience does,
has no official wording; write it yourself, in its own paragraph, so it is
clear which text is OpenAI's. If no official source describes something,
leave it undocumented and say so in your summary instead of inventing a
description.
