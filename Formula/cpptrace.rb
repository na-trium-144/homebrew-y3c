class Cpptrace < Formula
  desc "Simple, portable, and self-contained stacktrace library for C++11 and newer"
  homepage ""
  url "https://github.com/jeremy-rifkin/cpptrace/archive/refs/tags/v0.7.4.tar.gz"
  sha256 "1241790cace5d59ddf21ce5d046f71cd26448a3c8c15d123157498ba81e3543d"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "dwarfutils"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args,
      "-DCPPTRACE_USE_EXTERNAL_LIBDWARF=On", "-DCPPTRACE_FIND_LIBDWARF_WITH_PKGCONFIG=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "true"
  end
end
