!** libcurl for Clarion v1.71
!** 24.04.2026
!** mikeduglas@yandex.com
!** mikeduglas66@gmail.com

  MEMBER

  INCLUDE('libcurl.inc'), ONCE
  INCLUDE('cjson.inc'), ONCE

  MAP
    MODULE('Windows API')
      winapi::Sleep(LONG dwMilliseconds), PASCAL, PROC, NAME('Sleep')
      winapi::ShellExecute(LONG phWnd, <*CSTRING pAction>, *CSTRING pFilename, <*CSTRING pParameters>, <*CSTRING pDirectory>, LONG pFlags=1), LONG, PASCAL, RAW, PROC, NAME('ShellExecuteA')
    END
    INCLUDE('printf.inc'), ONCE
  END

!!RPC endpoints
!!  These endpoints accept arguments as JSON in the request body and return results as JSON in the response body. 
!!  RPC endpoints are on the api.dropboxapi.com domain. 
!!
!!Content-upload endpoints
!!  These endpoints accept file content in the request body, so their arguments are instead passed as JSON 
!!  in the Dropbox-API-Arg request header or arg URL parameter. These endpoints are on the content.dropboxapi.com domain. 
!!
!!Content-download endpoints
!!  As with content-upload endpoints, arguments are passed in the Dropbox-API-Arg request header or arg URL parameter. 
!!  The response body contains file content, so the result will appear as JSON in the Dropbox-API-Result response header. 
!!  These endpoints are also on the content.dropboxapi.com domain. 


!!!region private constants
domain_API                    STRING('https://api.dropboxapi.com')      ! api namespace
domain_Content                STRING('https://content.dropboxapi.com')  ! content namespace

ns_Files                      STRING('/2/files/')
ns_Users                      STRING('/2/users/')
ns_Sharing                    STRING('/2/sharing/')
ns_OAuth2                     STRING('/oauth2/')

!!!endregion

!!!region TCurlDropboxClass

TCurlDropboxClass.Construct   PROCEDURE()
  CODE
  SELF._response &= NewDynStr()

TCurlDropboxClass.Destruct    PROCEDURE()
  CODE
  SELF._response.Kill()
  DisposeDynStr(SELF._response)
    
TCurlDropboxClass.AccessToken PROCEDURE(STRING pAccessToken)
  CODE
  ASSERT(pAccessToken)
  SELF._accessToken = pAccessToken
  
TCurlDropboxClass.AccessToken PROCEDURE()
  CODE
  RETURN SELF._accessToken
        
TCurlDropboxClass.RefreshToken    PROCEDURE(STRING pRefreshToken)
  CODE
  SELF._refreshToken = pRefreshToken

TCurlDropboxClass.RefreshToken    PROCEDURE()
  CODE
  RETURN SELF._refreshToken

TCurlDropboxClass.Authorize   PROCEDURE(STRING pAppKey)
szAction                        CSTRING('open')
szUrl                           CSTRING(1024), AUTO
  CODE
  szUrl = printf('https://www.dropbox.com/oauth2/authorize?response_type=code&client_id=%s&token_access_type=offline', pAppKey)
  winapi::ShellExecute(0, szAction, szUrl, , , SW_SHOWNORMAL)

TCurlDropboxClass.CheckAccessTokenValidity    PROCEDURE(STRING pAccessToken)
func                                            STRING('get_current_account')
  CODE
  SELF.FreeHttpHeaders()
  SELF.AddHttpHeader('Authorization: Bearer '& pAccessToken)
  SELF.SetHttpHeaders()
  SELF._lastCurlCode = SELF.Send(domain_API, ns_Users, func)
  IF SELF._lastCurlCode = CURLE_OK AND SELF.GetResponseCode() = 200
    RETURN TRUE
  END
  RETURN FALSE
  
