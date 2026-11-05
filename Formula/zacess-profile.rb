# Homebrew formula for Zacess Profile 0.2.1, for Formula/zacess-profile.rb in the zacesshq/homebrew-tap
# repository. Each SHA256_ placeholder is the sum from the matching .sha256 file attached to the
# v0.2.1 release; packaging/fill-checksums.sh fills them in. The next release changes the version
# in the four URLs and the four sums.
class ZacessProfile < Formula
  desc "One accessibility profile for every app, checked for contrast and colour vision"
  homepage "https://zacess.com"
  version "0.2.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/zacesshq/profile/releases/download/v0.2.1/zacess-profile-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "bafb95bc4db1c062146396bb7ee0288b19cd17d7b4e395e7298bff793347f93d"
    end
    on_intel do
      url "https://github.com/zacesshq/profile/releases/download/v0.2.1/zacess-profile-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "77b0af8a25db5c9cf6ff203e034e67f1b8c238c677d848fd6d8f0d938ed71df9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zacesshq/profile/releases/download/v0.2.1/zacess-profile-v0.2.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0990326177f72f69f9750c7a21299156afa82c89d0c5b550e61c1589ac933423"
    end
    on_intel do
      url "https://github.com/zacesshq/profile/releases/download/v0.2.1/zacess-profile-v0.2.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b88a7dd5f4c9123cf45640ac1565735d83c6359addf0b6fe571f1e03b5842853"
    end
  end

  def install
    bin.install "zprf"
    pkgshare.install "profiles", "spec"
    doc.install "README.md", "CHANGELOG.md", "ACCESSIBILITY.md", "ROADMAP.md", "NOTICE"
  end

  def caveats
    <<~EOS
      The eight starter profiles are in:
        #{opt_pkgshare}/profiles
    EOS
  end

  test do
    assert_match "zprf #{version}", shell_output("#{bin}/zprf --version")
    assert_match "pass", shell_output("#{bin}/zprf check #{pkgshare}/profiles/zacess-dark.toml")
    system bin/"zprf", "render", pkgshare/"profiles/zacess-dark.toml", "--target", "all", "--out", testpath/"out"
    assert_path_exists testpath/"out/kitty/zacess-dark.conf"
  end
end
