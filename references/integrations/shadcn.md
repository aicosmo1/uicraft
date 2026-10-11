# `uicraft` Integration: official `shadcn/ui` Skill & Presets

`uicraft` delegates all visual design tokens, base color palettes, and accessible component primitives to **shadcn/ui**. This allows `uicraft` to focus 100% on **UX Architecture, Information Hierarchy, and Structural Component Trees**.

---

## 1. Skill Reference & Installation

- **Skill Name:** `shadcn`
- **Source Repository:** `https://github.com/shadcn-ui/ui.git` (`@shadcn`)
- **Local Location:** `.agents/skills/shadcn/`
- **Installation Command:**
  ```bash
  npx skills add shadcn-ui/ui@shadcn -y
  ```

---

## 2. The Power of shadcn Presets

Modern shadcn projects use **presets** (created visually via [ui.shadcn.com/create](https://ui.shadcn.com/create) or referenced by preset codes such as `buFywKm`, `b6FmyD0j2`, or default `b0`).

A preset packages the entire visual design system:
1. **Style**: `base-nova`, `base-maia`, `new-york`, or `default`
2. **Base Color**: `taupe`, `neutral`, `zinc`, `slate`, `stone`, `gray`
3. **Theme & CSS Variables**: OKLCH / HSL variables in `globals.css`
4. **Typography**: Body font and heading font families
5. **Icon Library**: `lucide`, etc.
6. **Geometry**: Base border radius (`--radius`)

### Project Initialization with a Preset
```bash
pnpm dlx shadcn@latest init --preset <code|url> --template next -y
```

### Applying or Switching Presets on Existing Projects
```bash
pnpm dlx shadcn@latest apply <preset-code-or-url> --yes
```

---

## 3. How `uicraft` Reads Client Project Configuration

When `uicraft` runs on a client codebase, it **never invents new colors or fonts**. Instead, it inspects:

### 1. `components.json`
- `style`: The active component architecture (e.g. `base-maia`).
- `tailwind.baseColor`: Base hue family.
- `tailwind.css`: Path to the stylesheet (typically `app/globals.css`).
- `iconLibrary`: Icon pack (e.g. `lucide`).
- `aliases.ui`: Directory where shadcn primitives live (e.g. `@/components/ui`).

### 2. `globals.css`
- Base border radius: `--radius`.
- Semantic surface tokens: `--background`, `--foreground`, `--card`, `--muted`, `--border`.
- Primary & Accent tokens: `--primary`, `--accent`, `--secondary`.
- Status tokens: `--destructive`, etc.

`uicraft` exports a concise summary to `public/preset-info.md` and `public/philosophy.md` for coding agents to reference.

---

## 4. Primitive Guidelines (Radix UI vs Base UI)

Depending on the preset style chosen, shadcn generates components using either Radix UI or Base UI (`@base-ui/react`):
- **Radix UI (`new-york`, `default`):** Utilizes `asChild` composition.
- **Base UI (`base-maia`, `base-nova`):** Does not use `asChild`. Trigger components directly accept trigger contents and styles, and anchor tags are styled using `className={cn(buttonVariants(...))}` directly.

`uicraft` code generation in Step 5 checks `package.json` for `@base-ui/react` and generates syntax perfectly matched to the installed primitive engine.
