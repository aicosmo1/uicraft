#!/usr/bin/env bash
set -euo pipefail

# uicraft Autonomous Skills Registry Synchronizer & Installer
# Distinguishes between:
# 1. External Third-Party Skills: Installed via `npx skills add <package_spec> -y`
# 2. Bundled Native Skills: Self-contained within uicraft/bundled-skills/

TARGET_DIR="${1:-.}"
DRY_RUN=0

for arg in "$@"; do
  if [[ "$arg" == "--dry-run" ]]; then
    DRY_RUN=1
  fi
done

SKILLS_DIR="${TARGET_DIR}/.agents/skills"

# Search up to repo root if not found directly
if [[ ! -d "${SKILLS_DIR}" && -d "./.agents/skills" ]]; then
  SKILLS_DIR="./.agents/skills"
fi

UICRAFT_BUNDLED_DIR="${SKILLS_DIR}/uicraft/bundled-skills"

echo "=========================================="
echo "📦 uicraft: Checking Partner Skills Registry"
echo "Skills Directory:  ${SKILLS_DIR}"
echo "Bundled Directory: ${UICRAFT_BUNDLED_DIR}"
echo "=========================================="

# 1. Bundled Native Skills (Self-Contained inside uicraft)
# Format: "skill_name|description"
BUNDLED_SKILLS=(
  "ui-copywriting|Concise Human-Crafted UI Microcopy & Anti-AI Tone"
)

echo "--- 1. Bundled Native Skills ---"
for item in "${BUNDLED_SKILLS[@]}"; do
  IFS="|" read -r SKILL_NAME DESC <<< "$item"
  
  if [[ -e "${SKILLS_DIR}/${SKILL_NAME}" || -L "${SKILLS_DIR}/${SKILL_NAME}" ]]; then
    echo "  ✅ Bundled & Active: ${SKILL_NAME} (${DESC})"
  else
    echo "  📦 Linking Bundled Skill: ${SKILL_NAME} -> uicraft/bundled-skills/${SKILL_NAME}"
    if [[ $DRY_RUN -eq 0 ]]; then
      if [[ -d "${UICRAFT_BUNDLED_DIR}/${SKILL_NAME}" ]]; then
        (cd "${SKILLS_DIR}" && ln -s "uicraft/bundled-skills/${SKILL_NAME}" "${SKILL_NAME}")
        echo "     ✨ Successfully linked bundled skill: ${SKILL_NAME}"
      else
        echo "     ❌ Error: Bundled skill source not found at ${UICRAFT_BUNDLED_DIR}/${SKILL_NAME}"
      fi
    else
      echo "     [Dry-run] Would link: ${SKILLS_DIR}/${SKILL_NAME} -> uicraft/bundled-skills/${SKILL_NAME}"
    fi
  fi
done

# 2. External Third-Party Skills (Managed via npx skills add)
# Format: "skill_dir_name|package_spec|description"
EXTERNAL_SKILLS=(
  "shadcn|shadcn-ui/ui@shadcn|Official shadcn/ui Presets & Primitives"
  "webperf|addyosmani/agent-skills@webperf|Addy Osmani Core Web Vitals & Web Performance"
  "agent-skills|addyosmani/agent-skills|Addy Osmani Engineering Suite & Code Review"
  "web-design-guidelines|vercel-labs/agent-skills@web-design-guidelines|Vercel Web Design, A11y & Contrast Guidelines"
  "better-layout|jakubkrehel/skills/skills/better-layout|Unstyled Spatial Hierarchy, Shared Edges & Baseline Alignment"
  "responsive-design|wshobson/agents/plugins/ui-design/skills/responsive-design|Container Queries, Fluid Grids & Breakpoint Adaptivity"
  "composition-patterns|vercel-labs/agent-skills@composition-patterns|Vercel React Composition & Compound Components"
  "vercel-react-view-transitions|vercel-labs/agent-skills@vercel-react-view-transitions|Vercel React View Transitions"
)

echo "--- 2. External Third-Party Skills ---"
MISSING_EXTERNAL=0

for item in "${EXTERNAL_SKILLS[@]}"; do
  IFS="|" read -r SKILL_DIR PKG_SPEC DESC <<< "$item"
  
  if [[ -e "${SKILLS_DIR}/${SKILL_DIR}" || -L "${SKILLS_DIR}/${SKILL_DIR}" ]]; then
    echo "  ✅ Installed: ${SKILL_DIR} (${DESC})"
  else
    echo "  ⚠️ Missing External Skill: ${SKILL_DIR} -> ${PKG_SPEC}"
    MISSING_EXTERNAL=$((MISSING_EXTERNAL + 1))
    
    if [[ $DRY_RUN -eq 0 ]]; then
      echo "     🚀 Installing via: npx skills add ${PKG_SPEC} -y ..."
      npx skills add "${PKG_SPEC}" -y || {
        echo "     ⚠️ Note: Installation command completed with status $?. Proceeding."
      }
    else
      echo "     [Dry-run] Would execute: npx skills add ${PKG_SPEC} -y"
    fi
  fi
done

echo "=========================================="
if [[ $MISSING_EXTERNAL -eq 0 ]]; then
  echo "🎉 All partner skills (Bundled & External) are active and ready in ${SKILLS_DIR}."
else
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "🔍 Dry-run complete. ${MISSING_EXTERNAL} external partner skill(s) missing."
  else
    echo "✨ Completed external skills synchronization."
  fi
fi
echo "=========================================="
