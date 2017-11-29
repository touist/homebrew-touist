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
    rebuild 1
    sha256 "9c39f422f5b4450dcebd29c9cfdaf42e4e01bfe2f2aceb8dcbaba4c38930d93a" => :sierra
    sha256 "3646e8f77d3c4cf83755a0ab5f00ab3c3d9ce2f612e9cffca6f2c9e92597f890" => :el_capitan
    sha256 "ef01a4b7e6e84d53442d2638706113ca13965b470f61d35fbe244bce8882693d" => :x86_64_linux
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

    system "opam", "install", "ocamlfind", "ocamlbuild"

    # Install the optionnal opam dependencies
    # If CC is set to CC=clang during `opam install qbf`,
    # then the ./configure of  libs/quantor-3.2 won't not work
    # because it (seemingly) expects CC to be 'cc*' or 'gcc*'.
    ENV["CC"] = "" if ENV["CC"] == "clang"

    system "opam", "install", "yices2", "qbf"

    # Install the mandatory opam dependencies
    system "opam", "pin", "add", ".", "--no-action"
    system "opam", "install", "touist", "--deps-only"

    # configure touist
    system "opam", "config", "exec", "--",
           "ocaml", "setup.ml", "-configure",
           "--enable-yices2", "--enable-qbf",
           "--disable-lib",
           "--prefix", prefix, "--mandir", man

    system "opam", "config", "exec", "--",
           "ocaml", "setup.ml", "-build"
    ENV.deparallelize { system "make", "install" }
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
