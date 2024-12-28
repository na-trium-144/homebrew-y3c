class Rang < Formula
  desc "Minimal, Header only Modern c++ library for terminal goodies"
  homepage "https://agauniyal.github.io/rang/"
  url "https://github.com/agauniyal/rang/archive/refs/tags/v3.2.tar.gz"
  sha256 "8b42d9c33a6529a6c283a4f4c73c26326561ccc67fbb3e6a3225edd688b39973"
  license "Unlicense"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-y3c/releases/download/rang-3.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d457b6eb06945ee9d2f181b37a6bab6e3d84b7961123168ebfc7bbc13020701c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "61ade10a8642085f281410d0fca08b0f5826be3b4b3861f5d98e4b3653a3fb9a"
    sha256 cellar: :any_skip_relocation, ventura:       "78b51a95ed556311c0adf63cd6ecdf69480d1d58a2751fb02adb46a215dd986f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "938a56a9dc5a9115de5ea4532c65921afb647fe1e88d75f67a8088ee23bbba51"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "true"
  end
end
