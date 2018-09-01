  PROGRAM

  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')

  MAP
  END

curl                          TCurlHttpClass
mime                          TCurlMimeClass
part                          curl_mimepart
res                           CURLcode

  CODE

  curl.Init()
  
  !Build an HTTP form with a single field named "data"
  mime.Init(curl)
  part = mime.AddPart()
  mime.SetData(part, 'This is the field data')
  mime.SetName(part, 'data')
  
  !Post and send it.
  curl.SetMimePost(mime)
  res = curl.SendRequest('http://example.com')
  IF res = CURLE_OK
    MESSAGE('Success', 'MimePost test', ICON:Asterisk)
  ELSE
    MESSAGE('MimePost failed: '& curl.StrError(res), 'MimePost', ICON:Exclamation)
  END
