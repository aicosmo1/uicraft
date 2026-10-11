# `uicraft` Integration: UX Microcopy & Anti-AI Tone (`ui-copywriting`)

This reference defines how `uicraft` integrates with the `ui-copywriting` partner skill to ensure all static text, headings, descriptions, button labels, and empty states are punchy, scannable, human-crafted, and free of AI fluff.

---

## 1. Division of Responsibility

| Domain | Responsible Skill | Enforcement |
| :--- | :--- | :--- |
| **Theme, Colors & Radii** | `shadcn/ui` & `globals.css` | `--primary`, `--background`, `--radius`, `--card` semantic tokens. |
| **UX Architecture & Tree** | `uicraft` | Product requirements, route mapping, component hierarchy, unstyled markdown specs. |
| **Spatial Alignment & Geometry** | `better-layout` | Shared edges, 2× negative space ratio, optical baselines, control clearance. |
| **Content, Headings & Microcopy** | **`ui-copywriting`** | Concise headings ($\le$ 4 words), short subtitles ($\le$ 12 words), active verbs, zero AI filler words. |

---

## 2. Rules Enforced During Step 3 (Tree Deconstruction)

When generating unstyled component specs in `public/ui-tree/**/*.md`:
1. **Hard Word Count Limits on Structural Elements:**
   - **Titles & Headings:** Maximum 2–4 words (*"Keyword Guardian"*, *"Budget Pacing"*).
   - **Subtitles & Descriptions:** Exactly 1 sentence, $\le$ 12 words (*"Review search terms draining budget before negative keyword sync."*).
   - **Action Triggers:** 2–3 words starting with an active imperative verb (*"Sync Keywords"*, *"Export CSV"*).
2. **Zero AI Fluff in Component Specs:**
   - Never write phrases like *"A comprehensive view empowering users to seamlessly manage..."* in `ui-tree/` markdown files.
   - Write pragmatic, direct functional descriptions: *"Displays live ad spend, target burn rate, and pacing variance."*
3. **Two-Sentence Empty State Specifications:**
   - Sentence 1: What is absent (*"No active alerts."*).
   - Sentence 2: What action to take next (*"Connect a channel to begin monitoring."*).

---

## 3. Rules Enforced During Step 5 (Code Generation)

When the coding agent implements components in `components/` and `app/`:
1. **Purge Synthetic AI Preamble:**
   - Never render phrases like *"Welcome to your overview"* or *"Here you can easily explore..."*.
   - Render the data group or active noun directly.
2. **Front-Loaded Column Headers:**
   - Table headers must be 1–2 words maximum (*"Spend"*, *"ROAS"*, *"Status"*, *"Actions"*).
   - Place currency symbols (`$`) and units (`%`, `x`) in data cells, not in headers.
3. **Action-First Button Labels:**
   - Primary and secondary buttons must never say *"Submit"*, *"Proceed"*, or *"Click here"*.
   - Use direct verb phrases: *"Create Rule"*, *"Download Report"*, *"Archive Term"*.
4. **Scannable Status Badges:**
   - Keep status pills to 1–2 words: *"Live"*, *"Paused"*, *"Critical"*, *"In Sync"*, *"+14% vs Target"*.