TCurlDropboxClass.AccessToken PROCEDURE(STRING pAuthCode, STRING pAppKey, STRING pAppSecret)
func                            STRING('token')
args                            STRING(1024), AUTO
sResponse                       ANY, AUTO
jParser                         cJSONFactory
jResponse                       &cJSON, AUTO
access_token:start              LONG, AUTO
access_token:end                LONG, AUTO
  CODE
  args = printf('code=%s&grant_type=authorization_code&client_id=%s&client_secret=%s', pAuthCode, pAppKey, pAppSecret)
  SELF._lastCurlCode = SELF.SetAuthEndpoint(args)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  SELF._lastCurlCode = SELF.Send(domain_API, ns_OAuth2, func)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  IF SELF.GetResponseCode() = 200
    !- access token is valid
    !- parse json response, format is:
    !- {"access_token": "<ACCESS_TOKEN>", "token_type": "bearer", "uid": "<UID>"}
    sResponse = SELF.DropboxResponse()
    jResponse &= jParser.Parse(sResponse)
    IF NOT jResponse &= NULL
      SELF.AccessToken(jResponse.GetValue('access_token'))
      SELF.RefreshToken(jResponse.GetValue('refresh_token'))
      jResponse.Delete()
      RETURN TRUE
    ELSE
      !- parsing error
      printd('TCurlDropboxClass.AccessToken response: %s', sResponse)
      printd('TCurlDropboxClass.AccessToken: error (%s at pos %i) parsing api response', jParser.GetError(), jParser.GetErrorPosition())
      RETURN FALSE
    END
  ELSE
    !- access token is invalid
  END
  
TCurlDropboxClass.ExchangeCode    PROCEDURE(STRING pRefreshToken, STRING pAppKey, STRING pAppSecret)
func                                STRING('token')
sResponse                           ANY, AUTO
jParser                             cJSONFactory
jResponse                           &cJSON, AUTO
access_token:start                  LONG, AUTO
access_token:end                    LONG, AUTO
  CODE
  SELF._lastCurlCode = SELF.SetAuthEndpoint(printf('refresh_token=%s&grant_type=refresh_token&client_id=%s&client_secret=%s', pRefreshToken, pAppKey, pAppSecret))
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  SELF._lastCurlCode = SELF.Send(domain_API, ns_OAuth2, func)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  IF SELF.GetResponseCode() <> 200
    RETURN FALSE
  END

  !- parse json response, format is:
  !- {"access_token": "<ACCESS_TOKEN>", "token_type": "bearer", "expires_in": 14400}
  sResponse = SELF.DropboxResponse()
  jResponse &= jParser.Parse(sResponse)
  IF NOT jResponse &= NULL
    SELF.AccessToken(jResponse.GetValue('access_token'))
    jResponse.Delete()
    RETURN TRUE
  ELSE
    !- parsing error
    printd('TCurlDropboxClass.ExchangeCode response: %s', sResponse)
    printd('TCurlDropboxClass.ExchangeCode error (%s at pos %i) parsing api response', jParser.GetError(), jParser.GetErrorPosition())
    RETURN FALSE
  END

TCurlDropboxClass.Send        PROCEDURE(STRING pDomain, STRING pNamespace, STRING pFunction)
  CODE
  !-- POST request
  SELF.SetCustomRequest('POST')
  !-- insecure
  SELF.SetSSLVerifyPeer(FALSE)
  SELF.SetSSLVerifyHost(FALSE)
  
  !- reset response buffer
  SELF._response.Kill()

  !-- send request
  RETURN SELF.SendRequest(CLIP(pDomain) & CLIP(pNamespace) & CLIP(pFunction), SELF._response)

TCurlDropboxClass.SetAuthEndpoint PROCEDURE(STRING pPostFields)
rc                                  CURLcode, AUTO
  CODE
  !-- http header
  SELF.FreeHttpHeaders()
  SELF.AddHttpHeader('Expect: ')
  rc = SELF.SetHttpHeaders()
  IF rc <> CURLE_OK
    RETURN rc
  END
  
  !-- arguments
  SELF.SetOpt(CURLOPT_POSTFIELDS, pPostFields)
  SELF.SetOpt(CURLOPT_POSTFIELDSIZE, LEN(CLIP(pPostFields)))

  RETURN CURLE_OK

