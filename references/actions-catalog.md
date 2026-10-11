# `uicraft` Actions Catalog

This catalog defines the official registry of structured mutation actions supported by `uicraft`. In all actions, **specifications in `public/` must be updated and audited before touching application source code**.

---

## 1. `action:build-code` (alias: `action:generate-ui`)

### Purpose
Autonomously generate or regenerate application source code in `components/` and `app/` (or `src/`) directly from the existing, audited `public/ui-tree/`, `public/preset-info.md`, and `public/philosophy.md`.

### Triggers
- "Build the code in src"
- "Generate UI from public ui-tree"
- "action:build-code"
- "action:generate-ui"

### Execution Flow
1. Verify audit: Ensure `bash uicraft/scripts/validate-ui-tree.sh <output_dir>` passes.
2. Install primitives: Scan component specs for shadcn primitives and run `pnpm dlx shadcn@latest add <primitives...> -y`.
3. Traverse `ui-tree/` depth-first:
   - Shell & Navigation (`layout/shell.md`, `layout/sidebar.md`, `layout/header.md`)
   - Route pages (`[route]/page.md`)
   - Leaf components (tables, cards, modals, sheets)
4. Verify lint: Run `pnpm run lint` and ensure zero linting errors.
5. Verify build: Run `pnpm run build` and ensure zero compilation errors.
6. Evaluate compliance: Run `bash uicraft/scripts/eval-app.sh <project_dir>` and audit against `references/evaluation-rubric.md`.

---

## 2. `action:update-colors`

### Purpose
Update the visual theme, colors, or palette preset using shadcn's preset architecture or semantic CSS variables.

### Triggers
- "Change the theme / apply a new preset"
- "Update primary color / change brand accent"
- "Switch between dark and light mode"
- "Apply preset buFywKm or b0"

### Structured Questionnaire Template
1. **Mutation Type:**
   - **Preset-Level Switch (Recommended):** Apply a complete preset code or URL from [ui.shadcn.com/create](https://ui.shadcn.com/create) (e.g., `buFywKm`, `b0`).
   - **Token-Level Tuning:** Adjust a specific semantic variable (e.g. `--primary`, `--accent`, `--destructive`) directly in `globals.css`.
2. **Parameters:**
   - If preset: What is the preset code or URL?
   - If token: What is the target color (OKLCH, HSL, or hex)?
3. **Theme Target:** Applies to light mode (`:root`), dark mode (`.dark`), or both?

### Target Spec Files
- `public/preset-info.md`
- `public/philosophy.md`

### Downstream Code Targets
- If preset switch: Run `pnpm dlx shadcn@latest apply <preset> --yes`
- If token tuning: Update `:root` / `.dark` CSS variables in `app/globals.css`
- Run `pnpm run lint` and `pnpm run build`
- Run evaluation audit: `bash uicraft/scripts/eval-app.sh <project_dir>`

---

## 3. `action:update-philosophy`

### Purpose
Update global architectural rules, geometry (border radius), information density, or component styling convention.

### Triggers
- "Change border radiuses across all cards and buttons"
- "Make the interface more compact / denser"
- "Switch component style (e.g. to base-nova, new-york, or default)"
- "Update typography hierarchy rules"

### Structured Questionnaire Template
1. **Target Dimension:**
   - Component Geometry: Change base border radius (`--radius`).
   - Information Density: Adjust padding/spacing standards (`p-4` vs `p-6`, compact table rows).
   - Component Style: Switch style in `components.json` (`base-nova`, `new-york`, `default`).
   - Typography Hierarchy: Update scaling standards in `philosophy.md`.
2. **Scope:** Does this apply to all cards, tables, and buttons globally?

### Target Spec Files
- `public/philosophy.md`
- `public/preset-info.md`

### Downstream Code Targets
- `components.json` (if style changes)
- `app/globals.css` (if `--radius` or font variables change)
- Shared layouts and components in `components/` and `app/`
- Run `pnpm run lint` and `pnpm run build`
- Run evaluation audit: `bash uicraft/scripts/eval-app.sh <project_dir>`

---

## 4. `action:modify-component`

### Purpose
Add, remove, or modify elements, layout positioning, interactive states, or user flows in a specific component spec in `ui-tree/`.

### Triggers
- "Add a filter dropdown to the incident table"
- "Add an export button to the header"
- "Modify the notification drawer layout"
- "Add a new metric card to the overview dashboard"

### Structured Questionnaire Template
1. **Target Component:** Which component in `ui-tree/` is being modified?
2. **Requirement Traceability:** What verbatim line from `requirements.md` (or new requirement) justifies this addition?
3. **States & Interactions:** What are the default, hover, active, loading, and empty states?
4. **Recommended shadcn Primitive:** Which primitive from `@/components/ui/` should be used (e.g. `Dialog`, `DropdownMenu`, `Sheet`, `Table`)?

### Target Spec Files
- `public/ui-tree/[path]/[component].md`

### Downstream Code Targets
- The corresponding component in `components/` or `app/`
- Run `pnpm dlx shadcn@latest add <component> -y` if a new primitive is required
- Run `pnpm run lint` and `pnpm run build`
- Run evaluation audit: `bash uicraft/scripts/eval-app.sh <project_dir>`

---

## 5. `action:update-technicals`

### Purpose
Add, modify, or swap backend data providers (e.g., Supabase, Neon, Prisma, Firebase), register new external utility libraries (e.g., `zod`, `date-fns`), or update typed domain contracts and async service handlers in `public/technicals.md`.

### Triggers
- "Add Supabase backend integration"
- "Switch database provider to Prisma / PostgreSQL"
- "Add validation library zod"
- "Update webhook dispatch service handler contract"
- "action:update-technicals"

### Structured Questionnaire Template
1. **Target Technical Layer:**
   - Backend / BaaS Provider: (e.g. Supabase, Firebase, Neon, Prisma, REST API)
   - Authentication Provider: (e.g. Supabase Auth, Clerk, NextAuth)
   - Utility / Data Library: (e.g. `zod`, `date-fns`, `recharts`, `tanstack/react-query`)
2. **Package Modifications:** Which npm packages must be installed or uninstalled?
3. **Data Contracts & Handlers:** What TypeScript models and service handler signatures (`lib/services/*.ts`) need to be added or updated?
4. **Environment Variables:** What secret or public keys are required?

### Target Spec Files
- `public/technicals.md`
- `public/config.json`

### Downstream Code Targets
- Run package manager: `pnpm add <packages...>`
- Update service handler definitions in `lib/services/*`
- Update application context or server action bindings
- Run `pnpm run lint` and `pnpm run build` to verify clean compilation with zero regressions
- Run evaluation audit: `bash uicraft/scripts/eval-app.sh <project_dir>`

