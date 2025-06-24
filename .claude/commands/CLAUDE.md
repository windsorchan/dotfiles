# DegenTrader - High Performance Trading System

## Project Overview

This is a **high-frequency, low-latency trading application** built in Rust for maximum performance. Every microsecond matters in this system.

## Core Design Philosophy

### Performance Above All
- **Performance > Maintainability**: We explicitly choose complexity if it improves speed
- **Performance > Memory Usage**: Prefer faster algorithms even if they use more RAM
- **Performance > Code Clarity**: Optimize hot paths aggressively, even if it makes code harder to read
- **Latency-Critical**: Target sub-microsecond response times for order processing

### Trade-offs We Accept
- **Complexity**: Willing to implement complex optimizations for speed gains
- **Maintenance burden**: Accept harder-to-maintain code in hot paths
- **Memory usage**: Use more memory if it reduces latency
- **Code duplication**: Duplicate code if specialization improves performance

## Architecture Principles

### Data Representation
- **Fixed-point arithmetic**: Use FixedPoint (i64 with 9 decimal places) over floating point
- **Binary formats**: Minimize serialization overhead with binary representations
- **Zero-copy where possible**: Avoid unnecessary data copying in hot paths
- **Columnar storage**: Use Parquet/Arrow for efficient market data storage
- **Cache-aligned unions**: 64-byte events fit in single cache line
- **Inline data storage**: Union types avoid heap allocations for event data

### Networking & I/O
- **Minimize syscalls**: Batch operations to reduce kernel transitions
- **Hardware timestamps**: Capture network timestamps at hardware level when possible
- **Pre-allocated buffers**: Minimize memory allocations in hot paths
- **CPU affinity**: Pin network interrupts and application to specific cores

### Market Data Processing
- **Tick-level precision**: Maintain exact decimal precision for prices
- **Fast path optimization**: Separate fast paths for common operations vs. full precision

### FixedPoint Type
- Uses i64 internally for native CPU operations
- 9 decimal places (1e9 multiplier) for price precision
- Multiple operation variants: full precision vs fast approximations

## Context for AI Assistants

When working on this codebase:
- **Speed is the primary concern** - suggest the fastest approach even if more complex
- **Deterministic execution** - all inputs must flow through single ordered queue
- **Question floating point** - prefer fixed-point or integer arithmetic
- **Consider CPU instruction count** - fewer instructions is always better
- **Assume Intel x86-64 in Tokyo** - optimize for specific CPU architecture and region
- **Micro-optimize hot paths** - even small improvements matter in critical sections
- **Sacrifice abstractions for speed** - inline code and specialize where it helps performance
- **No context switching overhead** - we have dedicated cores with SMT disabled
- **Colocation advantages** - assume minimal network latency to exchanges
- **Event sourcing mindset** - every input must be recordable and replayable
- **Hot path discipline** - minimize time in critical sections, defer all non-essential work

## Zero-Copy and Direct Buffer Writing

### Eliminate format! and String Allocations
- **Never use format!** in hot paths - it causes heap allocations and string formatting overhead
- **Write directly to output buffers** using byte literals and copy operations
- **Use stack buffers** for temporary message construction (e.g., `[u8; 128]`)
- **Avoid intermediate strings** - build messages byte-by-byte in target buffer

### Example: WebSocket Message Construction
```rust
// WRONG - heap allocation in hot path
let msg = format!(r#"{{"method":"subscribe","coin":"{}"}}"#, symbol);
ws_client.send_data(out_buffer, Opcode::TextFrame, msg.as_bytes());

// RIGHT - zero allocation with stack buffer
let mut buf = [0u8; 128];
let mut pos = 0;
buf[pos..pos+22].copy_from_slice(b"{\"method\":\"subscribe\",");
pos += 22;
buf[pos..pos+symbol.len()].copy_from_slice(symbol.as_bytes());
pos += symbol.len();
buf[pos..pos+2].copy_from_slice(b"\"}");
pos += 2;
ws_client.send_data(out_buffer, Opcode::TextFrame, &buf[..pos]);
```

### Buffer Writing Principles
- **Stack allocate** small temporary buffers (≤1KB)
- **Reuse buffers** across calls when safe to do so
