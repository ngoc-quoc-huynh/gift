# Development Guidelines

## Repository

- `gift_box/` receives and unlocks gifts. `gift_keys/` manages keys and presents
  them using NFC Host Card Emulation (HCE). Android is the supported platform.
- For NFC or HCE changes, inspect both apps for affected behavior.
- `gift_keys` responds to APDUs; `gift_box` reads and validates the responses.
  Change protocol or APDU handling in both apps together. Keep key material and
  APDU payloads out of logs.

## Approach

- Prefer simple, readable solutions and small, focused changes.
- Use modern, established practices compatible with the project's
  supported SDKs and platforms.
- Follow existing conventions unless `docs/architecture.md` defines the target.
- Reuse existing code and tools when appropriate. Avoid speculative
  features, unrelated refactoring, and premature optimization.
- Validate untrusted input, including NFC tag data and APDUs.
  Keep secrets and sensitive real data out of code, logs, and Git.

## Architecture

- Before you create or move Dart code, read `docs/architecture.md`.
- Keep responsibilities clear, public APIs small, and implementation
  details private.
- Separate platform-specific integration from shared logic through
  clear interfaces.
- Beyond the layers and building blocks in `docs/architecture.md`, introduce
  abstractions only when a concrete requirement justifies them.

## Workflow

- Inspect relevant code, instructions, and tests before making changes.
- Follow CONTRIBUTING.md when preparing requested contributions.
- Complete clear requests without unnecessary questions. Ask when
  ambiguity materially affects scope, safety, or design.
- Keep reviews and diagnoses read-only unless changes are requested.
- Preserve unrelated user changes and keep dependency changes within
  the requested scope.
- Do not create temporary files or directories. Use inline commands
  (pipes, heredocs, `python -c`) instead. If a temporary file or directory
  is unavoidable, ask first and remove it when finished.
- Ask before adding dependencies, making incompatible public API or
  cross-package/platform contract changes, raising SDK or platform
  minimums, or taking destructive actions unless explicitly authorized.
- Commit, push, publish, or deploy only when explicitly requested.

## Verification

- Add or update focused tests when behavior changes.
- Use the project's configured formatting, linting, and testing tools.
  Run checks appropriate to the change, including dependent packages
  when shared contracts change, and review the final diff.
- Never weaken or bypass tests, analyzer rules, or CI checks to pass.
- Report Android device verification separately from unit tests.
  State when relevant hardware behavior remains unverified.
- Report changes, checks actually performed, failures, and anything
  unverified. Keep the report concise and practical.
