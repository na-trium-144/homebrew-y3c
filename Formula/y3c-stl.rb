class Y3cStl < Formula
  desc "Friendly C++ STL wrapper with automatic stacktrace"
  homepage "https://na-trium-144.github.io/y3c-stl/"
  url "https://github.com/na-trium-144/y3c-stl/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "4d42cccc259a8f38791f96ffef2990fb0fa689db3f371561b723bc0cf9809aec"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "cpptrace"
  depends_on "dwarfutils"
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "rang" => :build

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
    system "cmake", "-B", "build"
    system "cmake", "--build", "build"
  end
end
