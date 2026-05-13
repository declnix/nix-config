---
name: commit-authoring
description: Skill for planning and drafting commit messages using hosts, aspects, and hjem modules.
---
# Commit Authoring Skill

This skill guides you through planning, titling, and drafting commit messages based on our Nix project structure.

## Workflow
1. **Analyze**: Identify modified files using `git status` and `git diff`.
2. **Order & Split**: Analyze dependencies between changes. Suggest a sequence of commits (e.g., adding modules or options BEFORE utilizing them) and split logically.
3. **Draft**:
    - Format: `type(scope): summary`
    - Body (Optional): Provide concise additional details only if the summary is insufficient.
4. **Propose**: Show the ordered commit messages to the user for final approval.

## Categorization Rules & Examples
- **Host Management**: 
    - Init: `hosts: init <hostname>`
    - Remove: `hosts!: remove <hostname>`
    - Modify: `<hostname>(<component>): <action>` OR `<hostname>: <action>`
    - Example: `c4rg0x(proxy): update config`, `c4rg0x: update main config`
- **Aspect Management**:
    - Init: `aspects: init <aspectname>`
    - Remove: `aspects!: remove <aspectname>`
    - Modify: `<aspectname>(<component>): <action>`
    - Example: `network(certs): add zscaler`
- **AI Agents/Skills**:
    - Init: `skills: init <name>` / `agents: init <name>`
    - Remove: `skills!: remove <name>` / `agents!: remove <name>`
    - Modify (Existing): `<name>(<component>): <action>` OR `<name>: <action>`
    - Examples: `skills: init commit-planner`, `commit-planner: implement drafting`
- **Hjem Modules**:
    - Init/Add: `hjem(<modulename>): init/add <component>`
    - Remove: `hjem!: remove <component>`
    - Add Option: `hjem(<modulename>): add option <short-name>`
    - Example: `hjem(zsh): add option autosuggest`
- **Flake**:
    - Action: `flake(<type>): <action>`
    - Example: `flake(deps): bump nixpkgs`

## Rules
- **Single Responsibility**: Each commit must target EXACTLY one host, aspect, hjem module, or flake input. No multi-scope commits allowed.
- Lowercase summaries.
- No trailing periods.
- NO hyphens, underscores, or combined words in titles; if necessary, split into multiple commits to maintain single responsibility.
- NEVER include `Co-Authored-By`.
- STRICT categorization: All commits MUST fall into `flake`, `host`, `aspect`, `hjem`, `skills`, or `agents` categories. NO general categories allowed.
