class Lingeling < Formula
  desc "SAT solver"
  homepage "http://fmv.jku.at/lingeling/"
  url "http://fmv.jku.at/lingeling/lingeling-bal-2293bef-151109.tar.gz"
  sha256 "211be9debb67caef07829601b2ea059dbe120470bf33fba6ef79d248baf940a8"

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    rebuild 1
    sha256 cellar: :any_skip_relocation, high_sierra:  "1838b06f007ef284b61151f294bc18bb4aaa6cf8f12653348f140bc5131d9ede"
    sha256 cellar: :any_skip_relocation, sierra:       "1838b06f007ef284b61151f294bc18bb4aaa6cf8f12653348f140bc5131d9ede"
    sha256 cellar: :any_skip_relocation, el_capitan:   "c8f51d68f3c0de8a14342b612e2f0b493e50c0adab27ec313a4d57207ff8e2e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0e99581140eb8482e4895681bfc5cf04ac095e2199d0215c778ec41cf65c96ab"
  end

  def install
    system "./configure.sh"
    system "make"
    bin.install "ilingeling", "lglddtrace", "lglmbt", "lgluntrace", "lingeling",
                "plingeling", "treengeling"
  end

  test do
    (testpath/"test.dimacs").write <<~EOS
      p cnf 2 1
      2 1 0
    EOS
    shell_output("#{bin}/lingeling #{testpath}/test.dimacs", result = 10).strip
  end
end
