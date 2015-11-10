  PROGRAM

  PRAGMA('project(#compile libcurl.clw)')

  INCLUDE('libcurl.inc')

  MAP
    Main()
    ProgressData(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, C
  END

  CODE
  Main()
  
    
ProgressData                  PROCEDURE(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
  CODE
  curl::DebugInfo('Downloaded '& dlnow &' bytes')
  RETURN 0

Main                          PROCEDURE()
curl                            TCurlClass
res                             CURLcode

  CODE  
  curl.Init()
  
!  res = curl.ReadFile('http://www.ingasoftplus.com/rss.php', 'rss.php', ProgressData) 
  res = curl.ReadFile('http://www.ingasoftplus.com/rss.php', 'rss.php')
  IF res = CURLE_OK
    MESSAGE('File successfully downloaded.', ICON:Asterisk)
  ELSIF res = -1 
    MESSAGE('Cannot create local file')
  ELSE
    MESSAGE('ReadFile failed: '& curl.StrError(res))
  END