TCurlDropboxClass.SetRPCEndpoint  PROCEDURE(STRING pJsonArgs)
rc                                  CURLcode, AUTO
  CODE
  IF SELF._accessToken = ''
    RETURN CURLE_HTTP_POST_ERROR
  END

  !-- http header
  SELF.FreeHttpHeaders()
  SELF.AddHttpHeader('Authorization: Bearer '& SELF._accessToken)
  SELF.AddHttpHeader('Content-Type: application/json')
  SELF.AddHttpHeader('Expect: ')
  rc = SELF.SetHttpHeaders()
  IF rc <> CURLE_OK
    RETURN rc
  END
    
  !-- arguments
  SELF.SetOpt(CURLOPT_POSTFIELDS, pJsonArgs)
  SELF.SetOpt(CURLOPT_POSTFIELDSIZE, LEN(CLIP(pJsonArgs)))

  RETURN CURLE_OK

TCurlDropboxClass.SetContentUploadEndpoint    PROCEDURE(STRING pJsonArgs)
rc                                              CURLcode, AUTO
  CODE
  IF SELF._accessToken = ''
    RETURN CURLE_HTTP_POST_ERROR
  END

  !-- http header
  SELF.FreeHttpHeaders()
  SELF.AddHttpHeader('Authorization: Bearer '& SELF._accessToken)
  SELF.AddHttpHeader('Content-Type: application/octet-stream')
  SELF.AddHttpHeader('Dropbox-API-Arg: '& CLIP(pJsonArgs))  !-- arguments
  rc = SELF.SetHttpHeaders()
  IF rc <> CURLE_OK
    RETURN rc
  END
  
  !-- reset postfields
  SELF.SetOpt(CURLOPT_POSTFIELDS, '')
  SELF.SetOpt(CURLOPT_POSTFIELDSIZE, 0)

  RETURN CURLE_OK

TCurlDropboxClass.SetContentDownloadEndpoint  PROCEDURE(STRING pJsonArgs)
rc                                              CURLcode, AUTO
  CODE
  IF SELF._accessToken = ''
    RETURN CURLE_HTTP_POST_ERROR
  END
  
  !-- http header
  SELF.FreeHttpHeaders()
  SELF.AddHttpHeader('Authorization: Bearer '& SELF._accessToken)
  SELF.AddHttpHeader('Content-Type: ')  !- empty Content-Type required by this api
  SELF.AddHttpHeader('Dropbox-API-Arg: '& CLIP(pJsonArgs))  !-- arguments
  rc = SELF.SetHttpHeaders()
  IF rc <> CURLE_OK
    RETURN rc
  END

  !-- reset postfields
  SELF.SetOpt(CURLOPT_POSTFIELDS, '')
  SELF.SetOpt(CURLOPT_POSTFIELDSIZE, 0)

  RETURN CURLE_OK

TCurlDropboxClass.Copy        PROCEDURE(STRING pFromPath, STRING pToPath)
func                            STRING('copy')
jArgs                           &cJSON, AUTO
  CODE
  jArgs &= json::CreateObject()
  jArgs.AddStringToObject('from_path', pFromPath)
  jArgs.AddStringToObject('to_path', pToPath)
  SELF._lastCurlCode = SELF.SetRPCEndpoint(jArgs.ToUtf8())
  jArgs.Delete()
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  SELF._lastCurlCode = SELF.Send(domain_API, ns_Files, func)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  RETURN CHOOSE(SELF.GetResponseCode() = 200, TRUE)
    
TCurlDropboxClass.Move        PROCEDURE(STRING pFromPath, STRING pToPath)
func                            STRING('move')
jArgs                           &cJSON, AUTO
  CODE
  jArgs &= json::CreateObject()
  jArgs.AddStringToObject('from_path', pFromPath)
  jArgs.AddStringToObject('to_path', pToPath)
  SELF._lastCurlCode = SELF.SetRPCEndpoint(jArgs.ToUtf8())
  jArgs.Delete()
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  SELF._lastCurlCode = SELF.Send(domain_API, ns_Files, func)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  RETURN CHOOSE(SELF.GetResponseCode() = 200, TRUE)

