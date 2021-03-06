require 'formula'

class Mimms < Formula
  homepage 'http://savannah.nongnu.org/projects/mimms'
  url 'https://launchpad.net/mimms/trunk/3.2.1/+download/mimms-3.2.1.tar.bz2'
  sha1 '279eee76dd4032cd2c1dddf1d49292a952c57b80'

  depends_on :python
  depends_on 'libmms'

  # Switch shared library loading to Mach-O naming convention (.dylib)
  # Matching upstream bug report: http://savannah.nongnu.org/bugs/?29684
  # Fix installation path for man page to $(brew --prefix)/share/man
  def patches
    DATA
  end

  def install
    python do
      system python, "setup.py", "install", "--prefix=#{prefix}"
    end
  end

  def caveats
    python.standard_caveats if python
  end

  test do
    python do
      system "#{bin}/mimms", "--version"
    end
  end
end

__END__
diff --git a/libmimms/libmms.py b/libmimms/libmms.py
index fb59207..ac42ba4 100644
--- a/libmimms/libmms.py
+++ b/libmimms/libmms.py
@@ -23,7 +23,7 @@ exposes the mmsx interface, since this one is the most flexible.
 
 from ctypes import *
 
-libmms = cdll.LoadLibrary("libmms.so.0")
+libmms = cdll.LoadLibrary("libmms.0.dylib")
 
 # opening and closing the stream
 libmms.mmsx_connect.argtypes = [c_void_p, c_void_p, c_char_p, c_int]
