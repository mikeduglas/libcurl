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
v1.62
- FIX: Changed SELF.SetOpt(CURLOPT_URL, url) calls to SELF.SetUrl(url) which uses CURLUPART_URL instead of CURLOPT_URL.

v1.61
- FIX: Subsequent TCurlClass.SetUrl calls could set incorrect url.
- NEW: TCurlUrlApiClass.RemovePart method.
- CHG: TCurlHttpClass uses 'http' default protocol.

v1.60
- FIX: TCurlMailClass: incorrect encoding from Chinese to utf8 (email subject/body).

v1.59 (libcurl.tpl fix)
- FIX: "Unknown identifier: XFERPROC" in template generated code if base class is TCurlFtpClass.

v1.59
- FIX: TCurlFtpClass.ReadFile now accepts (optional) pWildcardMatching argument. If you use [FTP wildcard matching](https://everything.curl.dev/libcurl/callbacks/ftpmatch) then call curl.ReadFile(remoteFile, localFile, true).
This change should fix endless downloading bug in recent curl builds.

v1.58
- CHG: Now uses libcurl v8.1.2, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 8.1.2 was built and statically linked with
> 
> * brotli 1.0.9
> * cacert 2023-05-30
> * gsasl 2.2.0
> * libssh2 1.11.0
> * nghttp2 1.53.0
> * nghttp3 0.11.0
> * ngtcp2 0.15.0
> * quictls 3.1.0
> * zlib 1.2.13
> * zstd 1.5.5

- FIX: TCurlClass.SetUserPwd method now allows blank password, in this case "username:" is passed as CURLOPT_USERPWD option value.
  

[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)
