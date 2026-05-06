# Claude Code Configuration

## IMPORTANT: Read CONTRIBUTING.md First

**MANDATORY**: Before starting ANY work, read [CONTRIBUTING.md](CONTRIBUTING.md).
- Commit format: `type(scope): message`
- Scopes must match: programs/aspects or hosts
- See file for complete convention

## Co-Author Policy

**DO NOT add `Co-Authored-By` to commits.**

Claude commits should be authored solely as:
```
Author: declnix <email@example.com>
```

Never append co-author trailers.

## Skills

Project-specific skills are in `.claude/skills/`. Claude loads them automatically when relevant, or invoke with `/skill-name`.
