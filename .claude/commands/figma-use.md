---
name: figma-use
description: "**MANDATORY prerequisite** — you MUST invoke this skill BEFORE every `use_figma` tool call. NEVER call `use_figma` directly without loading this skill first. Skipping it causes common, hard-to-debug failures. Trigger whenever the user wants to perform a write action or a unique read action that requires JavaScript execution in the Figma file context — e.g. create/edit/delete nodes, set up variables or tokens, build components and variants, modify auto-layout or fills, bind variables to properties, or inspect file structure programmatically."
disable-model-invocation: false
---

# use_figma — Figma Plugin API Skill

Use the `use_figma` tool to execute JavaScript in Figma files via the Plugin API. All detailed reference docs live in `references/`.

**Always pass `skillNames: "figma-use"` when calling `use_figma`.** This is a logging parameter used to track skill usage — it does not affect execution.

**If the task involves building or updating a full page, screen, or multi-section layout in Figma from code**, also load figma-generate-design. It provides the workflow for discovering design system components via `search_design_system`, importing them, and assembling screens incrementally. Both skills work together: this one for the API rules, that one for the screen-building workflow.

## 1. Critical Rules

1.  **Use `return` to send data back.** The return value is JSON-serialized automatically (objects, arrays, strings, numbers). Do NOT call `figma.closePlugin()` or wrap code in an async IIFE — this is handled for you.
2.  **Write plain JavaScript with top-level `await` and `return`.** Code is automatically wrapped in an async context. Do NOT wrap in `(async () => { ... })()`.
3.  `figma.notify()` **throws "not implemented"** — never use it
3a. `getPluginData()` / `setPluginData()` are **not supported** in `use_figma` — do not use them. Use `getSharedPluginData()` / `setSharedPluginData()` instead (these ARE supported), or track node IDs by returning them and passing them to subsequent calls.
4.  `console.log()` is NOT returned — use `return` for output
5.  **Work incrementally in small steps.** Break large operations into multiple `use_figma` calls. Validate after each step. This is the single most important practice for avoiding bugs.
6.  Colors are **0–1 range** (not 0–255): `{r: 1, g: 0, b: 0}` = red
7.  Fills/strokes are **read-only arrays** — clone, modify, reassign
8.  Font **MUST** be loaded before any text operation: `await figma.loadFontAsync({family, style})`. Use `await figma.listAvailableFontsAsync()` to discover all available fonts and their exact style strings — if a `loadFontAsync` call fails, call `listAvailableFontsAsync()` to find the correct style name or pick a fallback.
9.  **Pages load incrementally** — use `await figma.setCurrentPageAsync(page)` to switch pages and load their content. The sync setter `figma.currentPage = page` does **NOT** work and will throw.
10. `setBoundVariableForPaint` returns a **NEW** paint — must capture and reassign
11. `createVariable` accepts collection **object or ID string** (object preferred)
12. **`layoutSizingHorizontal/Vertical = 'FILL'` MUST be set AFTER `parent.appendChild(child)`** — setting before append throws. Same applies to `'HUG'` on non-auto-layout nodes.
13. **Position new top-level nodes away from (0,0).** Scan `figma.currentPage.children` to find a clear position.
14. **On `use_figma` error, STOP. Do NOT immediately retry.** Failed scripts are **atomic** — if a script errors, no changes are made to the file. Read the error message carefully, fix the script, then retry.
15. **MUST `return` ALL created/mutated node IDs.**
16. **Always set `variable.scopes` explicitly when creating variables.** The default `ALL_SCOPES` pollutes every property picker.
17. **`await` every Promise.** Never leave a Promise unawaited.

## 2. Page Rules (Critical)

**Page context resets between `use_figma` calls** — `figma.currentPage` starts on the first page each time.

Use `await figma.setCurrentPageAsync(page)` to switch pages. The sync setter does NOT work.

## 3. `return` Is Your Output Channel

The agent sees **ONLY** the value you `return`. Everything else is invisible.

- **Returning IDs (CRITICAL)**: Every script that creates or mutates canvas nodes **MUST** return all affected node IDs — e.g. `return { createdNodeIds: [...], mutatedNodeIds: [...] }`.
- `console.log()` output is **never** returned to the agent
- Always return actionable data (IDs, counts, status)

## 4. Incremental Workflow

1. **Inspect first.** Run a read-only `use_figma` to discover what already exists.
2. **Do one thing per call.**
3. **Return IDs from every call.**
4. **Validate after each step.** Use `get_metadata` for structure, `get_screenshot` for visuals.
5. **Fix before moving on.**

## 5. Error Recovery

1. **STOP** on error — do not retry immediately.
2. **Read the error message carefully.**
3. If unclear, call `get_metadata` or `get_screenshot` to inspect current file state.
4. **Fix the script** based on the error message.
5. **Retry** the corrected script.

| Error message | Likely cause | Fix |
|---|---|---|
| `"not implemented"` | Used `figma.notify()` | Remove it — use `return` |
| `"node must be an auto-layout frame..."` | Set `FILL`/`HUG` before appending | Move `appendChild` before sizing |
| `"Setting figma.currentPage is not supported"` | Used sync page setter | Use `await figma.setCurrentPageAsync(page)` |
| Property value out of range | Color > 1 | Divide by 255 |

## 6. Pre-Flight Checklist

- [ ] Code uses `return` (NOT `figma.closePlugin()`)
- [ ] NOT wrapped in async IIFE
- [ ] NO `figma.notify()`
- [ ] All colors use 0–1 range
- [ ] Fills/strokes reassigned as new arrays
- [ ] Page switches use `await figma.setCurrentPageAsync(page)`
- [ ] `layoutSizingX = 'FILL'` set AFTER `appendChild`
- [ ] `loadFontAsync()` called BEFORE text changes
- [ ] ALL created/mutated node IDs in `return` value
- [ ] Every async call is `await`ed
