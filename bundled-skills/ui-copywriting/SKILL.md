---
name: ui-copywriting
description: >-
  Guides concise, human-crafted UX writing, UI microcopy, and content hierarchy.
  Eliminates AI fluff, verbose descriptions, and corporate buzzwords. Enforces scannability,
  front-loaded phrasing, short active verbs, and strict word count limits across headings,
  cards, tables, tooltips, and empty states.
---

# `ui-copywriting`: Concise, Human-Crafted UX Microcopy & Content Architecture

## Overview

Software interfaces are scanned, not read. Users interact with dashboards, tools, and SaaS products to accomplish tasks—not to read marketing essays or AI-generated filler paragraphs.

When AI agents author UI specs or generate component code, they tend to default to **verbose, bloated corporate filler** (e.g., *"Comprehensive real-time orchestration engine empowering automated workflows across your enterprise"*). This makes products feel synthetic, cheap, and exhausting to scan.

The `ui-copywriting` skill establishes strict, professional UX writing standards that make user interfaces **punchy, scannable, human, and direct**.

---

## 1. The Core Philosophy of Product Copy

1. **Scannability Over Completeness:** Users glance at visual anchors (headings, bold metrics, button labels). Every extra word dilutes their attention.
2. **Front-Loaded Phrasing:** Put the most important information in the first 2–3 words. The eye scans in an F-pattern.
3. **Clarity Over Cleverness:** Direct, unambiguous verbs beat playful or vague terminology.
4. **Human Tone Over Machine Eloquence:** Write like a pragmatic senior engineer or product designer speaking directly to a colleague.

---

## 2. The AI Fluff Ban-List

Never use the following buzzwords or patterns in UI headings, card subtitles, descriptions, tooltips, or empty states:

| Banned AI Buzzwords | Why It Fails | What to Use Instead |
| :--- | :--- | :--- |
| *"seamlessly / seamless"* | Pure filler. Software either works or fails. | Drop completely. State the action directly. |
| *"empower / empowers"* | Corporate marketing jargon. | State what the user can do (*"Configure"*, *"Audit"*). |
| *"robust / holistic"* | Vague praise masquerading as information. | Specify exact capability (*"Automated"*, *"Real-time"*). |
| *"comprehensive overview"* | Redundant. An overview is already comprehensive. | *"Summary"*, *"Metrics"*, or just the topic name. |
| *"single pane of glass"* | Cliché buzzword. | *"Dashboard"*, *"Console"*, or *"Hub"*. |
| *"delve into / explore"* | Overly academic / promotional AI tell. | *"View"*, *"Inspect"*, *"Filter"*. |
| *"leverage / utilizing"* | Stilted and artificial. | *"Use"*, *"Apply"*, or drop entirely. |
| *"streamline / optimize"* | Overused filler when details are omitted. | Explain the specific action (*"Reduce spend"*, *"Automate sync"*). |
| *"in order to"* | Three words where zero or one will do. | *"To"* or omit entirely. |
| *"effortlessly manage"* | Promotional puffery. | *"Manage"*, *"Control"*, or the specific action. |

---

## 3. Strict Word Count & Structural Limits

Every piece of static or dynamic text in a UI belongs to a specific tier with strict length boundaries:

### Tier 1: Page Headings & Modal Titles ($\le$ 4 words)
- **Limit:** 2–4 words maximum.
- **Rules:** Title Case or Sentence Case (match product style). No trailing punctuation.
- ❌ *"Multi-Channel Ad Spend and Performance Overview"*
- ✅ *"Performance Overview"*
- ❌ *"Proactive Keyword Guardian and Conflict Detection"*
- ✅ *"Keyword Guardian"*

### Tier 2: Card Headers & Section Titles ($\le$ 3 words)
- **Limit:** 1–3 words.
- **Rules:** State the noun or metric group immediately.
- ❌ *"Summary of Platform Account Connections"*
- ✅ *"Connected Accounts"*
- ❌ *"Current Spend Pacing and Budget Burn Rate"*
- ✅ *"Budget Pacing"*

### Tier 3: Subtitles & Card Descriptions ($\le$ 12 words)
- **Limit:** Exactly 1 short sentence, 6–12 words.
- **Rules:** Explain the direct user value or the primary action. No introductory fluff (*"This card displays..."*).
- ❌ *"View an updated breakdown of your current spending pacing and track discrepancies across all channels in real time."* (19 words)
- ✅ *"Track actual spend against monthly targets across active channels."* (9 words)
- ❌ *"Manage and configure external data sources to keep your metrics synchronized."* (11 words, but passive)
- ✅ *"Connect advertising channels to sync campaign telemetry."* (7 words)

