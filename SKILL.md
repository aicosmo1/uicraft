---
name: uicraft
description: >-
  Autonomous UI/UX architecture framework natively integrated with shadcn/ui and
  an open Agent Skills Registry (better-layout, responsive-design, ui-copywriting, webperf, web-design-guidelines, composition-patterns).
  Generates UX-first unstyled UI Trees and Integration-Ready technical specifications
  (technicals.md) from PRDs. Supports structured mutations (update-colors, update-technicals,
  update-philosophy, modify-component, build-code).
---

# `uicraft`: Autonomous UI/UX Architecture Framework (shadcn & Integrations Registry)

## Overview

`uicraft` automates the translation of unstyled Product Requirements Documents (PRDs) into an agent-ready UI/UX architecture and integration-ready frontend.

### The Strategic Division of Labor
1. **Visual Polish is Delegated to `shadcn/ui`:** `shadcn/ui` provides human-tested, mathematically balanced themes, base colors, font stacks, and accessible primitives via **presets** (such as `b6FmyD0j2`, `buFywKm`, or default `b0`).
2. **Partner Skills Ecosystem:** Rather than duplicating instructions, `uicraft` integrates with official and community skills via [references/integrations/registry.md](./references/integrations/registry.md) (`better-layout`, `responsive-design`, `ui-copywriting`, `webperf`, `agent-skills`, `web-design-guidelines`, `composition-patterns`, `vercel-react-view-transitions`).
3. **`uicraft` Focuses 100% on UX Architecture & Integration-Ready Handlers:**
   - User task flows and information hierarchy.
   - Granular component decomposition (layouts, pages, cards, tables, drawers).
   - Interaction states (hover triggers, active modals, keyboard shortcuts, empty states).
   - **Integration-Ready Architecture (`public/technicals.md`):** Maps backend and third-party library dependencies, prescribing typed async service handlers (`lib/services/`) so the UI is completely wired and ready for immediate backend connection (e.g., Supabase, Prisma, REST) with zero UI refactoring.
   - **100% Requirement Traceability** citing verbatim PRD lines.
   - Producing clean, unstyled markdown specifications for coding agents.

---

## Directory Structure of Output

When executed on a client project, `uicraft` manages the following architecture inside the project's target directory (default: `public/`):

```text
public/
├── requirements.md            # Input unstyled PRD
├── config.json               # Framework configuration & preset pointers
├── preset-info.md            # Active shadcn preset metadata (style, baseColor, fonts)
├── philosophy.md             # UX principles, density, and interaction standards
├── technicals.md             # Integration-Ready libraries, domain types & service handlers
└── ui-tree/                  # Hierarchical component tree (zero inline styling)
    ├── layout/
    │   ├── shell.md          # Top-level application shell
    │   ├── sidebar.md        # Collapsible navigation sidebar
    │   └── header.md         # Global header with actions
    ├── [feature-route]/      # Mirrors router structure (e.g. dashboard/)
    │   ├── page.md           # Page composition and grid arrangement
    │   └── [component].md    # Individual component specs
    └── [another-route]/
        ├── page.md
        └── [component].md
```

---

## Mode 1: Scaffold Workflow (New Projects)

When scaffolding a new application from an unstyled PRD, follow these 5 steps in order:

### Step 1: Ingest Requirements & Verify Partner Skills
1. Locate the PRD file (default: `public/requirements.md` or as configured in `config.json`).
2. Extract user personas, route hierarchy, persistent views, and core interactive workflows.
3. **Verify Partner Skills Presence:** Run `bash .agents/skills/uicraft/scripts/install-integrations.sh` to ensure all registered partner skills (`shadcn`, `better-layout`, `responsive-design`, `ui-copywriting`, `webperf`, `web-design-guidelines`, `composition-patterns`, `vercel-react-view-transitions`) are installed in `.agents/skills/`.

### Step 2: Extract Foundations & Author `technicals.md`
1. Read [references/integrations/shadcn.md](./references/integrations/shadcn.md) and [references/philosophy-extraction.md](./references/philosophy-extraction.md).
2. Inspect the project's `components.json` and `globals.css` to identify:
   - The active preset (`style`, `baseColor`, `iconLibrary`, `--radius`).
3. Generate `public/preset-info.md` summarizing the active preset.
4. Generate `public/philosophy.md` defining information density, surface rules, and interaction patterns.
5. Read [references/technicals-specification.md](./references/technicals-specification.md) and author `public/technicals.md`:
   - Identify backend requirements (e.g., Supabase, Auth, Database, Payments).
   - List non-UI package dependencies (`pnpm add ...`).
   - Define domain TypeScript interfaces and typed async service handlers (`lib/services/`).
6. Write `public/config.json`.

### Step 3: Deconstruct into Hierarchical UI Tree
1. Read [references/tree-specification.md](./references/tree-specification.md) and [references/component-schema.md](./references/component-schema.md).
2. Consult [references/integrations/web-design-guidelines.md](./references/integrations/web-design-guidelines.md), [references/integrations/layout-and-alignment.md](./references/integrations/layout-and-alignment.md) (`better-layout`), [references/integrations/responsive-design.md](./references/integrations/responsive-design.md) (`responsive-design`), and [references/integrations/ui-copywriting.md](./references/integrations/ui-copywriting.md) (`ui-copywriting`) for tap target, 2x negative-space hierarchy, shared edge, container adaptivity, and concise, anti-AI microcopy guidelines (headings $\le$ 4 words, subtitles $\le$ 12 words).
3. Create layout specs (`sidebar.md`, `header.md`) and route specs (`[route]/page.md`, `[component].md`).
4. **Enforce Strict Rules on every `.md` file:**
   - Always include the verbatim PRD quote in `## 1. Requirement Traceability`.
   - **Zero style leakage:** Never specify hex codes, pixel dimensions, or hardcoded utility colors.
   - **Zero AI fluff:** Never use bloated buzzwords (*"seamlessly"*, *"empowering"*, *"comprehensive overview"*).
   - Detail hover states, click triggers, empty states, and accessibility attributes.

