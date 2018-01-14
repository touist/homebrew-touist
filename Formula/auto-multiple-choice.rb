class AutoMultipleChoice < Formula
  desc "Auto Multiple Choice (AMC) helps you prepare printed tests for your students and mark them using PDF scans"
  homepage "https://www.auto-multiple-choice.net"
  url "https://bitbucket.org/auto-multiple-choice/auto-multiple-choice/get/15d39fd2d4aa.tar.gz"
  sha256 "6c19ac832039b22ca266310c471aeff744c0e547d148e537969e6ba7668179dc"
  version "1.3.0+hg2017-10-25"
  head "https://bitbucket.org/auto-multiple-choice/auto-multiple-choice", :using => :hg

  option "with-doc", "Also generate doc; needs dblatex and fonts 'DejaVu Sans' & 'IPAex'"

  depends_on :x11
  depends_on :python => :build if build.with?("doc")
  depends_on "perl"
  depends_on "gtk+3"
  depends_on "adwaita-icon-theme"
  depends_on "gdk-pixbuf" # I don't know what this is; copied from macports'
  depends_on "librsvg" # I don't know what this is; copied from macports'
  depends_on "netpbm"
  depends_on "poppler"
  depends_on "opencv"
  # depends_on "graphicsmagick" # apparently, you can use either imagemagick or graphicsmagick
  depends_on "imagemagick@6" # for Image::Magick (perl)
  depends_on "glib" # for Glib (perl)
  depends_on "libffi" # for Glib::Object::Introspection (perl)
  depends_on "gettext" # for runtime and build (msgfmt)
  depends_on "libxml2" => :build # for XML::LibXML (perl) which is only used during build
  depends_on "docbook" => :build if build.with?("doc") # for doc
  depends_on "docbook-xsl" => :build if build.with?("doc") # for doc
  depends_on "libnotify" # for Desktop::Notify (perl)
  depends_on "dbus" # for Desktop::Notify (perl)
  depends_on "gnu-sed" => :build if build.with?("doc")

  resource "dblatex" do # for build
    url "http://downloads.sourceforge.net/project/dblatex/dblatex/dblatex-0.3.10/dblatex-0.3.10.tar.bz2"
    sha256 "6fd696b740e0044ae1caf843d225d98c01b6ed916550384544e7e31c0c6a2cfa"
  end
  resource "pdftk" do # for AMC itself
    url "https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-2.02-mac_osx-10.11-setup.pkg"
    sha256 "c33cf95151e477953cd57c1ea9c99ebdc29d75f4c9af0d5f947b385995750b0c"
  end

  # Perl deps:
  resource "XML::LibXML" do
    url "https://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/XML-LibXML-2.0132.tar.gz"
    sha256 "721452e3103ca188f5968ab06d5ba29fe8e00e49f4767790882095050312d476"
  end
  resource "XML::SAX" do
    url "https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-0.99.tar.gz"
    sha256 "32b04b8e36b6cc4cfc486de2d859d87af5386dd930f2383c49347050d6f5ad84"
  end
  resource "XML::NamespaceSupport" do
    url "https://cpan.metacpan.org/authors/id/P/PE/PERIGRIN/XML-NamespaceSupport-1.12.tar.gz"
    sha256 "47e995859f8dd0413aa3f22d350c4a62da652e854267aa0586ae544ae2bae5ef"
  end
  resource "XML::SAX::Base" do
    url "https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-Base-1.09.tar.gz"
    sha256 "66cb355ba4ef47c10ca738bd35999723644386ac853abbeb5132841f5e8a2ad0"
  end
  resource "Archive::Zip" do
    url "https://cpan.metacpan.org/authors/id/P/PH/PHRED/Archive-Zip-1.60.tar.gz"
    sha256 "eac75b05f308e860aa860c3094aa4e7915d3d31080e953e49bc9c38130f5c20b"
  end
  resource "Test::MockModule" do
    url "https://cpan.metacpan.org/authors/id/G/GF/GFRANKS/Test-MockModule-0.13.tar.gz"
    sha256 "7473742a0d600eb11766752c79a966570755168105ee4d4e33d90466b7339053"
  end
  resource "Module::Build" do
    url "https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4224.tar.gz"
    sha256 "a6ca15d78244a7b50fdbf27f85c85f4035aa799ce7dd018a0d98b358ef7bc782"
  end
  resource "SUPER" do
    url "https://cpan.metacpan.org/authors/id/C/CH/CHROMATIC/SUPER-1.20141117.tar.gz"
    sha256 "1a620e7d60aee9b13b1b26a44694c43fdb2bba1755cfff435dae83c7d42cc0b2"
  end
  resource "Sub::Identify" do
    url "https://cpan.metacpan.org/authors/id/R/RG/RGARCIA/Sub-Identify-0.14.tar.gz"
    sha256 "068d272086514dd1e842b6a40b1bedbafee63900e5b08890ef6700039defad6f"
  end
  resource "Clone" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GARU/Clone-0.39.tar.gz"
    sha256 "acb046683e49d650b113634ecf57df000816a49e611b0fff70bf3f93568bfa2d"
  end
  resource "DBD::SQLite" do
    url "https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/DBD-SQLite-1.54.tar.gz"
    sha256 "3929a6dbd8d71630f0cb57f85dcef9588cd7ac4c9fa12db79df77b9d3a4d7269"
  end
  resource "DBI" do
    url "https://cpan.metacpan.org/authors/id/T/TI/TIMB/DBI-1.637.tar.gz"
    sha256 "2557712593e80142c3b50877e00369b6ce78fa26d44edc42156d81a5cdd26bc6"
  end
  resource "Digest::MD5" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/Digest-MD5-2.55.tar.gz"
    sha256 "03b198a2d14425d951e5e50a885d3818c3162c8fe4c21e18d7798a9a179d0e3c"
  end
  resource "Email::MIME" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Email-MIME-1.946.tar.gz"
    sha256 "68ee79023165d77bec99a2e12ef89ad4e12501e6c321f6822053dc4f411c337c"
  end
  resource "Email::Simple::Creator" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Email-Simple-2.214.tar.gz"
    sha256 "b2f02b37441ea60efbddebbd675017d26bb767e9a4de3e0fc30b5410a1416b92"
  end
  resource "Email::Date::Format" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Email-Date-Format-1.005.tar.gz"
    sha256 "579c617e303b9d874411c7b61b46b59d36f815718625074ae6832e7bb9db5104"
  end
  resource "Module::Runtime" do
    url "https://cpan.metacpan.org/authors/id/Z/ZE/ZEFRAM/Module-Runtime-0.016.tar.gz"
    sha256 "68302ec646833547d410be28e09676db75006f4aa58a11f3bdb44ffe99f0f024"
  end
  resource "Email::MessageID" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Email-MessageID-1.406.tar.gz"
    sha256 "ec425ddbf395e0e1ac7c6f95b4933c55c57ac9f1e7514003c7c904ec6cd342b8"
  end
  resource "MIME::Types" do
    url "https://cpan.metacpan.org/authors/id/M/MA/MARKOV/MIME-Types-2.14.tar.gz"
    sha256 "4049cf0fc05205893f25fdbe07d1ab12bfc72259517db2c3348c1d1059730070"
  end
  resource "Email::Address::XS" do
    url "https://cpan.metacpan.org/authors/id/P/PA/PALI/Email-Address-XS-1.01.tar.gz"
    sha256 "204bf61bc00fcb71100326bda81363803b71446dcf43074d3cb876a71d0a0c26"
  end
  resource "Email::MIME::Encodings" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Email-MIME-Encodings-1.315.tar.gz"
    sha256 "4c71045507b31ec853dd60152b40e33ba3741779c0f49bb143b50cf8d243ab5c"
  end
  resource "Capture::Tiny" do
    url "https://cpan.metacpan.org/authors/id/D/DA/DAGOLDEN/Capture-Tiny-0.46.tar.gz"
    sha256 "5d7a6a830cf7f2b2960bf8b8afaac16a537ede64f3023827acea5bd24ca77015"
  end
  resource "Email::MIME::ContentType" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Email-MIME-ContentType-1.022.tar.gz"
    sha256 "9abb7280b0da62a855ae5528b14deb94341a84e721af0a7e5a2adc3534ec5310"
  end
  resource "Email::Sender" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Email-Sender-1.300031.tar.gz"
    sha256 "c412372938510283d8c850127895e09c2b670f892e1c3992fd54c0c1a9064f14"
  end
  resource "Sub::Exporter" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Sub-Exporter-0.987.tar.gz"
    sha256 "543cb2e803ab913d44272c7da6a70bb62c19e467f3b12aaac4c9523259b083d6"
  end
  resource "Params::Util" do
    url "https://cpan.metacpan.org/authors/id/A/AD/ADAMK/Params-Util-1.07.tar.gz"
    sha256 "30f1ec3f2cf9ff66ae96f973333f23c5f558915bb6266881eac7423f52d7c76c"
  end
  resource "Data::OptList" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Data-OptList-0.110.tar.gz"
    sha256 "366117cb2966473f2559f2f4575ff6ae69e84c69a0f30a0773e1b51a457ef5c3"
  end
  resource "Sub::Install" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Sub-Install-0.928.tar.gz"
    sha256 "61e567a7679588887b7b86d427bc476ea6d77fffe7e0d17d640f89007d98ef0f"
  end
  resource "MooX::Types::MooseLike::Base" do
    url "https://cpan.metacpan.org/authors/id/M/MA/MATEU/MooX-Types-MooseLike-0.29.tar.gz"
    sha256 "1d3780aa9bea430afbe65aa8c76e718f1045ce788aadda4116f59d3b7a7ad2b4"
  end
  resource "Test::Fatal" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Test-Fatal-0.014.tar.gz"
    sha256 "bcdcef5c7b2790a187ebca810b0a08221a63256062cfab3c3b98685d91d1cbb0"
  end
  resource "Try::Tiny" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/Try-Tiny-0.30.tar.gz"
    sha256 "da5bd0d5c903519bbf10bb9ba0cb7bcac0563882bcfe4503aee3fb143eddef6b"
  end
  resource "Moo" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Moo-2.003004.tar.gz"
    sha256 "f8bbb625f8e963eabe05cff9048fdd72bdd26777404ff2c40bc690f558be91e1"
  end
  resource "Role::Tiny" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Role-Tiny-2.000006.tar.gz"
    sha256 "cc73418c904a0286ecd8915eac11f5be2a8d1e17ea9cb54c9116b0340cd3e382"
  end
  resource "Sub::Defer" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Sub-Quote-2.004000.tar.gz"
    sha256 "5861520313fa8c8bf8f8b8c64af0d6d9140380652dc1f98bd03370ddaf1a30ff"
  end
  resource "Class::Method::Modifiers" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/Class-Method-Modifiers-2.12.tar.gz"
    sha256 "e44c1073020bf55b8c97975ed77235fd7e2a6a56f29b5c702301721184e27ac8"
  end
  resource "Test::Requires" do
    url "https://cpan.metacpan.org/authors/id/T/TO/TOKUHIROM/Test-Requires-0.10.tar.gz"
    sha256 "2768a391d50ab94b95cefe540b9232d7046c13ee86d01859e04c044903222eb5"
  end
  resource "Devel::GlobalDestruction" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Devel-GlobalDestruction-0.14.tar.gz"
    sha256 "34b8a5f29991311468fe6913cadaba75fd5d2b0b3ee3bb41fe5b53efab9154ab"
  end
  resource "Sub::Exporter::Progressive" do
    url "https://cpan.metacpan.org/authors/id/F/FR/FREW/Sub-Exporter-Progressive-0.001013.tar.gz"
    sha256 "d535b7954d64da1ac1305b1fadf98202769e3599376854b2ced90c382beac056"
  end
  resource "Email::Abstract" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Email-Abstract-3.008.tar.gz"
    sha256 "fc7169acb6c43df7f005e7ef6ad08ee8ca6eb6796b5d1604593c997337cc8240"
  end
  resource "Email::Simple" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Email-Simple-2.214.tar.gz"
    sha256 "b2f02b37441ea60efbddebbd675017d26bb767e9a4de3e0fc30b5410a1416b92"
  end
  resource "MRO::Compat" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/MRO-Compat-0.13.tar.gz"
    sha256 "8a2c3b6ccc19328d5579d02a7d91285e2afd85d801f49d423a8eb16f323da4f8"
  end
  resource "Module::Pluggable" do
    url "https://cpan.metacpan.org/authors/id/S/SI/SIMONW/Module-Pluggable-5.2.tar.gz"
    sha256 "b3f2ad45e4fd10b3fb90d912d78d8b795ab295480db56dc64e86b9fa75c5a6df"
  end
  resource "Throwable::Error" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Throwable-0.200013.tar.gz"
    sha256 "9987d0deb5bddd352a6330cefbe932f882e36dd8c8a4564bcfd372dc396b8fa0"
  end
  resource "Devel::StackTrace" do
    url "https://cpan.metacpan.org/authors/id/D/DR/DROLSKY/Devel-StackTrace-2.03.tar.gz"
    sha256 "7618cd4ebe24e254c17085f4b418784ab503cb4cb3baf8f48a7be894e59ba848"
  end
  resource "Email::Address" do
    url "https://cpan.metacpan.org/authors/id/R/RJ/RJBS/Email-Address-1.908.tar.gz"
    sha256 "e5f860bdfe6d768324bc9e402d563667e4171dd98f1a87d785e9087f7793d444"
  end
  resource "File::BaseDir" do
    url "https://cpan.metacpan.org/authors/id/K/KI/KIMRYAN/File-BaseDir-0.07.tar.gz"
    sha256 "120a57ef78535e13e1465717b4056aff4ce69af1e31c67c65d1177a52169082b"
  end
  resource "File::MimeInfo" do
    url "https://cpan.metacpan.org/authors/id/M/MI/MICHIELB/File-MimeInfo-0.28.tar.gz"
    sha256 "2a245db46f9aef7481d90b4e196a4d42a238e15f049f57fc1339c0b98681ebc6"
  end
  resource "IPC::System::Simple" do
    url "https://cpan.metacpan.org/authors/id/P/PJ/PJF/IPC-System-Simple-1.25.tar.gz"
    sha256 "f1b6aa1dfab886e8e4ea825f46a1cbb26038ef3e727fef5d84444aa8035a4d3b"
  end
  resource "File::Which" do
    url "https://cpan.metacpan.org/authors/id/P/PL/PLICEASE/File-Which-1.22.tar.gz"
    sha256 "e8a8ffcf96868c6879e82645db4ff9ef00c2d8a286fed21971e7280f52cf0dd4"
  end
  resource "File::DesktopEntry" do
    url "https://cpan.metacpan.org/authors/id/M/MI/MICHIELB/File-DesktopEntry-0.22.tar.gz"
    sha256 "169c01e3dae2f629767bec1a9f1cdbd6ec6d713d1501e0b2786e4dd1235635b8"
  end
  resource "URI::Escape" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/URI-1.72.tar.gz"
    sha256 "35f14431d4b300de4be1163b0b5332de2d7fbda4f05ff1ed198a8e9330d40a32"
  end
  resource "Test::Needs" do
    url "https://cpan.metacpan.org/authors/id/H/HA/HAARG/Test-Needs-0.002005.tar.gz"
    sha256 "5a4f33983586edacdbe00a3b429a9834190140190dab28d0f873c394eb7df399"
  end
  resource "Glib::Object::Introspection" do
    url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-Object-Introspection-0.044.tar.gz"
    sha256 "093c47141db683bf8dcbf1c3e7b2ece2b2b5488739197b8b623f50838eb7e734"
  end
  resource "Gtk3" do
    url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/Gtk3-0.033.tar.gz"
    sha256 "e18c9c4d860cf29c9b0fe9d2e2c6d342646c179f4dd7d787b3d0183932e10e93"
  end
  resource "Cairo::GObject" do
    url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/Cairo-GObject-1.004.tar.gz"
    sha256 "3bb9d40e802e51f56f1364abc553758152131803c12d85ba6e14bad6813409d5"
  end
  resource "Cairo" do
    url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/Cairo-1.106.tar.gz"
    sha256 "e64803018bc7cba49e73e258547f5378cc4249797beafec524852140f49c45c4"
  end
  resource "Glib" do
    url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/Glib-1.326.tar.gz"
    sha256 "020d0308220cb6e03a086bd45d33dd8fe03b265c502bfc2b4e58f2dbe64c365f"
  end
  resource "ExtUtils::PkgConfig" do
    url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-PkgConfig-1.16.tar.gz"
    sha256 "bbeaced995d7d8d10cfc51a3a5a66da41ceb2bc04fedcab50e10e6300e801c6e"
  end
  resource "ExtUtils::Depends" do
    url "https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-Depends-0.405.tar.gz"
    sha256 "8ad6401ad7559b03ceda1fe4b191c95f417bdec7c542a984761a4656715a8a2c"
  end
  resource "Locale::gettext" do
    url "https://cpan.metacpan.org/authors/id/P/PV/PVANDRY/gettext-1.07.tar.gz"
    sha256 "909d47954697e7c04218f972915b787bd1244d75e3bd01620bc167d5bbc49c15"
  end
  resource "Module::Load::Conditional" do
    url "https://cpan.metacpan.org/authors/id/B/BI/BINGOS/Module-Load-Conditional-0.68.tar.gz"
    sha256 "7627b55cd94a2f1a4667f9203e2c990cad015bf34ec6b41b4f73af848f0698fd"
  end
  resource "OpenOffice::OODoc" do
    url "https://cpan.metacpan.org/authors/id/J/JM/JMGDOC/OpenOffice-OODoc-2.125.tar.gz"
    sha256 "c11448970693c42a8b9e93da48cac913516ce33a9d44a6468400f7ad8791dab6"
  end
  resource "XML::Twig" do
    url "https://cpan.metacpan.org/authors/id/M/MI/MIROD/XML-Twig-3.52.tar.gz"
    sha256 "fef75826c24f2b877d0a0d2645212fc4fb9756ed4d2711614ac15c497e8680ad"
  end
  resource "XML::Parser" do
    url "https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.44.tar.gz"
    sha256 "1ae9d07ee9c35326b3d9aad56eae71a6730a73a116b9fe9e8a4758b7cc033216"
  end
  resource "LWP::UserAgent" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/libwww-perl-6.31.tar.gz"
    sha256 "525d5386d39d1c1d7da8a0e9dd0cbab95cba2a4bfcfd9b83b257f49be4eecae3"
  end
  resource "Test::RequiresInternet" do
    url "https://cpan.metacpan.org/authors/id/M/MA/MALLEN/Test-RequiresInternet-0.05.tar.gz"
    sha256 "bba7b32a1cc0d58ce2ec20b200a7347c69631641e8cae8ff4567ad24ef1e833e"
  end
  resource "Image::Magick" do
    url "https://cpan.metacpan.org/authors/id/J/JC/JCRISTY/PerlMagick-6.89-1.tar.gz"
    sha256 "c8f81869a4f007be63e67fddf724b23256f6209f16aa95e14d0eaef283772a59"
  end
  resource "Text::CSV" do
    url "https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/Text-CSV-1.95.tar.gz"
    sha256 "7e0a11d9c1129a55b68a26aa4b37c894279df255aa63ec8341d514ab848dbf61"
  end
  resource "XML::Simple" do
    url "https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.24.tar.gz"
    sha256 "9a14819fd17c75fbb90adcec0446ceab356cab0ccaff870f2e1659205dc2424f"
  end
  resource "XML::SAX::Expat" do
    url "https://cpan.metacpan.org/authors/id/B/BJ/BJOERN/XML-SAX-Expat-0.51.tar.gz"
    sha256 "4c016213d0ce7db2c494e30086b59917b302db8c292dcd21f39deebd9780c83f"
  end
  resource "HTTP::Status" do
    url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Message-6.14.tar.gz"
    sha256 "71aab9f10eb4b8ec6e8e3a85fc5acb46ba04db1c93eb99613b184078c5cf2ac9"
  end
  resource "LWP::MediaTypes" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/LWP-MediaTypes-6.02.tar.gz"
    sha256 "18790b0cc5f0a51468495c3847b16738f785a2d460403595001e0b932e5db676"
  end
  resource "Encode::Locale" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/Encode-Locale-1.05.tar.gz"
    sha256 "176fa02771f542a4efb1dbc2a4c928e8f4391bf4078473bd6040d8f11adb0ec1"
  end
  resource "IO::HTML" do
    url "https://cpan.metacpan.org/authors/id/C/CJ/CJM/IO-HTML-1.001.tar.gz"
    sha256 "ea78d2d743794adc028bc9589538eb867174b4e165d7d8b5f63486e6b828e7e0"
  end
  resource "URI" do
    url "https://cpan.metacpan.org/authors/id/E/ET/ETHER/URI-1.72.tar.gz"
    sha256 "35f14431d4b300de4be1163b0b5332de2d7fbda4f05ff1ed198a8e9330d40a32"
  end
  resource "HTTP::Date" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/HTTP-Date-6.02.tar.gz"
    sha256 "e8b9941da0f9f0c9c01068401a5e81341f0e3707d1c754f8e11f42a7e629e333"
  end
  resource "File::Listing" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/File-Listing-6.04.tar.gz"
    sha256 "1e0050fcd6789a2179ec0db282bf1e90fb92be35d1171588bd9c47d52d959cf5"
  end
  resource "HTTP::Daemon" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/HTTP-Daemon-6.01.tar.gz"
    sha256 "43fd867742701a3f9fcc7bd59838ab72c6490c0ebaf66901068ec6997514adc2"
  end
  resource "HTML::Tagset" do
    url "https://cpan.metacpan.org/authors/id/P/PE/PETDANCE/HTML-Tagset-3.20.tar.gz"
    sha256 "adb17dac9e36cd011f5243881c9739417fd102fce760f8de4e9be4c7131108e2"
  end
  resource "HTTP::Cookies" do
    url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Cookies-6.04.tar.gz"
    sha256 "0cc7f079079dcad8293fea36875ef58dd1bfd75ce1a6c244cd73ed9523eb13d4"
  end
  resource "WWW::RobotRules" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/WWW-RobotRules-6.02.tar.gz"
    sha256 "46b502e7a288d559429891eeb5d979461dd3ecc6a5c491ead85d165b6e03a51e"
  end
  resource "HTTP::Negotiate" do
    url "https://cpan.metacpan.org/authors/id/G/GA/GAAS/HTTP-Negotiate-6.01.tar.gz"
    sha256 "1c729c1ea63100e878405cda7d66f9adfd3ed4f1d6cacaca0ee9152df728e016"
  end
  resource "Net::HTTP" do
    url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/Net-HTTP-6.17.tar.gz"
    sha256 "1e8624b1618dc6f7f605f5545643ebb9b833930f4d7485d4124aa2f2f26d1611"
  end
  resource "XML::Writer" do
    url "https://cpan.metacpan.org/authors/id/J/JO/JOSEPHW/XML-Writer-0.625.tar.gz"
    sha256 "e080522c6ce050397af482665f3965a93c5d16f5e81d93f6e2fe98084ed15fbe"
  end
  resource "Desktop::Notify" do
    url "https://cpan.metacpan.org/authors/id/S/SA/SACAVILIA/Desktop-Notify-0.05.tar.gz"
    sha256 "5ec52aa13387a6819402554b74997830954aa5e908a711eb8bb19dd3334b101d"
  end

  def install
    installed = {} # helps me avoid installing the same perl package twice
    # Also install pdftk-server. I took the recipe from a github PR:
    # https://github.com/Homebrew/homebrew-binary/pull/344
    resource("pdftk").stage do
      system "pax", "-rz", "-f", "pdftk.pkg/Payload"
      libexec.install "bin", "man", "lib"
      # bin.install_symlink libexec/"bin/pdftk"
      # man1.install Dir[libexec/"man/*"]
    end

    ENV.prepend_path "PATH", "#{Formula["gnu-sed"].libexec}/gnubin" # used in build
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PATH", Formula["gettext"].bin # for msgfmt during build

    # For many non-problematic packages, we can simply use cpan. I disabled
    # the tests with '-T' because they take so much time.
    # For packages with problems, we install them manually.
    ENV["PERL_MM_OPT"] = "INSTALL_BASE=#{libexec}" # for cpan (Makefile.PL)
    ENV["PERL_MB_OPT"] = "--install_base '#{libexec}'" # for cpan (Build.PL)
    ENV["PERL_MM_USE_DEFAULT"] = "1" # for preventing cpan from asking questions
    ENV.prepend_path "PKG_CONFIG_PATH", "#{Formula["libffi"].opt_lib}/pkgconfig" # for Glib::Object::Introspection

    if build.with? "doc"
      # Because of bug with sed (GNU/non-GNU?) the .tex files have a missing '\'
      # ('usepackage{xeCJK}' instead of '\usepackage{xeCJK}').
      inreplace "doc/Makefile", "\\\\usepackage{xeCJK}", "\\\\\\usepackage{xeCJK}"
      ENV.prepend_path "PATH", buildpath/"bin" # for using 'dblatex' during build
      ENV.prepend_create_path "TEXMFHOME", buildpath/"texmf"
      ENV.prepend_path "PATH", buildpath/"bin" # for dblatex during the build
      resource("dblatex").stage do
        # The 'dblatex' python script is only useful during build. Requires XML::LibXML.
        system "python", "setup.py", "install", "--prefix=#{buildpath}", "--install-scripts=#{buildpath}/bin"
        # The dblatex tarball also contains latex .sty files that we need.
        mkdir_p buildpath/"texmf/tex/latex/dblatex"
        mv Dir[buildpath/"share/dblatex/latex/{style,misc}/*"], buildpath/"texmf/tex/latex/dblatex"
      end
    else
      inreplace "Makefile" do |s|
        s.gsub! /^install:(.*)install_doc(.*)/, 'install: \1 \2'
        s.gsub! /FROM_IN *=.*/, "FROM_IN = auto-multiple-choice $(GLADE_FROMIN) AMC-gui.pl AMC-latex-link.pl AMC-perl/AMC/Basic.pm $(DTX)"
        s.gsub! /^(all:.*) doc (.*)$/, '\1 \2'
        s.gsub! /.*\$\(STY\).*/, ""
      end
    end
    # Make sure we do not miss any silent error by setting 'set -e'.
    inreplace "doc/Makefile", "export TEXINPUTS=", "set -e; export TEXINPUTS="
    inreplace ["Makefile-macports.conf"] do |s|
      s.gsub! /PERLPATH=.*/, "PERLPATH=#{Formula["perl"].bin}/perl"
      s.gsub! /PERLDIR=.*/, "PERLDIR=#{libexec/"lib/perl5"}"
      s.gsub! "DIR=$(BASEPATH)", "DIR=$(PREFIX)"
      s.gsub! "$(BASEPATH)", "$(LIBS_PREFIX)"
      s.gsub! /DOCBOOK_MAN_XSL *=.*/, "DOCBOOK_MAN_XSL = #{Formula["docbook-xsl"].prefix}/docbook-xsl/manpages/docbook.xsl"
      s.gsub! /DOCBOOK_XHTML_XSL *=.*/, "DOCBOOK_XHTML_XSL = #{Formula["docbook-xsl"].prefix}/docbook-xsl/xhtml/docbook.xsl"
      s.gsub! /DOCBOOK_DTD *=.*/, "DOCBOOK_DTD = #{Formula["docbook"].prefix}/docbook/xml/4.5/docbookx.dtd"
    end
    # I had issues with _cvConvertImage not being found (opencv). Actually,
    # opencv >= 3.1.0 moved cvConvertImage from libopencv_highgui to
    # libopencv_imgcodecs. So we have to add -lopencv_imgcodecs.
    # See https://stackoverflow.com/questions/27552217/cvloadimage-undefined-symbols-linking-issue
    inreplace "Makefile-macports.conf", /GCC_OPENCV_LIBS.*=/, "GCC_OPENCV_LIBS = -lopencv_imgcodecs "
    inreplace ["doc/Makefile","doc/sty/Makefile"], "pdflatex", "pdflatex -halt-on-error -interaction=nonstopmode"
    inreplace ["doc/Makefile"], "xelatex", "xelatex -halt-on-error -interaction=nonstopmode"

    # Now we need to install XML::LibXML which is used during the build
    [ "XML::LibXML",
        "XML::SAX",
          "XML::NamespaceSupport",
          "XML::SAX::Base"
    ].reverse.each do |r|
      install_perl_package(r, installed)
    end

    # The actual build
    system "make", "version_files", "AMCCONF=macports", "PREFIX=#{prefix}", "LIBS_PREFIX=#{HOMEBREW_PREFIX}"
    system "make", "AMCCONF=macports", "PREFIX=#{prefix}", "LIBS_PREFIX=#{HOMEBREW_PREFIX}"
    system "make", "install", "AMCCONF=macports", "PREFIX=#{prefix}", "LIBS_PREFIX=#{HOMEBREW_PREFIX}"

    mv bin/"auto-multiple-choice", libexec/"bin/auto-multiple-choice"
    (bin/"auto-multiple-choice").write_env_script libexec/"bin/auto-multiple-choice",
        :PERL5LIB => ENV["PERL5LIB"],
        :TEXMFHOME => share/"texmf-local",
        :PATH => libexec/"bin:$PATH"

    # WARNING: when installing Cairo, make test won't pass because of a
    # (likely) bug in the count of tests skipped (Test::More); there is a
    # 'Bad plan' error.

    # WARNING: with perl v5.26.1 and Pango-1.227, 'perl Makefile.PL' segfaults.
    # In the following list, the dependency tree is given by identations.
    # Also, this list is installed from the bottom to the top.

    [
      # Here are all the perl dependencies that we will vendor (= install locally
      # only for this recipe):
      # - Archive::Zip
      # - Clone
      # - DBD::SQLite
      # - Digest::MD5
      # - Email::MIME
      # - Email::Sender
      # - File::BaseDir
      # - File::MimeInfo
      # - Glib::Object::Introspection
      # - Gtk3
      # - Locale::Gettext
      # - Module::Load::Conditional
      # - OpenOffice::OODoc
      # - Image::Magick
      # - Text::CSV
      # - XML::Simple
      # - XML::Writer
      # - Desktop::Notify (not in the macports deps??)

      # 1) To create the following array with a hierarchy-like indentation,
      #    I went to http://deps.cpantesters.org for each package and copied
      #    the resulting table with the dependency hierarchy and used:
      # cat deps_archive_zip | sed 's/-\t//g' | sed '/^.*Core module.*$/d' | \
      #     sed 's/^\(.*\)  Bugreports.*$/\1/g' | sed 's/[ \t]*$//g' | \
      #     sed 's/^\( *\)\([^ ]*\)$/\1"\2",/g' | sed 's/ "/"/g' | sed 's/    /  /g'

      # 2) From this array, I create the 'resource ... do ... end' using:
      #    ./list_to_resources.pl < ruby_list > resources
      #    The code of "list_to_resources.pl" is showed at the end of this file.


      # Note that duplicates are allowed; only the first package from the
      # bottom will be installed.
      "Archive::Zip",
        "Test::MockModule",
          "Module::Build",
          "SUPER",
            "Sub::Identify",
      "Clone",
      "DBD::SQLite",
        "DBI",
      "Digest::MD5",
      "Email::MIME",
        "Email::Simple::Creator",
          "Email::Date::Format",
        "Module::Runtime",
          "Module::Build",
        "Email::MessageID",
        "MIME::Types",
        "Email::Address::XS",
        "Email::MIME::Encodings",
          "Capture::Tiny",
        "Email::MIME::ContentType",
      "Email::Sender",
        "Capture::Tiny",
        "Sub::Exporter",
          "Params::Util",
          "Data::OptList",
            "Sub::Install",
        "MooX::Types::MooseLike::Base",
          "Test::Fatal",
            "Try::Tiny",
          "Module::Runtime",
            "Module::Build",
          "Moo",
            "Role::Tiny",
            "Sub::Defer",
            "Class::Method::Modifiers",
              "Test::Requires",
            "Devel::GlobalDestruction",
              "Sub::Exporter::Progressive",
        "Email::Abstract",
          "Email::Simple",
            "Email::Date::Format",
          "MRO::Compat",
          "Module::Pluggable",
        "Throwable::Error",
          "Devel::StackTrace",
        "Email::Address",
      "File::BaseDir",
      "File::MimeInfo",
        "File::BaseDir",
          "IPC::System::Simple",
          "File::Which",
          "Module::Build",
        "File::DesktopEntry",
          "URI::Escape",
            "Test::Needs",
      "Glib::Object::Introspection",
      "Gtk3",
        "Glib::Object::Introspection",
        "Cairo::GObject",
          "Cairo", # requires Glib
          "Glib",
            "ExtUtils::PkgConfig",
          "ExtUtils::Depends",
      "Locale::gettext",
      "Module::Load::Conditional",
      "OpenOffice::OODoc",
        "Archive::Zip",
          "Test::MockModule",
            "Module::Build",
            "SUPER",
              "Sub::Identify",
        "XML::Twig",
          "XML::Parser",
            "LWP::UserAgent",
              "Test::RequiresInternet",
      "Image::Magick",
      "Text::CSV",
      "XML::Simple",
        "XML::SAX",
          "XML::NamespaceSupport",
          "XML::SAX::Base",
        "XML::SAX::Expat",
          "XML::Parser",
            "LWP::UserAgent",
              "Test::RequiresInternet",
              "HTTP::Status",
              "LWP::MediaTypes",
                "Encode::Locale",
                "IO::HTML",
                "URI",
                "Test::Needs",
              "HTTP::Date",
              "File::Listing",
                "HTTP::Daemon",
                "HTML::Tagset",
              "HTTP::Cookies",
              "WWW::RobotRules",
              "HTTP::Negotiate",
              "Net::HTTP",
      "XML::Writer",
      "Desktop::Notify"
    ].reverse.each do |r|
      install_perl_package(r, installed)
    end
  end

  test do
    # Test à écrire
    system "false"
  end

  def install_perl_package(package, installed)
    if installed[package].nil?
      installed[package] = true
      resource(package).stage do
        if package == "XML::SAX" || package == "XML::SAX::Expat"
          # XML::SAX and XML::SAX::Expat have a race condition during
          # 'make install'.  Workaround proposed: unset the MAKEFLAGS variable
          # before installing.
          # See: https://github.com/miyagawa/cpanminus/issues/31
          system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}", "INSTALLMAN1DIR=none", "INSTALLMAN3DIR=none"
          system "make"
          ENV.deparallelize do # it basically unsets MAKEFLAGS
            system "make", "install"
          end
        elsif package == "XML::LibXML"
          # XML::LibXML is only used during build.
          # It needs to be given XMLPREFIX (= path to libxml2).
          system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}", "INSTALLMAN1DIR=none", "INSTALLMAN3DIR=none", "XMLPREFIX=#{Formula["libxml2"].prefix}"
          system "make"
          system "make", "install"
        elsif package == "Locale::gettext"
          # I read this: https://gist.github.com/andyjack/a2d8684c13d81adbba6ca550a8d9f54b
          ENV["CC"] = "#{ENV["CC"]} -I#{Formula["gettext"].include} -L#{Formula["gettext"].lib}"
          system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}", "INSTALLMAN1DIR=none", "INSTALLMAN3DIR=none"
          inreplace "Makefile", /CCCDLFLAGS *=/, "CCCDLFLAGS = -I#{Formula["gettext"].include}"
          inreplace "Makefile", /LDDLFLAGS *=/, "LDDLFLAGS = -L#{Formula["gettext"].lib}"
          system "make"
          system "make", "install"
        elsif package == "Image::Magick"
          system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}", "INSTALLMAN1DIR=none", "INSTALLMAN3DIR=none", "INC=-I#{Formula["imagemagick@6"].include}/ImageMagick-6", "LIBS=-L#{Formula["imagemagick@6"].lib}"
          inreplace "Makefile", /CCCDLFLAGS *=/, "CCCDLFLAGS = -I#{Formula["imagemagick@6"].include}/ImageMagick-6"
          inreplace "Makefile", /LDDLFLAGS *=/, "LDDLFLAGS = -L#{Formula["gettext"].lib}"
          system "make"
          system "make", "install"

        elsif File.exist? "Makefile.PL"
          system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}", "INSTALLMAN1DIR=none", "INSTALLMAN3DIR=none"
          system "make"
          system "make", "install"
        elsif File.exist? "Build.PL"
          system "perl", "Build.PL", "--install_base", libexec
          system "./Build"
          system "./Build", "install"
        else
          raise "Unknown build system for #{r.name}"
        end
      end
    end
  end

  def caveats
    mactex_texmf_home = begin %x{kpsewhich -var-value=TEXMFHOME}.chomp; rescue; end
    if mactex_texmf_home.nil? then mactex_texmf_home = "<Mactex TEXMFHOME path>" end
    s = <<~EOS
      In order to build latex files with \\usepackage{automultiplechoice},
      you will have to install the .sty files to your Mactex path using
      a symlink (you may need to add 'sudo' but try without):

          mkdir -p #{mactex_texmf_home}/tex/latex/AMC
          ln -s #{opt_share}/texmf-local/tex/latex/AMC/automultiplechoice.sty #{mactex_texmf_home}/tex/latex/AMC/automultiplechoice.sty

      If you don't already have Mactex, you can install it (3GB) using:

          brew cask install mactex

      You will also need the font Linux Libertine font in order to annotate
      the papers (AMC-annotate.pl):

          brew cask install caskroom/fonts/font-linux-libertine

      Documentation (PDF, HTML) is available here:

          https://www.auto-multiple-choice.net/doc
    EOS
    s
  end

  def find_mactex
    ["/Library/TeX/texbin", "/usr/texbin"].each do |path|
      break path if File.executable?(path+"/kpsewhich")
    end
  end
end

# ./list_to_resources.pl:
#################################################################
# #!/usr/bin/env perl
# # Lines must be of form (spaces and the comma are ignored):
# #     "XML::Simple",
# use MetaCPAN::Client;
# my $mcpan  = MetaCPAN::Client->new();
# my %already_seen = ();
# foreach $line ( <STDIN> ) {
#     chomp($line);
#     $line =~ s/^.*"([A-Za-z:0-9]*)".*$/\1/;
#     my $package = $mcpan->package($line);
#     if (! exists($already_seen{$line})) {
#         $already_seen{$line} = 1;
#         my $url = "https://cpan.metacpan.org/authors/id/".$package->file();
#         chomp(my $sha256 = `curl -sSL $url | sha256sum | cut -d' ' -f1`);
#         print "resource \"$line\" do\n";
#         print "  url \"".$url."\"\n";
#         print "  sha256 \"".$sha256."\"\n";
#         print "end\n";
#     }
# }
