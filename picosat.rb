class Picosat < Formula
  desc "SAT solver inspired by Minisat"
  homepage "http://fmv.jku.at/picosat/"
  url "http://fmv.jku.at/picosat/picosat-965.tar.gz"
  sha256 "15169b4f28ba8f628f353f6f75a100845cdef4a2244f101a02b6e5a26e46a754"
  revision 2

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    rebuild 4
    sha256 cellar: :any_skip_relocation, high_sierra:  "3a1d2f656f23bb76976b062a261fa6cb527c3fa02e012202a314e02d1defe962"
    sha256 cellar: :any_skip_relocation, sierra:       "3a1d2f656f23bb76976b062a261fa6cb527c3fa02e012202a314e02d1defe962"
    sha256 cellar: :any_skip_relocation, el_capitan:   "cdd30b793974be7fe709ff1dcfe0e5a7d1aafc893a4512dbdcf338f379bf9bcd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "53bf0c60ed8759f85a7bdef64c8f2c588f76e27b0437a9a0daebff11390cbd34"
  end

  def install
    system "./configure.sh"
    system "make"
    bin.install "picosat", "picomcs", "picogcnf", "picomus"
    lib.install "libpicosat.a"
    lib.install "picosat.h" # because quantor expects everything in one dir
  end

  def caveats
    <<~EOS
      Because Quantor (and apparently also other solvers) expects both
      the header and the library to be in one folder, `picosat.h` is
      installed along with `libpicosat.a` in the lib/ folder.
    EOS
  end

  test do
    (testpath/"test.dimacs").write <<~EOS
      p cnf 2 1
      2 1 0
    EOS
    assert_equal "s SATISFIABLE\nv 1 2 0", shell_output("#{bin}/picosat #{testpath}/test.dimacs", result = 10).strip
  end
end
