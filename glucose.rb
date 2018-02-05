class Glucose < Formula
  desc "A SAT Solver with parallel abilities based on Minisat"
  homepage "https://www.labri.fr/perso/lsimon/glucose/"
  url "https://www.labri.fr/perso/lsimon/downloads/softwares/glucose-syrup-4.1.tgz"
  sha256 "51aa1cf1bed2b14f1543b099e85a56dd1a92be37e6e3eb0c4a1fd883d5cc5029"

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "ea7764c05f501b879a843420175d2ac8c767504c1892ba1d48c981e2c40b5a04" => :high_sierra
    sha256 "ea7764c05f501b879a843420175d2ac8c767504c1892ba1d48c981e2c40b5a04" => :sierra
    sha256 "9a80d9f899f0dc38768e78a7b10de28dfcfcdddf8b5460f1cabcbe4d2c93a936" => :el_capitan
    sha256 "6a35552576991d1387c30d155d5eb4102a3a12b24e943a55574aeb75f38ba4c2" => :x86_64_linux
  end

  def install
    system "make", "-C", "simp", "r", "libr"
    system "make", "-C", "parallel", "r", "libr"

    bin.install "simp/glucose_release" => "glucose"
    bin.install "parallel/glucose-syrup_release" => "glucose-syrup"

    lib.install "simp/lib_release.a" => "libglucose.a"
    lib.install "parallel/lib_release.a" => "libglucose-syrup.a"
  end

  test do
    (testpath/"test.dimacs").write <<~EOS
      p cnf 2 1
      2 1 0
    EOS
    shell_output("#{bin}/glucose #{testpath}/test.dimacs", result = 10)
    shell_output("#{bin}/glucose-syrup #{testpath}/test.dimacs", result = 10)
  end

  # From e3146706111655643dc4d58e6a24ead8b036fff2 Mon Sep 17 00:00:00 2001
  # From: =?UTF-8?q?Ma=C3=ABl=20Valais?= <mael.valais@gmail.com>
  # Date: Mon, 13 Nov 2017 14:43:51 +0100
  # Subject: [PATCH 2/3] template.mk: fix --static which is specific to gnu-ld

  # ---
  # mtl/template.mk | 5 ++++-
  # 1 file changed, 4 insertions(+), 1 deletion(-)
  patch :p1, <<~EOS
diff --git a/mtl/template.mk b/mtl/template.mk
index db3327a..1b5e072 100644
--- a/mtl/template.mk
+++ b/mtl/template.mk
@@ -50,7 +50,10 @@ $(EXEC):		LFLAGS += -g
 $(EXEC)_profile:	LFLAGS += -g -pg
 $(EXEC)_debug:		LFLAGS += -g
 #$(EXEC)_release:	LFLAGS += ...
-$(EXEC)_static:		LFLAGS += --static
+
+# --static is only for GCC-like compilers, not LLVM/MSVC; use the seemingly
+# arch-pervasive -Bstatic (-static does not seem to work with LLVM ld )
+$(EXEC)_static:		LFLAGS += -Bstatic
 
 ## Dependencies
 $(EXEC):		$(COBJS)
EOS

  # From bfe8a8e41b79091f93584f394e30d1293bf66537 Mon Sep 17 00:00:00 2001
  # From: =?UTF-8?q?Ma=C3=ABl=20Valais?= <mael.valais@gmail.com>
  # Date: Mon, 13 Nov 2017 15:06:58 +0100
  # Subject: [PATCH 3/3] use CURDIR (GNU make) instead of PWD in order to use
  #  'make -C simp rs'

  # See -C and CURDIR in https://www.gnu.org/software/make/manual/make.html
  # ---
  #  mtl/template.mk   | 2 +-
  #  parallel/Makefile | 2 +-
  #  simp/Makefile     | 2 +-
  #  3 files changed, 3 insertions(+), 3 deletions(-)
  patch :p1, <<~EOS
diff --git a/mtl/template.mk b/mtl/template.mk
index 1b5e072..1950aae 100644
--- a/mtl/template.mk
+++ b/mtl/template.mk
@@ -5,7 +5,7 @@
 ##        "make d"  for a debug version (no optimizations).
 ##        "make"    for the standard version (optimized, but with debug information and assertions active)
 
-PWD        = $(shell pwd)
+PWD        = $(CURDIR)
 EXEC      ?= $(notdir $(PWD))
 
 CSRCS      = $(wildcard $(PWD)/*.cc) 
diff --git a/parallel/Makefile b/parallel/Makefile
index 0da6c25..7d33f50 100644
--- a/parallel/Makefile
+++ b/parallel/Makefile
@@ -1,4 +1,4 @@
 EXEC      = glucose-syrup
 DEPDIR    = mtl utils core simp
-MROOT = $(PWD)/..
+MROOT = $(CURDIR)/..
 include $(MROOT)/mtl/template.mk
diff --git a/simp/Makefile b/simp/Makefile
index f5d4481..491f744 100644
--- a/simp/Makefile
+++ b/simp/Makefile
@@ -1,5 +1,5 @@
 EXEC = glucose
 DEPDIR    = mtl utils core
-MROOT = $(PWD)/..
+MROOT = $(CURDIR)/..
 
 include $(MROOT)/mtl/template.mk
  EOS
end

