class Lingeling < Formula
  desc "A SAT solver"
  homepage "http://fmv.jku.at/lingeling/"
  url "http://fmv.jku.at/lingeling/lingeling-bal-2293bef-151109.tar.gz"
  sha256 "211be9debb67caef07829601b2ea059dbe120470bf33fba6ef79d248baf940a8"

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    sha256 "141f132d5ed58f930ada22fbe81d63e4115b9f78b8fb2ca3fa266e30e5fdf0a3" => :sierra
    sha256 "be1e33155185e36cbfbc48a743efd14d65edbfc174d2e31e4386414ea2153233" => :el_capitan
    sha256 "b24481b3ac4a7b02114ea5d627aff7cd6e2bb1551e4b4f073d3aa1d580f787c8" => :x86_64_linux
  end

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
