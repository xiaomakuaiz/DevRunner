# DevRunner

Base container images for Chaitin MonkeyCode developer workflows.

## Base image (bookworm)
- Dockerfile: `docker/base/bookworm/Dockerfile` (Debian bookworm-slim, git/curl/build-essential/python3, en_US.UTF-8 locale, default user root).
- Build locally: `STACK=base VERSION=bookworm ./scripts/build.sh`
- Push to GHCR: `PUSH=true REGISTRY=ghcr.io/chaitin/monkeycode-runner STACK=base VERSION=bookworm ./scripts/build.sh` (needs `docker login ghcr.io`).
- Run: `docker run --rm -it ghcr.io/chaitin/monkeycode-runner/base:bookworm bash`

## Layout
- `docker/base/bookworm/Dockerfile` – base image definition.
- `scripts/build.sh` – helper to build/push images (env-driven: STACK, VERSION, REGISTRY, PUSH).
- `docs/` – docs placeholder for future stacks and CI notes.

## CI/CD
- Workflow: `.github/workflows/ci.yaml`
  - PR: build only (no push).
  - Push to `main` branch: login to GHCR with `GITHUB_TOKEN` and push tags from metadata (`bookworm`, `latest`, branch/tag-derived). Non-main branches/tags build only. Target registry: `ghcr.io/chaitin/monkeycode-runner`.
- No personal access token needed; workflow requests `packages: write` and `contents: read` via `GITHUB_TOKEN` (ensure Actions permissions allow this if repository is restricted).
