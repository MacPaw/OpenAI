# Demo release test cases

Run by the `demo-release-check` skill. Edit freely: this file is the source of
truth for what gets checked before a release.

## How to write a case

```
### <ID> <Title>  [tags]
Needs: none | OpenAI key | GitHub token | manual only   (comma-separate several)
Steps: short, in on-screen labels, separated by →
Expect: what must be true to PASS
```

- **ID**: section letter + number. Letters are L = Launch, C = Chats,
  R = Responses, I = Image, M = Github MCP, X = Misc, P = Other providers.
- **Tags**: `[smoke]` = run on every pass, even a quick one. `[costly]` =
  noticeably more tokens (image generation); skip when only doing a fast check.
- **Needs** lists what a case depends on beyond the app itself. The shell
  variable that meets it must be set, or the whole run is aborted before it
  starts (see `SKILL.md`).

  | Needs | Met by | Notes |
  |---|---|---|
  | `none` | nothing | Makes no API calls and costs no tokens. |
  | `OpenAI key` | `OPENAI_API_KEY` | Calls the OpenAI API, so it spends tokens when it sends. |
  | `GitHub token` | `GITHUB_TOKEN` | For the Github MCP tab. |
  | `manual only` | nothing | Can't be driven reliably in the simulator (for example the photo picker). Always SKIPPED and listed as a follow-up for the human. |

  **Every run also needs `OPENAI_API_KEY`**, whatever the cases' `Needs`: it
  is Demo's only configuration (see below), so it isn't a per-case tag.

  To require another provider's key (say Gemini), Demo first needs to read
  it from the launch environment, then add a row here. No case needs one yet.
- Keep prompts short. The message input and send button are drawn by a
  chat UI package, so find them on screen rather than relying on a label.
- When a screen changes (new feature, a stub becomes real), update its case in
  the same change.

**Never rely on saved data.** Runs must be deterministic, so Demo's
configuration (OpenAI, with the key from `OPENAI_API_KEY`; optionally
`GITHUB_TOKEN`) is always supplied through the launch environment, which
overrides whatever is saved. Cases must not depend on what an earlier run or the
user saved, and whether this is the first run after an install or a later one
must make no difference. A case that needs a clean install can't be written yet;
don't add one.

Section **P** is the one place that changes saved data: it replaces the saved
provider and key with a placeholder, so it runs last. The next launch with
`OPENAI_API_KEY` set is back on OpenAI. Like any test run on a device, it
overwrites data.

---

## L: Launch and configuration

### L-01 Launch  [smoke]
Needs: none
Steps: launch Demo (step 4 of `SKILL.md`) → dismiss the API Configuration modal
with **Cancel** (if it has no Cancel, follow step 5 of `SKILL.md`)
Expect: no crash; the API Configuration modal opens on launch; once dismissed,
Chats opens with a "Conversations" list; the tab bar shows Chats, Responses,
Image, Github MCP and Misc (no More tab); nothing covers the tab bar.

### L-02 Reopen and cancel API Configuration
Needs: none
Steps: Misc → **API Configuration** (first row, under "Configuration") → look
at the form → tap **Cancel**
Expect: a sheet titled "API Configuration" shows Provider, Base URL and API Key
(no model field; models are chosen per chat); **Cancel** closes it; the app is
still on the same tab and still works. (Do not edit or save the key, and don't
repeat it in the report.)

---

## C: Chats

### C-01 Create a chat and get a reply  [smoke]
Needs: OpenAI key
Steps: Chats tab → **+** menu → **Create Chat** → select the new conversation →
type `Reply with only the word: pong` → send
Expect: the user message appears; an assistant reply containing "pong" appears;
no error banner; the header reads "Model: gpt-6-luna, stream: true" (the
default model).

### C-02 Disable streaming and send
Needs: OpenAI key
Steps: in an open chat, tap the **cpu** toolbar icon → **Disable streaming** →
send `Reply with only the word: pong`
Expect: the header now reads "stream: false"; the full reply arrives and is
shown once it completes, without an error.

### C-03 Model selection sheet
Needs: none
Steps: in an open chat, tap the **cpu** toolbar icon
Expect: a "Select model" dialog lists the streaming toggle, the available model
names and **Cancel**; **Cancel** dismisses it with the header unchanged.

### C-04 GPT-5.6 model with function tools  [smoke]
Needs: OpenAI key
Steps: in an open chat, tap the **cpu** toolbar icon → **gpt-5.6-terra** →
send `Reply with only the word: pong`
Expect: a reply containing "pong" arrives and no error banner appears. Chats
always attaches a function tool, and GPT-5.6 models reject function tools on
Chat Completions unless `reasoning_effort` is `none`; a message like "Function
tools with reasoning_effort are not supported…" means the model's `ModelSpec`
limitation is missing or ignored.

### C-05 Model menu offers the OpenAI models
Needs: none
Steps: in an open chat, tap the **cpu** toolbar icon
Expect: the list includes gpt-6-*, gpt-5.6-* and older models, with no
"Custom model ID…" entry.

---

## R: Responses

### R-01 Responses reply, streaming on  [smoke]
Needs: OpenAI key
Steps: Responses tab → check the subtitle reads `Model: gpt-6-luna, stream:
true, tools: Web Search` (the defaults) → send `Reply with only the word: pong`
Expect: the title shows "Streaming…" while the answer arrives and returns to
"Responses API" afterwards; a reply containing "pong" is shown; no alert.
Web Search is on by default, so R-05 starts with it already enabled.

### R-02 Settings screen toggles
Needs: none
Steps: Responses tab → **gear** icon → flip each of Stream, Web Search,
Function Calling, MCP Tools → go back
Expect: the Settings screen has a Model row plus the four toggles; each flips
and keeps its state after returning; the summary line under the title reflects
the enabled options.

