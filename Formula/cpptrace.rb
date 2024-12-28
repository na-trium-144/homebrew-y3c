class Cpptrace < Formula
  desc "Simple, portable, and self-contained stacktrace library for C++11 and newer"
  homepage "https://github.com/jeremy-rifkin/cpptrace"
  url "https://github.com/jeremy-rifkin/cpptrace/archive/refs/tags/v0.7.4.tar.gz"
  sha256 "1241790cace5d59ddf21ce5d046f71cd26448a3c8c15d123157498ba81e3543d"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-y3c/releases/download/cpptrace-0.7.4"
    sha256 cellar: :any,                 arm64_sequoia: "ebeb2cd9ad78aa676a019f359485d68ccc3ffc026cdf46607aa5d40242999f75"
    sha256 cellar: :any,                 arm64_sonoma:  "bedf6e410f1efce132a7c60e122c090bb69e4fc3df114af635ad82c9689ea953"
    sha256 cellar: :any,                 ventura:       "d68eff49ed449e5fa59d52099d182ae84dc77c921450fbf98d019fe33dbf39eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7dd02eb8713054b47f31c3cd03a22f0994063528bc809cf3efdc0eb98784f23c"
  end

  depends_on "ccache" => :build
  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "dwarfutils"
  depends_on "zstd"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args,
      "-DCPPTRACE_USE_EXTERNAL_LIBDWARF=On", "-DCPPTRACE_FIND_LIBDWARF_WITH_PKGCONFIG=ON",
      "-DBUILD_SHARED_LIBS=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "true"
  end
end
