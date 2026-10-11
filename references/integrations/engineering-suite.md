# `uicraft` Integration: Addy Osmani Engineering Suite (`agent-skills`)

`uicraft` integrates with **`addyosmani/agent-skills`**, a collection of production-grade engineering workflows maintained by Google Chrome engineering lead Addy Osmani.

---

## 1. Skill Reference & Installation

- **Skill Name:** `agent-skills`
- **Source Repository:** `https://github.com/addyosmani/agent-skills.git`
- **Local Location:** `.agents/skills/agent-skills/`
- **Installation Command:**
  ```bash
  npx skills add addyosmani/agent-skills -y
  ```

---

## 2. Workflows Leveraged by `uicraft`

The Addy Osmani Engineering Suite provides core disciplines that reinforce `uicraft`'s architectural rigor:

### 1. Spec-Driven Engineering (`/spec`)
- **Principle:** Never touch production code without an explicit specification.
- **In `uicraft`:** This is the bedrock of `uicraft`. PRDs (`requirements.md`) are deconstructed into atomic, traceable component markdown specifications before any code is generated in Step 5.

### 2. Atomic Planning (`/plan`)
- **Principle:** Break multi-step features into small, testable, and reviewable tasks.
- **In `uicraft`:** The hierarchical UI tree naturally divides work into isolated units:
  - Layout Shell -> Feature Pages -> Reusable Cards -> Interactive Modals/Drawers.
  - Each `.md` spec file is small, focused, and self-contained (under 50 lines).

### 3. Rigorous Code Health & Review (`/review`)
- **Principle:** Eliminate anti-patterns, leaky abstractions, memory leaks, and excessive re-renders.
- **In `uicraft`:** During Step 5, coding agents apply the `/review` checklist:
  - Clean TypeScript interfaces.
  - Proper React Hook dependencies.
  - Elimination of magic numbers or hardcoded inline styles.
  - Proper cleanup in `useEffect` and timer listeners (e.g. `clearTimeout` on copied feedback).

---

## 3. Integration Checklist for Coding Agents

When executing Step 5 under `uicraft`, the agent verifies:
- [ ] Every component has an unambiguous TypeScript interface exported.
- [ ] No component exceeds 250 lines of code; complex views decompose into leaf files.
- [ ] State mutations are predictable and isolated.
- [ ] Memory leaks from intervals or observers are cleanly disposed.