### R-03 Stream off
Needs: OpenAI key
Steps: Responses → gear → turn **Stream** off → back → send
`Reply with only the word: pong`
Expect: a complete reply appears with no error. Restore **Stream** to on
afterwards.

### R-04 Function calling with stubbed result
Needs: OpenAI key
Steps: Responses → gear → turn **Function Calling** on → back → send
`What is the weather in Paris?` → when the **Stub Function Result** sheet
appears, enter `21°C` → **Submit**
Expect: the sheet shows the function name and "Location: …, Unit: …"; after
**Submit** the final reply mentions 21; no alert. Turn **Function Calling** off
afterwards.

### R-05 Web search
Needs: OpenAI key
Steps: Responses → gear → make sure **Web Search** is on (it is by default) →
back → send `Name one city in France. One word.`
Expect: the title may show "Searching Web…" while the tool runs; a one-word
reply follows; no alert. Leave **Web Search** as you found it.

---

## I: Image

### I-01 Image menu
Needs: none
Steps: open the Image tab
Expect: list shows **Create Image**, **Create Image Edit** and **Create Image
Variation**; Variation is greyed out and not tappable.

### I-02 Create an image  [costly]
Needs: OpenAI key
Steps: Image → **Create Image** → Prompt `a plain red circle on a white
background` → leave Size default → tap **Create Image**
Expect: the button shows progress, then an image appears under **Images**; no
error alert.

### I-03 Create an image edit
Needs: manual only
Steps: Image → **Create Image Edit** → choose an input image (and optionally a
mask) → Prompt → **Generate Image**
Expect: the result replaces "Result will appear here". Needs the photo picker,
which can't be driven reliably in the simulator.

---

## M: Github MCP

### M-01 MCP tab, disconnected state
Needs: none
Steps: open the Github MCP tab
Expect: a **GitHub Token** field (filled or empty), a red ✗ status, a
**Connect to GitHub MCP** button, and "No tools available".

### M-02 Connect, toggle tools, disconnect
Needs: GitHub token
Steps: with `GITHUB_TOKEN` supplied at launch → **Connect to GitHub MCP** →
wait → toggle **Enable All Tools** → toggle it back to how it was →
**Disconnect**
Expect: status turns to a green ✓; the list under **Available Tools** fills in
and the "N enabled" count matches the toggles; after **Disconnect** the status
returns to ✗ and the tool list empties.

### M-03 Responses with MCP tools and approval dialog
Needs: OpenAI key, GitHub token
Steps: Github MCP → connect → Responses → gear → turn **MCP Tools** on → back →
send a prompt that uses GitHub (`List the open issues in apple/swift, max 1`)
Expect: an MCP approval dialog appears for the tool call; **Approve** lets the
request finish with a reply; no alert. (Also try **Deny** once and confirm the
request ends cleanly.)

---

## X: Misc

Misc is the last tab.

### X-01 Misc menu
Needs: none
Steps: open the Misc tab
Expect: sections Configuration (API Configuration), Models (List Models,
Retrieve Model), Assistants Beta (Assistants), Moderations (Moderation Chat),
Audio (Create Speech, Transcribe).

### X-02 List models  [smoke]
Needs: OpenAI key
Steps: Misc → **List Models**
Expect: a non-empty list of model ids loads; no error; exactly one back button
at the top-left.

### X-03 Retrieve model placeholder
Needs: none
Steps: Misc → **Retrieve Model**
Expect: the screen reads "Retrieve Model: TBD". Update this case if it ships.

### X-04 Moderation chat
Needs: OpenAI key
Steps: Misc → **Moderation Chat** → send `I love puppies`
Expect: the message is sent and a moderation result is shown for it; no error.

### X-05 Create speech
Needs: OpenAI key
Steps: Misc → **Create Speech** → Prompt `Hello there` → leave other options →
**Create Speech**
Expect: a new entry appears under "Click to play, swipe to save:". (Audio
playback itself can't be verified here.)

### X-06 Assistants list (read-only)
Needs: OpenAI key
Steps: Misc → **Assistants** → **Get Assistants** (the refresh button)
Expect: the request finishes without error and the list reflects the account
(an empty list is fine). Do not create or modify assistants in this pass.

### X-07 Transcribe placeholder
Needs: none
Steps: Misc → Audio → **Transcribe**
Expect: the screen reads "Transcribe: TBD". Update this case if transcription
ships.

---

## P: Other providers (overwrites the saved provider and key; run last)

These cases switch the saved provider to Custom with a placeholder token and a
local URL, so no real credentials or network are involved. Run them in order,
after everything else. They are not `[smoke]`.

### P-01 Switch to the Custom provider
Needs: none
Steps: Misc → **API Configuration** → Provider **Custom** → Base URL
`http://localhost:8080` → API Key `test-token-not-real` → take a screenshot
and confirm the provider reads "Custom" → **Save**
Expect: the form accepts the values (Save becomes enabled) and the modal closes.
Changing the provider clears the key field first, so type the token after
choosing Custom.

### P-02 Custom model ID in a chat
Needs: none
Steps: Chats → **+** → **Create Chat** → open it → read the header → **cpu**
icon → **Custom model ID…** → enter `my-model-1` → **Use** → go back, create
and open another chat
Expect: before choosing, the header reads "Model: not set" and the menu has
only the streaming toggle and "Custom model ID…"; afterwards the header shows
"Model: my-model-1", and the new chat starts with the same ID. Do not send a
message: no server runs at the URL.

### P-03 Responses is OpenAI-only
Needs: none
Steps: open the Responses tab
Expect: no chat UI; a screen titled "Responses is OpenAI-only" saying the
current provider is Custom and pointing to Misc > API Configuration.
