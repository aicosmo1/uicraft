# `uicraft` Integration: Vercel Web Design & Accessibility Guidelines

`uicraft` integrates with **`web-design-guidelines`** (from Vercel Labs) to ensure every component adheres to accessible, ergonomic, and modern design standards.

---

## 1. Skill Reference & Installation

- **Skill Name:** `web-design-guidelines`
- **Source Repository:** `https://github.com/vercel-labs/agent-skills.git` (`@web-design-guidelines`)
- **Local Location:** `.agents/skills/web-design-guidelines/`
- **Installation Command:**
  ```bash
  npx skills add vercel-labs/agent-skills@web-design-guidelines -y
  ```

---

## 2. Accessibility & Ergonomic Standards

When deconstructing UI trees (Step 3) and writing code (Step 5), `uicraft` enforces:

### 1. Touch Targets & Ergonomics
- **Minimum 44x44px Tap Targets:** Buttons, icon triggers, and dropdown toggles on touch surfaces must maintain an effective tap boundary of at least `44x44px` (using `size-9` / `h-10` with generous padding or invisible pseudo-element expansion).
- **Adequate Spacing:** Interactive elements must have a minimum `8px` gap between adjacent targets to prevent accidental taps.

### 2. Contrast & Visual Clarity (WCAG AA)
- **Semantic Text Tokens:** Never use low-contrast arbitrary gray shades. Use `text-foreground` for primary headings, `text-muted-foreground` for secondary metadata, and `text-card-foreground` on surface cards.
- **Visual State Feedback:** Every interactive element must define distinct `:hover`, `:active`, `:focus-visible`, and `:disabled` states.

### 3. Screen Reader Landmarks & Keyboard Navigation
- **Landmark Elements:**
  - `header role="banner"` for top application bars.
  - `aside role="navigation"` or `aria-label="..."` for sidebars.
  - `main role="main"` for the primary content container.
  - `section role="region" aria-label="..."` for distinct dashboard panels.
- **Focus Rings:**
  - Clear focus indicator: `focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 outline-none`.
- **Keyboard Shortcuts:**
  - Dialogs and sheets dismiss on `Escape`.
  - Accessible dialog triggers trap focus while active and restore focus to trigger buttons on dismiss.

---

## 3. UI Tree Spec Schema Compliance

In `public/ui-tree/**/*.md`, `## 5. Accessibility & Semantics` is mandatory:
```markdown
## 5. Accessibility & Semantics
- **ARIA Landmark:** `role="region" aria-label="Gateway Telemetry Metrics"`
- **Values:** `aria-live="polite"` for metric updates.
- **Touch Target:** Minimum 44px tap zone on mobile viewports.
```
