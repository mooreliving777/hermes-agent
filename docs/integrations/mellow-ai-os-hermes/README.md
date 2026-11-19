# Mellow AI OS ↔ Hermes Agent — staged MCP integration

**State (2026-11-19): NOT CONNECTED.** This change stages a reviewed, no-secret integration for the existing Mellow AI Operating System. It does **not** install Hermes, register an MCP server in a live client, grant access to personal conversations, connect an AI provider, consume credits, deploy infrastructure, or alter an existing application.

## Target architecture

- **Coordinator:** ChatGPT / the existing Mellow AI OS registry and approval queue.
- **Optional specialist:** Nous Research Hermes Agent, in its own local or separately authorized cloud runtime.
- **First MCP client:** Claude Code or Cursor, but only after the runtime and permissions are inspected.
- **Source repository:** this GitHub repository, not evidence of a running Hermes installation.
- Preserve the existing command registry, current workforce roles, existing automations and review gates. Do not import all Claude skills, credentials or memory automatically. Moorvio stays CRM-first.

## Why the MCP connection requires review

The official `mcp-serve` plugin lets MCP clients list and read Hermes messaging conversations, and **send messages** through Hermes-connected accounts. The default `mcp-serve` mode does not expose optional Hermes web/browser/media tools, but it is **not read-only**. Adding `--tools` may call providers and consume paid credits. This staged configuration **does not include `--tools`**, and has not been added to an active Claude/Cursor workspace.

Use a new, isolated Hermes profile with **no connected messaging accounts**, no sensitive conversation history and no production credentials for first tests. Grant further tool and account permissions only after action-specific approval. Keep all secrets in the host's approved secret store, not in GitHub or Notion.

## Steps to activate on an authorized host (not performed by this PR)

1. Verify that a suitable host exists (Windows PowerShell, Linux/WSL, or an approved cloud VM) and that it has a permissible no-additional-cost compute allocation. This repository alone cannot run a persistent agent.
2. Review the [official installation guide](https://hermes-agent.nousresearch.com/docs/getting-started/quickstart) before using the official installer. On Windows the official command is `iex (irm https://hermes-agent.nousresearch.com/install.ps1)`; on Linux/WSL it is `curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash`. Do not execute the installer on production machines without assessing permissions and dependencies.
3. Verify `hermes --version`. Configure an authorized model via `hermes setup` or `hermes model`; check model usage and costs before making any inference calls. Reuse approved free allowances if genuinely available; do not assume an existing ChatGPT/Claude subscription is a free API key.
4. On the isolated Hermes profile, deliberately install the official plugin: `hermes plugins install mcp-serve`. This is an **activation step**, not an action the PR runs.
5. Review [`claude-mcp.example.json`](./claude-mcp.example.json); after approval place its `mcpServers.hermes` entry in the **authorized client** configuration only, not this repository's root configuration.
6. Verify that Hermes starts locally, the MCP client discovers the server, and a harmless listing of MCP tool **names** succeeds. Do not query real conversation content, invoke message sending, run `--tools`, use paid models or enable autonomous execution during the first smoke test.
7. Record host, installation version, profile, selected client, permissions, test results, cost evidence and rollback decision in the existing private Mellow AI OS Notion integration record. Mark CONNECTED only after the live test succeeds.

## Acceptance gate

- [ ] Authorized host identified and installed Hermes version verified
- [ ] Cost/limits verified; incremental spend $0
- [ ] Isolated profile verified without messaging account credentials
- [ ] `mcp-serve` plugin actually installed on the host
- [ ] Claude Code/Cursor client enabled only in the intended workspace
- [ ] MCP tool discovery verified with no reads of private messages
- [ ] Safety review confirms read/send capabilities and rollback
- [ ] No additional services, public release, production write, or automation activated

**Safeguards:** additionalSpendUSD=0, draft=true, autoPublish=false, no purchases, automatic messages, credentials in source control, live deployments, or production repo writes. The branch/PR is configuration staging only.

## Official references
- [Hermes Agent Quickstart](https://hermes-agent.nousresearch.com/docs/getting-started/quickstart)
- [MCP documentation](https://hermes-agent.nousresearch.com/docs/user-guide/features/mcp)
- [mcp-serve official plugin](https://hermes-agent.nousresearch.com/marketplace/mcp-serve)
