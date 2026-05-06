# Skills Overview

This file provides an overview of the specialized skills available for the coding agent.

## MANDATORY Execution Sequence

Before starting ANY work on a plan, you MUST follow this sequence:

1. **Read Agent Workflow Skill FIRST**: [Agent Workflow](skills/agent-workflow/SKILL.md)
   - Governs task lifecycle, plan management, and progress tracking
   - MANDATORY before reading any plan

2. **Read Root Plan**: Read the corresponding plan file from `.agents/@plans/`
   - Contains numbered steps with links to subplans

3. **Read Subplan for Current Step**: Read `.agents/@plans/<topic>/<subplan>.md`
   - Contains implementation steps and verification criteria
   - Track progress with `[✓]` markers IN REAL-TIME as you complete each step

4. **Identify and Read Domain-Specific Skills**: Based on the step requirements, read relevant skills from the list below

**Failure to follow this sequence is non-compliance.**

## Domain-Specific Skills

- **[Agent Workflow](skills/agent-workflow/SKILL.md)** — Task lifecycle, plan management, progress tracking, execution protocol
- **[Skill Creation](skills/skill-creation/SKILL.md)** — Creating new skills, documenting procedures, formalizing domain knowledge
- **[Git Ops](skills/git-ops/SKILL.md)** — Git workflows, branching strategy, commits, PRs
- **[Flake-File Management](skills/flake-file/SKILL.md)** — Flake input management, regeneration, module aggregation patterns

## Creating New Skills

After every successfully completed task, create a corresponding skill in `.agents/`.
- **Grouping**: Group skills by category in `.agents/skills/<hyphen-separated-name>/SKILL.md`.
- **Structure**: Each `SKILL.md` file must provide further routing and instructions for specific actions or sub-tasks within that domain.
