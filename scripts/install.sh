#!/usr/bin/env bash
set -euo pipefail

# When piped from curl — no local files — clone and re-exec
if [ ! -f "$(dirname "$0")/../SKILL.md" ]; then
    TMP_DIR=$(mktemp -d)
    git clone --depth 1 --branch main \
        "https://github.com/riasat-mahbub/project-tracker-skill.git" "$TMP_DIR"
    exec bash "$TMP_DIR/scripts/install.sh"
fi

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

_pip_install() {
    pip install "$@" --quiet 2>/dev/null \
        || pip install "$@" --quiet --break-system-packages 2>/dev/null \
        || pip install "$@" --quiet --user 2>/dev/null \
        || pip install "$@"
}

_pip_install pyyaml
_pip_install -e "$TOOL_DIR"

# ---------------------------------------------------------------- harness --
echo ""
echo "==> Detecting harnesses and registering skill..."

installed=0

if [ -f ".opencode.json" ] || [ -f ".opencode.jsonc" ]; then
    mkdir -p .opencode/skills
    rm -rf ".opencode/skills/project-tracker"
    ln -sfn "$SKILL_SOURCE" ".opencode/skills/project-tracker"
    echo "    Installed for OpenCode (project-local)"
    installed=1
fi

if [ -d ".agents" ]; then
    mkdir -p .agents/skills
    rm -rf ".agents/skills/project-tracker"
    ln -sfn "$SKILL_SOURCE" ".agents/skills/project-tracker"
    echo "    Installed for Reasonix (project-local)"
    installed=1
fi

if [ -d "$HOME/.opencode/skills" ]; then
    rm -rf "$HOME/.opencode/skills/project-tracker"
    ln -sfn "$SKILL_SOURCE" "$HOME/.opencode/skills/project-tracker"
    echo "    Installed for OpenCode"
    installed=1
fi

if [ -d "$HOME/.agents/skills" ]; then
    rm -rf "$HOME/.agents/skills/project-tracker"
    ln -sfn "$SKILL_SOURCE" "$HOME/.agents/skills/project-tracker"
    echo "    Installed for Reasonix"
    installed=1
fi

if [ -d "$HOME/.claude/skills" ]; then
    rm -rf "$HOME/.claude/skills/project-tracker"
    ln -sfn "$SKILL_SOURCE" "$HOME/.claude/skills/project-tracker"
    echo "    Installed for Claude Code"
    installed=1
fi

if [ "$installed" -eq 0 ]; then
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
