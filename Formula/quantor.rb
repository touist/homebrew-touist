class Quantor < Formula
  desc "solver for quantified boolean formulas (QBF)"
  homepage "http://fmv.jku.at/quantor"
  url "http://fmv.jku.at/quantor/quantor-3.2.tar.gz"
  sha256 "7a82ebfd1c8ecc250325f311e725f6263bf69b412edcc2b600db2a25937d1189"

  option "with-nanosat", "Build using nanosat instead of picosat"

  depends_on "picosat" => :build
  depends_on "nanosat" => :build if build.with? "nanosat"

  def install
    # Remove unrecognized options if warned by configure
    system "./configure", "--nanosat=#{Formula["nanosat"].lib}" if build.with? "nanosat",
                          "--picosat=#{Formula["picosat"].lib}" if !build.with? "nanosat"
    system "make"
    bin.install "quantor"
    lib.install "libquantor.a"
  end

  test do
    (testpath/"test.dimacs").write <<-EOS.undent
      p cnf 2 1
      e 2 0
      a 1 0
      2 1 0
    EOS
    assert_equal "s TRUE\nc qnt (assignment to exported variables follows)\nv 2 0",
      shell_output("#{bin}/quantor #{testpath}/test.dimacs", result = 10).strip
  end
end
