class Touist < Formula
  desc "The solver for the TouIST language"
  homepage "https://www.irit.fr/touist"
  url "https://github.com/touist/touist/archive/v3.5.2.tar.gz"
  sha256 "faad60f20f88a9e539614dc9bdb30b42565cd7785cbbff200f18fd454f02b55f"
  head "https://github.com/touist/touist.git", :shallow => false
  # We use the git history for `git describe --tags`, so no shallow clone

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    cellar :any_skip_relocation
    sha256 "18ccb50794f50b0130531569583f5a8a3330c9731d789536a92922de8aba5227" => :high_sierra
    sha256 "18ccb50794f50b0130531569583f5a8a3330c9731d789536a92922de8aba5227" => :sierra
    sha256 "a657f34c95925eba3bf20128d0e42892990e1d6b89fa3d211b6b5e2cc1e0a7fe" => :el_capitan
    sha256 "900bfe67b72bacd73f9de60b22b399d5e69ef39ec9fe393d5e772bbfc7ee0e1a" => :x86_64_linux
  end


  option "without-gmp", "Build without gmp which disables the yices2 support"

  depends_on "opam" => :build
  depends_on "ocaml" => :build
  depends_on "gmp" => :build if OS.mac? && build.with?("gmp")
  depends_on "gmp" if OS.linux? && build.with?("gmp")

  def install
    ENV["OPAMYES"] = "1"
    opamroot = buildpath/"../opamroot"
    opamroot.mkpath
    ENV["OPAMROOT"] = opamroot
    system "opam", "init", "--no-setup"

    # Install the optionnal opam dependencies
    # If CC is set to CC=clang during `opam install qbf`,
    # then the ./configure of  libs/quantor-3.2 won't not work
    # because it (seemingly) expects CC to be 'cc*' or 'gcc*'.
    ENV["CC"] = "" if ENV["CC"] == "clang"

    system "opam", "install", "jbuilder", "qbf", *("yices2" if build.with? "gmp")

    # jbuilder subst will turn %%VERSION%% into real version name; we need
    # to do that BEFORE the pinning.

    system "eval `opam config env`; jbuilder subst"
    # Install the mandatory opam dependencies
    system "opam", "pin", "add", ".", "--no-action"
    # For some reason, `opam config exec -- jbuilder build` say that
    # jbuilder is not found. Workaround: use eval `opam config env`
    # instead.
    system "eval `opam config env`; opam install touist --deps-only"
    system "eval `opam config env`; jbuilder build"
    bin.install "_build/default/src/main.exe" => "touist"
    man1.install "_build/default/src/touist.1" => "touist.1"
  end

  test do
    (testpath/"test.touist").write <<~EOS
      (a and b => c) or d
    EOS
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve")
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve", "--smt", "QF_LIA") if build.with? "gmp"
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve", "--qbf")
  end
end


