!** libcurl for Clarion v1.09
!** 14.04.2016
!** mikeduglas66@gmail.com

  MEMBER

  INCLUDE('libcurl.inc')

  MAP
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
  DisposeDynStr(SELF._response)
    
TCurlDropboxClass.AccessToken PROCEDURE(STRING pAccessToken)
  CODE
  ASSERT(pAccessToken)
  SELF._accessToken = pAccessToken
  
TCurlDropboxClass.AccessToken PROCEDURE()
  CODE
  RETURN CLIP(SELF._accessToken)
  
TCurlDropboxClass.Authorize   PROCEDURE(STRING pAppKey)
szAction                        CSTRING('open')
szUrl                           CSTRING(256)
  CODE
  szUrl = 'https://www.dropbox.com/oauth2/authorize?response_type=code&client_id='& CLIP(pAppKey)
  winapi::ShellExecute(0, szAction, szUrl, , , SW_SHOWNORMAL)

TCurlDropboxClass.AccessToken PROCEDURE(STRING pAuthCode, STRING pAppKey, STRING pAppSecret)
func                            STRING('token')
args                            CSTRING(1024)
!json parsing
access_token:start              LONG, AUTO
access_token:end                LONG, AUTO
  CODE
  args = 'code='& CLIP(pAuthCode) &'&grant_type=authorization_code' &'&client_id='&CLIP(pAppKey) &'&client_secret='& CLIP(pAppSecret)
  SELF._lastCurlCode = SELF.SetAuthEndpoint(args)
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
  !- {"access_token": "<ACCESS_TOKEN>", "token_type": "bearer", "uid": "<UID>"} 
  access_token:start = INSTRING('{{"access_token": "', SELF.DropboxResponse(), 1, 1)
  IF access_token:start
    access_token:start += LEN('{{"access_token": "')
    access_token:end = INSTRING('"', SELF.DropboxResponse(), 1, access_token:start)
    IF access_token:end > 0
      SELF.AccessToken(SUB(SELF.DropboxResponse(), access_token:start, access_token:end - access_token:start))
      RETURN TRUE
    END
  END

  !- parsing error
  RETURN FALSE

TCurlDropboxClass.Send        PROCEDURE(STRING pDomain, STRING pNamespace, STRING pFunction)
UserAgent                       CSTRING('curl/7.40.0')
  CODE
  !-- POST request
  SELF.SetCustomRequest('POST')
  !-- user agent
  SELF.SetOpt(CURLOPT_USERAGENT, UserAgent)
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
  SELF.AddHttpHeader('Authorization: Bearer '& CLIP(SELF._accessToken))
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
  SELF.AddHttpHeader('Authorization: Bearer '& CLIP(SELF._accessToken))
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
  SELF.AddHttpHeader('Authorization: Bearer '& CLIP(SELF._accessToken))
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
args                            CSTRING(256)
  CODE
  args = '{{"from_path": "'& CLIP(pFromPath) &'","to_path": "'& CLIP(pToPath) &'"}'
  SELF._lastCurlCode = SELF.SetRPCEndpoint(args)
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
args                            CSTRING(256)
  CODE
  args = '{{"from_path": "'& CLIP(pFromPath) &'","to_path": "'& CLIP(pToPath) &'"}'
  SELF._lastCurlCode = SELF.SetRPCEndpoint(args)
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
args                                CSTRING(256)
  CODE
  args = '{{"path": "'& CLIP(pPath) &'"}'
  SELF._lastCurlCode = SELF.SetRPCEndpoint(args)
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
args                            CSTRING(256)
  CODE
  args = '{{"path": "'& CLIP(pPath) &'"}'
  SELF._lastCurlCode = SELF.SetRPCEndpoint(args)
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
args                            CSTRING(256)
fs                              TCurlFileStruct
dwBytes                         LONG, AUTO
  CODE
  args = '{{"path": "'& CLIP(pRemotePath) &'"}'
  SELF._lastCurlCode = SELF.SetContentDownloadEndpoint(args)
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
args                            CSTRING(1024)
fileContent                     &STRING
  CODE
  args = '{{"path": "'& CLIP(pRemotePath) &'"'
  IF pMode
    args = args & ', "mode": "'& CLIP(pMode) &'"'
  END
  IF pAutorename
    args = args & ', "autorename": true'
  END
  args = args &'}'
  
  SELF._lastCurlCode = SELF.SetContentUploadEndpoint(args)
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

  SELF._lastCurlCode = SELF.Send(domain_Content, ns_Files, func)
  
  DISPOSE(fileContent)
  
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  RETURN CHOOSE(SELF.GetResponseCode() = 200, TRUE)
  
TCurlDropboxClass.ListFolder  PROCEDURE(STRING pPath, BOOL pRecursive = FALSE)
func                            STRING('list_folder')
args                            CSTRING(256)
  CODE
  args = '{{"path": "'& CLIP(pPath) &'"'
  IF pRecursive
    args = args &', "recursive": true'
  END
  args = args &'}'

  SELF._lastCurlCode = SELF.SetRPCEndpoint(args)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  SELF._lastCurlCode = SELF.Send(domain_API, ns_Files, func)
  IF SELF._lastCurlCode <> CURLE_OK
    RETURN FALSE
  END

  RETURN CHOOSE(SELF.GetResponseCode() = 200, TRUE)

TCurlDropboxClass.DropboxResponse PROCEDURE()
  CODE
  RETURN SELF._response.Str()

TCurlDropboxClass.CurlResponse    PROCEDURE()
  CODE
  RETURN SELF._lastCurlCode
  
!!!endregion