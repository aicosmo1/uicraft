# `uicraft` Integration: React View Transitions (`vercel-react-view-transitions`)

`uicraft` integrates with **`vercel-react-view-transitions`** to enable native, fluid browser view transitions across pages and complex layout states without jarring white flashes or abrupt UI jumps.

---

## 1. Skill Reference & Installation

- **Skill Name:** `vercel-react-view-transitions`
- **Source Repository:** `https://github.com/vercel-labs/agent-skills.git` (`@vercel-react-view-transitions`)
- **Local Location:** `.agents/skills/vercel-react-view-transitions/`
- **Installation Command:**
  ```bash
  npx skills add vercel-labs/agent-skills@vercel-react-view-transitions -y
  ```

---

## 2. When to Apply View Transitions in `uicraft`

View transitions provide high perceived performance in modern web applications:

### 1. Route Navigation
- When navigating between core dashboard views (e.g. `/` -> `/api-keys` -> `/webhooks`), shared layout shells (sidebar, top header) remain stable while the central viewport content smoothly cross-fades.

### 2. State & Mode Morphing
- When toggling between environments (e.g. "Production" <-> "Staging"), the environment indicator badge and underlying telemetry numbers morph smoothly rather than re-rendering abruptly.

### 3. Drawer & Modal Expansions
- When clicking a row in a data table to open an inspect sheet, the row visually connects to the expanding slide-over drawer using browser transition roots.

---

## 3. Implementation Blueprint in Step 5

For Next.js App Router projects, the coding agent follows the transition wrapper pattern:
- Wrap links with `<Link>` or transition boundaries.
- Utilize CSS `@view-transition` properties defined in `globals.css` with zero inline styling.
- Ensure fallback behavior remains fully functional on browsers lacking View Transition API support.
