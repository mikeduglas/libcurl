!** libcurl for Clarion v1.47
!** 27.04.2020
!** mikeduglas@yandex.com
!** mikeduglas66@gmail.com

  MEMBER

  INCLUDE('libcurl.inc')

  MAP
    MODULE('libcurl API')
      curl_formadd_2(LONG pphttppost, LONG pplast_post, CURLformoption option1, *CSTRING option1name, CURLformoption option2, *CSTRING option2name, CURLformoption endoption), CURLFORMcode, PROC, C, RAW, NAME('curl_formadd')
      curl_formadd_3(LONG pphttppost, LONG pplast_post, CURLformoption option1, *CSTRING option1name, CURLformoption option2, *CSTRING option2name, CURLformoption option3, *CSTRING option3name, CURLformoption endoption), CURLFORMcode, PROC, C, RAW, NAME('curl_formadd')
      curl_formfree(LONG pform), C, RAW, NAME('curl_formfree')
    END
  END

!!!region TCurlHttpClass
TCurlHttpClass.Destruct       PROCEDURE()
  CODE
  SELF.FormFree()
  
!TCurlHttpClass.FollowLocation PROCEDURE(BOOL pFollowLocation = TRUE, LONG pContentLength = 0)
!  CODE
!  IF pFollowLocation
!    SELF.AddHttpHeader('Content-Length: '& pContentLength) !curl bug: "http error 411 (Length required)"; explicit 0 fixes this
!    SELF.SetHttpHeaders()
!  END
!  
!  RETURN SELF.SetOpt(CURLOPT_FOLLOWLOCATION, pFollowLocation)
TCurlHttpClass.FollowLocation PROCEDURE(BOOL pFollowLocation = TRUE)
  CODE
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

TCurlHttpClass.FormAdd        PROCEDURE(STRING pFieldName, STRING pContents)
szFieldName                     CSTRING(LEN(pFieldName) + 1)
szContents                      CSTRING(LEN(pContents) + 1)
  CODE
  szFieldName = CLIP(pFieldName)
  szContents = CLIP(pContents)
  RETURN curl_formadd_2(ADDRESS(SELF.httppost), ADDRESS(SELF.postend), CURLFORM_COPYNAME, szFieldName, CURLFORM_COPYCONTENTS, szContents, CURLFORM_END)

TCurlHttpClass.FormAddFile    PROCEDURE(STRING pFieldName, STRING pFileName, <STRING pContentType>)
szFieldName                     CSTRING(LEN(pFieldName) + 1)
szFileName                      CSTRING(LEN(pFileName) + 1)
szContentType                   CSTRING(LEN(pContentType) + 1)
  CODE
  szFieldName = CLIP(pFieldName)
  szFileName = CLIP(pFileName)
  szContentType = CLIP(pContentType)
  IF szContentType = ''
    RETURN curl_formadd_2(ADDRESS(SELF.httppost), ADDRESS(SELF.postend), CURLFORM_COPYNAME, szFieldName, CURLFORM_FILE, szFileName, CURLFORM_END)
  ELSE
    RETURN curl_formadd_3(ADDRESS(SELF.httppost), ADDRESS(SELF.postend), CURLFORM_COPYNAME, szFieldName, CURLFORM_FILE, szFileName, CURLFORM_CONTENTTYPE, szContentType, CURLFORM_END)
  END
  
TCurlHttpClass.FormPost       PROCEDURE(STRING pUrl, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>)
res                             CURLcode, AUTO
  CODE
  res = SELF.SetOpt(CURLOPT_HTTPPOST, SELF.httppost)
  IF res <> CURLE_OK
    RETURN res
  END

  ! perform request
  res = SELF.SendRequest(pUrl, '', pResponseFile, xferproc)
  
  SELF.FormFree()

  RETURN res
 
TCurlHttpClass.FormPost       PROCEDURE(STRING pUrl, *IDynStr pDynStr, <curl::ProgressDataProcType xferproc>)
res                             CURLcode, AUTO
  CODE
  res = SELF.SetOpt(CURLOPT_HTTPPOST, SELF.httppost)
  IF res <> CURLE_OK
    RETURN res
  END

  ! perform request
  res = SELF.SendRequest(pUrl, pDynStr, xferproc)
  
  SELF.FormFree()

  RETURN res

