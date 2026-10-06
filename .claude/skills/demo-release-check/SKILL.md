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

- **Credentials come from the shell, by name only.** The user exports the keys
  the cases need (`OPENAI_API_KEY`, and `GITHUB_TOKEN` for the MCP cases) in
  their shell profile. These are the *shell's* variable names; Demo itself reads
  `DEMO_API_PROVIDER`, `DEMO_API_KEY`, `DEMO_API_BASE_URL` and `GITHUB_TOKEN`,
  and the launch command maps one onto the other, for example
  `DEMO_API_KEY="$OPENAI_API_KEY"`. Never type a real key or token into the app
  (you never need to: the configuration arrives through the launch
  environment), never print, echo or log them, and never run `env`, `printenv`,
  `set -x` or anything else that would show their values. Test for presence
  only: `[ -n "$OPENAI_API_KEY" ]`.
- **Every case starts from a fresh launch.** Test runs must be as deterministic
  as possible, so before each case the app is relaunched with the
  configuration that case needs, provided from scratch through the launch
  environment. Cases never rely on saved data or on what an earlier case left
  behind, and may freely change whatever the app saves (the provider, key,
  GitHub token, remembered models, enabled tools). After a run, the app's saved
  state on the device may differ from before; that is expected. Never uninstall
  or reset the app: installing over it is enough.
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
- **Every case gets a configuration, but only API-calling cases need a working
  key.** The app can't start without a configuration, so each launch supplies
  one. A case tagged `Needs: none` makes no API call, so its launch uses a
  placeholder key (`test-token-not-real`) instead of the real one. That means
  `OPENAI_API_KEY` doesn't have to be set for it: the shell variable is only
  where the real key comes from, and the preflight checks it only when a case in
  scope has `Needs: OpenAI key`.
- **Keep prompts tiny** (see the prompts in the cases) to limit token spend.
- **The keyboard moves the layout.** When it appears, the input field and send
  button jump up, the model menu shrinks (scroll it to reach gpt-5.6-*), and
  the tab bar is covered; re-screenshot before tapping send. Swipe down on the
  message list to dismiss the keyboard before switching tabs.
- **The API Key field is masked.** Screenshots of the API Configuration modal
  show dots, not the key.

## Procedure

1. **Read `test-cases.md`** and pick the cases in scope for the argument.
   Then **check requirements before touching the simulator**, by presence
   only, as above: each `Needs` value of a case in scope that names a shell
   variable (`OpenAI key` is `OPENAI_API_KEY`, `GitHub token` is
   `GITHUB_TOKEN`) requires it to be set. **If any is missing, abort the whole
   run**: don't build, launch or run anything. Report which variables are
   missing and which cases need them, and stop. Never fall back to whatever the
   app has saved, and never ask the user to type a credential into the app. The
   user can pass a narrower argument to leave those cases out.
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
4. **Install the app once**, through Bash, over any existing copy:

   ```sh
   xcrun simctl install booted build/DemoDerivedData/Build/Products/Debug-iphonesimulator/Demo.app
   ```

   Then `control` → `attach` so the user can watch.
5. **Launch each case fresh.** Launch through Bash (the `control` tool's
   `launch` can't pass environment variables), with the configuration the
   case's `Needs` calls for:

   | `Needs` | `DEMO_API_PROVIDER` | `DEMO_API_KEY` | `DEMO_API_BASE_URL` |
   |---|---|---|---|
   | `none` | `openAI` | `test-token-not-real` | not set |
   | `OpenAI key` | `openAI` | `"$OPENAI_API_KEY"` | not set |
   | `Custom provider` | `custom` | `test-token-not-real` | `http://localhost:8080` |

   Add `SIMCTL_CHILD_GITHUB_TOKEN="$GITHUB_TOKEN"` when the case needs
   `GitHub token`.

   ```sh
   SIMCTL_CHILD_DEMO_API_PROVIDER=openAI \
   SIMCTL_CHILD_DEMO_API_KEY="$OPENAI_API_KEY" \
   xcrun simctl launch --terminate-running-process booted openAI.MacPaw.Demo
   ```

   Demo uses these as its configuration for that launch and, because the
   environment supplies it, ignores everything it saved earlier (configuration,
   GitHub token, enabled MCP tools, remembered model IDs), so a case only has
   a GitHub token if you pass one.
   Because the configuration is usable, Demo **skips** the API Configuration
   screen it otherwise opens at launch, so the case starts directly on the
   Chats tab; there is no modal to dismiss. Wait a few seconds after launching.
   If the modal shows anyway, the configuration didn't reach the app or isn't
   usable (for example `custom` without a base URL: the modal then has only
   **Continue**): abort the run and report that, instead of trying to get past
   the modal.
6. **For every case**, after launching it as above:
   - Follow the steps, taking a screenshot after the action that matters.
   - Compare against **Expect**. Record PASS or FAIL.
   - Wait for streaming or network responses to finish (up to ~30 s) before
     judging. Retry a real-API case once if it fails on a network error.
   - On FAIL, keep the screenshot and a one-line diagnosis, then continue with
     the next case (which starts from a fresh launch). A failure never stops
     the run.
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
```

Finish by stating plainly whether any FAIL remains. Don't declare the release
"good"; that call is the user's.
