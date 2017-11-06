class Touist < Formula
  desc "The solver for the TouIST language"
  homepage "https://www.irit.fr/touist"
  url "https://github.com/touist/touist/archive/v3.4.1.tar.gz"
  sha256 "f4ccc2254887a5839c1aebfe1e1f8a85210f0f9c29f7b435b6ee4cef8c572020"
  head "https://github.com/touist/touist.git", :shallow => false
  # We use the git history for `git describe --tags`, so no shallow clone

  bottle do
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
      a and b
    EOS
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve")
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve", "--smt", "QF_LIA")
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve", "--qbf")
  end
end
