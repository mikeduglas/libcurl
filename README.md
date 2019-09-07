# libcurl
libcurl for Clarion

## Required C6.3 and newer.

[libcurl home page](https://curl.haxx.se/libcurl/)  
[FAQ](https://clarionhub.com/t/libcurl-faq-https-github-com-mikeduglas-libcurl/1965)  
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
v1.44
- NEW: TCurlMultiClass: Enables multiple simultaneous transfers in the same thread without making it complicated for the application.
- NEW: 10-at-a-time example: Download many files in parallel, in the same thread. 
  
v1.43
- FIX: TCurlFtpClass.LoadDir and TCurlFtpClass.LoadDirListOnly did not dispose IDynStr instance if SendRequest failed.
- CHG: Now uses libcurl v7.65.3, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 7.65.3 was built and statically linked with
> 
> * OpenSSL 1.1.1c
> * brotli 1.0.7
> * libssh2 1.9.0
> * nghttp2 1.39.1
> * zlib 1.2.11
  
v1.42
- CHG: Now uses libcurl v7.63.0, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 7.63.0 was built and statically linked with
> 
> * OpenSSL 1.1.1a
> * brotli 1.0.7
> * libssh2 1.8.0
> * nghttp2 1.35.1
> * zlib 1.2.11
- NEW: TCurlUrlApiClass supports new [URL API](https://github.com/curl/curl/wiki/URL-API).
- NEW: URL API example.
  
v1.41
- NEW: CURLOPT_FILETIME, CURLOPT_FILE, CURLOPT_INFILE, CURLOPT_WRITEHEADER options.
- FIX: TCurlClass.GetInfo::DOUBLE() method called curl_easy_getinfo() with wrong parameters. 
  
v1.40
- NEW: added 2 options CURLOPT_NEW_FILE_PERMS and CURLOPT_NEW_DIRECTORY_PERMS:
```
Permission used when creating new files and directories on the remote server for protocols that support it, SFTP/SCP/FILE
```


[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)
