# Homebrew formula for Zacess Profile 1.0.0, for Formula/zacess-profile.rb in the zacesshq/homebrew-tap
# repository. Each SHA256_ placeholder is the sum from the matching .sha256 file attached to the
# v1.0.0 release; packaging/fill-checksums.sh fills them in. The next release changes the version
# in the four URLs and the four sums.
class ZacessProfile < Formula
  desc "One accessibility profile for every app, checked for contrast and colour vision"
  homepage "https://zacess.com"
  version "1.0.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/zacesshq/profile/releases/download/v1.0.0/zacess-profile-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "436c95da9f0b0812dea02a6db514b12d523b919dbf91b133afbf9a14f2a13ef4"
    end
    on_intel do
      url "https://github.com/zacesshq/profile/releases/download/v1.0.0/zacess-profile-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "ad179b9416ee49f57aea2fac746fd035a2c5dfc567d336404e862f0ecfd45a67"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zacesshq/profile/releases/download/v1.0.0/zacess-profile-v1.0.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d3d9dd8560ba1c3f64e1108188b4a47478291626857d5c367d2b69310692a1a3"
    end
    on_intel do
      url "https://github.com/zacesshq/profile/releases/download/v1.0.0/zacess-profile-v1.0.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "23a9748e49c58483fa99b9dc7d7d105694a11cd4fb0bb09d9b6f5e583e49ed89"
    end
  end

  def install
    bin.install "zprf"
    pkgshare.install "profiles", "spec"
    doc.install "README.md", "CHANGELOG.md", "ACCESSIBILITY.md", "ROADMAP.md", "NOTICE"
  end

  def caveats
    <<~EOS
      The ten starter profiles are in:
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
