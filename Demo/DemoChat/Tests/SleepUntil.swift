import Testing

/// Sleeps until `condition` holds, for state changed on another thread, such as URL loading, or after a delay. Fails the
/// test at the call site if it doesn't hold within `timeout`.
@MainActor
func sleepUntil(
    timeout: Duration = .seconds(5),
    sourceLocation: SourceLocation = #_sourceLocation,
    _ condition: () -> Bool
) async throws {
    let deadline = ContinuousClock.now + timeout
    while !condition() {
        try #require(
            ContinuousClock.now < deadline,
            "The condition didn't hold within \(timeout).",
            sourceLocation: sourceLocation
        )
        try await Task.sleep(for: .milliseconds(10))
    }
}
