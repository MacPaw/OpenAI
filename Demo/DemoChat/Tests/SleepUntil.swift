/// Sleeps until `condition` holds, for state changed on another thread, such as URL loading, or after a delay.
@MainActor
func sleepUntil(_ condition: () -> Bool) async throws {
    while !condition() {
        try await Task.sleep(for: .milliseconds(10))
    }
}
