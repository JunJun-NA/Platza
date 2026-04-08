---
name: figma-implement-design
description: Translates Figma designs into production-ready Flutter code with 1:1 visual fidelity. Use when implementing UI code from Figma files, when user mentions "implement design", "generate code", provides Figma URLs, or asks to build components matching Figma specs.
disable-model-invocation: false
---

# Implement Design

Structured workflow for translating Figma designs into production-ready Flutter code with pixel-perfect accuracy.

## Skill Boundaries

- Use this skill when the deliverable is **code** in the Flutter project.
- If the user asks to create/edit nodes inside Figma itself, switch to figma-use.
- If the user asks to build a full-page screen in Figma from code, switch to figma-generate-design.

## Prerequisites

- Figma MCP server must be connected
- User must provide a Figma URL: `https://figma.com/design/:fileKey/:fileName?node-id=1-2`

## Required Workflow

**Follow these steps in order. Do not skip steps.**

### Step 1: Get Node ID

Parse from Figma URL:
- **File key:** segment after `/design/`
- **Node ID:** value of `node-id` query parameter

### Step 2: Fetch Design Context

```
get_design_context(fileKey=":fileKey", nodeId="1-2")
```

If truncated, use `get_metadata` first, then fetch specific child nodes.

### Step 3: Capture Visual Reference

```
get_screenshot(fileKey=":fileKey", nodeId="1-2")
```

Keep accessible throughout implementation as source of truth.

### Step 4: Download Required Assets

- Use localhost sources from Figma MCP directly
- DO NOT import new icon packages
- DO NOT create placeholders if a localhost source is provided

### Step 5: Translate to Flutter Conventions

**Key principles for this project:**
- Treat Figma MCP output (React + Tailwind) as design spec, NOT final code
- Translate to Flutter widgets following the project's clean architecture
- Reuse existing widgets from `platza/lib/presentation/widgets/`
- Use the project's theme system (`platza/lib/core/theme/`)
- Use AppColors, AppTypography, AppSpacing tokens consistently
- Respect existing Riverpod state management and go_router patterns
- Place new widgets in appropriate directories under `presentation/`

### Step 6: Achieve 1:1 Visual Parity

- Match Figma design exactly using Flutter widgets
- Use design tokens from the theme system, avoid hardcoded values
- Follow WCAG requirements for accessibility

### Step 7: Validate Against Figma

Validation checklist:
- [ ] Layout matches (spacing, alignment, sizing)
- [ ] Typography matches (font, size, weight, line height)
- [ ] Colors match exactly
- [ ] Interactive states work as designed
- [ ] Assets render correctly

## Implementation Rules

- Place UI components in `platza/lib/presentation/widgets/` or feature-specific directories
- Always check for existing widgets before creating new ones
- Map Figma design tokens to `AppColors`, `AppTypography`, `AppSpacing`
- Use freezed for new data models if needed
- Run `dart run build_runner build --delete-conflicting-outputs` after code generation changes
- Run `flutter analyze` to verify no issues

$ARGUMENTS
