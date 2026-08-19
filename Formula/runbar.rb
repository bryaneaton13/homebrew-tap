class Runbar < Formula
  desc "GitHub Actions in the macOS menu bar"
  homepage "https://bryaneaton13.github.io/gh-actions-runbar/"
  url "https://github.com/bryaneaton13/gh-actions-runbar/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "24669a515c5910c4925f82ce9985c7c8525c83f5948cc0710c65905d8021b263"
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
    # v0.1.0 tarball lacks the flag; HEAD already has it.
    inreplace "scripts/build-app.sh",
              "swift build -c release",
              "swift build --disable-sandbox -c release",
              audit_result: false
    system "make", "app"
    prefix.install "dist/RunBar.app"
    (bin/"runbar").write <<~SH
      #!/bin/bash
      exec /usr/bin/open "#{opt_prefix}/RunBar.app"
    SH
    chmod "+x", bin/"runbar"
  end

  def post_install
    apps = Pathname("#{Dir.home}/Applications")
    apps.mkpath
    dest = apps/"RunBar.app"
    if dest.exist? && !dest.symlink?
      opoo "#{dest} already exists; leaving it in place."
      return
    end
    dest.unlink if dest.symlink?
    ln_sf opt_prefix/"RunBar.app", dest
  end

  def caveats
    <<~EOS
      RunBar.app is linked at ~/Applications/RunBar.app for Spotlight, Raycast,
      and launch at login. Launch with `runbar` or open that app.
    EOS
  end

  test do
    assert_path_exists prefix/"RunBar.app/Contents/MacOS/RunBar"
    assert_path_exists bin/"runbar"
  end
end
