class Quantor < Formula
  desc "solver for quantified boolean formulas (QBF)"
  homepage "http://fmv.jku.at/quantor"
  url "http://fmv.jku.at/quantor/quantor-3.2.tar.gz"
  sha256 "7a82ebfd1c8ecc250325f311e725f6263bf69b412edcc2b600db2a25937d1189"

  bottle do
  end

  depends_on "picosat" => :build

  patch :DATA

  def install
    system "./configure", "--picosat=#{Formula["picosat"].lib}"
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

# From a95fd487721e5b6a73d4a5ac4416c55256ef1171 Mon Sep 17 00:00:00 2001
# From: =?UTF-8?q?Ma=C3=ABl=20Valais?= <mael.valais@gmail.com>
# Date: Sun, 12 Nov 2017 20:38:13 +0100
# Subject: [PATCH 5/5] quantor-3.2: fix when CC is set to clang in macos
__END__
diff --git a/configure b/configure
index 7634f70..bfc72b1 100755
--- a/configure
+++ b/configure
@@ -225,6 +225,7 @@ do
   case $cc in
     gcc* | cc*) RAWCC=$cc; break;;
     *gcc | *cc) RAWCC=$cc; break;;
+    *clang*) RAWCC=$cc; break;;
     *) ;;
   esac
 done

