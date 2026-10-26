import Combine
import ExyteChat
import Testing
@testable import DemoChat

// Some tests wait for a held-back update; if it never comes, fail the test instead of waiting forever.
@MainActor
@Suite(.timeLimit(.minutes(1)))
struct ChatMessagesPacerTests {
    private static let interval: Duration = .milliseconds(50)

    @Test
    func firstUpdateIsAppliedRightAway() {
        let pacer = ChatMessagesPacer(minimumInterval: Self.interval)

        pacer.update(to: .mocks(["1"]))

        #expect(pacer.messages.map(\.id) == ["1"])
    }

    @Test
    func updatesWithinTheIntervalAreAppliedOnceAsTheLatest() async throws {
        let pacer = ChatMessagesPacer(minimumInterval: Self.interval)
        var updates: [(ids: [String], time: ContinuousClock.Instant)] = []
        let subscription = pacer.$messages.dropFirst().sink { messages in
            updates.append((messages.map(\.id), .now))
        }
        let start = ContinuousClock.now

        pacer.update(to: .mocks(["1"]))
        pacer.update(to: .mocks(["1", "2"]))
        pacer.update(to: .mocks(["1", "2", "3"]))
        #expect(pacer.messages.map(\.id) == ["1"])

        try await sleepUntil { updates.count >= 2 }
        #expect(updates.map(\.ids) == [["1"], ["1", "2", "3"]])
        #expect(updates[1].time - start >= Self.interval)

        // Nothing is left to apply after that.
        try await Task.sleep(for: Self.interval * 2)
        #expect(updates.count == 2)
        subscription.cancel()
    }

    @Test
    func updateAfterTheIntervalIsAppliedRightAway() async throws {
        let pacer = ChatMessagesPacer(minimumInterval: Self.interval)
        pacer.update(to: .mocks(["1"]))

        try await Task.sleep(for: Self.interval)
        pacer.update(to: .mocks(["1", "2"]))

        #expect(pacer.messages.map(\.id) == ["1", "2"])
    }

    @Test
    func releasedPacerIsDeallocatedWhileHoldingAnUpdateBack() {
        var pacer: ChatMessagesPacer? = ChatMessagesPacer(minimumInterval: Self.interval)
        weak var releasedPacer = pacer
        pacer?.update(to: .mocks(["1"]))
        pacer?.update(to: .mocks(["1", "2"]))

        pacer = nil

        #expect(releasedPacer == nil)
    }
}

private extension Array where Element == ExyteChat.Message {
    static func mocks(_ ids: [String]) -> Self {
        let user = ExyteChat.User(id: "assistant", name: "Assistant", avatarURL: nil, type: .system)
        return ids.map { ExyteChat.Message(id: $0, user: user, text: "Message \($0)") }
    }
}
