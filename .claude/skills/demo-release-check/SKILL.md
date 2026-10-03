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
`smoke` to run only cases tagged `[smoke]`. With no argument, run everything,
with section `P` last. Before starting a run that includes `P`, say that it will
replace the saved provider and key.

## Ground rules

- **Credentials come from the shell, by name only.** The user exports
  `OPENAI_API_KEY` (and optionally `GITHUB_TOKEN`) in their shell profile, and
  step 4 passes them to the app's launch environment. Never type a real key or
  token into the app, never print, echo or log them, and never run `env`,
  `printenv`, `set -x` or anything else that would show their values. Test for
  presence only: `[ -n "$OPENAI_API_KEY" ]`. The only text you type into the
  API Key field is the placeholder token of section P.
- **Saved data may or may not exist.** This may be the first run after
  installing Demo or a later one, so the saved provider, key, GitHub token and
  other settings may or may not be there, and may have been changed by the user
  since the last run. Never uninstall or reset the app (installing over it keeps
  its data). Cases in sections L to X leave saved settings as they found them.
  Only section **P** replaces the saved provider and key; it runs last and uses
  a placeholder token and a local URL. Credentials from the launch environment
  are in memory only, so a relaunch undoes P.
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
- **The keyboard moves the layout.** When it appears, the input field and send
  button jump up, the model menu shrinks (scroll it to reach gpt-5.6-*), and
  the tab bar is covered; re-screenshot before tapping send. Swipe down on the
  message list to dismiss the keyboard before switching tabs.
- **The API Key field is masked.** Screenshots of the API Configuration modal
  show dots, not the key.

## Procedure

1. **Read `test-cases.md`** and pick the cases in scope for the argument.
   Then **check requirements before touching the simulator**: test which of
   `OPENAI_API_KEY` and `GITHUB_TOKEN` are set (presence only, as above) and
   compare with the `Needs` of every case in scope. **If any requirement is
   missing, abort the whole run**: don't build, launch or run anything, not
   even the cases that could run. Report which variables are missing and which
   cases need them, and stop. Never fall back to whatever the app has saved,
   and never ask the user to type a credential into the app. To run a subset
   that doesn't need the missing credential, the user can pass a narrower
   argument.
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
4. **Install and launch with the credentials**, through Bash (the `control`
   tool's `launch` can't pass environment variables). Installing over the
   existing app keeps its saved data:

   ```sh
   [ -n "$OPENAI_API_KEY" ] && echo "key: set" || echo "key: NOT set"
   xcrun simctl install booted build/DemoDerivedData/Build/Products/Debug-iphonesimulator/Demo.app
   SIMCTL_CHILD_OPENAI_API_KEY="$OPENAI_API_KEY" \
   SIMCTL_CHILD_GITHUB_TOKEN="$GITHUB_TOKEN" \
   xcrun simctl launch --terminate-running-process booted openAI.MacPaw.Demo
   ```

   Demo uses these for that launch only, whatever provider or key is saved,
   and never stores them. Empty values are ignored. Then `control` → `attach`
   so the user can watch, and take screenshots and taps as usual.
5. **Dismiss the launch modal.** Demo opens the **API Configuration** modal on
   *every* launch; tap **Cancel** (never Save, except in P-01) and carry on.
   With `OPENAI_API_KEY` set, Demo is on OpenAI with that key whatever was
   saved.
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
| BLOCKED | Couldn't judge it while running: a 401/429/quota or network error. (A credential missing from the shell aborts the run before it starts; see step 1.) |
| SKIPPED | Tagged `manual only`, or out of scope for the argument |

Tell FAIL from BLOCKED by the error text: authentication, rate-limit or quota
errors are BLOCKED, not an app defect. An unexpected crash, a hang, a missing
or garbled UI element, or an empty response with no error is FAIL.

## Report

Print this in chat when the run finishes. An aborted run (step 1) has no table:
just say it was aborted, which variables are missing, and which cases need them
(for example "OPENAI_API_KEY not set; needed by C-01, C-04, R-01, X-02. Export
it in a file my shell reads and rerun.").

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
Saved configuration: <if section P ran: "replaced with a placeholder Custom
  provider; the next launch with OPENAI_API_KEY set restores OpenAI. Without
  it, re-enter your key.">
```

Finish by stating plainly whether any FAIL remains. Don't declare the release
"good"; that call is the user's.
