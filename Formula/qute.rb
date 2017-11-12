class Qute < Formula
  desc "A dependency learning QBF solver"
  homepage "https://github.com/maelvalais/qute"
  url "https://github.com/maelvalais/qute/archive/v0.0.1.tar.gz"
  sha256 "488825160ac586df7c0c642fff673731ba82647defa12941acde93bcf503a7d8"
  head "https://github.com/maelvalais/qute.git"

  bottle do
    root_url "https://dl.bintray.com/touist/bottles-touist"
    prefix "/home/linuxbrew/.linuxbrew"
    cellar "/home/linuxbrew/.linuxbrew/Cellar"
    sha256 "7a2456427a8f3788ba5b4d21737c41e923935ef55192971532d63dbccd4ad4b9" => :sierra
    sha256 "674453e70246ce05b5327fef7306e790f151f4a0a64a52c90ee07679672aa2e9" => :el_capitan
    sha256 "b94181f1385850e4b229a9e4ecb0bdd22704114c582524dfa2b43dc0268393dd" => :x86_64_linux
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
