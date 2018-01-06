class Touist < Formula
  desc "The solver for the TouIST language"
  homepage "https://www.irit.fr/touist"
  url "https://github.com/touist/touist/archive/v3.5.0.tar.gz"
  sha256 "859a4428ced26ed38615a606138c02ec63541cd34cf94a37b3e35d5bf46d40c4"
  head "https://github.com/touist/touist.git", :shallow => false
  # We use the git history for `git describe --tags`, so no shallow clone

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    prefix "/usr/local"
    cellar :any_skip_relocation
    rebuild 3
    sha256 "d66e8635b7ae1bd54b459dff127fa5da39717b092bc4231f4a69a789321ff4cd" => :sierra
    sha256 "58033b6259dcd085530e5aa60ddf663e7a98f1199f977c73376298dfa46e6cbb" => :el_capitan
    sha256 "63c6377ff73ebe9d54b9919dda9af5b55bff5184767eeedf92f84251a1931ab0" => :x86_64_linux
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

    # Install the optionnal opam dependencies
    # If CC is set to CC=clang during `opam install qbf`,
    # then the ./configure of  libs/quantor-3.2 won't not work
    # because it (seemingly) expects CC to be 'cc*' or 'gcc*'.
    ENV["CC"] = "" if ENV["CC"] == "clang"

    system "opam", "install", "jbuilder", "yices2", "qbf"

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
    (testpath/"test.touist").write <<-EOS.undent
      (a and b => c) or d
    EOS
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve")
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve", "--smt", "QF_LIA")
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve", "--qbf")
  end
end
