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
- NEW: All CURLOPT_xxx options from curl.h are declared.

v1.52
- NEW: for option CURLOPT_SSL_OPTIONS new equates defined: CURLSSLOPT_NO_PARTIALCHAIN, CURLSSLOPT_NATIVE_CA, CURLSSLOPT_AUTO_CLIENT_CERT.

v1.51 **experimental**
- CHG: removed printf dependency.
- FIX: recent libcurl.dll builds throw "Bad/illegal format or missing URL" error if an uri contains the characters which must be encoded (space, ampersand and so on).  
**Any feedback is much appreciated!**

v1.50
- CHG: Now uses libcurl v7.80.0, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 7.80.0 was built and statically linked with
> 
> * OpenSSL 3.0.0
> * brotli 1.0.9
> * libgsasl 1.10.0
> * libidn2 2.3.2
> * libssh2 1.10.0
> * nghttp2 1.46.0
> * zlib 1.2.11
> * zstd 1.5.0
- CHG: Removed libcrypto-1_1.dll and libssl-1_1.dll from BIN folder.
- NEW: curl::url:StrError(CURLUcode): turns a CURLUcode value into the equivalent human readable error string. This is useful for printing meaningful error messages.  
- CHG: libcurldropbox.clw depends on [printf project](https://github.com/mikeduglas/printf).

v1.49
- FIX: The length of TCurlDropboxClass._accessToken increased to 1024 characters.
  

[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)
