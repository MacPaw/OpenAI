//
//  ChatMessagesPacer.swift
//  DemoChat
//

import Combine
import ExyteChat

/// Passes a chat's messages on to ExyteChat's `ChatView` no more often than it can apply them, skipping to the
/// latest.
///
/// `ChatView` applies every change to its messages as a separate table update, in a serial queue that doesn't
/// merge them. Animated, an update takes about half a second (measured on iOS 27), while a streamed reply
/// changes its message every few dozen milliseconds. Changes passed on faster than that queue up, and the view
/// keeps replaying them long after the stream has ended, so this passes on at most one change per
/// `minimumInterval`: the first right away, and later ones as the latest messages once the interval has passed.
///
/// Updating without animation would be fast enough for every change, but `ChatView` takes the animation mode
/// only from `updateTransaction`, which returns before the table receives the update and applies the mode to
/// only some updates.
@MainActor
final class ChatMessagesPacer: ObservableObject {
    /// About how long `ChatView` takes to apply an animated update.
    static let chatViewUpdateInterval: Duration = .milliseconds(500)

    @Published private(set) var messages: [ExyteChat.Message] = []

    private let minimumInterval: Duration
    private var pendingMessages: [ExyteChat.Message]?
    private var updateTask: Task<Void, Never>?
    private var lastUpdate: ContinuousClock.Instant?

    init(minimumInterval: Duration) {
        self.minimumInterval = minimumInterval
    }

    func update(to messages: [ExyteChat.Message]) {
        pendingMessages = messages
        guard updateTask == nil else { return }
        guard let deadline = lastUpdate.map({ $0 + minimumInterval }), deadline > .now else {
            applyPendingMessages()
            return
        }
        updateTask = Task {
            try? await Task.sleep(until: deadline)
            updateTask = nil
            applyPendingMessages()
        }
    }

    private func applyPendingMessages() {
        guard let pendingMessages else { return }
        self.pendingMessages = nil
        lastUpdate = .now
        messages = pendingMessages
    }
}