TCurlDropboxClass.CreateFolder    PROCEDURE(STRING pPath)
func                                STRING('create_folder')
jArgs                               &cJSON, AUTO
  CODE
  jArgs &= json::CreateObject()
  jArgs.AddStringToObject('path', pPath)
  SELF._lastCurlCode = SELF.SetRPCEndpoint(jArgs.ToUtf8())
  jArgs.Delete()
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  SELF._lastCurlCode = SELF.Send(domain_API, ns_Files, func)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  RETURN CHOOSE(SELF.GetResponseCode() = 200, TRUE)

TCurlDropboxClass.Delete      PROCEDURE(STRING pPath)
func                            STRING('delete')
jArgs                           &cJSON, AUTO
  CODE
  jArgs &= json::CreateObject()
  jArgs.AddStringToObject('path', pPath)
  SELF._lastCurlCode = SELF.SetRPCEndpoint(jArgs.ToUtf8())
  jArgs.Delete()

  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  SELF._lastCurlCode = SELF.Send(domain_API, ns_Files, func)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  RETURN CHOOSE(SELF.GetResponseCode() = 200, TRUE)

TCurlDropboxClass.Download    PROCEDURE(STRING pRemotePath, STRING pLocalPath)
func                            STRING('download')
jArgs                           &cJSON, AUTO
fs                              TCurlFileStruct
dwBytes                         LONG, AUTO
  CODE
  jArgs &= json::CreateObject()
  jArgs.AddStringToObject('path', pRemotePath)
  SELF._lastCurlCode = SELF.SetContentDownloadEndpoint(jArgs.ToUtf8())
  jArgs.Delete()
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  SELF._lastCurlCode = SELF.Send(domain_Content, ns_Files, func)
  IF SELF._lastCurlCode = CURLE_OK
    IF SELF.GetResponseCode() = 200 !- HTTP OK
      !-- save file
      fs.Init(pLocalPath)
      IF fs.CreateFile()
        IF fs.WriteFile(SELF._response.CStrRef(), SELF._response.StrLen(), dwBytes)
          RETURN TRUE
        END
      END
    END
  END
  
  RETURN FALSE

TCurlDropboxClass.Upload      PROCEDURE(STRING pLocalPath, STRING pRemotePath, <STRING pMode>, BOOL pAutorename = FALSE)
func                            STRING('upload')
jArgs                           &cJSON, AUTO
fileContent                     &STRING, AUTO
  CODE
  jArgs &= json::CreateObject()
  jArgs.AddStringToObject('path', pRemotePath)
  IF pMode
    jArgs.AddStringToObject('mode', pMode)
  END
  IF pAutorename
    jArgs.AddTrueToObject('autorename')
  END
  
  SELF._lastCurlCode = SELF.SetContentUploadEndpoint(jArgs.ToUtf8())
  jArgs.Delete()
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  !-- file to upload
  fileContent &= curl::GetFileContents(pLocalPath)
  SELF._lastCurlCode = SELF.SetOpt(CURLOPT_POSTFIELDS, ADDRESS(fileContent))
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END  
  SELF._lastCurlCode = SELF.SetOpt(CURLOPT_POSTFIELDSIZE_LARGE, LEN(fileContent))
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END  

  winapi::Sleep(10) !-- workaround for "Jason string invalid" error returned by Send().
  
  SELF._lastCurlCode = SELF.Send(domain_Content, ns_Files, func)
  
  DISPOSE(fileContent)
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  RETURN CHOOSE(SELF.GetResponseCode() = 200, TRUE)
  
TCurlDropboxClass.ListFolder  PROCEDURE(STRING pPath, BOOL pRecursive = FALSE)
func                            STRING('list_folder')
jArgs                           &cJSON, AUTO
  CODE
  jArgs &= json::CreateObject()
  jArgs.AddStringToObject('path', pPath)
  IF pRecursive
    jArgs.AddTrueToObject('recursive')
  END

  SELF._lastCurlCode = SELF.SetRPCEndpoint(jArgs.ToUtf8())
  jArgs.Delete()
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  SELF._lastCurlCode = SELF.Send(domain_API, ns_Files, func)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  RETURN CHOOSE(SELF.GetResponseCode() = 200, TRUE)

