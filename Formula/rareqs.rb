# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Rareqs < Formula
  desc "Recursive Abstraction Refinement QBF Solver"
  homepage "http://sat.inesc-id.pt/~mikolas/sw/areqs/"
  url "http://sat.inesc-id.pt/~mikolas/sw/areqs/rareqs-1.1.src.tgz"
  sha256 "2d58097594e813036be922cb5914e6ba659e4bd424336dc7ed917d6c9191e2a3"

  bottle do
  end

  patch :DATA

  def install
    system "make"
    bin.install "rareqs"
  end

  test do
    (testpath/"test.dimacs").write <<-EOS.undent
      p cnf 2 1
      e 2 0
      a 1 0
      2 1 0
    EOS
    shell_output("#{bin}/rareqs #{testpath}/test.dimacs", result = 10).strip
  end
end

# From 609b2b6582564aa16876445f5ac4cd733546efc0 Mon Sep 17 00:00:00 2001
# From: =?UTF-8?q?Ma=C3=ABl=20Valais?= <mael.valais@gmail.com>
# Date: Tue, 5 Sep 2017 08:57:18 +0200
# Subject: [PATCH] osx: moved default argument in mkLit() from definition to
#  declaration
#
#     minisat/core/SolverTypes.h:50:16: error: friend declaration specifying a
#     default argument must be a definition
#
#         friend Lit mkLit(Var var, bool sign = false);
# ---
#  minisat/core/SolverTypes.h | 4 ++--
#  1 file changed, 2 insertions(+), 2 deletions(-)

# From 9dadee4a04fd693429fc4f29e8737be21a872220 Mon Sep 17 00:00:00 2001
# From: =?UTF-8?q?Ma=C3=ABl=20Valais?= <mael.valais@gmail.com>
# Date: Sun, 12 Nov 2017 20:47:48 +0100
# Subject: [PATCH 3/3] _MSC_VER should not be set when not on MSVC

# It triggers, on clang 8.1.0, the error:

# /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/8.1.0/include/inttypes.h:27:2:
# error: MSVC does not have inttypes.h prior to Visual Studio 2013

__END__
diff --git a/Makefile b/Makefile
index 0036f69..7213ea3 100644
--- a/Makefile
+++ b/Makefile
@@ -25,7 +25,7 @@ endif
 
 CFLAGS += -Wall
 CFLAGS+=-D __STDC_LIMIT_MACROS -D __STDC_FORMAT_MACROS -Wno-parentheses -Wno-deprecated -D _MSC_VER
-CFLAGS+=-D _MSC_VER # this is just for compilation of Options in minisat, which are not used anyhow
+#CFLAGS+=-D _MSC_VER # this is just for compilation of Options in minisat, which are not used anyhow
 CFLAGS+=-I./minisat/
 CFLAGS+=-std=c++0x
 LIBS+=-lz -lminisat
diff --git a/minisat/core/SolverTypes.h b/minisat/core/SolverTypes.h
index 1ebcc73..709caa7 100644
--- a/minisat/core/SolverTypes.h
+++ b/minisat/core/SolverTypes.h
@@ -47,7 +47,7 @@ struct Lit {
     int     x;
 
     // Use this as a constructor:
-    friend Lit mkLit(Var var, bool sign = false);
+    friend Lit mkLit(Var var, bool sign);
 
     bool operator == (Lit p) const { return x == p.x; }
     bool operator != (Lit p) const { return x != p.x; }
@@ -55,7 +55,7 @@ struct Lit {
 };
 
 
-inline  Lit  mkLit     (Var var, bool sign) { Lit p; p.x = var + var + (int)sign; return p; }
+inline  Lit  mkLit     (Var var, bool sign = false) { Lit p; p.x = var + var + (int)sign; return p; }
 inline  Lit  operator ~(Lit p)              { Lit q; q.x = p.x ^ 1; return q; }
 inline  Lit  operator ^(Lit p, bool b)      { Lit q; q.x = p.x ^ (unsigned int)b; return q; }
 inline  bool sign      (Lit p)              { return p.x & 1; }
