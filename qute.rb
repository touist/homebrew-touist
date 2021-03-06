class Qute < Formula
  desc "Dependency learning QBF solver"
  homepage "https://github.com/maelvalais/qute"
  url "https://github.com/maelvalais/qute/archive/v0.0.1.tar.gz"
  sha256 "488825160ac586df7c0c642fff673731ba82647defa12941acde93bcf503a7d8"
  revision 5
  head "https://github.com/maelvalais/qute.git"

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    sha256 cellar: :any, mojave:       "6e11e476e05d9ed38b9b1c45495e884e30e74504454949ddb2b6cc6122f3323a"
    sha256 cellar: :any, high_sierra:  "6e11e476e05d9ed38b9b1c45495e884e30e74504454949ddb2b6cc6122f3323a"
    sha256 cellar: :any, sierra:       "21e5e6a5c0984ce7a4c757c81a80d65312428096f03a8054f7cc77a3e16119c1"
    sha256 cellar: :any, x86_64_linux: "bb91a0f5a84f57afbdb9f491b146557ea0ec838dea8b96dcdb7384115821cbd6"
  end

  depends_on "cmake" => :build
  depends_on "boost"

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
