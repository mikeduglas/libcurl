### Many questions “how to translate CURL script to Clarion?” For example,
```
curl -X POST https://server.com/v1/person 11 -H “Content-Type: application/json” -H “Authorization: Bearer Access-Token” -d “k1=v1&k2=v2”
```

-X POST means “POST” request and can be translated to curl.SetCustomRequest(‘POST’).  
-H “…” means http header and can be translated to curl.AddHttpHeader(’…’).  
To apply headers call curl.SetHttpHeaders().  
-d “…” means post parameters which you pass to curl.SendRequest().  

Sample code looks like this:
```
curl                            TCurlHttpClass
res                             CURLcode
url                             STRING(256), AUTO
PostParams                      STRING(4096), AUTO
respfile                        STRING(256), AUTO
  CODE
  curl.Init()

  !-X POST
  curl.SetCustomRequest('POST')
  
  !-H "Content-Type: application/json"
  curl.AddHttpHeader('Content-Type: application/json')

  !-H "Authorization: Bearer Access-Token"
  curl.AddHttpHeader('Authorization: Bearer Access-Token')

  !-- applies http headers added by AddHttpHeader calls
  curl.SetHttpHeaders()
  
  url = 'https://server.com/v1/person'
  PostParams = 'k1=v1&k2=v2'
  respfile = 'response.txt'
  
  res = curl.SendRequest(url, PostParams, respfile)
  IF res = CURLE_OK
    MESSAGE('Success, see file '& CLIP(respfile) &' for details', 'Post test', ICON:Asterisk)
  ELSIF res = -1
    MESSAGE('SendRequest failed: errcode '& res, 'Post test', ICON:Asterisk)
  ELSE
    MESSAGE('SendRequest failed: '& curl.StrError(res), 'libcurl', ICON:Exclamation)
  END
```

### Another example
```
curl -u jsmith:jsmith -X POST -F “environment=TEM” -F “filename=Test” -F “multipartFile=@mmabc.manifest” ‘https://server.com/api/manifests 2’
```
-u jsmith:jsmith defines login and password and translated to curl.SetUserPwd(‘jsmith’, ‘jsmith’).  
-F “environment=TEM” sends the data as a multipart formpost 2: curl.FormAdd(‘environment’, ‘TEM’).  
-F “multipartFile=@mmabc.manifest” sends a file: curl.FormAddFile(‘multipartFile’, ‘mmabc.manifest’).  
**For formpost, call curl.FormPost() method instead of curl.SendRequest():**  
```
  curl.Init()

  !-- add form fields
  cfres = curl.FormAdd('environment', 'TEM')
  cfres = curl.FormAdd('filename', 'Test')
  !-- add file
  cfres = curl.FormAddFile('multipartFile', 'mmabc.manifest')

  curl.SetUserPwd('jsmith', 'jsmith')

  respfile = 'FormPost_response.txt'
  res = curl.FormPost('https://server.com/api/manifests', respfile)
```
### Send a file over http
```
curl http://server.com 1 -H “Content-Type: application/json” --data-binary @test.json
```
Call curl.SendFile() with appropriate mime type (“application/json” in this case):
```
  curl.Init()

  url = 'http://server.com'
  infile = 'test.json'
  respfile = 'send_response.json'
  
  res = curl.SendFile(url, infile, 'application/json', respfile)
```
### Test a connection
```
curl.SetOpt(CURLOPT_CONNECT_ONLY, TRUE)
res = curl.SendRequest(url)
IF res = CURLE_OK
  !- success
ELSE
  !- fail
END
```
### Q. I’m trying to send email, no errors reported but the email never arrives at the destination.
A. If server url starts with email protocol (“smtp.gmail.com”), libcurl uses this protocol (smtp) to send a request; otherwise it uses http by default, so you must change it by calling curl.SetDefaultProtocol(‘smtp’).
  
UPD:
since v1.38 TCurlFtpClass uses ‘ftp’ default protocol; TCurlMailClass uses ‘smtp’ default protocol, so calling SetDefaultProtocol is not required.

### Q. How to translate following NetTalk code into libcurl?
```
 webclient.SetValue('user', 'mike')
 webclient.SetValue('password', '12345')
 webclient.SetValue('file', FileName, true)
 webclient.Post(url)
```
A. curl is TCurlHttpClass:
```
curl.FormAdd('user', 'mike')
curl.FormAdd('password', '12345')
curl.FormAddFile('file', filename)
res = curl.FormPost(url)
```

### Q. How to add HTTP headers?
I used 
```
curl.AddHttpHeader(‘x-test: text’) 
```
but those headers never make it to the PHP service.

A. Call curl.SetHttpHeaders() to commit headers added by AddHttpHeader():
```
curl.AddHttpHeader(‘x-test: text’)
curl.AddHttpHeader(‘y-test: text’)
curl.SetHttpHeaders()
```

### Q. a SSL site throws errors when trying to connect.

A1. Don’t verify the authenticity:
```
  curl.SetSSLVerifyPeer(FALSE)  !- Don't verify the authenticity of the peer's certificate.
  curl.SetSSLVerifyHost(FALSE)  !- the connection succeeds regardless of the names in the certificate.
```

A2. Download the Mozilla CA certificate store PEM file from [here](https://curl.haxx.se/docs/caextract.html) 9 and call this:
```
  curl.SetCAInfo('cacert.pem')
  curl.SetSSLVerifyPeer(TRUE)  !- not necessary, it is default option
  curl.SetSSLVerifyHost(TRUE)  !- not necessary, it is default option
```
Thanks to Arnor Baldvinsson for sharing.

### Q. Is it possible to show a progress bar during the execution of curl.SendRequest?
A. Yes it is possible, you should derive **XFerInfo** callback method, for example:
```
curl                        CLASS(TCurlClass)
XFerInfo                        PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, DERIVED
                              END

curl.XFerInfo         PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
  CODE
  IF dlnow
    !- downloaded {dlnow} of {dltotal} bytes
   END
  
  IF ulnow
    !- uploaded {ulnow} of {ultotal} bytes
  END
  
  RETURN PARENT.XFerInfo(dltotal, dlnow, ultotal, ulnow)
```

### Q. I need to send json string

A. Assume sUrl is string variable containing url, sJson is string variable containing json:
```
  curl.AddHttpHeader('Content-Type: application/json')  !- or 'Content-Type: text/json'
  curl.SetCustomRequest('POST')
  curl.SendRequest(sUrl, sJson)
```

### Q. On some machines, sending an email fails with the error "Send failed: Access denied to remote resource".

A. During the session libcurl sends to the server HELO command with computer name by default: "HELO MyComputer". If
computer name doesn't match the rules of HELO command, you see the "Send failed: Access denied to remote resource". An example of invalid HELO is "HELO Мой-Комп".

TCurlMailClass.Server method has 3rd optional parameter pHelo, so to fix this issue just pass a string like 'MyComputer' or 'MIKE'::
```
curl.Server('smtps://smtp.mail.ru', 465, 'MyComputer')
```