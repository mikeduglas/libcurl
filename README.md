# libcurl
libcurl for Clarion

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
