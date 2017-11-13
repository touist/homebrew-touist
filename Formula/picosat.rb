class Picosat < Formula
  desc "A SAT solver inspired by Minisat"
  homepage "http://fmv.jku.at/picosat/"
  url "http://fmv.jku.at/picosat/picosat-965.tar.gz"
  sha256 "15169b4f28ba8f628f353f6f75a100845cdef4a2244f101a02b6e5a26e46a754"
  revision 2

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    rebuild 2
    sha256 "243e0e1c5802d239e35ed26a6576e234e0f59ead56c3a265edfce596e8bc6f7e" => :sierra
    sha256 "bb585d2a961ebbdf3355e5fa33275cbec11dd13968aacdaccf75ce96eb9eff3a" => :el_capitan
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
