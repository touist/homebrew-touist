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
    rebuild 6
    sha256 "1abcb99fef97d994a41be4f0ad6216f4e3aa6739dc7fcea1a1268c357c390c26" => :high_sierra
    sha256 "1abcb99fef97d994a41be4f0ad6216f4e3aa6739dc7fcea1a1268c357c390c26" => :sierra
    sha256 "aeb2851241a31e274cf60d490a70c0f1709075ca820324b0f6745ca0830e330f" => :el_capitan
    sha256 "a40fdcfff12c288f6432c96023d4b42631f5b38e901a138e6250d23767a57bdc" => :x86_64_linux
  end

  option "without-gmp", "Build without gmp which disables the yices2 support"

  depends_on "opam" => :build
  depends_on "ocaml" => :build
  depends_on "gmp" => [:recommended, :build]

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


