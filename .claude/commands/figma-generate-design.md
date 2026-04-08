---
name: figma-generate-design
description: Build or update full-page screens in Figma using published design systems. Use when the task involves translating an application page or multi-section layout into Figma.
disable-model-invocation: false
---

# Build / Update Screens from Design System

Use this skill to create or update full-page screens in Figma by **reusing the published design system** — components, variables, and styles — rather than drawing primitives with hardcoded values.

**MANDATORY**: You MUST also load figma-use before any `use_figma` call.

**Always pass `skillNames: "figma-generate-design"` when calling `use_figma` as part of this skill.**

## Skill Boundaries

- Use when deliverable is a **Figma screen** (new or updated) composed of design system component instances.
- For generating **code from Figma**, switch to figma-implement-design.

## Required Workflow

### Step 1: Understand the Screen

1. Read relevant Flutter source files to understand the page structure
2. Identify major sections (Header, Content, Footer, etc.)
3. List UI components involved (buttons, inputs, cards, etc.)

### Step 2: Discover Design System

#### 2a: Components
Inspect existing screens first. Only fall back to `search_design_system` when no existing screens to reference.

#### 2b: Variables (colors, spacing, radii)
Use `search_design_system` with `includeVariables: true`. Search broadly: "gray", "background", "space", "radius", etc.

**WARNING:** `figma.variables.getLocalVariableCollectionsAsync()` returns only LOCAL variables. Always also run `search_design_system` for library variables.

#### 2c: Styles (text styles, effect styles)
Use `search_design_system` with `includeStyles: true`.

### Step 3: Create Page Wrapper Frame

Create wrapper in its own `use_figma` call. Position away from existing content.

```js
let maxX = 0;
for (const child of figma.currentPage.children) {
  maxX = Math.max(maxX, child.x + child.width);
}
const wrapper = figma.createFrame();
wrapper.name = "Screen Name";
wrapper.layoutMode = "VERTICAL";
wrapper.resize(1440, 100);
wrapper.layoutSizingHorizontal = "FIXED";
wrapper.layoutSizingVertical = "HUG";
wrapper.x = maxX + 200;
return { success: true, wrapperId: wrapper.id };
```

### Step 4: Build Each Section Inside Wrapper

One section per `use_figma` call. Import components by key, bind variables, override text with `setProperties()`.

**Never hardcode hex colors or pixel spacing** when design system variables exist.

After each section, validate with `get_screenshot`.

### Step 5: Validate Full Screen

Screenshot individual sections AND the full page. Check for:
- Cropped/clipped text
- Overlapping content
- Placeholder text still showing
- Wrong component variants

### Step 6: Updating Existing Screen

1. Use `get_metadata` to inspect structure
2. Locate existing nodes by ID or name
3. Swap/update components as needed
4. Validate with `get_screenshot` after each modification

## Best Practices

- **Always search before building** — the design system likely has what you need
- **Prefer design system tokens** over hardcoded values
- **Prefer component instances** over manual builds
- **Work section by section** — never build more than one section per `use_figma` call
- **Return node IDs from every call**
- **Validate visually after each section**

$ARGUMENTS
