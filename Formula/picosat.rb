class Picosat < Formula
  desc "A SAT solver inspired by Minisat"
  homepage "http://fmv.jku.at/picosat/"
  url "http://fmv.jku.at/picosat/picosat-965.tar.gz"
  sha256 "15169b4f28ba8f628f353f6f75a100845cdef4a2244f101a02b6e5a26e46a754"
  revision 1

  bottle do
  end

  def install
    system "./configure.sh"
    system "make"
    bin.install "picosat","picomcs","picogcnf"
    lib.install "libpicosat.a"
  end

  test do
    (testpath/"test.dimacs").write <<-EOS.undent
      p cnf 2 1
      2 1 0
    EOS
    assert_equal "s SATISFIABLE\nv 1 2 0", shell_output("#{bin}/picosat #{testpath}/test.dimacs", result = 10).strip
  end
end
