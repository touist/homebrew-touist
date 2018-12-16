class Qute < Formula
  desc "A dependency learning QBF solver"
  homepage "https://github.com/maelvalais/qute"
  url "https://github.com/maelvalais/qute/archive/v0.0.1.tar.gz"
  sha256 "488825160ac586df7c0c642fff673731ba82647defa12941acde93bcf503a7d8"
  head "https://github.com/maelvalais/qute.git"
  revision 5

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    cellar :any
    sha256 "8423a4510102ec43d187cd715006c8995757c175cd2bd3ff824f2dcd2cf4647a" => :high_sierra
    sha256 "2a412d29940b62f8cb1bc616d27c7cc8ae6f1ddca58ff0f314c0f85d5bf9fb3f" => :sierra
    sha256 "f30fa63d8f1b99a3324ed799bc764b50890858367314593bdae49d38c11691ea" => :el_capitan
    sha256 "8ce00ec128c2340ab77c4727400ef241a774111ed5e4735267d8adcb8fcb6960" => :x86_64_linux
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
    assert_equal "SAT", shell_output("#{bin}/qute #{testpath}/test.dimacs", 10).strip
  end
end
