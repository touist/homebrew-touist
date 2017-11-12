class Touist < Formula
  desc "The solver for the TouIST language"
  homepage "https://www.irit.fr/touist"
  url "https://github.com/touist/touist/archive/v3.4.2.tar.gz"
  sha256 "5fd3a59ccec8f83101b0c6d5081d66df99ad5323889bb2c50d5fc093dd79ac04"
  head "https://github.com/touist/touist.git", :shallow => false
  # We use the git history for `git describe --tags`, so no shallow clone

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    sha256 "b324b4df8ea3e5f56ea533371c5b8c400b586d476e67196efe977c68f90f972b" => :sierra
    sha256 "b1541c5060f5a9290396d8dc3396eb1348a11d30d907c8eeae681eb6cfd6448a" => :el_capitan
    sha256 "661938f49baa7ab30a820381020608b8a08d766eb51024e22931852ea91ac059" => :x86_64_linux
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
