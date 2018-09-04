  PROGRAM

  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')

  MAP
    MimePost()
    MimePostCB()  !- callback-based data source for a mime part's body
  END

  CODE

  IF 1
    MimePost()
  ELSE
    MimePostCB()
  END
  
MimePost                      PROCEDURE()
curl                            TCurlHttpClass
mime                            TCurlMimeClass
part                            curl_mimepart
res                             CURLcode
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

MimePostCB                    PROCEDURE()
curl                            TCurlHttpClass
mime                            TCurlMimeClass
part                            curl_mimepart
hugedata                        &STRING
res                             CURLcode
  CODE

  curl.Init()
  
  !- create "huge" data
  hugedata &= NEW STRING(512)
  hugedata = 'This is the field data: '& ALL('+', 255)

  !Build an HTTP form with a single field named "data"
  mime.Init(curl)
  part = mime.AddPart()
  mime.SetDataCB(part, hugedata, TRUE)  !- it will dispose hugedata after the transfer terminates
  mime.SetName(part, 'data')
  
  !Post and send it.
  curl.SetMimePost(mime)
  res = curl.SendRequest('http://example.com')
  IF res = CURLE_OK
    MESSAGE('Success', 'MimePost test', ICON:Asterisk)
  ELSE
    MESSAGE('MimePost failed: '& curl.StrError(res), 'MimePost', ICON:Exclamation)
  END

  !- clean up
!  DISPOSE(hugedata)