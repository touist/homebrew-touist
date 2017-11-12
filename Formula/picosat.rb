class Picosat < Formula
  desc "A SAT solver inspired by Minisat"
  homepage "http://fmv.jku.at/picosat/"
  url "http://fmv.jku.at/picosat/picosat-965.tar.gz"
  sha256 "15169b4f28ba8f628f353f6f75a100845cdef4a2244f101a02b6e5a26e46a754"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    prefix "/usr/local"
    cellar :any_skip_relocation
    sha256 "4b22ca618eb628806d8715e9598ba3ab6f759d8918c85d9f59e35f35726e1aa3" => :sierra
    sha256 "1bec1c3c81c41a78c5f06568959b02a0f6e97c33ae05925b18db947b0eaffed9" => :el_capitan
    sha256 "eb7887245b37d42e8dcb67fd9dbd143c6648ec2f4efac4764088a35c805093ec" => :x86_64_linux
  end

  def install
    system "./configure.sh"
    system "make"
    bin.install "picosat","picomcs","picogcnf"
    lib.install "libpicosat.a"
  end

  test do
    (testpath/"test.dimacs").write <<-EOS.undent
      p cnf 2 1
      2 1 0
    EOS
    assert_equal "s SATISFIABLE\nv 1 2 0", shell_output("#{bin}/picosat #{testpath}/test.dimacs", result = 10).strip
  end
end
