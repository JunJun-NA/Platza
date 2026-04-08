---
name: figma-code-connect
description: Creates and maintains Figma Code Connect template files (.figma.js) that map Figma components to code snippets. Use when the user mentions Code Connect, Figma component mapping, or asks to create/update .figma.js files.
disable-model-invocation: false
---

# Figma Code Connect Template Guide

Create parserless Code Connect template files (`.figma.js`) that map Figma components to code snippets.

## Prerequisites

- Organization or Enterprise Figma plan
- Components must be published to a team library
- Figma MCP server connected
- Figma URL with node-id

## 6-Step Workflow

### Step 1: Parse the Figma URL

Extract `fileKey` and `nodeId` from the URL:
- `https://figma.com/design/:fileKey/:fileName?node-id=1-2`

### Step 2: Discover Unmapped Components

Use `get_code_connect_suggestions` to find components that need mapping.

### Step 3: Fetch Component Properties

Use `get_context_for_code_connect` to get the component's properties:
- TEXT properties → `instance.getString('Name')`
- BOOLEAN properties → `instance.getBoolean('Name', { true: ..., false: ... })`
- VARIANT properties → `instance.getEnum('Name', { 'FigmaVal': 'codeVal' })`
- INSTANCE_SWAP properties → `instance.getInstanceSwap('Name')`

### Step 4: Identify the Matching Code Component

Search the Flutter codebase for the matching widget in `platza/lib/presentation/widgets/`.

### Step 5: Create the .figma.js Template

```js
const figma = require('figma')
const instance = figma.selectedInstance

const label = instance.getString('Label')
const variant = instance.getEnum('Variant', { 'Primary': 'primary' })

export default {
  example: figma.tsx`<Component ... />`,
  imports: ['import { Component } from "..."'],
  id: 'component-name',
  metadata: { nestable: true }
}
```

**Critical Rule:** Never concatenate template results as strings; interpolate inside tagged templates.

### Step 6: Validate

Check `hasCodeConnect()` before executing templates and verify `type === 'INSTANCE'` when using find methods.

$ARGUMENTS
