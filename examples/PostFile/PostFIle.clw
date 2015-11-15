  PROGRAM


  PRAGMA('project(#compile libcurl.clw)')
  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')

  MAP
  END

curl                          TCurlClass
res                           CURLcode
url                           STRING(256)
argname                       STRING(32)
infile                        STRING(256)
respfile                      STRING(256)

  CODE

  curl.Init()
  
  url = 'http://www.clarionlife.net/curl/index.php'
  argname = 'userfile'
  infile = 'test.xml'
  respfile = 'post_response.txt'
  
  res = curl.PostFile(url, argname, infile, respfile)
  IF res = CURLE_OK
    MESSAGE('Success, see file '& CLIP(respfile) &' for details', 'Post test', ICON:Asterisk)
  ELSIF res = -1
    MESSAGE('curl_formadd failed: errcode '& res, 'Post test', ICON:Asterisk)
  ELSE
    MESSAGE('SetCustomRequest failed: '& curl.StrError(res), 'libcurl', ICON:Exclamation)
  END
