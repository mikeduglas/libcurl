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
v1.67
- CHG: TCurlMailClass.AddAttachment now accepts pRemoteName omittable parameter.

v1.66
- CHG: Now uses libcurl v8.11.0_1, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 8.11.0_1 was built and statically linked with
> 
> * brotli 1.1.0
> * cacert 2024-09-24
> * curl 8.11.0
> * libpsl 0.21.5
> * libressl 4.0.0
> * libssh2 1.11.1
> * nghttp2 1.64.0
> * nghttp3 1.6.0
> * ngtcp2 1.8.1
> * zlib 1.3.1
> * zstd 1.5.6
- NEW: 8 new CURLINFO_xxx equates defined.
- CHG: TCurlWebsocketClass cosmetic changes.

v1.65
- CHG: Now uses libcurl v8.9.1_1, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 8.9.1_1 was built and statically linked with
> 
> * brotli 1.1.0
> * cacert 2024-07-02
> * curl 8.9.1
> * libpsl 0.21.5
> * libressl 3.9.2
> * libssh2 1.11.0
> * nghttp2 1.62.1
> * nghttp3 1.4.0
> * ngtcp2 1.6.0
> * zlib 1.3.1
> * zstd 1.5.6
- FIX: (Regression) Explicit scheme was overwritten with the default protocol.  

v1.64
- FIX: If an url was set without a scheme (for example "smtp.gmail.com") then the default "HTTPS" scheme was used.

v1.63
- CHG: Now uses libcurl v8.4.0, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 8.4.0_6 was built and statically linked with
> 
> * brotli 1.1.0
> * cacert 2023-08-22
> * libssh2 1.11.0
> * nghttp2 1.58.0
> * nghttp3 1.0.0
> * ngtcp2 1.0.1
> * quictls 3.1.4
> * zlib 1.3
> * zstd 1.5.5
- NEW: New equates added.
- FIX: CURLU_DEFAULT_PORT equate had a wrong value.

v1.62
- FIX: Changed SELF.SetOpt(CURLOPT_URL, url) calls to SELF.SetUrl(url) which uses CURLUPART_URL instead of CURLOPT_URL.

v1.61
- FIX: Subsequent TCurlClass.SetUrl calls could set incorrect url.
- NEW: TCurlUrlApiClass.RemovePart method.
- CHG: TCurlHttpClass uses 'http' default protocol.

v1.60
- FIX: TCurlMailClass: incorrect encoding from Chinese to utf8 (email subject/body).
  

[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)