### Tier 4: Action Buttons & Triggers (2–3 words)
- **Limit:** 2–3 words.
- **Rules:** Always start with an active, imperative verb. Never write *"Click here"*, *"Submit"*, or *"Proceed"*.
- ❌ *"Click here to export the report"*
- ✅ *"Export CSV"*
- ❌ *"Execute Keyword Sync"*
- ✅ *"Sync Keywords"*
- ❌ *"Proceed with Rule Creation"*
- ✅ *"Create Rule"*

### Tier 5: Table Column Headers (1–2 words)
- **Limit:** 1–2 words.
- **Rules:** Concise nouns or abbreviations with units in header or cells.
- ❌ *"Total Spend in USD"*
- ✅ *"Spend"* (with `$` in cells)
- ❌ *"Calculated ROAS Multiple"*
- ✅ *"ROAS"*
- ❌ *"Current Operational Status"*
- ✅ *"Status"*

### Tier 6: Empty States (Exactly 2 Sentences)
- **Limit:** Exactly 2 sentences.
  - Sentence 1: What is absent (3–5 words).
  - Sentence 2: What to do next with clear instruction (5–10 words).
- ❌ *"There are currently no keyword recommendations to display at this time. When our system identifies opportunities or anomalies in your accounts, they will appear here automatically."*
- ✅ **Headline:** *"No keyword recommendations"*  
  **Subtext:** *"All search terms meet target ROAS thresholds. Check back after next sync."*

### Tier 7: Error Messages & Alerts (Direct Cause + Fix)
- **Limit:** 1–2 short sentences.
- **Rules:** State what failed, why, and how to recover. Never blame the user. Avoid cryptic codes alone.
- ❌ *"An unexpected error occurred while processing your request. Please try again later."*
- ✅ *"Google Ads sync failed. Reconnect your account in Settings to restore telemetry."*

---

## 4. UI Copy Transformation Gallery

Study these direct before-and-after transformations:

### Dashboard Telemetry Cards
- ❌ **Before (AI verbose):**  
  Title: *"Aggregate Paid Media Capital Deployment"*  
  Subtitle: *"Comprehensive overview of capital spent across all active ad networks"*  
  Value: *"$142,500.00"*  
  Badge: *"Spending is trending 12% higher compared to last month"*
- ✅ **After (Clean & punchy):**  
  Title: *"Total Spend"*  
  Subtitle: *"Across 4 connected ad networks."*  
  Value: *"$142,500"*  
  Badge: *"+12% vs last month"*

### Table Action Drawers / Sheets
- ❌ **Before (AI verbose):**  
  Title: *"Detailed Search Term Anomaly Investigation Panel"*  
  Description: *"Use this panel to thoroughly inspect all historical bid fluctuations and configure automated exclusion rules."*
- ✅ **After (Clean & punchy):**  
  Title: *"Search Term Details"*  
  Description: *"Review match queries and negative keyword exclusions."*

### Filter Bars & Toolbars
- ❌ **Before (AI verbose):**  
  Placeholder: *"Search through all campaign records by name or account ID..."*  
  Button: *"Apply Selected Filters to Grid"*
- ✅ **After (Clean & punchy):**  
  Placeholder: *"Search campaigns or accounts..."*  
  Button: *"Apply Filters"*

---

## 5. Microcopy Checklist for Coding Agents

When authoring `public/ui-tree/**/*.md` or generating React components in `components/`:

- [ ] **Word count audit:** Are all headings $\le$ 4 words? Are all card descriptions $\le$ 12 words?
- [ ] **Zero AI buzzwords:** Did you purge *"seamlessly"*, *"empowers"*, *"robust"*, *"comprehensive"*, and *"single pane of glass"*?
- [ ] **Action-first buttons:** Does every button start with an imperative verb (*"Connect"*, *"Export"*, *"Save"*, *"Pause"*)?
- [ ] **No conversational preamble:** Did you delete *"Here you can find..."*, *"This section is designed to..."*, *"Welcome to..."*?
- [ ] **Units in place:** Are currency symbols (`$`), percentages (`%`), and durations (`ms`, `s`) placed alongside numbers rather than spelled out in headers?
- [ ] **Two-sentence empty states:** Does the empty state tell the user what is missing and what single step to take next?
