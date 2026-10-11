# `uicraft`: Full-App Architecture & Compliance Evaluation Rubric

This document defines the official **Evaluation Rubric** that coding agents must execute after completing code generation and verifying `pnpm run build`. 

The goal of this evaluation is to perform an end-to-end audit of both the **specification layer (`public/`)** and the **application source code (`src/` / `app/` / `components/` / `lib/`)** to guarantee 100% compliance with `uicraft` architectural standards and partner skills.

---

## The 7 Evaluation Dimensions

| Dimension | Scope | Target Standard | Partner Skill Reference |
| :--- | :--- | :--- | :--- |
| **1. Spec-to-Code Alignment** | `public/ui-tree/` $\leftrightarrow$ `components/` | 100% parity. Every spec is implemented; zero orphaned specs or components. | [tree-specification.md](./tree-specification.md) |
| **2. Requirement Traceability** | `public/requirements.md` $\leftrightarrow$ Specs | 100% of specs cite verbatim PRD lines. Feature workflows match requirements. | [component-schema.md](./component-schema.md) |
| **3. Design Token Invariant** | `globals.css` $\leftrightarrow$ Code | Zero inline hex codes (`#123456`) or arbitrary utility colors (`bg-blue-500`). | [shadcn.md](./integrations/shadcn.md) |
| **4. Spatial Layout & Edges** | Components & Layout | 2× spacing ratio, optical baseline alignment, control clearance, no flex blowout (`min-w-0`). | [layout-and-alignment.md](./integrations/layout-and-alignment.md) |
| **5. Container Adaptivity** | Grids & Wrappers | `@container` queries on parent wrappers, intrinsic tracks (`minmax(280px, 1fr)`). | [responsive-design.md](./integrations/responsive-design.md) |
| **6. Microcopy & Anti-AI Tone** | Headings & UI text | Headings $\le$ 4 words, subtitles $\le$ 12 words, active verbs, 2-sentence empty states, zero AI fluff. | [ui-copywriting.md](./integrations/ui-copywriting.md) |
| **7. Integration Handlers** | `lib/services/` $\leftrightarrow$ UI | Typed async handlers in `lib/services/`, realistic mock data, zero static mock arrays in UI. | [technicals-specification.md](./technicals-specification.md) |

---

## Detailed Evaluation Checklist

### Dimension 1: Spec-to-Code Alignment & Tree Integrity
- [ ] Every component file in `public/ui-tree/**/*.md` has a corresponding React component in `components/` or `app/`.
- [ ] Route structures in `app/` (or `src/routes/`) mirror the directory structure in `public/ui-tree/`.
- [ ] No extraneous, untracked component files exist without an architectural spec in `ui-tree/`.

### Dimension 2: Requirement Traceability
- [ ] Every markdown spec in `public/ui-tree/` includes Section 1 with a verbatim quotation citing `requirements.md`.
- [ ] Every leaf component and interactive trigger satisfies the verbatim user flow prescribed in the PRD.

### Dimension 3: Design Token Invariant (Zero Style Leaks)
- [ ] `validate-ui-tree.sh` passes with 0 style leaks detected.
- [ ] Source code uses semantic tokens exclusively: `bg-card`, `bg-background`, `text-foreground`, `text-muted-foreground`, `border-border`, `bg-primary`, `bg-secondary`, `bg-destructive`.
- [ ] Zero inline hex colors exist in `.tsx` files (except in dedicated SVG chart definitions or CSS variable declarations in `globals.css`).
- [ ] Zero ad-hoc color classes (e.g. `text-red-500`, `bg-blue-600`, `border-green-400`)—all state colors use semantic badge variants (`variant="destructive"`, `variant="outline"`, `variant="secondary"`).

### Dimension 4: Spatial Hierarchy & Shared Edges (`better-layout`)
- [ ] **Optical Baseline Alignment:** All icon-and-label pairings use `inline-flex items-center gap-1.5` with explicit sizes (`size-3.5` or `size-4`).
- [ ] **2× Spacing Ratio Rule:** The gap between distinct component sections is at least 2× the internal gap (e.g., `gap-2` inside controls, `gap-6` between cards).
- [ ] **Equal-Height Tracks:** Multi-column card rows use `grid auto-rows-fr` and children declare `h-full flex flex-col justify-between`.
- [ ] **Control Clearance:** Bordered controls maintain $\ge$ 12px clearance (`gap-3`); borderless action buttons maintain $\ge$ 20px clearance (`gap-5`).
- [ ] **Flex Blowout Safeguard:** Every flex item displaying truncated text or monospace numbers declares `min-w-0`.

### Dimension 5: Responsive Adaptivity (`responsive-design`)
- [ ] Major composite containers declare `@container` on their parent wrapper.
- [ ] Multi-column grids declare intrinsic sizing (`grid-cols-[repeat(auto-fit,minmax(280px,1fr))]` or container breakpoints `@md:`, `@lg:`).
- [ ] Tables include horizontal overflow containment (`overflow-x-auto min-w-[...]`).
- [ ] Progressive disclosure collapses secondary metadata into tooltips or icons on compact screens.

### Dimension 6: UI Microcopy & Anti-AI Tone (`ui-copywriting`)
- [ ] **Headings:** All page headings and card titles are $\le$ 4 words (*"Keyword Guardian"*, *"Budget Pacing"*).
- [ ] **Subtitles:** All card descriptions are $\le$ 12 words in a single concise sentence.
- [ ] **Action Triggers:** All button labels start with an active imperative verb (*"Export CSV"*, *"Sync Keywords"*) and are 2–3 words.
- [ ] **Zero AI Fluff:** Purged all buzzwords: *"seamlessly"*, *"empowering"*, *"comprehensive overview"*, *"robust"*, *"single pane of glass"*, *"delve into"*.
- [ ] **Empty States:** Exactly 2 sentences: Sentence 1 (What is absent) + Sentence 2 (What action to take).

### Dimension 7: Integration Handlers (`technicals.md`)
- [ ] Typed domain interfaces exist in `lib/types/` matching Section 3 of `technicals.md`.
- [ ] Typed async service handlers exist in `lib/services/` matching Section 4 of `technicals.md`.
- [ ] UI components read data from services or context providers, with zero static mock arrays hardcoded directly in JSX templates.

---

## Evaluation Gate Protocol

When completing Step 5 of Scaffold Workflow or Step 4 of Action Workflow:

1. **Lint Verification:**
   ```bash
   pnpm run lint
   ```
   *Must exit with code 0 (zero ESLint errors or unhandled warnings).*

2. **Build Verification:**
   ```bash
   pnpm run build
   ```
   *Must exit with code 0 (zero TypeScript errors, clean bundle compilation).*

3. **Evaluation Audit Execution:**
   ```bash
   bash .agents/skills/uicraft/scripts/eval-app.sh <project_dir>
   ```
   *Review all 7 dimensions and provide a structured Evaluation Scorecard in the final walkthrough report.*
