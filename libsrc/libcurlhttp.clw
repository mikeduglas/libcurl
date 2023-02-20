!** libcurl for Clarion v1.57
!** 20.02.2023
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

    GetLocalFileName(STRING pLocalFile, STRING pAttachment, STRING pUrl), STRING, PRIVATE
  END

!!!region helpers
GetLocalFileName              PROCEDURE(STRING pLocalFile, STRING pAttachment, STRING pUrl)
nLen                            LONG, AUTO
uapi                            TCurlUrlApiClass
sRemotePath                     STRING(1024), AUTO
slashPos                        LONG, AUTO
  CODE
  nLen = LEN(CLIP(pLocalFile))
  
  IF nLen AND pLocalFile[nLen] <> '\' AND pLocalFile[nLen] <> '/'
    !- pLocalFile is a filename
    RETURN pLocalFile
  END
  
  IF pAttachment
    !- pLocalFile is a folder or an empty string, use pAttachment as an actual name
    RETURN CLIP(pLocalFile) & pAttachment
  END
  
  !- extract filename from pUrl
  uapi.Init()
  uapi.SetPart(CURLUPART_URL, pUrl, 0)
  uapi.GetPart(CURLUPART_PATH, sRemotePath)

  !- find trailing /
  nLen = LEN(CLIP(sRemotePath))
  slashPos = INSTRING('/', sRemotePath, -1, nLen)
  IF slashPos
    RETURN CLIP(pLocalFile) & sRemotePath[slashPos+1 : nLen]
  END
  
  !- unable to get local name
  RETURN ''
!!!endregion

!!!region TCurlHttpClass
TCurlHttpClass.Destruct       PROCEDURE()
  CODE
  SELF.FormFree()
  
TCurlHttpClass.HeaderCallback PROCEDURE(STRING pHeaderLine)
pos1                            LONG, AUTO
len                             LONG, AUTO
  CODE
  IF NOT SELF.bAcceptRangesEnabled
    IF UPPER(SUB(pHeaderLine, 1, SIZE('ACCEPT-RANGES:'))) = 'ACCEPT-RANGES:'
      SELF.bAcceptRangesEnabled = TRUE
    END
  END
  IF NOT SELF.sAttachment
    IF UPPER(SUB(pHeaderLine, 1, SIZE('CONTENT-DISPOSITION:'))) = 'CONTENT-DISPOSITION:'
      pos1 = INSTRING('FILENAME=', UPPER(pHeaderLine), 1, SIZE('CONTENT-DISPOSITION:'))
      IF pos1
        SELF.sAttachment = SUB(pHeaderLine, pos1+SIZE('FILENAME='), SIZE(pHeaderLine))
        !- remove double qoutes
        len = LEN(CLIP(SELF.sAttachment))
        pos1 = INSTRING('"', SELF.sAttachment, -1, len)
        IF pos1 >= 2
          SELF.sAttachment = SELF.sAttachment[2 : pos1-1]
        END
      END
    END
  END
  
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

TCurlHttpClass.DownloadFile   PROCEDURE(STRING pRemoteFile, <STRING pLocalFile>, ULONG pBlockSize=0, BOOL pAppend=FALSE, USHORT pRetries=5, <curl::ProgressDataProcType xferproc>)
sLocalFile                      STRING(MAX_PATH), AUTO
  CODE
  sLocalFile = pLocalFile
  RETURN SELF.DownloadFile(pRemoteFile, sLocalFile, pBlockSize, pRetries, pAppend, xferproc)
  
