class Touist < Formula
  desc "The solver for the TouIST language"
  homepage "https://www.irit.fr/touist"
  url "https://github.com/touist/touist/archive/v3.5.0.tar.gz"
  sha256 "7e8dedef983e90d4f318b6c8d2321a8b6fba88aebe52c925233886eb589a9afa"
  head "https://github.com/touist/touist.git", :shallow => false
  # We use the git history for `git describe --tags`, so no shallow clone

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    prefix "/usr/local"
    cellar :any_skip_relocation
    sha256 "7b5d439807b146bf9d695f1e1d73741a4788c8d8c900a4b18c2ff51a5e9ae3e2" => :sierra
    sha256 "94f0dbbab03a7b66127d580984b8f25dd7fbbca3d1d5228ef4802c6eec8ef2a3" => :el_capitan
    sha256 "0c607a78a49d09a6cee903c6f24eea50c7b103b09b8c4b4944417872195d108d" => :x86_64_linux
  end

  depends_on "opam" => :build
  depends_on "ocaml" => :build
  depends_on "gmp"

  def install
    ENV["OPAMYES"] = "1"
    opamroot = buildpath/"../opamroot"
    opamroot.mkpath
    ENV["OPAMROOT"] = opamroot
    system "opam", "init", "--no-setup"

    system "opam", "install", "ocamlfind", "jbuilder"

    # Install the optionnal opam dependencies
    # If CC is set to CC=clang during `opam install qbf`,
    # then the ./configure of  libs/quantor-3.2 won't not work
    # because it (seemingly) expects CC to be 'cc*' or 'gcc*'.
    ENV["CC"] = "" if ENV["CC"] == "clang"

    system "opam", "install", "yices2", "qbf"

    # Install the mandatory opam dependencies
    system "opam", "pin", "add", ".", "--no-action"
    system "eval `opam config env`; opam install touist --deps-only"
    system "eval `opam config env`; jbuilder build"
    bin.install "_build/default/src/main.exe" => "touist"
    man1.install "_build/default/src/touist.1" => "touist.1"
  end

  test do
    (testpath/"test.touist").write <<-EOS.undent
      (a and b => c) or d
    EOS
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve")
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve", "--smt", "QF_LIA")
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve", "--qbf")
  end
end
