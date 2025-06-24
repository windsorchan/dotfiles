# Implement Feature Workflow with Linear & Git

This guide covers the implementation phase after setting up your feature with `new-feature.md`.

## 1. Start Implementation

Navigate to your feature subtree and begin work:

```
"In features/eng-123-order-book-aggregator, implement the OrderBookAggregator struct with:
- Methods to connect to multiple exchanges
- Merge order books maintaining price-time priority  
- Use FixedPoint for all price calculations
- Zero-allocation message parsing"
```

## 2. Regular Progress Updates

As you complete parts of the feature, update Linear:

```
"Add a comment to Linear issue ENG-123 with the current progress:
- Implemented base aggregator structure
- Added Binance connector
- Working on order book merging algorithm"
```

## 3. Testing Implementation

Run tests within the subtree:

```
"In features/eng-123-order-book-aggregator, create comprehensive tests for:
- Order book merging with different price levels
- Handling missing data from exchanges
- Performance benchmarks for the aggregator"

# Run the tests
"Run cargo test in features/eng-123-order-book-aggregator"
```

## 4. Code Quality Checks

Before creating PR, ensure code quality:

```
"Run the following checks in features/eng-123-order-book-aggregator:
- cargo fmt
- cargo clippy
- cargo test
- Verify no heap allocations in hot paths"
```

## 5. Prepare for Pull Request

When feature is complete:

```
# Commit with Linear issue reference
"Commit all changes with message: 'Implement order book aggregator for ENG-123

- Add multi-exchange order book aggregation
- Zero-allocation parsing for market data  
- Comprehensive test coverage'
"

# Push branch
"Push the eng-123-order-book-aggregator branch to origin"

# Create PR
"Create a pull request for eng-123-order-book-aggregator with:
- Title: 'ENG-123: Add order book aggregator'
- Description including 'Fixes ENG-123'
- Summary of implementation approach
- Performance metrics from benchmarks"
```

## 6. Post-PR Updates

After PR is created:

```
"Update Linear issue ENG-123 with:
- Link to the PR (this happens automatically if setup correctly)
- Comment about readiness for review
- Any specific areas that need attention"
```

## Integration Example

If you need to integrate the subtree work back into main codebase:

```
"Integrate features/eng-123-order-book-aggregator into src/market_data/:
1. Move aggregator.rs to src/market_data/aggregator.rs
2. Update Cargo.toml dependencies
3. Add module to src/market_data/mod.rs
4. Update imports in affected files"
```

## Quick Commands Reference

```
# Check feature status
"Show me the current status of Linear issue ENG-123 and list any linked PRs"

# Update issue during implementation  
"Update ENG-123 with status 'In Review' and add comment about PR being ready"

# After merge
"Check if ENG-123 was automatically closed after PR merge"
```

## Workflow Automation Tips

1. **Auto-assign on branch creation**: Linear can auto-assign issues when you copy branch names
2. **Status automation**: Configure Linear to move issues through statuses based on PR state
3. **Review tracking**: Linear shows reviewer avatars on linked issues
4. **Branch rules**: Set different automations for main vs staging branches