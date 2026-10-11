#!/usr/bin/env bash
set -euo pipefail

# uicraft Full-App Evaluation Audit Script
# Audits both public/ specifications and application source code against uicraft standards.
# Usage: bash eval-app.sh <project_dir>

PROJECT_DIR="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================================="
echo "🎯 uicraft: Full-App Architecture & Compliance Evaluation"
echo "Project Directory: ${PROJECT_DIR}"
echo "=========================================================="

FAILED=0
PUBLIC_DIR="${PROJECT_DIR}/public"
if [[ ! -d "${PUBLIC_DIR}" && -d "./public" ]]; then
  PUBLIC_DIR="./public"
fi

# 1. Audit public/ UX Tree specifications
echo "1️⃣  Auditing Specifications Layer (public/)..."
if [[ -f "${SCRIPT_DIR}/validate-ui-tree.sh" ]]; then
  if bash "${SCRIPT_DIR}/validate-ui-tree.sh" "${PUBLIC_DIR}"; then
    echo "    ✅ UX Tree & Requirements Traceability Passed."
  else
    echo "    ❌ UX Tree validation failed."
    FAILED=$((FAILED + 1))
  fi
else
  echo "    ⚠️ Warning: validate-ui-tree.sh not found."
fi

# 2. Audit source code for style leaks (hex codes & hardcoded color utilities)
echo "2️⃣  Scanning Source Code for Style Leaks..."
CODE_DIRS=()
for d in "components" "app" "src"; do
  if [[ -d "${PROJECT_DIR}/${d}" ]]; then
    CODE_DIRS+=("${PROJECT_DIR}/${d}")
  fi
done

SRC_HEX_LEAKS=0
SRC_CLASS_LEAKS=0

if [[ ${#CODE_DIRS[@]} -gt 0 ]]; then
  # Scan for inline hex codes in TSX/TS (excluding globals.css or tailwind config)
  HEX_MATCHES=$(grep -rEi --include="*.tsx" --include="*.ts" '#[0-9a-f]{3,6}\b' "${CODE_DIRS[@]}" 2>/dev/null || true)
  if [[ -n "${HEX_MATCHES}" ]]; then
    echo "    ⚠️ Warning: Detected hex color codes in application source code:"
    echo "${HEX_MATCHES}" | head -n 5
    echo "    (Ensure colors are strictly managed via CSS variables in globals.css)"
  else
    echo "    ✅ Zero inline hex codes in component code."
  fi

  # Scan for hardcoded tailwind color classes (bg-blue-500, text-red-600)
  CLASS_MATCHES=$(grep -rEi --include="*.tsx" '\b(bg|text|border)-(red|blue|green|yellow|purple|pink|indigo|emerald|amber|slate|zinc|gray)-[0-9]{2,3}\b' "${CODE_DIRS[@]}" 2>/dev/null || true)
  if [[ -n "${CLASS_MATCHES}" ]]; then
    echo "    ⚠️ Warning: Detected hardcoded Tailwind color utility classes in source code:"
    echo "${CLASS_MATCHES}" | head -n 5
    echo "    (Ensure styling uses semantic tokens: bg-card, text-foreground, border-border)"
  else
    echo "    ✅ Zero hardcoded palette classes in component code."
  fi
else
  echo "    ℹ️  No components/ or app/ source directories found to scan."
fi

# 3. Static Analysis Gate: Linting
echo "3️⃣  Executing Static Analysis Gate (Lint)..."
if grep -q '"lint":' "${PROJECT_DIR}/package.json" 2>/dev/null; then
  echo "    Running pnpm run lint..."
  if (cd "${PROJECT_DIR}" && pnpm run lint); then
    echo "    ✅ Lint gate PASSED with zero errors."
  else
    echo "    ❌ Lint gate FAILED."
    FAILED=$((FAILED + 1))
  fi
else
  echo "    ℹ️  No lint script found in package.json. Skipping."
fi

# 4. Compilation Gate: Production Build
echo "4️⃣  Executing Compilation Gate (Build)..."
if grep -q '"build":' "${PROJECT_DIR}/package.json" 2>/dev/null; then
  echo "    Running pnpm run build..."
  if (cd "${PROJECT_DIR}" && pnpm run build); then
    echo "    ✅ Build gate PASSED with zero errors."
  else
    echo "    ❌ Build gate FAILED."
    FAILED=$((FAILED + 1))
  fi
else
  echo "    ℹ️  No build script found in package.json. Skipping."
fi

echo "=========================================================="
if [[ $FAILED -eq 0 ]]; then
  echo "🎉 EVALUATION PASSED: Application conforms 100% to uicraft standards."
  exit 0
else
  echo "💥 EVALUATION FAILED: Found ${FAILED} error gate(s). Address issues before deployment."
  exit 1
fi
