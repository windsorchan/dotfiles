# Build & Fix Command

Build any project and systematically fix compilation, type, and lint errors to ensure a clean, working codebase.

## Instructions

Follow these steps to build the project and resolve all errors:

1. **Project Discovery**
   - Identify the project type and build system (npm, cargo, make, gradle, etc.)
   - Locate build configuration files (package.json, Cargo.toml, Makefile, etc.)
   - Check for existing build scripts in README or documentation

2. **Initial Build Attempt**
   - Run the appropriate build command for the project
   - Capture all error messages and warnings
   - Categorize errors by type (syntax, type, import, dependency, etc.)

3. **Dependency Resolution**
   - Install missing dependencies if needed
   - Update lock files when necessary
   - Resolve version conflicts between packages
   - Verify all required tools are available

4. **Error Analysis & Fixing**
   - Start with blocking errors that prevent compilation
   - Fix type errors and interface mismatches
   - Resolve import and module resolution issues
   - Address deprecated API usage
   - Fix syntax errors and formatting issues

5. **Incremental Building**
   - After each fix, run the build again
   - Track progress and remaining error count
   - Use watch mode if available for faster iteration
   - Clear build cache if encountering persistent issues

6. **Linting & Formatting**
   - Run the project's linter (eslint, ruff, clippy, etc.)
   - Apply automatic fixes where available
   - Manually fix remaining lint warnings
   - Ensure code follows project style guidelines

7. **Type Checking**
   - Run type checker separately if available (tsc, mypy, etc.)
   - Fix strict mode violations
   - Resolve any type assertion issues
   - Ensure proper type exports for libraries

8. **Verification**
   - Perform a clean build from scratch
   - Run all quality checks (lint, type check, format)
   - Execute test suite to ensure nothing broke
   - Document any workarounds or temporary fixes

Always fix errors systematically, starting with the most fundamental issues first. Use file paths and line numbers when reporting fixes.