### Step 4: Audit & Verification
Run the validation script against the output directory:
```bash
bash .agents/skills/uicraft/scripts/validate-ui-tree.sh <output_dir>
# (or via root symlink: bash uicraft/scripts/validate-ui-tree.sh <output_dir>)
```
Ensure 100% of components cite requirements, `technicals.md` exists and is valid, and zero style leaks are detected. The audit MUST pass before proceeding to Step 5.

### Step 5: Autonomous UI Code Generation & Full Verification
Once the UX Tree and technicals pass audit, the agent proceeds immediately to code generation:
1. **Install Technical & UI Dependencies:**
   - Execute package installations specified in `public/technicals.md` (e.g., Supabase client, zod, date-fns).
   - Install required shadcn primitives via `pnpm dlx shadcn@latest add <components...> -y`.
2. **Scaffold Integration-Ready Service Handlers:**
   - Create typed async service handlers in `lib/services/` (or `lib/api/`) matching Section 4 of `public/technicals.md` with realistic mock data and async latency simulation.
3. **Wire Application State:**
   - Connect client state and React Context to the service handlers rather than embedding static inline arrays.
4. **Build Layout Shell & Views (Depth-First):**
   - Step 5a: Build Layout Shell (`layout/shell.md`, `layout/sidebar.md`, `layout/header.md`).
   - Step 5b: Build Feature Routes & Pages (`[route]/page.md`).
   - Step 5c: Build Leaf Components (tables, metric cards, modals, drawers).
   - Apply [references/integrations/layout-and-alignment.md](./references/integrations/layout-and-alignment.md) (`better-layout`), [references/integrations/responsive-design.md](./references/integrations/responsive-design.md) (`responsive-design`), [references/integrations/ui-copywriting.md](./references/integrations/ui-copywriting.md) (`ui-copywriting`), [references/integrations/composition-patterns.md](./references/integrations/composition-patterns.md), and [references/integrations/web-performance.md](./references/integrations/web-performance.md).
   - Style strictly through preset semantic tokens (`bg-card`, `text-foreground`, `border-border`, `font-mono tabular-nums`).
5. **Static Analysis & Lint Verification (`pnpm run lint`):**
   - Run `pnpm run lint` (or project lint script) to verify zero syntax, linting, or typing errors. Address all issues before building.
6. **Compile & Production Build Verification (`pnpm run build`):**
   - Run `pnpm run build` (or project build command) to verify clean compilation with zero TypeScript errors.
7. **Full-App Architecture & Compliance Evaluation (`eval`):**
   - Run `bash .agents/skills/uicraft/scripts/eval-app.sh <project_dir>` and audit both `src/` and `public/` against [references/evaluation-rubric.md](./references/evaluation-rubric.md).
   - Verify 100% spec-to-code alignment, requirement traceability, zero style leaks, and partner skills compliance.

---

## Mode 2: Action Workflow (Structured Mutations)

When modifying an existing project (changing colors, presets, backend services, adding component features, or rebuilding UI), coding agents must **never** edit code directly. Follow [references/action-workflow.md](./references/action-workflow.md):

### Step 1: Match Action & Structured Interview
Match user intent to the [references/actions-catalog.md](./references/actions-catalog.md):
- `action:build-code`: Generate or regenerate application code from an existing, audited `ui-tree/` and `technicals.md`.
- `action:update-technicals`: Modify backend providers, add libraries, or update service handler contracts in `public/technicals.md`.
- `action:update-colors`: Switch shadcn presets (`shadcn apply <preset>`) or tune specific CSS variables in `globals.css`.
- `action:update-philosophy`: Adjust preset geometry (`--radius`), typography scales, or density in `components.json`/`globals.css`.
- `action:modify-component`: Add or modify elements in `ui-tree/` with requirement traceability.

Conduct an interactive interview using `ask_question` to lock in parameters before touching files (if clarification is needed).

### Step 2: Mutate Public Spec Files First (ZERO Code Changes)
Update `public/preset-info.md`, `public/philosophy.md`, `public/technicals.md`, or the targeted `public/ui-tree/**/*.md` files.

### Step 3: Run Audit Gate
```bash
bash .agents/skills/uicraft/scripts/validate-ui-tree.sh <output_dir>
# (or via root symlink: bash uicraft/scripts/validate-ui-tree.sh <output_dir>)
```
Must pass with zero errors before proceeding to code changes.

### Step 4: Synchronize Application Source Code & Verify
1. Install new dependencies or execute corresponding shadcn CLI commands.
2. Update service handlers in `lib/services/` and components in `components/` and `app/`.
3. Run `pnpm run lint` to verify zero linting errors.
4. Run `pnpm run build` to verify clean compilation with zero regressions.
5. Execute full-app evaluation audit: `bash .agents/skills/uicraft/scripts/eval-app.sh <project_dir>` against [references/evaluation-rubric.md](./references/evaluation-rubric.md).
