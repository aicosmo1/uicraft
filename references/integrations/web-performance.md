# `uicraft` Integration: Web Performance & Core Web Vitals (`webperf`)

`uicraft` integrates with **`webperf`** (from Addy Osmani's agent skills suite) to guarantee that every generated UI architecture is optimized for real-world speed, zero layout shifts, and responsive interactions from day one.

---

## 1. Skill Reference & Installation

- **Skill Name:** `webperf`
- **Source Repository:** `https://github.com/addyosmani/agent-skills.git` (`@webperf`)
- **Local Location:** `.agents/skills/webperf/`
- **Installation Command:**
  ```bash
  npx skills add addyosmani/agent-skills@webperf -y
  ```

---

## 2. Core Web Vitals Enforced by `uicraft`

When deconstructing UI trees (Step 3) and generating code (Step 5), `uicraft` enforces the following web performance rules:

### 1. Cumulative Layout Shift (CLS < 0.1)
- **Monospace Tabular Numerals:** All real-time telemetry metrics, timestamps, and currency counters must use `tabular-nums font-mono` so changing numbers do not cause container width jitter.
- **Skeleton Placeholders:** Initial loading states must reserve the exact dimensions of data tables, metric cards, and charts using skeleton blocks.
- **Explicit Aspect Ratios:** Avatar icons, image media, and embedded graphs must have predefined sizing (`size-7`, `h-16`, `aspect-video`).

### 2. Interaction to Next Paint (INP < 200ms)
- **Optimistic UI Updates:** Switches, toggles, and status badges must update state immediately on user click, with background async synchronization.
- **Deferred Modal & Drawer Rendering:** Complex dialog overlays, JSON viewers, and side drawers must be rendered on-demand (e.g. conditional rendering inside `<Sheet>` or `<Dialog>`), preventing heavy DOM nodes from blocking main thread hydration.
- **Micro-Tasks & Debounced Search:** Search inputs filtering large table datasets must use lightweight memoization or debouncing.

### 3. Largest Contentful Paint (LCP < 2.5s)
- **Server Component Rendering:** Layout shells, navigation bars, and static documentation links render as React Server Components where possible.
- **Client Boundary Minimization:** `"use client"` is isolated to interactive leaves (e.g., table filters, dialog buttons, theme toggles) rather than wrapping entire page bodies.

---

## 3. How `uicraft` Encodes Performance in Specifications

In each component spec (`public/ui-tree/**/*.md`), the `## 4. State & Interactions` section explicitly includes performance directives:
```markdown
## 4. State & Interactions
- **Numerals:** Formatted with tabular numbers (tabular-nums font-mono) to prevent layout jitter on metric ticks.
- **Drawer Rendering:** Body payload inspector is lazily hydrated only when the row is clicked.
```

Coding agents in Step 5 follow these instructions to produce lean, high-performing React components.
