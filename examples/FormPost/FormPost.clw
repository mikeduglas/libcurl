  PROGRAM


  PRAGMA('project(#compile libcurl.clw)')
  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')

  MAP
  END

curl                          TCurlHttpClass
res                           CURLcode
cfres                         CURLFormcode
respfile                      STRING(256)

  CODE

  curl.Init()
  
  !-- add form field
  cfres = curl.FormAdd('comment', 'test')
  IF cfres <> CURL_FORMADD_OK
    MESSAGE('FormAdd failed: '& curl.StrFormAddError(cfres), 'FormPost test', ICON:Asterisk)
    RETURN
  END

  !-- add file
  cfres = curl.FormAddFile('userfile', 'test.xml')
  IF cfres <> CURL_FORMADD_OK
    MESSAGE('FormAddFile failed: '& curl.StrFormAddError(cfres), 'FormPost test', ICON:Asterisk)
    RETURN
  END

  respfile = 'FormPost_response.txt'

  res = curl.FormPost('http://127.0.0.1/index.php', respfile)
  IF res = CURLE_OK
    MESSAGE('Success, see file '& CLIP(respfile) &' for details', 'FormPost test', ICON:Asterisk)
  ELSIF res = -1
    MESSAGE('FormPost failed: errcode '& res, 'FormPost test', ICON:Asterisk)
  ELSE
    MESSAGE('FormPost failed: '& curl.StrError(res), 'FormPost test', ICON:Exclamation)
  END
