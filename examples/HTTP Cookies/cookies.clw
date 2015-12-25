  PROGRAM

  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')

  MAP
    PrintCookies(TCurlHttpClass pCurl)
  END

SEP                           EQUATE('<9>') !Tab separates the fields
my_cookie                     STRING( '' |
                                &       'example.com'  | !Hostname
                                & SEP & 'FALSE'        | !Include subdomains
                                & SEP & '/'            | !Path
                                & SEP & 'FALSE'        | !Secure
                                & SEP & '0'            | !Expiry in epoch time format. 0 == Session
                                & SEP & 'foo'          | !Name
                                & SEP & 'bar'          | !Value
                              )

curl                          TCurlHttpClass
res                           CURLcode, AUTO

  CODE
  
  curl.Init()

  res = curl.AddHeaderCookie('username=Joe;userpwd=12345')
  IF res <> CURLE_OK
    MESSAGE('AddHeaderCookie failed: '& curl.StrError(res), 'cookies', ICON:Exclamation)
  END

  !my_cookie is imported immediately via AddCookie.
  res = curl.AddCookie(my_cookie)
  IF res <> CURLE_OK
    MESSAGE('AddCookie failed: '& curl.StrError(res), 'cookies', ICON:Exclamation)
  END

  !The list of cookies in cookies.txt will not be imported until right
  !before a transfer is performed. Cookies in the list that have the same
  !hostname, path and name as in my_cookie are skipped. That is because
  !libcurl has already imported my_cookie and it's considered a "live"
  !cookie. A live cookie won't be replaced by one read from a file.
  res = curl.ImportCookies('cookies.txt')
  IF res <> CURLE_OK
    MESSAGE('ImportCookies failed: '& curl.StrError(res), 'cookies', ICON:Exclamation)
  END

  !Cookies are exported after Cleanup is called. The server
  !may have added, deleted or modified cookies by then. The cookies that
  !were skipped on import are not exported.
  res = curl.ExportCookies('cookies.txt')
  IF res <> CURLE_OK
    MESSAGE('ExportCookies failed: '& curl.StrError(res), 'cookies', ICON:Exclamation)
  END

  !send request
  res = curl.SetUrl('http://www.example.com/')
  IF res <> CURLE_OK
    MESSAGE('SetUrl failed: '& curl.StrError(res), 'cookies', ICON:Exclamation)
  END

  res = curl.Perform()  !cookies imported from cookies.txt
  IF res <> CURLE_OK
    MESSAGE('Perform failed: '& curl.StrError(res), 'cookies', ICON:Exclamation)
  END

  PrintCookies(curl)
  
  !cookies exported to cookies.txt
  !Cleanup() is automatically called in destructor
  !curl.Cleanup()

PrintCookies                  PROCEDURE(TCurlHttpClass pCurl)
q                               QUEUE(TCurlSQueue)
                                END
qIndex                          LONG, AUTO
  CODE
  pCurl.GetCookieList(q)
  LOOP qIndex = 1 TO RECORDS(q)
    GET(q, qIndex)
    MESSAGE(q.item, 'cookies', ICON:Asterisk)
  END
  