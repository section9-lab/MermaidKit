# pi-work fork

Fork of [clintecker/MermaidKit](https://github.com/clintecker/MermaidKit) at
tag `v1.0.0` (upstream commit `74f62a6081d2c2dce66293b8abff8febb23e4d7e`).

## Divergence from upstream

`Package.swift` only — the source tree is untouched:

- `swift-tools-version: 6.2` → `6.0` (pi-work's CI pins Xcode 26.0).
- `platforms: macOS 14 / iOS 17` → `macOS 13 / iOS 16` (pi-work supports
  macOS 13 Ventura; the package uses no unguarded macOS 14 API).
- Dropped the `LinuxRaster` package trait and the Silica/Cairo dependency
  graph. Apple platforms never linked those symbols — every reference sits
  inside `#if canImport(SilicaCairo)`.

## Verification

- `swift build` with a macOS 13 deployment target: clean.
- `swift test`: 169 layout tests + 7 render tests pass.
- Rendered the four Mermaid blocks from the pi-work super-agent session:
  parse + render OK, 0.9–23.7 ms cold, cache hits ~0.02 ms.

## Upgrading

1. `git fetch upstream && git checkout -b piwork/next upstream/vX.Y.Z`
2. Re-apply the three `Package.swift` edits above.
3. `swift build && swift test`; re-render `Fixtures/diagrams/`.
4. Push the branch and bump the `revision:` in pi-work's `project.yml`.