TCurlHttpClass.DownloadFile   PROCEDURE(STRING pRemoteFile, *STRING pLocalFile, ULONG pBlockSize=0, BOOL pAppend=FALSE, USHORT pRetries=5, <curl::ProgressDataProcType xferproc>)
sLocalFile                      STRING(MAX_PATH), AUTO
fs                              LIKE(TCurlFileStruct)
nContentLength                  ULONG, AUTO
nRange1                         ULONG, AUTO
nRange2                         ULONG, AUTO
sByteRange                      CSTRING(22), AUTO   ! 2x10 digits and '-' sign = 21 characters
dwBytesRead                     ULONG, AUTO
httpCode                        LONG, AUTO
nRetryCount                     USHORT, AUTO
res                             CURLcode, AUTO
  CODE
  !- reset bAcceptRangesEnabled
  SELF.bAcceptRangesEnabled = FALSE
  
  ! progress
  SELF.SetXFerCallback(xferproc)
  
  ! header callback
  SELF.SetHeaderCallback(curl::HeaderCallback)

  ! remote file
  SELF.SetUrl(pRemoteFile)
  
  !- follow HTTP 3xx redirects
  SELF.FollowLocation(TRUE)

  ! do the download request without getting the body ("HEAD" method)
  SELF.SetOpt(CURLOPT_NOBODY, 1)  
  
  ! fail the request if the HTTP code returned is equal to or larger than 400. The default action would be to return the page normally, ignoring that code.
  SELF.SetOpt(CURLOPT_FAILONERROR, 1)  

  res = SELF.Perform()
  IF res <> CURLE_OK
    !- can't connect
    httpCode = SELF.GetInfo::LONG(CURLINFO_RESPONSE_CODE)
    CASE httpCode
    OF 405  !- Method Not Allowed
      !- "HEAD" method is not allowed, so continue without the header info
    ELSE
      !- abort
      RETURN res
    END
  END
    
  ! set WriteFile callback
  sLocalFile = GetLocalFileName(pLocalFile, SELF.sAttachment, pRemoteFile)
  IF NOT sLocalFile
    curl::DebugInfo('TCurlHttpClass.DownloadFile: Target filename is blank.')
    RETURN CURLE_URL_MALFORMAT
  END
  
  !- return actual filename to the caller
  pLocalFile = sLocalFile

  !- force the HTTP request to get back to using GET
  SELF.SetOpt(CURLOPT_NOBODY, 0)  
  SELF.SetOpt(CURLOPT_HTTPGET, 1)  

  ! reset header callback as we already parsed the header earlier.
  SELF.ResetHeaderCallback()

  IF NOT SELF.bAcceptRangesEnabled
    !- Accept-Ranges header is missing: call ReadFile instead,
    curl::DebugInfo('TCurlHttpClass.DownloadFile: Accept-Ranges header is missing, continue with ReadFile.')
    RETURN PARENT.ReadFile(pRemoteFile, sLocalFile, xferproc)
  END
  
  !- write callback
  fs.Init(sLocalFile)
  IF NOT pAppend
    !- create new file
    SELF.SetWriteCallback(curl::FileWrite, ADDRESS(fs))
  ELSE
    !- open existing file and append data to the end
    SELF.SetWriteCallback(curl::FileAppend, ADDRESS(fs))
  END

  !- get the Content-Length header
  nContentLength = SELF.GetInfo::OFF_T(CURLINFO_CONTENT_LENGTH_DOWNLOAD_T)
  IF nContentLength = 0FFFFFFFFh  ! -1
    !- no Content-Length header found
    nContentLength = 0
  END

  !- set byte range to request (0..pBlockSize-1)
  IF NOT pAppend
    !- download from beginning
    nRange1 = 0
  ELSE
    !- download from EOF
    nRange1 = fs.GetFileSize()
  END
  sByteRange = nRange1 &'-'
  IF pBlockSize AND nRange1+pBlockSize < nContentLength
    nRange2 = nRange1 + pBlockSize-1
    sByteRange = sByteRange & nRange2
  END
  SELF.SetOpt(CURLOPT_RANGE, sByteRange)  

  ! perform request
  nRetryCount = 0
  
  LOOP
    res = SELF.Perform()
    httpCode = SELF.GetInfo::LONG(CURLINFO_RESPONSE_CODE)

    IF res = CURLE_OK
      !- reset retry counter
      nRetryCount = 0
      
      CASE httpCode
      OF 200  !- Success
        BREAK
        
      OF 206  !- Partial Content
        dwBytesRead = SELF.GetInfo::OFF_T(CURLINFO_SIZE_DOWNLOAD_T)
        
        !- set next byte range
        nRange1 += dwBytesRead
        IF nRange1 >= nContentLength
          !- downloading completed
          BREAK
        END

        sByteRange = nRange1 &'-'
        IF pBlockSize AND nRange1+pBlockSize < nContentLength
          nRange2 = nRange1+pBlockSize-1
          sByteRange = sByteRange & nRange2
        END
        SELF.SetOpt(CURLOPT_RANGE, sByteRange)
      END
    ELSE
      !- Perform failed
      
      CASE res 
      OF CURLE_OPERATION_TIMEDOUT
      OROF CURLE_COULDNT_CONNECT
        nRetryCount += 1
        IF nRetryCount >= pRetries
          !- too many errors: abort
          BREAK
        END
      
        curl::DebugInfo('TCurlHttpClass.DownloadFile: '& SELF.StrError(res) &', try again...')
        YIELD()
        CYCLE
      END
      
      CASE httpCode
      OF   400  !- Bad request
      OROF 404  !- Not found
        nRetryCount += 1
        IF nRetryCount >= pRetries
          !- too many errors: abort
          BREAK
        END
        
        !- try again
        curl::DebugInfo('TCurlHttpClass.DownloadFile: HTTP error '& httpCode &', try again...')
        YIELD()
      OF 416    !- Range Not Satisfiable
        ! range is out of bounds
        ! this could happen if Content-Length is unknown (nContentLength==-1) and we exceed the actual downloading file size.
        ! so ignore this error and return OK
        res = CURLE_OK
        BREAK
      ELSE
        IF httpCode > 400
          !- abort on any other fatal error
          curl::DebugInfo('TCurlHttpClass.DownloadFile: HTTP fatal error '& httpCode &', abort downloading')
          BREAK
        ELSE
          !- abort on unexpected error (3xx)
          curl::DebugInfo('TCurlHttpClass.DownloadFile: HTTP unexpected error '& httpCode &', abort downloading')
          BREAK
        END
      END
    END
  END
  
  RETURN res
!!!endregion