class Liblouis < Formula
  desc "Open-source braille translator and back-translator."
  homepage "http://liblouis.org"

  option "with-ucs4", "Enable 4 byte-wide characters"
  option "with-python", "compile with Python bindings"

  stable do
    url "https://github.com/liblouis/liblouis/releases/download/v3.11.0/liblouis-3.11.0.tar.gz"
    sha256 "b802aba0bff49636907ca748225e21c56ecf3f3ebc143d582430036d4d9f6259"
    depends_on "pkg-config" => :build
    depends_on "python" => :optional
  end
  head do
    url "https://github.com/liblouis/liblouis.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "Libtool" => :build
    depends_on "pkg-config" => :build
    depends_on "python" => :optional
  end

  def install
    if build.head?
      system "./autogen.sh"
    end
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--disable-silent-rules",
            "--prefix=#{prefix}"]
    args << "--enable-ucs4" if build.with? "ucs4"
    system "./configure", *args
    system "make"
    system "make check"
    system "make install"
    if build.with? "python"
      cd "python" do
        system "python3", *Language::Python.setup_install_args(prefix)
      end
    end
  end

  test do
    o, s = Open3.capture2(bin/"lou_translate", "unicode.dis,de-g2.ctb", :stdin_data=>"42")
    assert_equal o, "⠼⠙⠃"
  end
end
