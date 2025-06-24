# Review Changes Command

Quick code review for unstaged changes before committing.

## Instructions

1. **Get Change Summary**
   - Run `git status` to see modified files
   - Run `git diff` to review all unstaged changes
   - Note the scope and purpose of changes

2. **Quick Quality Check**
   - Look for debugging code (console.log, print statements)
   - Check for hardcoded values that should be configurable
   - Verify no sensitive data (API keys, passwords)
   - Ensure consistent code style with surrounding code

3. **Common Issues**
   - Unused imports or variables
   - Missing error handling
   - Incomplete TODOs or FIXMEs
   - Broken imports or references

4. **Test Impact**
   - Identify which tests might be affected
   - Check if new code needs tests
   - Verify no existing tests were broken

5. **Final Review**
   - Ensure changes match intended purpose
   - Check for unintended modifications
   - Verify no accidental file additions

Focus on catching issues before they enter version control. Don't attribute to any author.
