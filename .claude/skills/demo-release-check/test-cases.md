# Demo release test cases

Run by the `demo-release-check` skill. Edit freely: this file is the source of
truth for what gets checked before a release.

## How to write a case

```
### <ID> <Title>  [tags]
Needs: no-network | real API | GitHub token | manual only
Steps: short, in on-screen labels, separated by →
Expect: what must be true to PASS
```

- **ID**: section letter + number. Letters are L = Launch, C = Chats,
  R = Responses, I = Image, M = Github MCP, X = Misc.
- **Tags**: `[smoke]` = run on every pass, even a quick one. `[costly]` =
  noticeably more tokens (image generation); skip when only doing a fast check.
- **Needs** drives the status: `manual only` is always SKIPPED and listed as a
  follow-up for the human.
- Keep prompts short. The message input and send button are drawn by a
  chat UI package, so find them on screen rather than relying on a label.
- When a screen changes (new feature, a stub becomes real), update its case in
  the same change.

Assumes the API key is already saved in the simulator's Demo app (provider
OpenAI). Provider-specific behavior (Gemini, Custom) isn't covered here yet.

---

## L: Launch and configuration

### L-01 Launch with saved configuration  [smoke]
Needs: no-network
Steps: launch Demo → tap **Cancel** on the API Configuration modal
Expect: no crash; the modal opens on launch (Provider OpenAI, Base URL, Chat
model ID, API Key filled in) and **Cancel** dismisses it; Chats opens with a
"Conversations" list; the tab bar shows Chats, Responses, Image, Github MCP and
Misc (no More tab); nothing covers the tab bar.

