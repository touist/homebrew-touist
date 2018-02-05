class Qute < Formula
  desc "A dependency learning QBF solver"
  homepage "https://github.com/maelvalais/qute"
  url "https://github.com/maelvalais/qute/archive/v0.0.1.tar.gz"
  sha256 "488825160ac586df7c0c642fff673731ba82647defa12941acde93bcf503a7d8"
  head "https://github.com/maelvalais/qute.git"
  revision 2

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    cellar :any
    rebuild 2
    sha256 "8f565e78ad63859123d4a40abce2998884e4e359521640297738db7eaf2c9fa7" => :high_sierra
    sha256 "8f565e78ad63859123d4a40abce2998884e4e359521640297738db7eaf2c9fa7" => :sierra
    sha256 "fb4e4b8d6abc4e4f1c6661f3698b9f0167de7f3f8d30d94a3b9e31fcf142669c" => :el_capitan
    sha256 "16ea382528f474b88dba0893cb31404508c9058a9516d741287ad204e90878cf" => :x86_64_linux
  end

  depends_on "boost"
  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    bin.install "qute"
  end

  test do
    (testpath/"test.dimacs").write <<~EOS
      p cnf 2 1
      e 2 0
      a 1 0
      2 1 0
    EOS
    assert_equal "SAT", shell_output("#{bin}/qute #{testpath}/test.dimacs", result = 10).strip
  end
end

