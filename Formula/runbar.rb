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

  depends_on xcode: ["16.0", :build]
  depends_on "gh"
  depends_on macos: :sonoma

  def install
    system "make", "app"
    prefix.install "dist/RunBar.app"
    (bin/"runbar").write <<~SH
      #!/bin/bash
      exec /usr/bin/open "#{opt_prefix}/RunBar.app"
    SH
    chmod "+x", bin/"runbar"
  end

  def caveats
    <<~EOS
      RunBar.app is in the keg. Launch it with:
        open #{opt_prefix}/RunBar.app
      or:
        runbar

      Launch at login needs an Applications path:
        mkdir -p ~/Applications
        ln -sf #{opt_prefix}/RunBar.app ~/Applications/RunBar.app
    EOS
  end

  test do
    assert_path_exists prefix/"RunBar.app/Contents/MacOS/RunBar"
    assert_path_exists bin/"runbar"
  end
end
