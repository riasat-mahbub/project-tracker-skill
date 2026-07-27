# project-tracker-skill

An OpenCode/Codex/Claude Code skill for maintaining a file-based project
knowledge graph.  This is a thin orchestration layer — the actual tool lives
at [project-tracker-graph](https://github.com/riasat-mahbub/project-tracker-graph).

## Quickstart

```bash
# Install the tool in your project
pip install pyyaml
pip install -e /path/to/project-tracker-graph   # or add to dev dependencies

# Scaffold a tracker
tracker init
```

## Command reference

See [SKILL.md](SKILL.md) for full command docs, format spec, and agent policies.
