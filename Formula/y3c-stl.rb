class Y3cStl < Formula
  desc "Friendly C++ STL wrapper with automatic stacktrace"
  homepage "https://na-trium-144.github.io/y3c-stl/"
  url "https://github.com/na-trium-144/y3c-stl/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "4a81fbd296b737e425aa87ce24283792b2fad29e7622390835342ac565cacfe8"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-y3c/releases/download/y3c-stl-0.4.0"
    sha256 cellar: :any, arm64_sequoia: "9fbdbc19862be6a30bf0e64f7159c0c4e0db3665315ba1be4537a2ef1c53366b"
    sha256 cellar: :any, arm64_sonoma:  "7aa4779b026c7f308306e91d98b6c17d120aaee547da3cd3ab9380ca1f0dc13c"
    sha256 cellar: :any, ventura:       "2525fe888fc8df66a361d48ef7bb15188fecd04ce0696d3d60a87ff161be2c92"
    sha256               x86_64_linux:  "d1e4a340e05717c428c28a101a1b6caf4546b4f85d5fcefb40ca0fa565dbf1b8"
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
