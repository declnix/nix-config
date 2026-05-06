# Agent Workflow Skill

This skill governs the task lifecycle and execution mandates for this project.

## Operational Mandates

- **Strict Adherence**: You MUST strictly follow the provided plans and skills. Do NOT attempt to find solutions through trial and error or invent paths.
- **Subplan-First Execution**: Before starting any numbered plan step:
  1. Read the corresponding subplan file FIRST (do not defer or ignore)
  2. Track each implementation step with `[✓]` markers IN REAL-TIME as you complete it
  3. Update both root plan AND subplan verification sections when step finishes
  Failure to follow this is non-compliance.
- **Memory Management**: Do NOT save facts to memory unless explicitly requested by the user.
- **Pending Changes (WORKSPACE.md)**: Maintain non-tracked `WORKSPACE.md` for pending updates to `.agents/` structure. Each entry must specify target file and exact change.

## Lifecycle
1. **Initiate**: Read or draft a plan in `.agents/@plans/`.
2. **Execute**: Perform tasks using specialized domain skills. STRICTLY follow existing plans. Do NOT deviate or invent paths; if a technical decision is required, ASK the user.
3. **Formalize**: Upon completion, create or update a skill in `skills/` to capture domain knowledge and procedures.

## Plan Management Strategy
1. **Hierarchy**:
   - Root plans: `.agents/@plans/`.
   - Subplans: `.agents/@plans/<topic>/`.
2. **Structure**: 
   - Root plans MUST contain numbered sections corresponding to task phases.
   - Each section must include:
     - A concise high-level description of what the phase achieves.
     - A link to the corresponding subplan file.
   - Plans can be hierarchical (subplans can contain their own subplans).
3. **Tracking**:
   - Mark completed sections by adding `[✓]` before the title (applies to root plans and all subplan steps/tasks).
   - This tracking applies to both implementation steps and verification tasks to maintain visibility of progress.
   - Prioritize execution of the first non-completed numbered section.
4. **Safety**: If the plan is ambiguous or you are unsure of the technical implementation, ASK the user first.
5. **Consistency**: Do not invent paths. Always prefer existing modules and established patterns.
