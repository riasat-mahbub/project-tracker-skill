# project-tracker-skill

A [Reasonix](https://reasonix.ai) / OpenCode skill for maintaining a file-based
project knowledge graph. Every bug, feature, decision (ADR), task, and epic
lives as a Markdown file with YAML frontmatter. A `tracker rebuild` generates
dashboards, a JSON adjacency graph, and automatic backlinks.

**The `tracker` CLI tool is a required dependency. The skill alone cannot run
without it.**

## Quick start (one-liner)

```bash
pip install -e ~/Projects/projet-tracker-graph  && \
ln -sfn $(pwd) ~/.reasonix/skills/project-tracker && \
ln -sfn $(pwd) ~/.opencode/skills/project-tracker
```

## Step 1: Install the CLI tool

The CLI tool lives in a
[separate repo](https://github.com/riasat-mahbub/projet-tracker-graph).

```bash
git clone git@github.com:riasat-mahbub/projet-tracker-graph.git ~/Projects/projet-tracker-graph
pip install -e ~/Projects/projet-tracker-graph
```

Verify:

    tracker --help

## Step 2: Install the skill

```bash
# Reasonix / agents
ln -sfn $(pwd) ~/.agents/skills/project-tracker

# OpenCode
ln -sfn $(pwd) ~/.opencode/skills/project-tracker
```

Restart your agent session to discover the skill.

## Usage

See [SKILL.md](SKILL.md) for workflows and command reference.
