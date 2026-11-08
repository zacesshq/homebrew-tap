# Homebrew formula for Zacess Scenes 1.0.0, for Formula/zacess-scenes.rb in the zacesshq/homebrew-tap
# repository. Each SHA256_ placeholder is the sum from the matching .sha256 file attached to the
# v1.0.0 release; packaging/fill-checksums.sh fills them in. The next release changes the version
# in the four URLs and the four sums.
class ZacessScenes < Formula
  desc "Calm animated scenes for the terminal in the ten Zacess accessible themes"
  homepage "https://zacess.com"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zacesshq/scenes/releases/download/v1.0.0/zacess-scenes-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "6e0de1599f813b994df9fc75fa2f7cbde5c0f1c410f76b22899568441e75d834"
    end
    on_intel do
      url "https://github.com/zacesshq/scenes/releases/download/v1.0.0/zacess-scenes-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "00840a194d132a98c8c3bcea071438c9fba376d2b24f8065a6bae338f767ac20"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zacesshq/scenes/releases/download/v1.0.0/zacess-scenes-v1.0.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bf87ef102677026ae2c55bb514b8f2d927ff5b90d6fab526e03a512f20ec605d"
    end
    on_intel do
      url "https://github.com/zacesshq/scenes/releases/download/v1.0.0/zacess-scenes-v1.0.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b97424c384a11397bbcc81e01842bde354ea6086cc48510e510678b3dcc1172f"
    end
  end

  def install
    bin.install "zacess-scenes"
    doc.install "README.md", "CHANGELOG.md", "ACCESSIBILITY.md", "NOTICE.md"
  end

  test do
    assert_match "zacess-scenes #{version}", shell_output("#{bin}/zacess-scenes --version")
    system bin/"zacess-scenes", "sea", "--headless", "--frames", "1", "--size", "20x8", "--theme", "deep-dark"
  end
end
