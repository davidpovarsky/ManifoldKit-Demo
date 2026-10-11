# Known limitations

- This environment cannot run Xcode; Simulator/device builds and IPA evidence require the committed GitHub Actions workflow.
- No Apple signing certificate, provisioning profile, developer-team credential, or API key is included.
- Full unsigned IPA is an artifact for later signing, not a directly installable app.
- macOS-only local stdio MCP and `npx` are not iPad capabilities.
- MLX/llama/image generation live in separate companion packages and are not represented as runnable Advanced features.
- Live provider generation is configuration-dependent and is not claimed as tested without credentials.
- Lite/no-extension variant remains intentionally unclaimed until a separate Xcode target/configuration is implemented and verified.
