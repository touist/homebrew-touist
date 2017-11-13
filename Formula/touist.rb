class Touist < Formula
  desc "The solver for the TouIST language"
  homepage "https://www.irit.fr/touist"
  url "https://github.com/touist/touist/archive/v3.4.3.tar.gz"
  sha256 "1c3bcc11077c40a51c31be259a09e37a2c4b95b396577b45b53fb3355bafda57"
  head "https://github.com/touist/touist.git", :shallow => false
  # We use the git history for `git describe --tags`, so no shallow clone

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    prefix "/usr/local"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "80be7050b2eaded841eb942543b131d7bbcc7e6a765907c816f32e8f03b7545a" => :sierra
    sha256 "e8b1b04de6614520b8280f372cba27b71d15fce42a8c240df5f04e68549cf58f" => :el_capitan
    sha256 "50f156e52b88891b159c116eaa0fb9e5c0059c16387b9ccfc2d7f066f909f2f5" => :x86_64_linux
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
