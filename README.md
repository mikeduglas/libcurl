# libcurl
libcurl for Clarion

## Required C6.3 and newer.

[libcurl home page](https://curl.haxx.se/libcurl/)  
[changelog](https://curl.haxx.se/changes.html)  
[FAQ](https://github.com/mikeduglas/libcurl/tree/master/doc/faq.md)  
[Forum](https://clarionhub.com/t/libcurl-faq-https-github-com-mikeduglas-libcurl/1965)  
[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)  
[Clarion 6.3 examples](https://github.com/mikeduglas/libcurl/tree/master/examples/C6.3%20apps). Last update 2018-12-16.  


## How to install
Hit the 'Clone or Download' button and select 'Download Zip'.
Now unzip libcurl-master.zip into a temporary folder somewhere.

Copy the contents of...

Bin into %ClarionRoot%\Accessory\bin  
Lib into %ClarionRoot%\Accessory\lib  
Libsrc into %ClarionRoot%\Accessory\libsrc\win  
Template into %ClarionRoot%\Accessory\template\win  

Where %ClarionRoot% is the folder into which you installed Clarion 10.

Now, with no APPs or DCTs loaded in the Clarion IDE, register the libcurl template by selecting...
Clarion main menu - Tools - 'Edit Template Registry' - click on 'Register' and use the dialog to navigate to %ClarionRoot%\Accessory\template\win and double-click on libcurl.tpl and click 'Open'.

You should see 'Class LibcurlTpl - Libcurl template' and the LibcurlGloExt and LibcurlLocExt templates are now in the list.
Click on the Save icon 'floppy disk' and the Green arrow to close.


## Recent changes
v1.55
- CHG: Now uses libcurl v7.85.0, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 7.85.0_5 was built and statically linked with
> 
> brotli 1.0.9
> gsasl 2.2.0
> libssh2 1.10.0
> nghttp2 1.50.0
> nghttp3 0.7.1
> ngtcp2 0.9.0
> openssl-quic 3.0.5
> zlib 1.2.12
> zstd 1.5.2
> 
> The following tools/compilers were used in the build process:
> 
> clang 14.0.6
> clang 15.0.0 (ARM64)
> curl-for-win bce14879
> llvm-mingw 20220906 (ARM64)
> mingw-w64 10.0.0-2

- NEW: CURLE_XX codes (93..99).
- NEW: CURLINFO enum values: CURLINFO_CAINFO and CURLINFO_CAPATH.
- NEW: GetDefaultCAInfo() and GetDefaultCAPath() methods.

v1.54
- CHG: Added "ONCE" to all INCLUDE statements.

v1.53
- CHG: Now uses libcurl v7.83.0, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 7.83.0 was built and statically linked with
> 
> * OpenSSL 3.0.2
> * brotli 1.0.9
> * libgsasl 1.10.0
> * libidn2 2.3.2
> * libssh2 1.10.0
> * nghttp2 1.47.0
> * zlib 1.2.12
- CHG: All CURLOPT_* options from curl.h are declared.
- CHG: Missing CURLINFO_* constants added.

v1.52
- NEW: for option CURLOPT_SSL_OPTIONS new equates defined: CURLSSLOPT_NO_PARTIALCHAIN, CURLSSLOPT_NATIVE_CA, CURLSSLOPT_AUTO_CLIENT_CERT.

v1.51 **experimental**
- CHG: removed printf dependency.
- FIX: recent libcurl.dll builds throw "Bad/illegal format or missing URL" error if an uri contains the characters which must be encoded (space, ampersand and so on).  
**Any feedback is much appreciated!**
  

[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)
