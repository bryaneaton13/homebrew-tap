# bryaneaton13/tap

Homebrew tap. Formulae compile on your Mac.

```bash
brew install bryaneaton13/tap/runbar
```

Upgrade:

```bash
brew upgrade bryaneaton13/tap/runbar
```

## Formulae

| Formula | What |
| --- | --- |
| [`runbar`](Formula/runbar.rb) | GitHub Actions menu bar app. Compiles from [gh-actions-runbar](https://github.com/bryaneaton13/gh-actions-runbar). |

`runbar` needs macOS 14+ and Swift 6 (Xcode or Command Line Tools). It depends on `gh`. Sign in with `gh auth login` after install.

Homebrew cannot write `~/Applications` during install. `runbar` creates that link on first launch so Spotlight, Raycast, and launch at login see the app.

Do not bottle unsigned macOS apps. A later cask would need Developer ID notarization.

## Add a formula

1. Put a Ruby file in `Formula/`.
2. `brew tap bryaneaton13/tap /path/to/this/repo` if this checkout is not already tapped.
3. `brew audit --strict --online bryaneaton13/tap/<name>`
4. `brew install --build-from-source bryaneaton13/tap/<name>`
5. Commit and push `main`.

`brew install bryaneaton13/tap/<name>` picks this repo up as `homebrew-tap`.
