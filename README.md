# project-tracker-skill

A [Reasonix](https://reasonix.ai) / OpenCode skill for maintaining a file-based
project knowledge graph. Every bug, feature, decision (ADR), task, and epic
lives as a Markdown file with YAML frontmatter. A `tracker rebuild` generates
dashboards, a JSON adjacency graph, and automatic backlinks.

The CLI tool lives in a [separate repo](https://github.com/riasat-mahbub/projet-tracker-graph).

## Install the CLI

```bash
pip install pyyaml
pip install -e /path/to/projet-tracker-graph
```

Or from the tool repo directly:
```bash
git clone git@github.com:riasat-mahbub/projet-tracker-graph.git ~/Projects/projet-tracker-graph
pip install -e ~/Projects/projet-tracker-graph
```

## Install the skill

```bash
# Reasonix
ln -sfn $(pwd) ~/.agents/skills/project-tracker

# OpenCode
ln -sfn $(pwd) ~/.opencode/skills/project-tracker
```

## Usage

See [SKILL.md](SKILL.md) for workflows and command reference.
