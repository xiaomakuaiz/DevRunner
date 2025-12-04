# Go developer image based on DevRunner base (Debian bookworm)
ARG BASE_IMAGE=ghcr.io/chaitin/monkeycode-runner/base:bookworm
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.title="DevRunner Go" \
      org.opencontainers.image.source="https://github.com/chaitin/DevRunner" \
      org.opencontainers.image.description="Golang toolbox image for DevRunner stacks"

ARG GO_VERSION=1.25.5
ARG GO_SHA256_AMD64=9e9b755d63b36acf30c12a9a3fc379243714c1c6d3dd72861da637f336ebb35b
ARG GO_SHA256_ARM64=b00b694903d126c588c378e72d3545549935d3982635ba3f7a964c9fa23fe3b9

ARG GOLANGCI_LINT_VERSION=v1.61.0
ARG GOLANGCI_LINT_SHA256_AMD64=77cb0af99379d9a21d5dc8c38364d060e864a01bd2f3e30b5e8cc550c3a54111
ARG GOLANGCI_LINT_SHA256_ARM64=af60ac05566d9351615cb31b4cc070185c25bf8cbd9b09c1873aa5ec6f3cc17e

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

ENV GOROOT=/usr/local/go \
    GOPATH=/go \
    GOCACHE=/go/cache \
    PATH=/usr/local/go/bin:/go/bin:${PATH}

RUN set -eux; \
    mkdir -p "${GOPATH}" "${GOCACHE}"; \
    GO_OS="${TARGETOS:-linux}"; \
    GO_ARCH="${TARGETARCH:-amd64}"; \
    case "${GO_ARCH}" in \
      amd64) GO_ARCHIVE="${GO_OS}-amd64"; GO_SHA256="${GO_SHA256_AMD64}"; GCL_ARCH="linux-amd64"; GCL_SHA256="${GOLANGCI_LINT_SHA256_AMD64}";; \
      arm64) GO_ARCHIVE="${GO_OS}-arm64"; GO_SHA256="${GO_SHA256_ARM64}"; GCL_ARCH="linux-arm64"; GCL_SHA256="${GOLANGCI_LINT_SHA256_ARM64}";; \
      "") GO_ARCHIVE="${GO_OS}-amd64"; GO_SHA256="${GO_SHA256_AMD64}"; GCL_ARCH="linux-amd64"; GCL_SHA256="${GOLANGCI_LINT_SHA256_AMD64}";; \
      *) echo "Unsupported GOARCH: ${GO_ARCH}${TARGETVARIANT:+ (${TARGETVARIANT})}" >&2; exit 1;; \
    esac; \
    curl -fsSL "https://go.dev/dl/go${GO_VERSION}.${GO_ARCHIVE}.tar.gz" -o /tmp/go.tar.gz; \
    echo "${GO_SHA256}  /tmp/go.tar.gz" | sha256sum -c -; \
    tar -C /usr/local -xzf /tmp/go.tar.gz; \
    rm /tmp/go.tar.gz; \
    go env; \
    go install honnef.co/go/tools/cmd/staticcheck@latest; \
    go install mvdan.cc/gofumpt@latest; \
    go install github.com/swaggo/swag/cmd/swag@latest; \
    GOLANGCI_LINT_VERSION_TRIMMED="${GOLANGCI_LINT_VERSION#v}"; \
    curl -fsSL "https://github.com/golangci/golangci-lint/releases/download/${GOLANGCI_LINT_VERSION}/golangci-lint-${GOLANGCI_LINT_VERSION_TRIMMED}-${GCL_ARCH}.tar.gz" -o /tmp/golangci-lint.tgz; \
    echo "${GCL_SHA256}  /tmp/golangci-lint.tgz" | sha256sum -c -; \
    tar -C /tmp -xzf /tmp/golangci-lint.tgz; \
    install -m 0755 "/tmp/golangci-lint-${GOLANGCI_LINT_VERSION_TRIMMED}-${GCL_ARCH}/golangci-lint" /usr/local/bin/golangci-lint; \
    rm -rf /tmp/golangci-lint*

WORKDIR /workspace
