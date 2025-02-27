class Y3cStl < Formula
  desc "Friendly C++ STL wrapper with automatic stacktrace"
  homepage "https://na-trium-144.github.io/y3c-stl/"
  url "https://github.com/na-trium-144/y3c-stl/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "4a81fbd296b737e425aa87ce24283792b2fad29e7622390835342ac565cacfe8"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-y3c/releases/download/y3c-stl-0.3.3"
    sha256 cellar: :any, arm64_sequoia: "cbbb921efc95cf43df230d056ce9e6fdecaa2935ec2b028dc1462b65026372f9"
    sha256 cellar: :any, arm64_sonoma:  "70651566d40595a99b1b2542959743ffb8a1181077f930a744a536d98787a40d"
    sha256 cellar: :any, ventura:       "48412fcc2038bad92ec73a0265337aa59160784e5928570d5aa35faca2ce51fa"
    sha256               x86_64_linux:  "31e1fb61a5d4bfaaf570ca2ca7dea74547ccbf9ac3f6049cc25469ccbd8c4a2a"
  end

  depends_on "cmake" => :build
  depends_on "meson" => [:build, :test]
  depends_on "ninja" => [:build, :test]
  depends_on "pkgconf" => [:build, :test]
  depends_on "rang" => :build
  depends_on "cpptrace"
  depends_on "dwarfutils"
  depends_on "zstd"

  def install
    system "meson", "setup", "build", *std_meson_args, "-Dtests=false"
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"meson.build").write <<EOS
      project('test', 'cpp')
      executable('main', 'main.cc', dependencies: [dependency('y3c')])
EOS
    (testpath/"main.cc").write <<EOS
      #include <y3c/wrap>
      int main(){
        y3c::link();
      }
EOS
    system "meson", "setup", "build", "-Dcpp_std=c++11"
    system "meson", "compile", "-C", "build", "--verbose"
  end
end
