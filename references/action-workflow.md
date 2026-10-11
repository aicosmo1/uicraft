# `uicraft` Action Execution Runbook

This document defines the strict, non-negotiable step-by-step workflow coding agents must follow when executing an action command.

---

## The 4-Step Action Lifecycle

```text
[User Request]
       │
       ▼
[Step 1: Match Action & Structured Interview]
  - Identify action from actions-catalog.md
  - Ask user structured questions (using ask_question tool or clear modal)
  - Lock in parameters before touching files
       │
       ▼
[Step 2: Mutate Public Spec Files (ZERO CODE CHANGES)]
  - Edit public/philosophy.md, public/colors.md, or public/ui-tree/**/*.md
  - Keep zero inline color classes in ui-tree
  - Preserve requirement traceability
       │
       ▼
[Step 3: Run Automated Audit]
  - Execute: bash uicraft/scripts/validate-ui-tree.sh <output_dir>
  - Must pass with 0 errors before proceeding
       │
       ▼
[Step 4: Propagate to Application Source Code & Verify]
  - Update CSS variables, Tailwind tokens, or component files in src/ / app/ / components/
  - Run lint verification: pnpm run lint
  - Run build command: pnpm run build
  - Run full-app evaluation: bash uicraft/scripts/eval-app.sh <project_dir>
  - Verify zero TypeScript, lint, or architectural regressions
```

---

## Detailed Rules per Step

### Rule 1: No Unclarified Edits
Never guess visual preferences when a user asks for a design change (e.g., "make fonts bigger"). Always clarify the target scale, boundaries, and scope using the questionnaire defined in [actions-catalog.md](./actions-catalog.md).

### Rule 2: Spec Invariant (Specs Precede Code)
Never touch `.tsx`, `.ts`, or `.css` files before the markdown specification files in `public/` reflect the intended change. The `public/` directory is the single source of truth for the project's design system and UI architecture.

### Rule 3: Tree Audit Gate
Always run `validate-ui-tree.sh` immediately after editing any markdown file in `public/`. If the script reports a style leak or missing requirement trace, fix the specification immediately before touching any code.

### Rule 4: Verification & Evaluation Gate
Always execute `pnpm run lint` followed by `pnpm run build` after updating code. Following a clean build, execute `bash uicraft/scripts/eval-app.sh <project_dir>` and audit both `public/` and `src/` against [evaluation-rubric.md](./evaluation-rubric.md) to confirm 100% architectural compliance.
