## Version history
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

v1.39

- CHG: Now uses libcurl v7.61.1, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 7.61.1_8 was built and statically linked with
> 
> * OpenSSL 1.1.1
> * brotli 1.0.7
> * libssh2 1.8.0
> * nghttp2 1.34.0
> * zlib 1.2.11

v1.38
- CHG: TCurlFtpClass uses 'ftp' default protocol; TCurlMailClass uses 'smtp' default protocol.
- FIX: possible memory leak in TCurlFtpClass and TCurlDropboxClass.

v1.37

- CHG: TCurlFtpClass: PublicKeyMD5 field was added to TSSHSettings group  
```
TSSHSettings                  GROUP, TYPE, PRE(TSSHSettings)
AuthMethod                      CURLSSH_AUTH_ENUM     !allowed SSH authentication methods
PublicKeyFile                   STRING(256)           !Used by scp/sftp to do public/private key authentication
PrivateKeyFile                  STRING(256)           !Used by scp/sftp to do public/private key authentication
KnownHosts                      STRING(256)           !set the SSH knownhost file name to use
KeyPassword                     STRING(40)            !password for the SSL or SSH private key
PublicKeyMD5                    STRING(32)            !used by scp/sftp to verify the host's public key
                              END
```

v1.36

- NEW: curl::StrError(CURLcode errcode) static function returns  meaningful error message.  
- FIX: TCurlMimeClass.SetDataCB(part,hugedata,TRUE) did not dispose allocated memory for hugedata.  
- CHG: TCurlMailClass now internally uses curl mime api.  
- CHG: TCurlMailClass allows both '\\' and '/' in attached file names.  

v1.35

- NEW: TCurlMimeClass.SetDataCB method sets a callback-based data source for a mime part's body.  
- CHG: MimePost example now demonstrates both SetData and SetDataCB approaches.

v1.34

