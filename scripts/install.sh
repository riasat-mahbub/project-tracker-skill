#!/usr/bin/env bash
set -euo pipefail

SKILL_SOURCE="$(cd "$(dirname "$0")/.." && pwd)"
TOOL_DIR="$HOME/Projects/projet-tracker-graph"
TOOL_REPO="git@github.com:riasat-mahbub/projet-tracker-graph.git"

echo "==> project-tracker-skill installer"
echo "    Skill source: $SKILL_SOURCE"

# ------------------------------------------------------------------ tool --
echo ""
echo "==> Setting up tracker CLI tool..."

if [ ! -d "$TOOL_DIR" ]; then
    echo "    Cloning tool repo..."
    git clone "$TOOL_REPO" "$TOOL_DIR"
else
    echo "    Tool repo already at $TOOL_DIR"
fi

pip install pyyaml --quiet 2>/dev/null || pip install pyyaml
pip install -e "$TOOL_DIR" --quiet 2>/dev/null || pip install -e "$TOOL_DIR"

# ---------------------------------------------------------------- harness --
echo ""
echo "==> Detecting harness and registering skill..."

# Project-local (highest priority)
if [ -f ".opencode.json" ] || [ -f ".opencode.jsonc" ]; then
    mkdir -p .opencode/skills
    rm -rf ".opencode/skills/project-tracker"
    ln -sfn "$SKILL_SOURCE" ".opencode/skills/project-tracker"
    echo "    Installed for OpenCode (project-local)"

elif [ -d ".agents" ]; then
    mkdir -p .agents/skills
    rm -rf ".agents/skills/project-tracker"
    ln -sfn "$SKILL_SOURCE" ".agents/skills/project-tracker"
    echo "    Installed for Reasonix (project-local)"

# Home-directory harnesses
elif [ -d "$HOME/.opencode/skills" ]; then
    rm -rf "$HOME/.opencode/skills/project-tracker"
    ln -sfn "$SKILL_SOURCE" "$HOME/.opencode/skills/project-tracker"
    echo "    Installed for OpenCode"

elif [ -d "$HOME/.agents/skills" ]; then
    rm -rf "$HOME/.agents/skills/project-tracker"
    ln -sfn "$SKILL_SOURCE" "$HOME/.agents/skills/project-tracker"
    echo "    Installed for Reasonix"

elif [ -d "$HOME/.claude/skills" ]; then
    rm -rf "$HOME/.claude/skills/project-tracker"
    ln -sfn "$SKILL_SOURCE" "$HOME/.claude/skills/project-tracker"
    echo "    Installed for Claude Code"

else
    echo "    No supported harness detected."
    echo ""
    echo "    Manually symlink into your harness's skills directory:"
    echo "      ln -s $SKILL_SOURCE ~/.opencode/skills/project-tracker"
    echo "      ln -s $SKILL_SOURCE ~/.agents/skills/project-tracker"
fi

# --------------------------------------------------------------- verify --
echo ""
echo "==> Verifying..."

if tracker --help >/dev/null 2>&1; then
    echo "    tracker CLI ready: $(tracker --help 2>&1 | head -1)"
else
    echo "    WARNING: tracker CLI not on PATH."
    echo "    Try: pip install -e $TOOL_DIR"
fi

echo ""
echo "Done."
