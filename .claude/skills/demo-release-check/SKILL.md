---
name: demo-release-check
description: Run the pre-release manual test pass on the Demo iOS app in the simulator, following the cases in test-cases.md, and report pass/fail/skipped. Use when asked to release-check, smoke-test, or regression-test Demo.
disable-model-invocation: true
---

# Demo release check

Drive the `Demo` app in the iOS Simulator through the cases in
[test-cases.md](test-cases.md) and report the results. Real-API cases spend
tokens, which is why this only runs when invoked explicitly.

Arguments (optional): a section prefix (`R` = Responses, `C` = Chats, …) or
`smoke` to run only cases tagged `[smoke]`. With no argument, run everything.

## Ground rules

- **Never type credentials.** The OpenAI API key (and GitHub token for the MCP
  tab) are entered by the user in the simulator panel. Do not enter, edit or
  clear them, and do not use the API Configuration screen's Save/Continue.
- **Don't change code or commit** during the run. If something fails, report
  it; fixing is a separate step.
- **Navigate by what's on screen.** Demo has no accessibility identifiers and
  the simulator tool taps by coordinates. Take a screenshot before each tap;
  never hardcode coordinates.
- **Screenshot pixels are not points.** Screenshots are downscaled, so convert
  before tapping: `point = pixel × (point width ÷ image width shown)`. On the
  iPhone 17 (402×874 pt) a 920-px-wide screenshot means ×0.437.
- **Simulator actions are order-dependent, so run them one at a time.** Never
  put `tap`, `text` or `swipe` calls in the same parallel tool-call block, even
  when they look independent: a send tap that runs before the typing has
  landed sends a half-typed message (this happened: "Reply" was sent instead of
  the full prompt). Only batch read-only calls, such as a screenshot alongside
  a shell command.
- **Layout can shift between builds.** Coordinates from an earlier run may hit
  the wrong control; re-screenshot after any navigation you didn't just watch.
- **Tabs.** The tab bar is Chats, Responses, Image, Github MCP, Misc. The
  **API Configuration** screen is reachable from Misc's first row.
- **Keep prompts tiny** (see the prompts in the cases) to limit token spend.
- **Screenshots of the API Configuration modal show the key.** Dismiss it with
  **Cancel** without taking a screenshot first.

## Procedure

1. **Read `test-cases.md`** and pick the cases in scope for the argument.
2. **Open the simulator panel first:** `control` → `attach`. If no simulator is
   booted, boot one (prefer `iPhone 17`) and retry.
3. **Build** from the repo root, into a gitignored folder:

   ```sh
   xcodebuild -project Demo/Demo.xcodeproj -scheme Demo \
     -destination "platform=iOS Simulator,name=iPhone 17" \
     -derivedDataPath build/DemoDerivedData build
   ```

   The app lands at
   `build/DemoDerivedData/Build/Products/Debug-iphonesimulator/Demo.app`
   (bundle id `openAI.MacPaw.Demo`). If the build fails, stop and report the
   errors; there is nothing to test.
4. **Launch** it with `control` → `launch`. Do not uninstall or reset the
   simulator: the saved API key lives in app storage and would be lost.
5. **Check the key is configured.** Demo opens the **API Configuration**
   modal on *every* launch. With a saved key it has **Cancel** and **Save**
   buttons: tap **Cancel** (never Save) and carry on. The API Key field shows
   the key in plain text, so never repeat it in chat or the report. If the
   modal has only a **Continue** button and an empty key, or the screen only
   says "Configure an API provider", stop and ask the user to enter their key
   in the panel; resume when they confirm. The **Github MCP** tab needs a
   GitHub token too: if it's empty, mark the `M-` cases that need it BLOCKED.
6. **Run each case** in order. For every case:
   - Follow the steps, taking a screenshot after the action that matters.
   - Compare against **Expect**. Record PASS or FAIL.
   - Wait for streaming or network responses to finish (up to ~30 s) before
     judging. Retry a real-API case once if it fails on a network error.
   - On FAIL, keep the screenshot and a one-line diagnosis, then return to a
     known state (go back, close sheets, dismiss alerts) and continue with
     the next case. A failure never stops the run.
7. **Report** (below).

## Result statuses

| Status | Meaning |
|---|---|
| PASS | Every Expect line held |
| FAIL | The app behaved differently from Expect: a Demo or SDK defect |
| BLOCKED | Couldn't judge it: bad/missing key, 401/429/quota, no network, a missing GitHub token |
| SKIPPED | Tagged `manual only`, or out of scope for the argument |

Tell FAIL from BLOCKED by the error text: authentication, rate-limit or quota
errors are BLOCKED, not an app defect. An unexpected crash, a hang, a missing
or garbled UI element, or an empty response with no error is FAIL.

## Report

Print this in chat when the run finishes:

```
Demo release check: <date>, iPhone 17 / iOS <version>, git <short SHA> (<clean|dirty>)
Scope: <all | smoke | section>

| Case | Title | Status | Note |
|------|-------|--------|------|
| L-01 | ...   | PASS   |      |

Totals: N pass, N fail, N blocked, N skipped

Failures
- R-04 <title>: <what happened vs Expect>. Likely area: <file/view if obvious>.

Manual follow-ups: <the `manual only` cases the user still needs to do>
```

Finish by stating plainly whether any FAIL remains. Don't declare the release
"good"; that call is the user's.
