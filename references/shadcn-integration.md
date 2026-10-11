# `uicraft`: Official shadcn/ui Skill & Preset Integration

`uicraft` delegates all visual design tokens, color palettes, and component primitive behaviors to **shadcn/ui**. This allows `uicraft` to focus 100% of its intelligence on **UX Architecture, Information Hierarchy, and Structural Component Trees**.

---

## 1. Version-Controlled Skill Integration

`uicraft` works hand-in-hand with the official `shadcn` skill published by the shadcn team:

- **Source Repository:** `https://github.com/shadcn-ui/ui.git` (`@shadcn`)
- **Local Location:** `.agents/skills/shadcn/`
- **Lockfile Management:** Tracked in consumer workspace's `skills-lock.json` under `skills.shadcn`:
  ```json
  "shadcn": {
    "source": "shadcn-ui/ui",
    "sourceType": "github",
    "skillPath": "skills/shadcn/SKILL.md",
    "computedHash": "..."
  }
  ```

### Updating the Underlying shadcn Skill
To pull the latest official component guidelines, registry patterns, and CLI capabilities from GitHub at any time, run:
```bash
npx skills update shadcn -y
```

---

## 2. The Power of shadcn Presets

Modern shadcn projects use **presets** (created visually via [ui.shadcn.com/create](https://ui.shadcn.com/create) or referenced by preset codes such as `buFywKm` or default `b0`).

A preset packages the entire visual design system:
1. **Style**: `base-nova`, `new-york`, or `default`
2. **Base Color**: `neutral`, `zinc`, `slate`, `stone`, `gray`
3. **Theme & CSS Variables**: OKLCH / HSL variables in `globals.css`
4. **Typography**: Body font and heading font families
5. **Icon Library**: `lucide`, etc.
6. **Geometry**: Base border radius (`--radius`)

### Project Initialization with a Preset
When scaffolding a project, users run:
```bash
pnpm dlx shadcn@latest init --preset <code|url> --template next -y
# Example default:
pnpm dlx shadcn@latest init --preset b0 --template next -y
```

### Applying or Switching Presets on Existing Projects
To update or change an entire theme preset later:
```bash
pnpm dlx shadcn@latest apply <preset-code-or-url> --yes
```

---

## 3. How `uicraft` Reads Client Project Configuration

When `uicraft` is invoked on a client codebase, it **never invents new colors or fonts**. Instead, it inspects two files:

### 1. `components.json`
`uicraft` extracts:
- `style`: The active component architecture (e.g., `base-nova`).
- `tailwind.baseColor`: Neutral, zinc, slate, etc.
- `tailwind.css`: Path to the stylesheet (typically `app/globals.css`).
- `iconLibrary`: Icon pack (e.g. `lucide`).
- `aliases.ui`: Directory where shadcn primitives live (e.g. `@/components/ui`).

### 2. `globals.css`
`uicraft` extracts:
- Base border radius: `--radius`.
- Semantic surface tokens: `--background`, `--foreground`, `--card`, `--muted`, `--border`.
- Primary & Accent tokens: `--primary`, `--accent`, `--secondary`.
- Status tokens: `--destructive`, etc.

`uicraft` exports a concise summary to `public/preset-info.md` and `public/philosophy.md` for coding agents to reference.

---

## 4. The Separation of Concerns

| Responsibility | Handled By | Artifacts / Tools |
| :--- | :--- | :--- |
| **Visual Tokens, Colors & Geometry** | `shadcn/ui` Preset | `components.json`, `globals.css`, `pnpm dlx shadcn@latest apply` |
| **Component Primitives** | Official `shadcn` Skill | `pnpm dlx shadcn@latest add <component>`, `@/components/ui/*` |
| **UX Architecture & Structure** | **`uicraft` Framework** | `public/ui-tree/**/*.md`, `public/preset-info.md`, `requirements.md` |
| **Implementation** | Coding Agent | Traverses `ui-tree`, adds needed shadcn primitives, builds `src/` |

By respecting this boundary, `uicraft` guarantees that generated applications look human-designed, accessible, and clean from day one.