### L-02 Reopen and cancel API Configuration
Needs: no-network
Steps: Misc → **API Configuration** (first row, under "Configuration") → look
at the form → tap **Cancel**
Expect: a sheet titled "API Configuration" shows Provider, Base URL, Chat model
ID and API Key; **Cancel** closes it; the app is still on the same tab and
still works. (Do not edit or save the key, and don't repeat it in the report.)

---

## C: Chats

### C-01 Create a chat and get a reply  [smoke]
Needs: real API
Steps: Chats tab → **+** menu → **Create Chat** → select the new conversation →
type `Reply with only the word: pong` → send
Expect: the user message appears; an assistant reply containing "pong" appears;
no error banner; the header reads "Model: gpt-6-luna, stream: true" (the
default model).

### C-02 Disable streaming and send
Needs: real API
Steps: in an open chat, tap the **cpu** toolbar icon → **Disable streaming** →
send `Reply with only the word: pong`
Expect: the header now reads "stream: false"; the full reply arrives and is
shown once it completes, without an error.

### C-03 Model selection sheet
Needs: no-network
Steps: in an open chat, tap the **cpu** toolbar icon
Expect: a "Select model" dialog lists the streaming toggle, the available model
names and **Cancel**; **Cancel** dismisses it with the header unchanged.

### C-04 GPT-5.6 model with function tools  [smoke]
Needs: real API
Steps: in an open chat, tap the **cpu** toolbar icon → **gpt-5.6-terra** →
send `Reply with only the word: pong`
Expect: a reply containing "pong" arrives and no error banner appears. Chats
always attaches a function tool, and GPT-5.6 models reject function tools on
Chat Completions unless `reasoning_effort` is `none`; a message like "Function
tools with reasoning_effort are not supported…" means the model's `ModelSpec`
limitation is missing or ignored.

---

## R: Responses

### R-01 Responses reply, streaming on  [smoke]
Needs: real API
Steps: Responses tab → check the subtitle reads `Model: gpt-6-luna, stream:
true, tools: Web Search` (the defaults) → send `Reply with only the word: pong`
Expect: the title shows "Streaming…" while the answer arrives and returns to
"Responses API" afterwards; a reply containing "pong" is shown; no alert.
Web Search is on by default, so R-05 starts with it already enabled.

### R-02 Settings screen toggles
Needs: no-network
Steps: Responses tab → **gear** icon → flip each of Stream, Web Search,
Function Calling, MCP Tools → go back
Expect: the Settings screen has a Model row plus the four toggles; each flips
and keeps its state after returning; the summary line under the title reflects
the enabled options.

### R-03 Stream off
Needs: real API
Steps: Responses → gear → turn **Stream** off → back → send
`Reply with only the word: pong`
Expect: a complete reply appears with no error. Restore **Stream** to on
afterwards.

### R-04 Function calling with stubbed result
Needs: real API
Steps: Responses → gear → turn **Function Calling** on → back → send
`What is the weather in Paris?` → when the **Stub Function Result** sheet
appears, enter `21°C` → **Submit**
Expect: the sheet shows the function name and "Location: …, Unit: …"; after
**Submit** the final reply mentions 21; no alert. Turn **Function Calling** off
afterwards.

### R-05 Web search
Needs: real API
Steps: Responses → gear → make sure **Web Search** is on (it is by default) →
back → send `Name one city in France. One word.`
Expect: the title may show "Searching Web…" while the tool runs; a one-word
reply follows; no alert. Leave **Web Search** as you found it.

---

## I: Image

### I-01 Image menu
Needs: no-network
Steps: open the Image tab
Expect: list shows **Create Image**, **Create Image Edit** and **Create Image
Variation**; Variation is greyed out and not tappable.

### I-02 Create an image  [costly]
Needs: real API
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
Needs: no-network
Steps: open the Github MCP tab
Expect: a **GitHub Token** field, a red ✗ status, a **Connect to GitHub MCP**
button, and "No tools available".

### M-02 Connect, toggle tools, disconnect
Needs: GitHub token
Steps: with a token already saved in the field → **Connect to GitHub MCP** →
wait → toggle **Enable All Tools** → **Disconnect**
Expect: status turns to a green ✓; the list under **Available Tools** fills in
and the "N enabled" count matches the toggles; after **Disconnect** the status
returns to ✗ and the tool list empties.

### M-03 Responses with MCP tools and approval dialog
Needs: GitHub token, real API
Steps: Github MCP → connect → Responses → gear → turn **MCP Tools** on → back →
send a prompt that uses GitHub (`List the open issues in apple/swift, max 1`)
Expect: an MCP approval dialog appears for the tool call; **Approve** lets the
request finish with a reply; no alert. (Also try **Deny** once and confirm the
request ends cleanly.)

---

## X: Misc

Misc is the last tab.

### X-01 Misc menu
Needs: no-network
Steps: open the Misc tab
Expect: sections Configuration (API Configuration), Models (List Models, Retrieve Model), Assistants Beta
(Assistants), Moderations (Moderation Chat), Audio (Create Speech, Transcribe).

### X-02 List models  [smoke]
Needs: real API
Steps: Misc → **List Models**
Expect: a non-empty list of model ids loads; no error; exactly one back button
at the top-left.

### X-03 Retrieve model placeholder
Needs: no-network
Steps: Misc → **Retrieve Model**
Expect: the screen reads "Retrieve Model: TBD". Update this case if it ships.

### X-04 Moderation chat
Needs: real API
Steps: Misc → **Moderation Chat** → send `I love puppies`
Expect: the message is sent and a moderation result is shown for it; no error.

### X-05 Create speech
Needs: real API
Steps: Misc → **Create Speech** → Prompt `Hello there` → leave other options →
**Create Speech**
Expect: a new entry appears under "Click to play, swipe to save:". (Audio
playback itself can't be verified here.)

### X-06 Assistants list (read-only)
Needs: real API
Steps: Misc → **Assistants** → **Get Assistants** (the refresh button)
Expect: the request finishes without error and the list reflects the account
(an empty list is fine). Do not create or modify assistants in this pass.

### X-07 Transcribe placeholder
Needs: no-network
Steps: Misc → Audio → **Transcribe**
Expect: the screen reads "Transcribe: TBD". Update this case if transcription
ships.
