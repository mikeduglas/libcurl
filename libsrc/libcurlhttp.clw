!** libcurl for Clarion v1.07
!** 26.12.2015
!** mikeduglas66@gmail.com


  MEMBER

  INCLUDE('libcurl.inc')

  MAP
  END

!!!region TCurlHttpClass
TCurlHttpClass.FollowLocation PROCEDURE(BOOL pFollowLocation = TRUE, LONG pContentLength = 0)
  CODE
  IF pFollowLocation
    SELF.AddHttpHeader('Content-Length: '& pContentLength) !curl bug: "http error 411 (Length required)"; explicit 0 fixes this
  END
  
  RETURN SELF.SetOpt(CURLOPT_FOLLOWLOCATION, pFollowLocation)

TCurlHttpClass.MaxRedirs      PROCEDURE(LONG pValue)
  CODE
  RETURN SELF.SetOpt(CURLOPT_MAXREDIRS, pValue)

TCurlHttpClass.GetRedirectUrl PROCEDURE()
  CODE
  RETURN SELF.GetInfo::STRING(CURLINFO_EFFECTIVE_URL)

TCurlHttpClass.AddHeaderCookie    PROCEDURE(STRING pCookieString)
  CODE
  RETURN SELF.SetOpt(CURLOPT_COOKIE, pCookieString)
  
TCurlHttpClass.ImportCookies  PROCEDURE(<STRING pCookieFile>)
  CODE
  RETURN SELF.SetOpt(CURLOPT_COOKIEFILE, pCookieFile)

TCurlHttpClass.ExportCookies  PROCEDURE(STRING pCookieFile)
  CODE
  RETURN SELF.SetOpt(CURLOPT_COOKIEJAR, pCookieFile)

TCurlHttpClass.AddCookie      PROCEDURE(STRING pCookie)
  CODE
  RETURN SELF.SetOpt(CURLOPT_COOKIELIST, pCookie)
  
TCurlHttpClass.GetCookieList  PROCEDURE(*TCurlSQueue pQ)
ptr                             LONG, AUTO
lst                             TCurlSList
  CODE
  FREE(pQ)
  ptr = SELF.GetInfo::SLIST(CURLINFO_COOKIELIST)
  IF ptr = 0
    RETURN FALSE
  END
  
  lst.AssignPtr(ptr)
  lst.GetQueue(pQ)
  
  RETURN TRUE
  
!!!endregion