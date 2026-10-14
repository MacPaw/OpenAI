# DemoChat

The SwiftUI interface used by the iOS Demo app.

## Audio transcription

Open **Misc → Audio → Transcribe**, choose a supported recording (up to 25 MB),
and select a transcription model. Language is an optional ISO-639-1 code, such
as `en`; the optional prompt can provide names or vocabulary from the recording.
Tap **Transcribe** to upload the file to the provider selected in API Configuration.
Selecting a file alone does not make a request. API usage may incur charges.

The transcript can be selected or copied. Failed requests display an error and
can be retried; Cancel or leaving the screen cancels the pending request.
Custom providers must implement the OpenAI-compatible `audio/transcriptions`
endpoint and support the entered model and file format. The example uses JSON
responses, not streaming, subtitle export, or microphone recording.

Build the Demo app from the repository root:

```sh
xcodebuild -project Demo/Demo.xcodeproj -scheme Demo \
  -destination 'generic/platform=iOS Simulator' build
```

Run the package tests from this directory with an installed iOS Simulator:

```sh
xcodebuild -scheme DemoChat \
  -destination 'platform=iOS Simulator,name=iPhone 17' test
```

Transcription tests use injected responses and local temporary files; they do
not require an API key or call a provider.
