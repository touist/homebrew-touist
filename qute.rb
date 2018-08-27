class Qute < Formula
  desc "A dependency learning QBF solver"
  homepage "https://github.com/maelvalais/qute"
  url "https://github.com/maelvalais/qute/archive/v0.0.1.tar.gz"
  sha256 "488825160ac586df7c0c642fff673731ba82647defa12941acde93bcf503a7d8"
  head "https://github.com/maelvalais/qute.git"
  revision 4

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    sha256 "96c91c925b367b9e28d42b8fbef955e60362db082c0d411d7b6e57971f69a4c5" => :high_sierra
    sha256 "94d1c045d2e2e405f4f3a99c1a3a611d7b3aa5f42e27423ce7c3d248ea6136fa" => :sierra
    sha256 "9c4a953c901e167fcdb91e7ea3b45c3bed60184c02186e11b93617e3c2d896f9" => :el_capitan
    sha256 "d03c178aa63da8b2fed184a8095ab813f8cc57dcadc8c1a52deee4f469b54495" => :x86_64_linux
  end

  depends_on "boost"
  depends_on "cmake" => :build

  needs :cxx11

  def install
    ENV.cxx11
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

