# libcurl
libcurl for Clarion

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
