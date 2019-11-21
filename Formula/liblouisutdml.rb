class Liblouisutdml < Formula
  desc "Braille  transcription services for xml, html and text documents"
  homepage "http://liblouis.org"
  url "https://github.com/liblouis/liblouisutdml/releases/download/v2.8.0/liblouisutdml-2.8.0.tar.gz"
  sha256 "97f0ecb0182f51891704bf545c92e3cc705735e86edb9b2de74027ce167760a6"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/tamaracha/bottles-liblouis"
    sha256 "02195fdb162556def015ab1007e5a5ced482bda7a0527992f313350b6388653b" => :mojave
  end

  depends_on "ant" => :build
  depends_on "help2man" => :build
  depends_on "pkg-config" => :build
  depends_on "liblouis"
  uses_from_macos "libxml2"

  patch :DATA

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
__END__
diff --git a/java/build.xml b/java/build.xml
index 437f32a..a57c9d5 100644
--- a/java/build.xml
+++ b/java/build.xml
@@ -34,7 +34,7 @@
   </target>
   <target name="compile" depends="init">
     <javac srcdir="${src}" destdir="${build}"
-        includeantruntime="false" source="1.6" target="1.6">
+        includeantruntime="false" source="1.8" target="1.8">
     </javac>
   </target>
   <target name="dist" depends="compile">
@@ -44,7 +44,7 @@
   </target>
   <target name="testCompile" depends="testInit, compile">
     <javac srcdir="${test.src}" destdir="${test.build}"
-        includeantruntime="false" source="1.6" target="1.6" 
+        includeantruntime="false" source="1.8" target="1.8" 
         classpathref="test_cp"/>
   </target>
   <target name="test" depends="testCompile">
