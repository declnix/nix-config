# Agent Workflow Skill

This skill governs the task lifecycle in the denful ecosystem.

## Routing
- [Plan Management](plan.md)
- [Skill Creation](.agents/skills/skill-creation/SKILL.md)
- [Commit Conventions](.agents/skills/git/SKILL.md)

## Lifecycle
1. **Initiate**: Read/draft plan in `@plans`.
2. **Execute**: Perform work using specific domain skills (e.g., `git`, `den`, `hjem`).
3. **Formalize**: Upon task completion, update or create a skill in `skills/`.
