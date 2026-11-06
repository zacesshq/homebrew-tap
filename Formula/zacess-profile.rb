# Homebrew formula for Zacess Profile 0.2.2, for Formula/zacess-profile.rb in the zacesshq/homebrew-tap
# repository. Each SHA256_ placeholder is the sum from the matching .sha256 file attached to the
# v0.2.2 release; packaging/fill-checksums.sh fills them in. The next release changes the version
# in the four URLs and the four sums.
class ZacessProfile < Formula
  desc "One accessibility profile for every app, checked for contrast and colour vision"
  homepage "https://zacess.com"
  version "0.2.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/zacesshq/profile/releases/download/v0.2.2/zacess-profile-v0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "79f8515a3a4318acf493b3ce9b6ec1b251eada893a574129ddac45dc29f31a0b"
    end
    on_intel do
      url "https://github.com/zacesshq/profile/releases/download/v0.2.2/zacess-profile-v0.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "8e6ab33eeee10d538b7e454232acb963ef20f27b1a46a07d07f750aaee239694"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zacesshq/profile/releases/download/v0.2.2/zacess-profile-v0.2.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fa93d038731bd99c368c850fa7003266f99646dae027e7fbbb1273f9f11d050e"
    end
    on_intel do
      url "https://github.com/zacesshq/profile/releases/download/v0.2.2/zacess-profile-v0.2.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "987506c778bd8ea70e3da7e69b21b6ad521d595ba3a6ce339428614f590d7beb"
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
