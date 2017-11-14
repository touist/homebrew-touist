class Lingeling < Formula
  desc "A SAT solver"
  homepage "http://fmv.jku.at/lingeling/"
  url "http://fmv.jku.at/lingeling/lingeling-bal-2293bef-151109.tar.gz"
  sha256 "211be9debb67caef07829601b2ea059dbe120470bf33fba6ef79d248baf940a8"

  def install
    system "./configure.sh"
    system "make"
    bin.install "ilingeling", "lglddtrace", "lglmbt", "lgluntrace", "lingeling",
                "plingeling", "treengeling"
  end

  test do
    (testpath/"test.dimacs").write <<-EOS.undent
      p cnf 2 1
      2 1 0
    EOS
    shell_output("#{bin}/lingeling #{testpath}/test.dimacs", result = 10).strip
  end
end
