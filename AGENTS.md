# loglm Repository Notes

## Scope
This file describes repository-specific conventions for developing `loglm`.

## Logging (when working via loglm)
- Raw logs are stored under `./logs/`.
- Default raw filename pattern:
  - `logs/loglm-<agent>-log-YYYYMMDD-HHMMSS-pid<PID>.txt`
- Legacy daily mode:
  - `logs/loglm-<agent>-log-YYYYMMDD.txt`
- Decode raw logs before review:
  - `loglm-decode <raw-log-file>`
- Decoded output is written as `*.decoded.txt` in the same directory.

## Local Validation Commands
- Shell syntax checks:
  - `bash -n loglm loglm-decode setup/*.sh scripts/regression.sh`
- Regression checks:
  - `bash scripts/regression.sh`
- Optional E2E checks:
  - `bash scripts/regression.sh --e2e --repo <owner/repo> --agent <codex|claude|gemini|all>`

## Escalation-First Rule
- If a required command fails due to permissions/sandbox restrictions, request escalated execution first.
- Do not switch to alternative implementation paths before trying the same command with user approval.
- Use alternatives only after escalation is rejected or after escalated execution still fails.

<!-- loglm:begin policy -->
# loglm Execution Policy (managed)
- If a required command fails due to permissions/sandbox restrictions, request escalated execution first.
- Do not switch to alternative implementation paths before trying the same command with approval.
- Use alternatives only after escalation is rejected or after escalated execution still fails.
<!-- loglm:end policy -->

<!-- loglm:begin platform -->
# loglm Platform Notes (managed)
- `loglm` is a wrapper command that launches coding agents and records terminal logs for later review.
- This session may be running through `loglm`; if so, raw logs are being recorded under `./logs/`.
- Runtime: native macOS.
- Prefer macOS-native commands and paths.
- For preview/open, use `open` (example: `open -a Skim paper.pdf`).
- loglm repository: `https://github.com/ks91/loglm`
- Raw logs are stored under `./logs/` (from launch directory).
- Raw log filename pattern: `logs/loglm-<agent>-log-YYYYMMDD-HHMMSS-pid<PID>.txt`
- If `--daily-log` is used: `logs/loglm-<agent>-log-YYYYMMDD.txt`
- Decode raw logs with: `loglm-decode logs/*`
- Build a chronological overview with: `loglm-timeline logs/*.decoded.txt`
- Prefer `*.decoded.txt` or `*.redacted.txt` over raw logs when asked to inspect past work.
<!-- loglm:end platform -->
