class Runbar < Formula
  desc "GitHub Actions in the macOS menu bar"
  homepage "https://bryaneaton13.github.io/gh-actions-runbar/"
  url "https://github.com/bryaneaton13/gh-actions-runbar/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "14d70fab62213bae7b54286c081c7d863e780a48d15290c00155241621c14193"
  license "MIT"
  head "https://github.com/bryaneaton13/gh-actions-runbar.git", branch: "main"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "gh"
  depends_on macos: :sonoma

  def install
    # SwiftPM's sandbox-exec cannot nest inside Homebrew's build sandbox.
    # v0.2.0+ already passes --disable-sandbox in scripts/build-app.sh.
    system "make", "app"
    prefix.install "dist/RunBar.app"
    (bin/"runbar").write <<~SH
      #!/bin/bash
      APP="#{opt_prefix}/RunBar.app"
      LINK="${HOME}/Applications/RunBar.app"
      mkdir -p "${HOME}/Applications"
      if [[ -L "${LINK}" || ! -e "${LINK}" ]]; then
        ln -sfn "${APP}" "${LINK}"
      fi
      exec /usr/bin/open "${APP}"
    SH
    chmod "+x", bin/"runbar"
  end

  def caveats
    <<~EOS
      Run `runbar` once. That opens the app and links ~/Applications/RunBar.app
      so Spotlight, Raycast, and launch at login can see it.
    EOS
  end

  test do
    assert_path_exists prefix/"RunBar.app/Contents/MacOS/RunBar"
    assert_path_exists bin/"runbar"
  end
end
