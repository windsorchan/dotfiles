# New Feature Workflow with Linear & Git Subtree

This guide walks through creating a new feature using Linear for issue tracking and Git subtrees for isolated development.

## 1. Design & Create Linear Issue

First, describe your feature to Claude Code and create a Linear issue:

```
# Describe the feature
"I want to add a real-time order book aggregator that combines data from multiple exchanges"

# Create Linear issue
"Create a Linear issue for this feature in the ENG team"
```

Claude Code will use `mcp__linear-server__create_issue` to create the issue and return the issue ID (e.g., ENG-123).

## 2. Set Up Git Subtree

Copy the branch name from Linear and create your subtree:

```
# Get the branch name format from Linear
"Copy the git branch name for issue ENG-123"

# Create subtree and feature branch
"Create a git subtree at features/eng-123-order-book-aggregator and switch to branch eng-123-order-book-aggregator"
```

Claude Code will execute:
```bash
git subtree add --prefix=features/eng-123-order-book-aggregator HEAD --squash
git checkout -b eng-123-order-book-aggregator
```

## 3. Initial Feature Structure

Set up the basic skeleton code in your subtree if necessary (some feature only touch existing files):

```
"Create the initial structure for the order book aggregator in features/eng-123-order-book-aggregator with:
- src/aggregator.rs for the main logic
- src/exchanges/ directory for exchange-specific implementations  
- tests/aggregator_tests.rs for unit tests
- Cargo.toml for the module"
```

## 4. Update Linear Issue

Track progress by updating the Linear issue:

```
"Update Linear issue ENG-123 to 'In Progress' status and assign it to me"
```

## Example Full Command

Here's a complete example for creating a new feature:

```
"I want to create a new feature for a WebSocket message parser that handles Hyperliquid market data.
1. Create a Linear issue in the ENG team with high priority
2. Set up a git subtree for this feature using the Linear branch name
3. Create the initial module structure with src/parser.rs and tests/
4. Update the Linear issue to In Progress"
```

## Tips

- Always create the Linear issue first to get the issue ID
- Use descriptive names that match the Linear issue title
- Keep each feature in its own subtree for isolation
- Link commits to Linear by including the issue ID
