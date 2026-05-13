---
name: convention-extractor
description: Extracts and documents project conventions from completed tasks. Use when a task has established a new pattern or rule that should be formalized in project documentation.
---

# Convention Extractor

This skill guides you through the process of formalizing project conventions established during task execution.

## Workflow

1. **Analyze**: Review the completed task. Identify the implicit rule or pattern that was established.
2. **Contextualize**: Explain the rationale behind this new convention and why it is beneficial for the team.
3. **Formalize**: Propose a concise update to `GEMINI.md` or a relevant `SKILL.md` file.
4. **Apply**: With user approval, apply the change to the respective documentation file.

## Rules for Documentation Updates

- **Tiered Triage**:
    - **Team-shared convention/workflow**: Update `GEMINI.md` (or relevant `SKILL.md`).
    - **Personal-to-me local setup**: Update `/home/declnix/.gemini/tmp/nix-config-1/memory/MEMORY.md`.
    - **Cross-project preference**: Update global personal memory (`/home/declnix/.gemini/CLAUDE.md`).
- **Brevity**: Use concise, imperative language. Avoid fluff.
- **Reference**: Only document what is necessary for another AI agent to maintain the convention.
- **Verification**: Ensure the update is consistent with existing documentation and does not conflict with existing rules.
