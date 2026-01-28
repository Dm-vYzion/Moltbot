# Tools

## shell-run
description: >
  Run shell commands in the StoryForge repo for building, testing, and simple diagnostics.
  Use this for npm scripts, linting, and basic file operations.

permissions:
  - Allow read/write inside the StoryForge repo path.
  - Do not run destructive commands (rm -rf, dropping databases) without explicit confirmation.

common_commands:
  - cd frontend && npm start
  - cd frontend && npm test
  - cd frontend && npm run build
  - cd backend && python server.py
  - cd backend && python seed_data.py

usage_notes: >
  Prefer read-only inspection and small edits first.
  Ask for confirmation before making big or slow changes (e.g., dependency upgrades, mass refactors).
