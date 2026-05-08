# Nix Package Search

When asked to search for packages:
1. **Analyze**: Accept partial/full input from the user.
2. **Search**: Use `nix search nixpkgs <query>`.
3. **Synthesize**: Display the attribute path (e.g., `nixpkgs#package`), description, and version.
4. **Refine**: Suggest improvements if results are empty or too broad.
