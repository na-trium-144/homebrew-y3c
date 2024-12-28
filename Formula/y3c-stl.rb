class Y3cStl < Formula
  desc "Friendly C++ STL wrapper with automatic stacktrace"
  homepage "https://na-trium-144.github.io/y3c-stl/"
  url "https://github.com/na-trium-144/y3c-stl/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "4d42cccc259a8f38791f96ffef2990fb0fa689db3f371561b723bc0cf9809aec"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-y3c/releases/download/y3c-stl-0.3.2"
    sha256 cellar: :any, arm64_sequoia: "2bfb0e0b98c3d172ef2a3b68e582fb43110f73d1e34be53829433aa8bfa239e1"
    sha256 cellar: :any, arm64_sonoma:  "0e2a7ef2b73ad77190c654b5bdac3a2a597a5169cdb7d992eac8e662c883408c"
    sha256 cellar: :any, ventura:       "071faec2953f2932c24ef1fb92b3e8bce58eb90900ae33d59e71542bde12fe37"
    sha256               x86_64_linux:  "01cdb8595ebe088c02787786f40875f9348af4b18bb70f469e66855980363889"
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