TCurlHttpClass.FormPostStr    PROCEDURE(STRING pUrl, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>)
res                             CURLcode, AUTO
  CODE
  res = SELF.SetOpt(CURLOPT_HTTPPOST, SELF.httppost)
  IF res <> CURLE_OK
    RETURN res
  END

  ! perform request
  res = SELF.SendRequestStr(pUrl, '', pResponseBuf, xferproc)
  
  SELF.FormFree()

  RETURN res

TCurlHttpClass.FormFree       PROCEDURE()
  CODE
  IF SELF.httppost
    curl_formfree(SELF.httppost)
    SELF.httppost = 0
    SELF.postend = 0
  END

TCurlHttpClass.StrFormAddError    PROCEDURE(CURLFORMcode errcode)
  CODE
  CASE errcode
  OF CURL_FORMADD_MEMORY
    RETURN 'The allocation of a FormInfo struct failed'
  OF CURL_FORMADD_OPTION_TWICE
    RETURN 'One option is given twice for one Form'
  OF CURL_FORMADD_NULL
    RETURN 'A null pointer was given for a char'
  OF CURL_FORMADD_UNKNOWN_OPTION
    RETURN 'An unknown option was used'
  OF CURL_FORMADD_INCOMPLETE
    RETURN 'The some FormInfo is not complete (or error)'
  OF CURL_FORMADD_ILLEGAL_ARRAY
    RETURN 'An illegal option is used in an array'
  ELSE
    RETURN 'Unknown CURLFORMcode: '& errcode
  END

TCurlHttpClass.SendFile       PROCEDURE(STRING pUrl, STRING pFileName, STRING pContentType, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>)
sFileContents                   &STRING
res                             CURLcode, AUTO
  CODE
  sFileContents &= curl::GetFileContents(pFileName)
  IF NOT sFileContents &= NULL
    res = SELF.SendBinData(pUrl, sFileContents, LEN(sFileContents), pContentType, pResponseFile, xferproc)
      
    !-- deallocate dynamic buffer
    DISPOSE(sFileContents)
  ELSE
    res = CURLE_READ_ERROR
  END
  
  RETURN res
      
TCurlHttpClass.SendBinData    PROCEDURE(STRING pUrl, CONST *STRING pBinData, LONG pDataLen = 0, STRING pContentType, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>)
  CODE
  IF pContentType
    SELF.AddHttpHeader('Content-Type: '& CLIP(pContentType))
    SELF.SetHttpHeaders()
  END
    
  !- send binary content (--data-binary)
  SELF.SetOpt(CURLOPT_POSTFIELDS, ADDRESS(pBinData))
  IF pDataLen = 0
    SELF.SetOpt(CURLOPT_POSTFIELDSIZE, LEN(pBinData))
  ELSE
    SELF.SetOpt(CURLOPT_POSTFIELDSIZE, pDataLen)
  END
  
  RETURN SELF.SendRequest(pUrl, '', pResponseFile, xferproc)

TCurlHttpClass.SendFileStr    PROCEDURE(STRING pUrl, STRING pFileName, STRING pContentType, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>)
sFileContents                   &STRING
res                             CURLcode, AUTO
  CODE
  sFileContents &= curl::GetFileContents(pFileName)
  IF NOT sFileContents &= NULL
    res = SELF.SendBinDataStr(pUrl, sFileContents, LEN(sFileContents), pContentType, pResponseBuf, xferproc)
    
    !-- deallocate dynamic buffer
    DISPOSE(sFileContents)
  ELSE
    res = CURLE_READ_ERROR
  END
  
  RETURN res

TCurlHttpClass.SendBinDataStr PROCEDURE(STRING pUrl, CONST *STRING pBinData, LONG pDataLen = 0, STRING pContentType, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>)
res                             CURLcode, AUTO
  CODE
  IF pContentType
    SELF.AddHttpHeader('Content-Type: '& CLIP(pContentType))
    SELF.SetHttpHeaders()
  END
    
  !- send binary content (--data-binary)
  SELF.SetOpt(CURLOPT_POSTFIELDS, ADDRESS(pBinData))
  IF pDataLen = 0
    SELF.SetOpt(CURLOPT_POSTFIELDSIZE, LEN(pBinData))
  ELSE
    SELF.SetOpt(CURLOPT_POSTFIELDSIZE, pDataLen)
  END

  RETURN SELF.SendRequestStr(pUrl, '', pResponseBuf, xferproc)

!!!endregion