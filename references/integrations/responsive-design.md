# `uicraft` Integration: Responsive Design & Container Queries (`responsive-design`)

This reference defines how `uicraft` integrates with the `responsive-design` partner skill to ensure application layouts adapt seamlessly across all viewport sizes and container constraints.

---

## 1. The Dynamic Shell Problem

In modern dashboard shells, the available main content width is **not equal to the browser viewport**:
- When the shadcn sidebar is expanded: Available content width = `100vw - 16rem` (`256px`).
- When the sidebar is collapsed: Available content width = `100vw - 3rem` (`48px`).

Relying solely on viewport media queries (`@media (min-width: 1024px)`) causes layout collision when the sidebar is open on laptops (1024px–1280px).

---

## 2. Rules Enforced During Step 3 (Tree Deconstruction)

In `public/ui-tree/`:
1. **Define Progressive Disclosure Hierarchy:**
   - In Section 4 (State & Interactions), explicitly define how non-critical labels collapse when horizontal space is constrained.
2. **Specify Container Containment:**
   - Note which composite sections require container-aware adaptation independent of browser window width.

---

## 3. Rules Enforced During Step 5 (Code Generation)

1. **Container Query Declaration:**
   - Declare `@container` on composite parent wrappers (card grids, toolbars, headers).
   - Use container query classes (e.g. `@sm:flex-row`, `@lg:grid-cols-4`) for internal component layout.
2. **Intrinsic Grid Sizing:**
   - Use `grid-template-columns: repeat(auto-fit, minmax(280px, 1fr))` instead of rigid viewport columns.
3. **Progressive Disclosure Implementation:**
   - Use responsive text spans: `hidden md:inline` for secondary label words.
   - Truncate long strings with progressive max-width limits (e.g., `max-w-[120px] md:max-w-[200px] xl:max-w-none`).
