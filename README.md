# project-tracker-skill

A skill for OpenCode, Reasonix, and Claude Code that maintains a file-based
project knowledge graph.  The actual CLI tool lives in a [separate repo](https://github.com/riasat-mahbub/projet-tracker-graph).

## Install

```bash
curl -sSL https://raw.githubusercontent.com/riasat-mahbub/project-tracker-skill/main/scripts/install.sh | bash
```

Or from a local checkout:

```bash
bash scripts/install.sh
```

This clones the tool repo, installs the CLI, detects your harness, and
symlinks the skill into the correct skills directory.

Supports: **OpenCode**, **Reasonix**, **Claude Code**.

## Usage

See [SKILL.md](SKILL.md) for workflows and command reference.
