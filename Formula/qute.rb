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
    sha256 "8e575716d02136ec6cf3b27e1659427134838b272957327f4d1b84725c7d3b5e" => :sierra
    sha256 "e75a507e7cd5a90f4775a83bd5873cf0cc0b641d80234ff078bb6d3c57c4c41a" => :el_capitan
    sha256 "de5b48c9619ebfe7f95cb18c0fe97206592f0b18bf523c3189ff7cdb790c199e" => :x86_64_linux
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
