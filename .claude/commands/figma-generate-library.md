---
name: figma-generate-library
description: Build or update a professional-grade design system in Figma from the Platza codebase. Use when the user wants to create variables/tokens, build component libraries, set up theming, or reconcile gaps between code and Figma.
disable-model-invocation: false
---

# Design System Builder

Build professional-grade design systems in Figma that match the Platza codebase.

**MANDATORY**: Load figma-use skill before every `use_figma` call.

**Always pass `skillNames: "figma-generate-library"` when calling `use_figma`.**

## The One Rule That Matters Most

**This is NEVER a one-shot task.** Requires 20–100+ `use_figma` calls across multiple phases with mandatory user checkpoints.

## Mandatory Workflow

```
Phase 0: DISCOVERY (no writes yet)
  0a. Analyze codebase → extract tokens, components, naming
  0b. Inspect Figma file → pages, variables, components, styles
  0c. Search subscribed libraries
  0d. Lock v1 scope with user
  USER CHECKPOINT: present plan, await approval

Phase 1: FOUNDATIONS (tokens first — before components)
  1a. Create variable collections and modes
  1b. Create primitive variables
  1c. Create semantic variables (aliased to primitives)
  1d. Set scopes on ALL variables
  1e. Set code syntax on ALL variables
  1f. Create effect styles and text styles
  USER CHECKPOINT: show variable summary

Phase 2: FILE STRUCTURE
  2a. Create page skeleton
  2b. Create foundations documentation pages
  USER CHECKPOINT: show page list + screenshot

Phase 3: COMPONENTS (one at a time, atoms before molecules)
  For EACH component:
    3a. Create dedicated page
    3b. Build base component with auto-layout + variable bindings
    3c. Create all variant combinations
    3d. Add component properties
    3e. Link properties to child nodes
    3f. Add page documentation
    3g. Validate: get_metadata + get_screenshot
    USER CHECKPOINT per component

Phase 4: INTEGRATION + QA
  4a. Code Connect mappings
  4b. Accessibility audit
  4c. Naming audit
  4d. Final review screenshots
  USER CHECKPOINT: complete sign-off
```

## Critical Rules

1. **Variables BEFORE components**
2. **Inspect before creating** — match existing conventions
3. **One page per component** (default)
4. **Bind visual properties to variables** — fills, strokes, padding, radius, gap
5. **Scopes on every variable** — NEVER leave as `ALL_SCOPES`
6. **Code syntax on every variable** — WEB uses `var()` wrapper
7. **Alias semantics to primitives** — never duplicate raw values
8. **INSTANCE_SWAP for icons** — never create a variant per icon
9. **Validate before proceeding** — `get_metadata` + `get_screenshot` after every create
10. **NEVER parallelize `use_figma` calls**
11. **Never hallucinate Node IDs** — always read from state ledger

## Token Architecture

| Complexity | Pattern |
|-----------|---------|
| < 50 tokens | Single collection, 2 modes (Light/Dark) |
| 50–200 tokens | Primitives (1 mode) + Color semantic (Light/Dark) + Spacing (1 mode) |
| 200+ tokens | Multiple semantic collections, 4–8 modes |

## State Management

Maintain a state ledger tracking all created entities:
```json
{
  "runId": "ds-build-001",
  "phase": "phase3",
  "entities": {
    "collections": { "primitives": "id:..." },
    "variables": { "color/bg/primary": "id:..." },
    "pages": { "Cover": "id:..." },
    "components": { "Button": "id:..." }
  }
}
```

Write state to `/tmp/dsb-state-{RUN_ID}.json` for persistence across context truncation.

$ARGUMENTS
