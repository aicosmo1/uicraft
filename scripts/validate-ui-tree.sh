#!/usr/bin/env bash
set -euo pipefail

# uicraft UI Tree Validation Script (shadcn-Native)
# Usage: bash validate-ui-tree.sh <target_dir>

TARGET_DIR="${1:-.}"
if [[ -d "${TARGET_DIR}/public/ui-tree" ]]; then
  TARGET_DIR="${TARGET_DIR}/public"
fi

echo "========================================"
echo "🔍 uicraft: Validating UX Architecture"
echo "Target Directory: ${TARGET_DIR}"
echo "========================================"

FAILED=0

# 1. Check foundational files
echo -n "Checking foundational files (config.json, philosophy.md, technicals.md)... "
FOUND_MISSING=0
for FILE in "config.json" "philosophy.md"; do
  if [[ ! -f "${TARGET_DIR}/${FILE}" ]]; then
    echo -e "\n  ❌ Missing required file: ${TARGET_DIR}/${FILE}"
    FOUND_MISSING=1
    FAILED=1
  fi
done

# Check technicals.md if configured or present
if [[ -f "${TARGET_DIR}/technicals.md" ]]; then
  # Verify technicals.md has no style leaks
  TECH_LEAKS=$(grep -rEi '#[0-9a-f]{3,6}\b' "${TARGET_DIR}/technicals.md" || true)
  if [[ -n "${TECH_LEAKS}" ]]; then
    echo -e "\n  ❌ Detected hex color codes in technicals.md:"
    echo "${TECH_LEAKS}"
    FAILED=1
  fi
elif grep -q '"technicalsFile"' "${TARGET_DIR}/config.json" 2>/dev/null; then
  echo -e "\n  ❌ Missing configured technicals.md: ${TARGET_DIR}/technicals.md"
  FOUND_MISSING=1
  FAILED=1
fi

if [[ $FOUND_MISSING -eq 0 && $FAILED -eq 0 ]]; then
  echo "✅ OK"
fi

# 2. Check UI Tree directory existence
TREE_DIR="${TARGET_DIR}/ui-tree"
if [[ ! -d "${TREE_DIR}" ]]; then
  echo "❌ Missing ui-tree directory at: ${TREE_DIR}"
  exit 1
fi

# 3. Check for style leaks in all ui-tree markdown files
echo -n "Scanning ui-tree for style leaks (hex codes, hardcoded color classes)... "
LEAKS=0

# Regex for hex colors (#123, #123456)
HEX_MATCHES=$(grep -rEi --include="*.md" '#[0-9a-f]{3,6}\b' "${TREE_DIR}" || true)
if [[ -n "${HEX_MATCHES}" ]]; then
  echo -e "\n  ❌ Detected hex color codes in UI tree:"
  echo "${HEX_MATCHES}"
  LEAKS=1
  FAILED=1
fi

# Regex for direct tailwind color classes (e.g. bg-blue-500, text-red-600)
CLASS_MATCHES=$(grep -rEi --include="*.md" '\b(bg|text|border)-(red|blue|green|yellow|purple|pink|indigo|emerald|amber|slate|zinc|gray)-[0-9]{2,3}\b' "${TREE_DIR}" || true)
if [[ -n "${CLASS_MATCHES}" ]]; then
  echo -e "\n  ❌ Detected hardcoded Tailwind color utility classes in UI tree:"
  echo "${CLASS_MATCHES}"
  LEAKS=1
  FAILED=1
fi

if [[ $LEAKS -eq 0 ]]; then
  echo "✅ Zero style leaks detected (Visual styling cleanly delegated to shadcn)"
fi

# 4. Check Requirement Traceability in all component specs
echo -n "Verifying Requirement Traceability in component files... "
MISSING_TRACE=0
TOTAL_SPECS=0

while IFS= read -r FILE; do
  TOTAL_SPECS=$((TOTAL_SPECS + 1))
  # Check if Section 1 exists and has a blockquote
  if ! grep -q "## 1. Requirement Traceability" "$FILE" || ! grep -q "^>" "$FILE"; then
    echo -e "\n  ❌ File missing requirement traceability blockquote: ${FILE}"
    MISSING_TRACE=$((MISSING_TRACE + 1))
    FAILED=1
  fi
done < <(find "${TREE_DIR}" -type f -name "*.md")

if [[ $MISSING_TRACE -eq 0 ]]; then
  echo "✅ All ${TOTAL_SPECS} specs trace back to requirements"
fi

echo "========================================"
if [[ $FAILED -eq 0 ]]; then
  echo "🎉 Validation PASSED: UX Tree conforms to uicraft specifications."
  exit 0
else
  echo "💥 Validation FAILED: Address the issues above."
  exit 1
fi
