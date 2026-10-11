# UI Tree Specification Guidelines

This document specifies the rules and structure for generating the hierarchical `ui-tree/` directory.

## 1. Directory Tree Hierarchy
The `ui-tree/` directory should mirror the client application's mental model and routing architecture:

```text
ui-tree/
├── layout/
│   ├── shell.md              # Application container, sidebar provider, main content area
│   ├── sidebar.md            # Primary navigation sidebar & items
│   └── header.md             # Top navigation, global actions, user status
├── [route-1]/                # Feature route (e.g., dashboard)
│   ├── page.md               # Layout composition of this view
│   ├── [child-component-1].md
│   └── [child-component-2].md
└── [route-2]/                # Secondary feature route (e.g., notifications)
    ├── page.md
    └── [child-component].md
```

## 2. File Organization Rules
1. **One file per distinct UI unit**: If a component has state, triggers actions, or renders independently (e.g., a table, a metrics card grid, an incident drawer), give it its own `.md` file.
2. **Page Composition (`page.md`)**: Every route must contain a `page.md`. This file explains how the subcomponents are arranged (e.g., 2-column layout, responsive grid, drawer trigger) without specifying styling.
3. **No Stylistic Descriptions**:
   - ❌ WRONG: "A red button with 8px rounded corners and white bold text"
   - ✅ RIGHT: "A destructive action button labeled 'Acknowledge Incident', disabled if incident is already acknowledged"

## 3. Component Deconstruction Process
1. Read the user requirement line.
2. Identify the core user intent (view data, filter items, navigate, take action).
3. Select appropriate semantic primitives (e.g., from `shadcn/ui`: `Table`, `Badge`, `Sheet`, `Card`, `Tooltip`).
4. Detail the interaction lifecycle:
   - Initial render state
   - User hover state (show tooltip, cursor change)
   - User focus state (keyboard navigation)
   - User active/trigger state (modal open, toast notification, route change)
   - Empty/error states (when zero records exist)
