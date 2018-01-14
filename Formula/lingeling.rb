class Lingeling < Formula
  desc "A SAT solver"
  homepage "http://fmv.jku.at/lingeling/"
  url "http://fmv.jku.at/lingeling/lingeling-bal-2293bef-151109.tar.gz"
  sha256 "211be9debb67caef07829601b2ea059dbe120470bf33fba6ef79d248baf940a8"

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "1838b06f007ef284b61151f294bc18bb4aaa6cf8f12653348f140bc5131d9ede" => :high_sierra
    sha256 "1838b06f007ef284b61151f294bc18bb4aaa6cf8f12653348f140bc5131d9ede" => :sierra
    sha256 "c8f51d68f3c0de8a14342b612e2f0b493e50c0adab27ec313a4d57207ff8e2e5" => :el_capitan
    sha256 "0e99581140eb8482e4895681bfc5cf04ac095e2199d0215c778ec41cf65c96ab" => :x86_64_linux
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

