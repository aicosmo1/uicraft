# `uicraft` Integration: Spatial Layout, Alignment & Shared Edges (`better-layout`)

This reference defines how `uicraft` integrates with the `better-layout` partner skill to ensure composite UI layouts assemble with pixel-perfect alignment and robust spatial hierarchy.

---

## 1. Division of Responsibility

| Domain | Responsible Skill | Enforcement |
| :--- | :--- | :--- |
| **Theme, Colors & Radii** | `shadcn/ui` & `globals.css` | `--primary`, `--background`, `--radius`, `--card` semantic tokens. |
| **UX Architecture & Tree** | `uicraft` | Product requirements, route mapping, component hierarchy, unstyled markdown specs. |
| **Spatial Alignment & Geometry** | **`better-layout`** | Shared edges, 2× negative space ratio, optical baselines, control clearance. |

---

## 2. Rules Enforced During Step 3 (Tree Deconstruction)

When generating unstyled component specs in `public/ui-tree/`:
1. **Specify Spatial Relationships, Not CSS Hex/Colors:**
   - Define whether elements share an edge or are inset.
   - Prescribe negative-space groupings (e.g. "Action buttons grouped with 12px clearance, separated from content by 24px margin").
2. **Never leak style properties:** Never write background colors, hex codes, or arbitrary borders in `ui-tree/`.

---

## 3. Rules Enforced During Step 5 (Code Generation)

When the coding agent writes composite components:
1. **Optical Baseline Alignment:**
   - Icons paired with text must use `inline-flex items-center gap-1.5` with explicit sizes (`size-3.5` or `size-4`) so icons never sit 2px above or below the text baseline.
2. **Equal-Height Card Tracks:**
   - Any multi-column card row must use `grid auto-rows-fr` or flex `h-full flex-col justify-between` to ensure sibling cards share identical bottom edges.
3. **Flex Blowout Safeguard:**
   - Any flex element containing truncated text must declare `min-w-0` to prevent overflowing its container bounds.
4. **Control Clearance:**
   - Adjacent borderless icon buttons must have `gap-4` to `gap-5` (minimum 20px) to prevent overlapping tap targets.
