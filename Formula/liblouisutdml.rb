class Liblouisutdml < Formula
  desc "Braille  transcription services for xml, html and text documents"
  homepage "http://liblouis.org"
  url "https://github.com/liblouis/liblouisutdml/releases/download/v2.8.0/liblouisutdml-2.8.0.tar.gz"
  sha256 "97f0ecb0182f51891704bf545c92e3cc705735e86edb9b2de74027ce167760a6"

  bottle do
    root_url "https://dl.bintray.com/tamaracha/bottles-liblouis"
    rebuild 1
    sha256 "d19ebd0a4c1e3dfc76ed2897cdcc4d6b4b576d87f5cb818af8e674f8fbbeb992" => :catalina
  end

  depends_on "ant" => :build
  depends_on "help2man" => :build
  depends_on "pkg-config" => :build
  depends_on "liblouis"
  uses_from_macos "libxml2"

  def install
    ENV["CFLAGS"] = "-I/System/Library/Frameworks/JavaVM.framework/Headers"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    cd "java" do
      system "ant"
      mkdir "#{prefix}/java"
      mv "jliblouisutdml.jar", "#{prefix}/java/", :force => true
    end
  end

  test do
    (testpath/"input.txt").write("Lorem ipsum")
    system bin/"file2brl", "input.txt", "output.brl"
    assert_predicate testpath/"output.brl", :exist?
  end
end
