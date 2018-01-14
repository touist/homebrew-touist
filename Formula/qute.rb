class Qute < Formula
  desc "A dependency learning QBF solver"
  homepage "https://github.com/maelvalais/qute"
  url "https://github.com/maelvalais/qute/archive/v0.0.1.tar.gz"
  sha256 "488825160ac586df7c0c642fff673731ba82647defa12941acde93bcf503a7d8"
  head "https://github.com/maelvalais/qute.git"
  revision 2

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    prefix "/usr/local"
    cellar :any
    rebuild 1
    sha256 "71f3b8ca527e745e284f1739fe0b9d1f76ee9c2b9daefc3902be95fa16e18279" => :sierra
    sha256 "74e356eae00233d381b351209d009cd23c35180b70a93210254cefe46c9e97a4" => :el_capitan
    sha256 "20471f9c21d0d291d9f56e7055ea96865a2ae3dd434e610f8af390515e88ffe0" => :x86_64_linux
  end

  depends_on "boost"
  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    bin.install "qute"
  end

  test do
    (testpath/"test.dimacs").write <<-EOS.undent
      p cnf 2 1
      e 2 0
      a 1 0
      2 1 0
    EOS
    assert_equal "SAT", shell_output("#{bin}/qute #{testpath}/test.dimacs", result = 10).strip
  end
end

