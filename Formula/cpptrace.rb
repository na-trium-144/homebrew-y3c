class Cpptrace < Formula
  desc "Simple, portable, and self-contained stacktrace library for C++11 and newer"
  homepage "https://github.com/jeremy-rifkin/cpptrace"
  url "https://github.com/jeremy-rifkin/cpptrace/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "618fb746174f76eb03c7ece059ebdcfe39b7b6adca6a5da0c9f9bc6a4764d7f9"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-y3c/releases/download/cpptrace-0.8.2"
    sha256 cellar: :any,                 arm64_sequoia: "b5b9eff896b5a3010de1fffc640ec5f14da22e767841a4338ee64b965cbaac9c"
    sha256 cellar: :any,                 arm64_sonoma:  "38b1668c69e1cb3343930d82f46cba157957280f10eab87f8ba24b76325a7b11"
    sha256 cellar: :any,                 ventura:       "6b208bfb61884c6f5fd85a4d5c972644d72873496ec6201f419adcf66716bc15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2818d25bc5d310941ad375d9a9a98bd01b1dd525e77b51cffde3326be429eee5"
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
