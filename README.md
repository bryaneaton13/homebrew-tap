# bryaneaton13/tap

Homebrew tap. Formulae compile on your Mac.

```bash
brew install bryaneaton13/tap/runbar
```

## Formulae

| Formula | What |
| --- | --- |
| [`runbar`](Formula/runbar.rb) | GitHub Actions menu bar app. Compiles from [gh-actions-runbar](https://github.com/bryaneaton13/gh-actions-runbar). |

`runbar` depends on `gh`. Sign in with `gh auth login` after install.

Launch at login wants the app under Applications:

```bash
mkdir -p ~/Applications
ln -sf "$(brew --prefix runbar)/RunBar.app" ~/Applications/RunBar.app
```

Do not bottle unsigned macOS apps. A later cask would need Developer ID notarization.

## Add a formula

1. Put a Ruby file in `Formula/`.
2. `brew audit --strict --online Formula/<name>.rb`
3. `brew install --build-from-source Formula/<name>.rb`
4. Commit and push `main`.

`brew install bryaneaton13/tap/<name>` picks this repo up as `homebrew-tap`.
