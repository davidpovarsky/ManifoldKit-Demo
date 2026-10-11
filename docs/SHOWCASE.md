# ManifoldKit Showcase

This repository is a host-app showcase of the **real ManifoldKit Advanced reference app**. It is not a production AI client and does not replace `ChatView`, `ConversationRuntime`, tool approval, session persistence, or the framework message renderer with a custom chat.

## Provenance

- Upstream: [ManifoldKit/ManifoldKit](https://github.com/ManifoldKit/ManifoldKit)
- Audited upstream commit: `e204b489dfb2517e156c2272910bfa267febb3a4`
- License: MIT, copyright Rory Ford (preserved)
- Showcase branch: `feat/ipad-showcase`

## Offline Demo

A normal launch defaults to **Offline demo · scripted responses**. It injects the existing public `ScriptedBackend` into the same `InferenceService` and stock `ChatView` pipeline used by the reference app. No API key, network request, Apple Intelligence availability, or downloaded model is needed.

The Demos menu reuses `DemoScenarios`, `DemoScenarios+Scripts`, `DemoScenarioRunner`, `ToolRegistry`, real tool invocation rendering, and the real approval sheet. Before each scenario, the finite fixture is reset with that scenario's turns; this makes `tip-calc → workspace-search → tip-calc` and repeated playback deterministic. **Reset Demo / Replay** restores the generic fixture.

Live mode is explicit and opt-in by launching with `--live-mode`; it preserves the upstream Foundation, Ollama, and Cloud SaaS registrations. Offline mode never calls those providers.

## Capability matrix

| Surface | Real implementation | Offline status / limitation | Source |
|---|---|---|---|
| Chat, composer, message rendering | `ManifoldUI.ChatView` | Interactive | `Example/Advanced/DemoContentView.swift` |
| Sessions/sidebar | `SessionListView`, `SessionManagerViewModel` | Interactive with SwiftData | `Example/Advanced/DemoContentView.swift` |
| Tools and approval | `ToolRegistry`, `UIToolApprovalGate`, `ToolApprovalSheet` | Scripted tool calls; writes stay under demo sandbox | `Example/Advanced/DemoTools.swift` |
| Model management/API config | `ModelManagementSheet`, endpoint UI | Opens without a configured provider; downloads/live generation require network/provider | `ManifoldUIModelManagement` |
| Knowledge Base | `DocumentLibrarySheet`, `RAGService` | Document UI available; embeddings/backend claims depend on actual bootstrap | `Example/Advanced` |
| Voice | `ManifoldVoice` | Real-device permissions and microphone; simulator is gated | `Example/Advanced/DemoContentView.swift` |
| MCP | `ManifoldMCP` / connected-services UI | Local stdio+npx example is macOS-only; scripted MCP failure is not a live server | `Example/Advanced/MCP` |
| MLX / llama / image generation | companion packages | Not linked by Advanced; no local model is claimed here | `Example/Examples/LocalInferenceExample` |

## Build, unsigned IPA, signing, installation

The workflow **Build iPad Showcase** runs on `macos-26`, selects Xcode 26.3, builds Simulator first, then a generic `iphoneos` Release build with code signing disabled, validates that the binary is an arm64 device Mach-O, packages `Payload/<app>.app`, and uploads `ManifoldKit-Showcase-Full-unsigned-IPA`. DerivedData is outside the checkout under `$RUNNER_TEMP`.

An unsigned IPA is **not installable on a stock iPad**. Physical installation still needs a valid signing/provisioning route (Apple Developer, free provisioning where applicable, or an approved sideloading service). No signing credentials are stored here. A successful Simulator build is not physical-device evidence.

The Full target retains the official Share and Action extensions and App Group source/capabilities, with owner-specific bundle identifiers. A separate Lite no-extension target is not claimed until it is implemented and independently device-built; the workflow intentionally does not fabricate a Lite artifact.

## Known limitations

See `KNOWN-LIMITATIONS.md`.
