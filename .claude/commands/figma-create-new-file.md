---
name: figma-create-new-file
description: Create a new Figma file in the user's drafts. Use when the user wants to start a new Figma design file or FigJam whiteboard.
disable-model-invocation: false
---

# Create a New Figma File

## Arguments

Optional: `[editorType] [fileName]`
- **editorType**: `design` (default) or `figjam`
- **fileName**: Name for the new file (defaults to "Untitled")

Examples:
- `/figma-create-new-file` — design file named "Untitled"
- `/figma-create-new-file figjam My Whiteboard` — FigJam file
- `/figma-create-new-file design Platza Design` — design file

## Workflow

### Step 1: Resolve the planKey

1. If user already provided a planKey, use it.
2. Otherwise, call `whoami` tool to get available plans.
   - Single plan: use its key automatically.
   - Multiple plans: ask user which team/org.

### Step 2: Call create_new_file

```json
{
  "planKey": "team:123456",
  "fileName": "My New Design",
  "editorType": "design"
}
```

### Step 3: Use the result

Returns `file_key` and `file_url`. Use `file_key` for subsequent `use_figma` calls.

**Note:** File is created in the user's drafts folder. Load figma-use skill before calling `use_figma`.

$ARGUMENTS
