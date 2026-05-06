# Agent Workflow Skill

This skill governs the task lifecycle for this project.

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
3. **Tracking**:
   - Mark completed sections (including link and description) using `~~strikethrough~~`.
   - Prioritize execution of the first non-strikethrough numbered section.
4. **Safety**: If the plan is ambiguous or you are unsure of the technical implementation, ASK the user first.
5. **Consistency**: Do not invent paths. Always prefer existing modules and established patterns.
