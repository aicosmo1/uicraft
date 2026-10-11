# Design Philosophy: shadcn Preset Derivation & UX-First Architecture

In `uicraft`, **visual styling is a solved problem**. `shadcn/ui` provides human-tested, mathematically balanced design systems via presets (such as `buFywKm` or default `b0`).

`uicraft` extracts the project's visual foundations directly from the active shadcn preset, freeing 100% of the agent's focus for **UX Architecture and Information Hierarchy**.

---

## 1. Extracting the Preset

When analyzing a client project, `uicraft` inspects:

1. **`components.json`**:
   - `style`: Determines primitive component styling (`base-nova`, `new-york`, `default`).
   - `tailwind.baseColor`: Determines the neutral tonal palette (`neutral`, `zinc`, `slate`, `stone`).
   - `iconLibrary`: Determines the iconography package (e.g., `lucide-react`).
2. **`globals.css`**:
   - Reads `--radius` to determine the geometry standard.
   - Reads CSS variables (`--background`, `--foreground`, `--primary`, `--border`) to confirm theme coverage.

---

## 2. Generating `public/preset-info.md`

`uicraft` generates a concise summary in the project's output directory (`public/preset-info.md`):

```markdown
# Active shadcn Preset Information

- **Preset Source:** `components.json` / `globals.css`
- **Style:** [e.g. base-nova]
- **Base Color:** [e.g. neutral]
- **Icon Library:** [e.g. lucide]
- **Base Radius:** [e.g. 0.625rem]
- **Stylesheet:** [e.g. app/globals.css]

> **Note for Coding Agents:** All component colors, border styles, and font tokens are managed natively by this preset. Do not introduce arbitrary CSS classes or custom color schemes.
```

---

## 3. Generating `public/philosophy.md`

`uicraft` produces `public/philosophy.md` to define the **Information Architecture & Density Rules** for the project:

### Surface & Elevation Principles
- Avoid drop shadows; surfaces are defined by single-pixel borders (`border border-border`) and tonal card backgrounds (`bg-card`).
- Containers (Cards, Modals, Tables) follow `rounded-lg` or the preset's `--radius`.
- Interactive controls (Buttons, Inputs, Badges) follow `rounded-md`.

### Information Density
- Balanced spacing: `p-4` or `p-6` for content containers, `gap-4` or `gap-6` for responsive grids.
- Data tables and telemetry consoles use monospace tabular numbers (`tabular-nums font-mono`) to prevent layout shifts.

### Micro-interactions & Accessibility
- Hover transitions: Snappy transitions (`duration-150`).
- Keyboard focus: High-visibility focus ring (`focus-visible:ring-2 focus-visible:ring-ring`).
- Tooltips: 150ms delay on icon-only triggers.
- Empty states: Purpose-built, centered containers with clear instructions.

---

## 4. The Golden Rule of `uicraft` UI Trees
Because visual tokens are already locked in by the shadcn preset:
- **Zero Style Classes in `ui-tree`:** Component specifications in `ui-tree/**/*.md` must **never** mention colors, font sizes, or pixel values.
- **100% Focus on UX Structure:** Specs describe user workflows, data elements, state transitions, and verbatim requirement citations.
