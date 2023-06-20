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

v1.57
- CHG: Now uses libcurl v7.88.1, see [changelog](https://curl.haxx.se/changes.html) for details.
- FIX: TCurlClass.AddErrors(curl::ErrorBlock ErrsIn) failed if curl::DefaultErrors had more than 1 entries in libcurl.trn.
- NEW: TCurlClass.GetInfo now supports parameters of curl_off_t (uint64) type.
- NEW: TCurlClass.SetDebugInfoFilter method allows to filter debug messages or completely turn them off. See CURL_DEBUGINFO_xxx equates.
- NEW: TCurlHttpClass.DownloadFile method allows to resume interrupted downloads if the server supports partial requests.
- NEW: TCurlClass: ResetReadCallback, ResetWriteCallback, ResetXFerCallback, ResetDebugCallback, ResetHeaderCallback methods.
- NEW: TCurlFileStruct: SetFilePointer, GetFilePointer, GetFileSize methods.
- NEW: curl::FileAppend write callback.
- CHG: TCurlWebsocketClass: internal changes.
- CHG: Some Windows APIs moved from libcurl.inc into the modules where they are used.

v1.56
- CHG: Now uses libcurl v7.88.0, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 7.88.0 was built and statically linked with
> 
> * brotli 1.0.9
> * cacert 2023-01-10
> * gsasl 2.2.0
> * libssh2 1.10.0
> * nghttp2 1.52.0
> * nghttp3 0.8.0
> * ngtcp2 0.13.1
> * openssl-quic 3.0.8
> * zlib 1.2.13
> * zstd 1.5.4
  
- NEW: CURLU_PUNYCODE flag: allows TCurlUrlApiClass.GetPart() get the punycode version of host names for the host name and URL parts.
- NEW: TCurlWebsocketClass implements new WebSocket communication api.
- NEW: WebsocketsClient.clw example.

v1.55
- CHG: Now uses libcurl v7.85.0, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 7.85.0_5 was built and statically linked with
> 
> * brotli 1.0.9
> * gsasl 2.2.0
> * libssh2 1.10.0
> * nghttp2 1.50.0
> * nghttp3 0.7.1
> * ngtcp2 0.9.0
> * openssl-quic 3.0.5
> * zlib 1.2.12
> * zstd 1.5.2
> 
> The following tools/compilers were used in the build process:
> * clang 14.0.6
> * clang 15.0.0 (ARM64)
> * curl-for-win bce14879
> * llvm-mingw 20220906 (ARM64)
> * mingw-w64 10.0.0-2

- NEW: CURLE_XX codes (93..99).
- NEW: CURLINFO enum values: CURLINFO_CAINFO and CURLINFO_CAPATH.
- NEW: GetDefaultCAInfo() and GetDefaultCAPath() methods.

v1.54
- CHG: Added "ONCE" to all INCLUDE statements.
  

[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)
