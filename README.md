# libcurl
libcurl for Clarion

## Required C6.3 and newer.

[libcurl home page](https://curl.haxx.se/libcurl/)  
[changelog](https://curl.haxx.se/changes.html)  
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

v1.49
- FIX: The length of TCurlDropboxClass._accessToken increased to 1024 characters.

v1.48
- NEW: CURLOPT_TIMECONDITION, CURLOPT_TIMEVALUE, CURLOPT_TIMEVALUE_LARGE options.
- NEW: static curl::UnixTime function, returning Unix time specified in number of seconds since 1 Jan 1970.

v1.47
- FIX: in TCurlHttpClass.FollowLocation() "pContentLength" parameter was removed. Add http header "Content-Length: 0" explicitly if it is required.

v1.46
- FIX: TCurlClass.GetContentType() returned invalid data.
- NEW: CURLOPT_HEADERFUNCTION option
- NEW: TCurlClass.SetHeaderCallback method enables a callback that receives header data.
- NEW: TCurlClass.HeaderCallback(STRING headerLine) virtual method to store headers.
- CHG: default UserAgent changed to 'curl/7.65.3'

v1.45
- FIX: changed some method names to avoid "Redefine system intrinsic" compiler warnings and related "No matching prototype available" compiler errors in C6.3:
  - TCurlSList.Append renamed to TCurlSList.AppendData
  - TCurlUrlApiClass.Dup renamed to TCurlUrlApiClass.Clone
  - TCurlMultiClass.Add renamed to TCurlMultiClass.AddCurl

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
  

[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)
