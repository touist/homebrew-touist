class Picosat < Formula
  desc "A SAT solver inspired by Minisat"
  homepage "http://fmv.jku.at/picosat/"
  url "http://fmv.jku.at/picosat/picosat-965.tar.gz"
  sha256 "15169b4f28ba8f628f353f6f75a100845cdef4a2244f101a02b6e5a26e46a754"
  revision 2

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    rebuild 3
    sha256 "fec2ab3ddb718d4e97d9831dbcb472b67f0de773214c1e829031fbaf0dc09f47" => :sierra
    sha256 "ef3f7a54476c05254c916a07a6658588d6e64e19d152a0992a618583bc4da181" => :el_capitan
    sha256 "c0172793bceb20e59b5a87e12514bb574b0840b21d5438803c3224ac3d390b76" => :x86_64_linux
  end

  def install
    system "./configure.sh"
    system "make"
    bin.install "picosat", "picomcs", "picogcnf", "picomus"
    lib.install "libpicosat.a"
    lib.install "picosat.h" # because quantor expects everything in one dir
  end

  test do
    (testpath/"test.dimacs").write <<-EOS.undent
      p cnf 2 1
      2 1 0
    EOS
    assert_equal "s SATISFIABLE\nv 1 2 0", shell_output("#{bin}/picosat #{testpath}/test.dimacs", result = 10).strip
  end

  def caveats
    <<~EOS
      Because Quantor (and apparently also other solvers) expects both
      the header and the library to be in one folder, `picosat.h` is
      installed along with `libpicosat.a` in the lib/ folder.
    EOS
  end
end
