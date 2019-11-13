class Liblouisutdml < Formula
  desc "Braille  transcription services for xml, html and text documents"
  homepage "http://liblouis.org"
  url "https://github.com/liblouis/liblouisutdml/releases/download/v2.8.0/liblouisutdml-2.8.0.tar.gz"
  sha256 "97f0ecb0182f51891704bf545c92e3cc705735e86edb9b2de74027ce167760a6"

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
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test liblouisutdml`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