- CHG: Now uses libcurl v7.61.0, see [changelog](https://curl.haxx.se/changes.html) for details. Old binaries were moved to bin_v_7.52.1 subfolder.  
- CHG: Now uses OpenSSL v1.1.0i.  

- NEW: bitmasks for CURLOPT_HTTPAUTH and CURLOPT_PROXYAUTH options have been added: 
```
CURLAUTH_NTLM                 EQUATE(8)
CURLAUTH_DIGEST_IE            EQUATE(16)
CURLAUTH_NTLM_WB              EQUATE(32)
CURLAUTH_BEARER               EQUATE(64)
CURLAUTH_ONLY                 EQUATE(080000000h)
CURLAUTH_ANY                  EQUATE(0FFFFFFEFh)
CURLAUTH_ANYSAFE              EQUATE(0FFFFFFEEh)

```
- NEW: bitmasks for CURLOPT_SSLVERSION option have been added: 
```
CURL_SSLVERSION_MAX_DEFAULT   EQUATE(010000h)  !CURL_SSLVERSION_TLSv1   << 16
CURL_SSLVERSION_MAX_TLSv1_0   EQUATE(040000h)  !CURL_SSLVERSION_TLSv1_0 << 16
CURL_SSLVERSION_MAX_TLSv1_1   EQUATE(050000h)  !CURL_SSLVERSION_TLSv1_1 << 16
CURL_SSLVERSION_MAX_TLSv1_2   EQUATE(060000h)  !CURL_SSLVERSION_TLSv1_2 << 16
CURL_SSLVERSION_MAX_TLSv1_3   EQUATE(070000h)  !CURL_SSLVERSION_TLSv1_3 << 16
```
- NEW: CURLOPT_REQUEST_TARGET (the request target, instead of extracted from the URL)  
- NEW: CURLOPT_MIMEPOST (Post MIME data)  

- NEW: TCurlClass methods:
```
SetUserAgent  PROCEDURE(STRING pUserAgent), CURLcode, PROC    !default user-agent: curl/7.61.0
GetHandle     PROCEDURE(), CURL                               ! returns curl handle
SetMimePost   PROCEDURE(TCurlMimeClass mime), CURLcode, PROC  !set post/send data from mime structure
```
- NEW: TCurlMimeClass (libcurlmime.clw) implements new curl mime api.  
- NEW: MimePost example.  

v1.33
- NEW: Added an option to specify which HTTP version to use, and constants for use with the CURLOPT_HTTP_VERSION option:
```
CURLOPT_HTTP_VERSION          EQUATE(84 + CURLOPTTYPE_LONG)             !Specify which HTTP version to use! This must be set to one of the CURL_HTTP_VERSION* enums set below.
!  /* These enums are for use with the CURLOPT_HTTP_VERSION option. */ 
CURL_HTTP_VERSION_NONE              EQUATE(0)                           !setting this means we don't care, and that we'd like the library to choose the best possible for us!
CURL_HTTP_VERSION_1_0               EQUATE(1)                           !please use HTTP 1.0 in the request
CURL_HTTP_VERSION_1_1               EQUATE(2)                           !please use HTTP 1.1 in the request
CURL_HTTP_VERSION_2_0               EQUATE(3)                           !please use HTTP 2 in the request
CURL_HTTP_VERSION_2TLS              EQUATE(4)                           !use version 2 for HTTPS, version 1.1 for HTTP
CURL_HTTP_VERSION_2_PRIOR_KNOWLEDGE EQUATE(5)                           !please use HTTP 2 without HTTP/1.1 Upgrade
CURL_HTTP_VERSION_LAST              EQUATE(6)                           !*ILLEGAL* http version
```
- NEW: TCurlClass.SetPostFields(*IDynStr pPostFields)

v1.32
- CHG: TCurlMailClass now adds Date header field (ex.: "Date: Wed, 22 Aug 2018 12:32:25 +0300").

v1.31
- FIX: TCurlMailClass failed if encoded body size was exceeded 16K (original body size of ~12885 bytes or larger).

v1.30
- FIX: new TCurlClass.SetPostFields method could affect the behavior of other stuff, now it is changed and sets post fields only if passed argument is not empty. To clear post fields use SetOpt calls.
- Updated [Clarion 6.3 examples](https://github.com/mikeduglas/libcurl/tree/master/examples/C6.3%20apps).

v1.29
- NEW: TCurlClass.SetPostFields(STRING pPostFields)
- NEW: TCurlMailClass now allows to send html emails with embedded (inline) images:
```
curl.Body('<html><body><p>HTML content</p><img src="cid:myLogo"/><p>with embedded images.</p></body></html>')
curl.AddEmbeddedImage('d:\Images\logo.jpg', 'myLogo')  !- 'myLogo' is an image id and appears in html "src" attribute: <img src="cid:myLogo"/>
curl.ContentType('text/html')  !- not required in this case (embedded images force to use text/html)
curl.AltBody('This is an alternative plain text. Embedded images will appear as attachments.')  !- for those email clients not supporting html.
```

new TCurlMailClass methods:
```
AddEmbeddedImage(STRING pFilename, STRING pCid, <STRING pName>)  !forces to use 'text/html' content-type
AltBody(STRING pBody)    !forces to use 'text/html' content-type
```

**Thank to Guillermo who has provided these changes in TCurlMailClass**

v1.28
- FIX: Some TCurlFtpClass methods (RenameFile, DeleteFile, CreateDir, RenameDir) required CLIPped parameters, otherwise you could get "Qouta command returned error".
- Updated [Clarion 6.3 examples](https://github.com/mikeduglas/libcurl/tree/master/examples/C6.3%20apps).

v1.27
- NEW: TCurlFtpClass.IsDirExist() checks remote directory existance; returns CURLE_OK if dir exists.
- NEW: TCurlFtpClass.CreateMissingDirs() ("create missing dirs for FTP and SFTP"), pass one of the following parameters:
```
CURLFTP_CREATE_DIR_NONE       EQUATE(0) !do NOT create missing dirs! Default value.
CURLFTP_CREATE_DIR            EQUATE(1) !(FTP/SFTP) if CWD (Change working directory) fails, try MKD (Make directory) and then CWD again if MKD succeeded, for SFTP this does similar magic.
CURLFTP_CREATE_DIR_RETRY      EQUATE(2) !(FTP only) if CWD fails, try MKD and then CWD again  even if MKD failed!

```

v1.26
- NEW: overloaded TCurlHttpClass.FormPost() which takes IDynStr to get unlimited server response string:
```
FormPost  PROCEDURE(STRING pUrl, *IDynStr pDynStr, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
```

v1.25
- NEW: overloaded TCurlClass.SendRequest() which takes IDynStr to get unlimited server response string:
```
SendRequest  PROCEDURE(STRING pUrl, <STRING pPostFields>, *IDynStr pDynStr, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
```

- NEW: [Clarion 6.3 examples](https://github.com/mikeduglas/libcurl/tree/master/examples/C6.3%20apps), big thanks to Johan de Klerk! See [Readme.txt](https://github.com/mikeduglas/libcurl/tree/master/examples/C6.3%20apps/Readme.txt) for details.


v1.24
- CHG: TCurlMailClass.Subject() now accepts 2nd parameter 'pEncode'; pass FALSE to disable utf-8 encoding (in Outlook, the subject is unreadable in UTF-8).

v1.23
- NEW: TCurlMailClass methods: .FreeRecipients(), .FreeAttachments(), .FreeCustomHeaders().

v1.22
- NEW: CURLOPT_SSL_OPTIONS - set SSL behavior options.  
Pass a long with a bitmask to tell libcurl about specific SSL behaviors:
curl.SetOpt(CURLOPT_SSL_OPTIONS, CURLSSLOPT_ALLOW_BEAST)
curl.SetOpt(CURLOPT_SSL_OPTIONS, CURLSSLOPT_ALLOW_BEAST + CURLSSLOPT_NO_REVOKE)

- CHG: TCurlMailClass.Reset() now resets mailto list, attachments, custom headers. It does not change the following information kept in the handle:  
live connections, the Session ID cache, the DNS cache, the cookies and shares.

v1.21
- CHG: LONGLONG type renamed to TLONGLONG (naming conflict with Office Inside).

v1.20
- FIX: TCurlClass.FreeHttpHeaders() sets CURLOPT_HTTPHEADER to NULL (resets back to no custom headers).

v1.19
- FIX: added sleep() call before SELF.Send() in TCurlDropboxClass.Upload().
Sometimes "Jason string invalid" error thrown; sleep() call is a workaround.

v1.18
- CHG: OpenSSL dlls upgraded to version 1.1.f.  
**Note: Microsoft Visual C++ 2010 SP1 Runtime (msvcr100.dll) no more required to be installed on target computer.**
- NEW: TCurlHttpClass methods to send a file (by name or contents): .SendFile, .SendBinData, .SendFileStr, .SendBinDataStr. Shortcuts for curl.exe --data-binary [@file].
- <del>FIX: template: Changed #AT(%DataSection) to #AT(%DataSectionBeforeWindow)</del>

v1.17
- FIX: in TCurlClass methods .SetUrl, .SetUserPwd, .SetCAInfo now accept unlimited string arguments.
- FIX: in TCurlDropboxClass size of some local string variables were increased.


v1.16
- FIX: TCurlClass.AddHttpHeader(STRING pHeader) now accepts unlimited HTTP header string (it was 255 characters).


v1.15
- CHG: TCurlMailClass.Server now accepts optional 3rd parameter for 'HELO/EHLO' command: curl.Server('smtp.gmail.com', 587, 'client.examples.com')
- NEW: TCurlClass.SetDefaultProtocol PROCEDURE(STRING pSchema)


v1.14
- Now uses libcurl v7.52.1

- Now only 3 dlls required:
 - libcurl.dll
 - libcrypto-1_1.dll
 - libssl-1_1.dll

**Note: Microsoft Visual C++ 2010 SP1 Runtime (msvcr100.dll) must be installed on target computer.**
[Download Microsoft Visual C++ 2010 SP1 Runtime.](http://www.microsoft.com/en-us/download/details.aspx?id=8328)

- Some new CURL options (used in .SetOpt()):
 - CURLOPT_SSLCERTTYPE      !type of the file keeping your SSL-certificate ("DER", "PEM", "ENG")
 - CURLOPT_SSLKEY           !name of the file keeping your private SSL-key
 - CURLOPT_SSLKEYTYPE       !type of the file keeping your private SSL-key ("DER", "PEM", "ENG")
 - CURLOPT_SSLENGINE        !crypto engine for the SSL-sub system
 - CURLOPT_CAPATH           !The CApath directory used to validate the peer certificate. This option is used only if SSL_VERIFYPEER is true.
 - CURLOPT_CRLFILE          !CRL file
 - CURLOPT_ISSUERCERT       !Issuer certificate
 - CURLOPT_PROXYUSERNAME    !"name" to use with Proxy when fetching.
 - CURLOPT_PROXYPASSWORD    !"pwd" to use with Proxy when fetching.
 - CURLOPT_TLSAUTH_USERNAME !Set a username for authenticated TLS
 - CURLOPT_TLSAUTH_PASSWORD !Set a password for authenticated TLS
 - CURLOPT_TLSAUTH_TYPE     !Set authentication type for authenticated TLS
 - CURLOPT_MAIL_AUTH        !set the SMTP auth originator
 - CURLOPT_SSL_VERIFYSTATUS !Set if we should verify the certificate status.
 - CURLOPT_SSL_FALSESTART   !Set if we should enable TLS false start.
 - CURLOPT_DEFAULT_PROTOCOL !Set the protocol used when curl is given a URL without a protocol
 - CURLOPT_FTP_ALTERNATIVE_TO_USER !Pointer to command string to send if USER/PASS fails.

- New constants:
 - CURL_SSLVERSION_TLSv1_3  !used in .SetSSLVersion()

- New error codes (used in functions returning "CURLcode"):
 - CURLE_SSL_INVALIDCERTSTATUS   !invalid certificate status
 - CURLE_HTTP2_STREAM            !stream error in HTTP/2 framing layer


v1.13
- NEW: TCurlMailClass method:
.AddCustomHeader(STRING pKey, STRING pValue)

Examples:
- curl.AddCustomHeader('X-Confirm-Reading-To', 'mikeduglas66@gmail.com')
- curl.AddCustomHeader('Return-Receipt-To', 'mikeduglas66@gmail.com')
- curl.AddCustomHeader('Disposition-Notification-To', 'mikeduglas66@gmail.com')
- curl.AddCustomHeader('X-Priority', 1)
- curl.AddCustomHeader('X-MSMail-Priority', 'High')
- curl.AddCustomHeader('Importance', 'High')

**Note: custom headers may be deprecated or ignored by mail server.**

v1.12
- NEW: TCurlHttpClass methods to support form fields:
.FormAdd() adds field's contents to a query;
.FormAddFile() adds a file to a query;
.FormPost() and .FormPostStr() post a query.

- NEW: FormPost example

v1.11
- NEW: TCurlDropboxClass methods .Get_Copy_Reference, .Save_Copy_Reference, .Preview, .Thumbnail
- CHG: Dropbox File Manager -- enhanced UI (2 file panels, preview/thumbnail for documents and images), modified JSON.CLW (2 bugs fixed in JSONDataClass.FromJSON)

v1.10
- NEW: TCurlDropboxClass OAuth2 authorization support
- CHG: Dropbox File Manager example now uses OAuth2

v1.09

- NEW: TCurlDropboxClass (Dropbox API v2)
  - allows to copy, move, delete files and folders, create folders, upload and download files, get folder list (application access token required)
- NEW: Dropbox File Manager hand-coded example (C10 solution, uses JSON stuff)
- NEW: some curl constants added
- CHG: some methods rewritten to use dynamic strings (IDynStr) instead of files as server response storage
- FIX: TCurlClass.SetOpt(CURLoption option, *STRING param)


22.02.2016: 
  FTP Manager now correctly displays local disk drives.


V1.08

- FIX: TCurlFtpClass.ReadFile() went into endless loop for SFTP protocol.
- FIX: Updated FTPManager.exe


30.12.2015: Added ReceiveMail example


**Template support added**

v1.07

- NEW: CURLE_xxx error codes
- NEW: includes 'libcurl.trn' to translate curl errors
- CHG: TCurlClass.StrError() now VIRTUAL
- NEW: AddError(), AddErrors() methods
- NEW: TCurlHttpClass
  - redirection support:
    - FollowLocation
    - MaxRedirs
    - GetRedirectUrl
  - cookies support
    - AddHeaderCookie
    - ImportCookies
    - ExportCookies
    - AddCookie
    - GetCookieList
- NEW: cookies example
- CHG: Removed a reference to 'svapifnc.inc'

v1.06

- FIX: TCurlMailClass -- possible redundant 'noname.txt' attachment
- FIX: TCurlMailClass -- allows 'Jimmy Page <jpage@yahoo.com>' in From, To, CC and BCC fields
- FIX: TCurlMailClass -- From, To, CC, BCC and Subject fields are utf-8 encoded to allow non-English characters

v1.05

- NEW: TCurlMailClass class
- NEW: SendMail example

v1.04

- CHG: TCurlFtpClass class -- some internal enhancements and bug fixes
- CHG: FTP Manager demo app -- recursive directory upload/download/delete; some gui changes

v1.03

- FIX: TCurlSList.Append() bug
- NEW: TCurlFtpClass class
- FTP Manager app:
  - Context menu
  - SSH settings
  - Logging 

v1.02

- .PostFile and .PostFileStr methods similar to .SendRequest and .SendRequestStr, but upload file to http server using POST form method.
- FTP Manager demo app

v1.01

- .SetCustomRequest method, for customizing the get command like HTTP: DELETE, TRACE and others
- .GetResponseCode method returns HTTP or FTP response code
- constants to use in .SetOpt(curlopt_constant):
  - CURLOPT_HEADER  throw the header out too 
  - CURLOPT_NOBODY  use HEAD to get http document
  - CURLOPT_POST    HTTP POST method
  - CURLOPT_DIRLISTONLY (CURLOPT_FTPLISTONLY)  bare names when listing directories
  - CURLOPT_APPEND  Append instead of overwrite on upload!
  - CURLOPT_PUT     HTTP PUT

v1.00

- HTTP GET/POST
- documentation

v0.99

- methods .ReadFile, .WriteFile, .SetUserPwd
- virtual method .XFerInfo
- SSH support
