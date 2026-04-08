---
name: figma-create-design-system-rules
description: Generates custom design system rules for the Platza codebase. Use when user says "create design system rules", "generate rules for my project", or wants to establish project-specific conventions for Figma-to-code workflows.
disable-model-invocation: false
---

# Create Design System Rules

Generate custom design system rules tailored to the Platza Flutter project.

## What Are Design System Rules?

Project-level instructions that encode the "unwritten knowledge" of the codebase:
- Which widgets and components to use
- Where component files should be located
- How to handle design tokens and styling
- Project-specific architectural patterns

## Required Workflow

### Step 1: Run the Tool

Call `create_design_system_rules` with:
- `clientLanguages`: "dart"
- `clientFrameworks`: "flutter"

### Step 2: Analyze the Codebase

**Component Organization:**
- UI widgets: `platza/lib/presentation/widgets/`
- Screen widgets: `platza/lib/presentation/<feature>/`
- Theme: `platza/lib/core/theme/`

**Styling Approach:**
- AppColors, AppTypography, AppSpacing, AppShadows
- Material Design theme system

**Architecture:**
- Clean Architecture (domain, infrastructure, application, presentation)
- Riverpod for state management
- freezed for entities
- Drift for local DB

### Step 3: Generate Rules

Include rules for:
- Component discovery and reuse
- Design token mapping (Figma → AppColors, AppTypography, AppSpacing)
- Styling approach (Flutter theme system)
- Figma MCP integration workflow
- Asset handling

### Step 4: Save Rules

Save generated rules to `CLAUDE.md` in the project root, appending a Figma Design System section.

### Step 5: Validate and Iterate

1. Test with a simple component implementation
2. Verify rules are followed correctly
3. Refine as needed

$ARGUMENTS
