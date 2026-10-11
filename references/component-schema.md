# Component Specification Schema

Every component in the `ui-tree/` hierarchy must conform to this schema.

## Format Specification

```markdown
# Component: [Component Name]
**Path:** `[ui-tree relative path, e.g. ui-tree/dashboard/stats-grid.md]`
**Parent:** `[Parent container or layout, e.g. ui-tree/dashboard/page.md]`

## 1. Requirement Traceability
> "[Exact verbatim quotation from requirements.md]"
*(Optional: Note explaining the business goal or user role)*

## 2. Semantic Role & Layout Placement
- **Component Type:** [e.g., Card Grid, Data Table, Navigation Item, Sheet Drawer]
- **Placement:** [Exact location within parent, e.g. Top row of main content area, sticky header right side]
- **Recommended Primitive:** [shadcn component, e.g. Card, Table, Badge, Tooltip, Sheet]

## 3. Structural Elements & Hierarchy
- [Element 1]: [Semantic type, displayed data, icon, label]
- [Element 2]: [Semantic type, displayed data, icon, label]
- [Child Subcomponents]: [Pointers to nested component files if applicable]

## 4. State & Interactions
- **Default State:** [Initial view, data display]
- **Hover / Focus:** [Hover highlights, tooltip text, keyboard focus outlines]
- **Active / Trigger:** [Click behavior, route change, modal trigger, acknowledgment flow]
- **Empty / Loading / Error:** [Skeleton loaders, zero-data illustration, retry prompts]

## 5. Accessibility & Semantics
- **ARIA Roles:** [e.g. role="status", role="alert", role="navigation"]
- **Keyboard Shortcuts:** [e.g. Tab order, Enter/Space activation, Esc to dismiss]
```

## Anti-Pattern Checklist (Must Pass)
- ❌ **No hex codes** (`#ffffff`, `#000000`, etc.)
- ❌ **No direct styling classes** (`bg-blue-600`, `text-red-500`, `font-bold text-xl`)
- ❌ **No pixel dimensions** (`width: 320px`, `margin-top: 15px`)
- ❌ **No bloated AI marketing copy** (*"seamlessly"*, *"empowering"*, *"comprehensive overview"*, *"robust"*)
- ❌ **No overly long headings or descriptions** (Headings must be $\le$ 4 words; subtitles $\le$ 12 words)
- ✅ **All styles deferred to global semantic tokens** (`bg-card`, `text-foreground`, `border-border`)
- ✅ **Must have verbatim quote in Section 1**
- ✅ **Concise, human-crafted microcopy (`ui-copywriting`):** Action-first verbs on buttons, 2-sentence empty states
