class Qute < Formula
  desc "A dependency learning QBF solver"
  homepage "https://github.com/maelvalais/qute"
  url "https://github.com/maelvalais/qute/archive/v0.0.1.tar.gz"
  sha256 "d46774becd3a5046a0d442002f480d6467242407d3f537b9b003e441bdb46dbf"
  head "https://github.com/maelvalais/qute.git"

  bottle do
    cellar :any
    sha256 "023a9dbbef90d86cacf355dcc592fc005300f8ac52c04adadacb745af61a8f69" => :sierra
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
