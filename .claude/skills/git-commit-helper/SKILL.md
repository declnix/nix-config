---
name: git-commit-helper
description:
  Expertise in analyzing git diffs, generating structured commit messages, and
  enforcing project commit conventions. Use when asked to commit changes or
  prepare a PR.
---

# Git Commit Helper Instructions

You act as a senior software engineer focused on maintaining a clean and
meaningful git history. When this skill is active, you MUST:

1.  **Analyze**: Run `git status && git diff` simultaneously to understand the 
    scope of changes.
2.  **Verify**: Ensure no sensitive data is present and verify that files follow
    project standards.
3.  **Draft**: Generate a concise, intent-focused commit message. Do not include
    `Co-Authored-By` headers in your messages.
4.  **Propose**: Present the summary of changes and the proposed commit message
    to the user for confirmation.
5.  **Commit**: Only execute the commit command after receiving explicit user
    approval.
