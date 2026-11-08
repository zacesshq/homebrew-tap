# Homebrew formula for Zacess Games 1.1.0, for Formula/zacess-games.rb in the zacesshq/homebrew-tap
# repository. Each SHA256_ placeholder is the sum from the matching .sha256 file attached to the
# v1.1.0 release; packaging/fill-checksums.sh fills them in. The next release changes the version
# in the four URLs and the four sums.
class ZacessGames < Formula
  desc "Fourteen original games for the terminal in the Zacess high contrast themes"
  homepage "https://zacess.com"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/zacesshq/games/releases/download/v1.1.0/zacess-games-v1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "79caba70673bc1102ca9a334af063f761244faf9d0c0d210ebd839b50cf38f5c"
    end
    on_intel do
      url "https://github.com/zacesshq/games/releases/download/v1.1.0/zacess-games-v1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "e6fa672ddca2226b75b6afbe01d1aa3fc1dab83ef5dc7f1f478773c779bdd26a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zacesshq/games/releases/download/v1.1.0/zacess-games-v1.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "eef6ed5813d434cd4f3b55ba1b8658307e666832127c7aac83974d0708e6429f"
    end
    on_intel do
      url "https://github.com/zacesshq/games/releases/download/v1.1.0/zacess-games-v1.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "713891cf90123fc2a0de825bbaf11264f28c730b7f355746f946923539f28596"
    end
  end

  def install
    bin.install "zacess-games"
    doc.install "README.md", "CHANGELOG.md", "ACCESSIBILITY.md", "NOTICE.md"
  end

  test do
    assert_match "zacess-games #{version}", shell_output("#{bin}/zacess-games --version")
    ENV["ZACESS_GAMES_STATE"] = testpath/"state"
    system bin/"zacess-games", "--headless", "trace", "--keys", "right,enter",
           "--size", "60x20", "--theme", "deep-dark"
  end
end
