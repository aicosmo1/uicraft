# `uicraft` Integration: React Composition Patterns (`composition-patterns`)

`uicraft` integrates with **`composition-patterns`** (from Vercel Labs) to ensure generated React components avoid rigid prop-drilling and leverage modern compound component architectures.

---

## 1. Skill Reference & Installation

- **Skill Name:** `composition-patterns`
- **Source Repository:** `https://github.com/vercel-labs/agent-skills.git` (`@composition-patterns`)
- **Local Location:** `.agents/skills/composition-patterns/`
- **Installation Command:**
  ```bash
  npx skills add vercel-labs/agent-skills@composition-patterns -y
  ```

---

## 2. Core Architectural Patterns

### 1. Compound Component Architecture
Instead of "monster components" that take 30 arbitrary props (`<Card title="..." hasButton buttonIcon="..." />`), `uicraft` decomposes components into composable primitives:
```tsx
<Card>
  <CardHeader>
    <CardTitle>Recent Transactions</CardTitle>
    <CardDescription>Live telemetry stream</CardDescription>
  </CardHeader>
  <CardContent>
    <TransactionTable />
  </CardContent>
</Card>
```

### 2. State Encapsulation via Context
- Global domain state (such as active environment, search queries, active keys, or webhook endpoints) lives in dedicated providers (`context/gateway-context.tsx`).
- Individual leaf components consume only the specific hooks they need (`useGatewayContext()`), eliminating deep prop drilling.

### 3. Slot Patterns & Headless Decoupling
- Components accept `children` or render slots rather than hardcoding child markup.
- For triggers and overlays, components expose triggers (e.g. `<DialogTrigger>`, `<SheetTrigger>`) that wrap interactive elements seamlessly.

---

## 3. Application in `uicraft` Tree Specs

In `public/ui-tree/**/*.md`:
- `## 3. Structural Elements & Hierarchy` details the child slots and compound pieces.
- Specifications explicitly mandate compound decomposition rather than monolithic configurations.