TCurlDropboxClass.Get_Copy_Reference  PROCEDURE(STRING pPath)
func                                    STRING('copy_reference/get')
jArgs                                   &cJSON, AUTO
  CODE
  jArgs &= json::CreateObject()
  jArgs.AddStringToObject('path', pPath)
  SELF._lastCurlCode = SELF.SetRPCEndpoint(jArgs.ToUtf8())
  jArgs.Delete()
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  SELF._lastCurlCode = SELF.Send(domain_API, ns_Files, func)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  RETURN CHOOSE(SELF.GetResponseCode() = 200, TRUE)
  
TCurlDropboxClass.Save_Copy_Reference PROCEDURE(STRING pPath, STRING pCopyReference)
func                                    STRING('copy_reference/save')
jArgs                                   &cJSON, AUTO
  CODE
  jArgs &= json::CreateObject()
  jArgs.AddStringToObject('path', pPath)
  jArgs.AddStringToObject('copy_reference', pCopyReference)
  SELF._lastCurlCode = SELF.SetRPCEndpoint(jArgs.ToUtf8())
  jArgs.Delete()
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  SELF._lastCurlCode = SELF.Send(domain_API, ns_Files, func)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  RETURN CHOOSE(SELF.GetResponseCode() = 200, TRUE)

TCurlDropboxClass.Preview     PROCEDURE(STRING pPath, *STRING pTmpFile)
func                            STRING('get_preview')
jArgs                           &cJSON, AUTO
htmlDocTypeStr                  STRING('<<!DOCTYPE html>')
pdfDocTypeStr                   STRING('%PDF')
fs                              TCurlFileStruct
dwBytes                         LONG, AUTO
rc                              BOOL(FALSE)
  CODE
  jArgs &= json::CreateObject()
  jArgs.AddStringToObject('path', pPath)
  SELF._lastCurlCode = SELF.SetContentDownloadEndpoint(jArgs.ToUtf8())
  jArgs.Delete()
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  SELF._lastCurlCode = SELF.Send(domain_Content, ns_Files, func)
  IF SELF._lastCurlCode = CURLE_OK
    IF SELF.GetResponseCode() = 200 !- HTTP OK
      IF INSTRING(htmlDocTypeStr, SELF._response.Str(), 1, 1) = 1
        pTmpFile = CLIP(pTmpFile) &'.html'
      ELSIF INSTRING(pdfDocTypeStr, SELF._response.Str(), 1, 1) = 1
        pTmpFile = CLIP(pTmpFile) &'.pdf'
      ELSE
        RETURN FALSE
      END

      !-- save temp file
      fs.Init(pTmpFile)
      IF fs.CreateFile()
        IF fs.WriteFile(SELF._response.CStrRef(), SELF._response.StrLen(), dwBytes)
          rc = TRUE
        END
      END
    END
  END
  
  RETURN rc

TCurlDropboxClass.Thumbnail   PROCEDURE(STRING pPath, TDbxThumbnailFormat pFormat, TDbxThumbnailSize pSize, *STRING pTmpFile)
func                            STRING('get_thumbnail')
jArgs                           &cJSON, AUTO
fs                              TCurlFileStruct
dwBytes                         LONG, AUTO
rc                              BOOL(FALSE)
  CODE
  jArgs &= json::CreateObject()
  jArgs.AddStringToObject('path', pPath)
  jArgs.AddStringToObject('format', pFormat)
  jArgs.AddStringToObject('size', pSize)
  SELF._lastCurlCode = SELF.SetContentDownloadEndpoint(jArgs.ToUtf8())
  jArgs.Delete()
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END
  
  SELF._lastCurlCode = SELF.Send(domain_Content, ns_Files, func)
  IF SELF._lastCurlCode = CURLE_OK
    IF SELF.GetResponseCode() = 200 !- HTTP OK
      !-- save temp file
      fs.Init(pTmpFile)
      IF fs.CreateFile()
        IF fs.WriteFile(SELF._response.CStrRef(), SELF._response.StrLen(), dwBytes)
          rc = TRUE
        END
      END
    END
  END
  
  RETURN rc

TCurlDropboxClass.DropboxResponse PROCEDURE()
  CODE
  RETURN SELF._response.Str()

TCurlDropboxClass.CurlResponse    PROCEDURE()
  CODE
  RETURN SELF._lastCurlCode
!!!endregion