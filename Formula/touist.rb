class Touist < Formula
  desc "The solver for the TouIST language"
  homepage "https://www.irit.fr/touist"
  url "https://github.com/touist/touist/archive/v3.5.0.tar.gz"
  sha256 "859a4428ced26ed38615a606138c02ec63541cd34cf94a37b3e35d5bf46d40c4"
  head "https://github.com/touist/touist.git", :shallow => false
  # We use the git history for `git describe --tags`, so no shallow clone

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    cellar :any_skip_relocation
    rebuild 5
    sha256 "186eba72b4c72928f71e60b2171ed55ab072bf17e64a365890b5c3b3ff9a1e95" => :sierra
    sha256 "a298a3f01fb1261704c60e55c0fa82b4391937ec9189d3b68ea2952d0befef36" => :el_capitan
    sha256 "9677495e2fa831dcc5a30ead430a1ecdaaf8fe16e3ad24ba8a46ad015fb3f424" => :x86_64_linux
  end

  option "without-gmp", "Build without gmp which disables the yices2 support"

  depends_on "opam" => :build
  depends_on "ocaml" => :build
  depends_on "gmp" => :recommended

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
    (testpath/"test.touist").write <<-EOS.undent
      (a and b => c) or d
    EOS
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve")
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve", "--smt", "QF_LIA") if build.with? "gmp"
    system("#{bin}/touist", "#{testpath}/test.touist", "--solve", "--qbf")
  end
end

