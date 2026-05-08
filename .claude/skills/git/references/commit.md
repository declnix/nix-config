# Commit Procedures and Conventions

## 1. Workflow
1. **Analyze**: `git status && git diff`.
2. **Verify**: Ensure no secrets and adherence to project standards.
3. **Draft**: Create message: `type(scope): message`.
4. **Propose**: Present summary and draft to user.
5. **Commit**: Only after user confirmation.

## 2. Scope Conventions
Each commit MUST target **only one** scope.

- **Hosts:** `hostname(app): short description` (e.g., `z4c1sz3(niri): update keybinds`)
- **Aspects:** `aspectname(plugin/item): short description` (e.g., `fonts(nerdfonts): add JetBrainsMono`)
- **Modules:** `modulename(item): short description` (e.g., `zsh(plugin): add autosuggestions`)
- **AI Agents/Skills:** `agentname(item): short description` (e.g., `git(commit): update convention`)

### Multi-scope Fallback
If a change touches multiple items, use the top-level folder prefix (e.g., `hosts`, `modules`) WITHOUT scope.
- **Example:** `hosts: sync common configs`
- **Body Requirement:** Describe why multiple levels/items were affected in the commit body.

## 3. Global Rules
- **Format:** `type(scope): message` (where `type` is the host/aspect/module name).
- **Optionality:** Omit scope for general/global changes (e.g., `init: bootstrap repo`, `chore: format all`).
- **Granularity:** Group changes logically based on their functional dependency. Do not over-split commits; changes that are closely related or depend on each other should remain together.
- **Formatting:** Lowercase message, no trailing period.
- **Prohibitions:** STRICTLY prohibit `Co-Authored-By`.
