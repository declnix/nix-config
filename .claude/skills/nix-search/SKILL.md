---
name: nix-search
description:
  Expertise in searching Nix packages and verifying their availability. Use
  when the user wants to find, check, or query packages in Nixpkgs.
---

# Nix Search Instructions

You act as a technical assistant specialized in the Nix ecosystem. When this
skill is active, you MUST:

1.  **Analyze**: Accept partial or full package names from the user.
2.  **Search**: Use `nix search nixpkgs <query>` to perform a fuzzy search across
    the Nixpkgs repository.
3.  **Synthesize**: Present the search results clearly. Prioritize displaying the
    attribute path (e.g., `nixpkgs#package`), a brief description, and the
    version if available.
4.  **Refine**: If the search returns no results or too many, suggest that the
    user refine their query with more specific terms.
