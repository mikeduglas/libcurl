!** libcurl for Clarion v1.00 
!** 12.11.2015
!** mikeduglas66@gmail.com


  PROGRAM

  PRAGMA('project(#compile libcurl.clw)')
  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')

TXFerInfo                     GROUP, TYPE
Url                             STRING(256)
Filename                        STRING(256)
User                            STRING(20)
Pwd                             STRING(20)
PostParams                      STRING(256)
                              END

THttpHeaders                   QUEUE, TYPE
HttpHeader                      STRING(256)
                              END

TSSLInfo                      GROUP, TYPE
bUseSSL                         BOOL
Version                         CURL_SSLVERSION_ENUM
bVerifyHost                     BOOL
bVerifyPeer                     BOOL
Certificate                     STRING(255)
                              END
  
  MAP
    ReadFile(TXFerInfo xferinfo)
    WriteFile(TXFerInfo xferinfo)
    SendRequest(TXFerInfo xferinfo, THttpHeaders headers, TSSLInfo ssl, BOOL pGetResponse, BOOL pSaveToFile)
  END

Download                      LIKE(TXFerInfo), PRE(Download)
Upload                        LIKE(TXFerInfo), PRE(Upload)
Send                          LIKE(TXFerInfo), PRE(Send)

bShowDownloadPwd              BYTE
bShowUploadPwd                BYTE
bShowHttpPwd                  BYTE

HttpHeader                    STRING(256)
HttpHeaders                   QUEUE(THttpHeaders), PRE(HttpHeaders)
                              END

bGetServerResponse            BOOL
bSaveServerResponseToFile     BOOL

SSLInfo                       LIKE(TSSLInfo), PRE(SSLInfo)

Window                        WINDOW('libcurl demo'),AT(,,425,278),CENTER,GRAY,FONT('Microsoft Sans Serif',8)
                                SHEET,AT(3,2,420,241),USE(?SHEET1)
                                  TAB('Download'),USE(?TAB1)
                                    PROMPT('Url:'),AT(17,44),USE(?PROMPT2)
                                    ENTRY(@s255),AT(58,42,353),USE(Download:Url)
                                    PROMPT('Local file:'),AT(17,68),USE(?PROMPT1)
                                    ENTRY(@s255),AT(58,67,353),USE(Download:Filename)
                                    PROMPT('User:'),AT(17,92),USE(?PROMPT5)
                                    ENTRY(@s20),AT(58,92),USE(Download:User)
                                    PROMPT('Password:'),AT(169,92),USE(?PROMPT6)
                                    ENTRY(@s20),AT(215,92),USE(Download:Pwd),PASSWORD
                                    CHECK(' Show password'),AT(324,91),USE(bShowDownloadPwd)
                                    BUTTON('Start!'),AT(12,214,50),USE(?bDownload)
                                    PROMPT('Bytes read:'),AT(115,214),USE(?lblBytesRead)
                                  END
                                  TAB('Upload'),USE(?TAB2)
                                    PROMPT('Url:'),AT(17,44),USE(?PROMPT3)
                                    ENTRY(@s255),AT(58,42,353),USE(Upload:Url)
                                    PROMPT('Local file:'),AT(17,68),USE(?PROMPT4)
                                    ENTRY(@s255),AT(58,67,353),USE(Upload:Filename)
                                    PROMPT('User:'),AT(17,92),USE(?PROMPT7)
                                    ENTRY(@s20),AT(58,92),USE(Upload:User)
                                    PROMPT('Password:'),AT(169,92),USE(?PROMPT8)
                                    ENTRY(@s20),AT(215,92),USE(Upload:Pwd),PASSWORD
                                    CHECK(' Show password'),AT(324,91),USE(bShowUploadPwd)
                                    BUTTON('Start!'),AT(12,214,50),USE(?bUpload)
                                    PROMPT('Bytes written:'),AT(115,214),USE(?lblBytesWritten)
                                  END
                                  TAB('Http'),USE(?TAB3)
                                    SHEET,AT(12,28,400,183),USE(?SHEET2)
                                      TAB('General'),USE(?TAB4)
                                        PROMPT('Url:'),AT(17,54),USE(?PROMPT10)
                                        ENTRY(@s255),AT(39,54,357),USE(Send:Url)
                                        PROMPT('Parameters (key=value&&ley=value):'),AT(17,74),USE(?PROMPT16)
                                        ENTRY(@s255),AT(139,73,257),USE(Send:PostParams)
                                        PROMPT('User:'),AT(17,94),USE(?PROMPT11)
                                        ENTRY(@s20),AT(58,92),USE(Send:User)
                                        PROMPT('Password:'),AT(166,94),USE(?PROMPT12)
                                        ENTRY(@s20),AT(211,92),USE(Send:Pwd),PASSWORD
                                        CHECK(' Show password'),AT(312,94),USE(bShowHttpPwd)
                                        PROMPT('Http header:'),AT(17,118),USE(?PROMPT13)
                                        ENTRY(@s255),AT(63,118),USE(HttpHeader)
                                        BUTTON('Add'),AT(214,118),USE(?bAddHttpHeader)
                                        BUTTON('Delete all'),AT(259,118),USE(?bFreeHttpHeaders)
                                        CHECK(' Use SSL'),AT(17,143),USE(SSLInfo:bUseSSL)
                                        CHECK(' Get server response'),AT(17,162),USE(bGetServerResponse)
                                        PROMPT('File:'),AT(124,185),USE(?PROMPT15)
                                        ENTRY(@s255),AT(142,183,254),USE(Send:Filename)
                                        CHECK(' Save response to File'),AT(17,185),USE(bSaveServerResponseToFile)
                                      END
                                      TAB('SSL'),USE(?tabSSL)
                                        ENTRY(@s255),AT(79,110,316),USE(SSLInfo:Certificate)
                                        CHECK(' Verify peer'),AT(36,90),USE(SSLInfo:bVerifyPeer)
                                        PROMPT('Certificate:'),AT(34,113),USE(?PROMPT9)
                                        CHECK(' Verify host'),AT(36,71),USE(SSLInfo:bVerifyHost)
                                        PROMPT('SSL version:'),AT(34,137),USE(?PROMPT14)
                                        LIST,AT(79,135,104,12),USE(SSLInfo:Version),DROP(10),FROM('Default|#' & |
                                          '0|TLSv1|#1|SSLv2|#2|SSLv3|#3|TLSv1_0|#4|TLSv1_1|#5|TLSv1_2|#6')
                                      END
                                      TAB('Server response'),USE(?TAB5)
                                        TEXT,AT(18,50,382,153),USE(?txtHttpResponse),VSCROLL
                                      END
                                    END
                                    BUTTON('Send!'),AT(12,214,50),USE(?bSendRequest)
                                  END
                                END
                                BUTTON('Close'),AT(376,254,47),USE(?bClose),STD(STD:Close)
                              END

TCurlClassEx                  CLASS(TCurlClass)
XFerInfo                        PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, DERIVED
                              END

  CODE
  !Init
  Download:Url = 'http://www.ingasoftplus.com/rss.php'
  Download:Filename = 'rss.php'
  Download:User = ''
  Download:Pwd = ''

  Upload:Url = 'sftp://192.168.100.2/file.bin'
  Upload:Filename = 'file.bin'
  Upload:User = 'username'
  Upload:Pwd = 'password'

  Send:Url = 'https://127.0.0.1/wsearch'
  Send:PostParams = 'ztoken=VIV0M53N369AUXZ6&tagno=928'
  Send:Filename = 'response.txt'
  
  SSLInfo:bVerifyHost = FALSE
  SSLInfo:bVerifyPeer = FALSE
  SSLInfo:Certificate = '.\certificates\mycert.crt'
  SSLInfo:Version = CURL_SSLVERSION_DEFAULT
  SSLInfo:bUseSSL = TRUE
  
  bGetServerResponse = TRUE
  
  OPEN(Window)
  ACCEPT
    CASE ACCEPTED()
    OF ?bShowDownloadPwd
      ?Download:Pwd{PROP:Password} = 1 - bShowDownloadPwd
    OF ?bShowUploadPwd
      ?Upload:Pwd{PROP:Password} = 1 - bShowUploadPwd
    OF ?bShowHttpPwd
      ?Send:Pwd{PROP:Password} = 1 - bShowHttpPwd
    OF ?bDownload
      ReadFile(Download)
    OF ?bUpload
      WriteFile(Upload)
    OF ?bSendRequest
      ?txtHttpResponse{PROP:Text} = ''
      DISPLAY(?txtHttpResponse)
      SendRequest(Send, HttpHeaders, SSLInfo, bGetServerResponse, bSaveServerResponseToFile)
    OF ?bAddHttpHeader
      IF HttpHeader
        HttpHeaders.HttpHeader = HttpHeader
        GET(HttpHeaders, HttpHeaders.HttpHeader)
        IF ERRORCODE()
          ADD(HttpHeaders)
        END
      END
    OF ?bFreeHttpHeaders
      FREE(HttpHeaders)
    OF ?SSLInfo:bUseSSL
      ?tabSSL{PROP:Disable} = 1 - SSLInfo:bUseSSL
    END
  END
  
  
    
TCurlClassEx.XFerInfo         PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
  CODE
  IF dlnow
    curl::DebugInfo('Downloaded '& dlnow &' bytes')
    ?lblBytesRead{PROP:Text} = 'Bytes read: '& dlnow
  END
  
  IF ulnow
    curl::DebugInfo('Uploaded '& ulnow &' bytes')
    ?lblBytesWritten{PROP:Text} = 'Bytes written: '& ulnow
  END
  
  RETURN 0

  

ReadFile                      PROCEDURE(TXFerInfo xferinfo)
curl                            TCurlClassEx
res                             CURLcode
  CODE
  ?lblBytesRead{PROP:Text} = 'Bytes read:'
  
  curl.Init()
  
  res = curl.SetUserPwd(xferinfo.User, xferinfo.Pwd)
  IF res <> CURLE_OK
    MESSAGE('SetUserPwd failed: '& curl.StrError(res), 'libcurl', ICON:Asterisk)
  END

  res = curl.ReadFile(xferinfo.Url, xferinfo.Filename)
  IF res = CURLE_OK
    MESSAGE('File successfully downloaded.', 'libcurl', ICON:Asterisk)
  ELSIF res = -1 
    MESSAGE('Cannot create local file', 'libcurl', ICON:Exclamation)
  ELSE
    MESSAGE('ReadFile failed: '& curl.StrError(res), 'libcurl', ICON:Exclamation)
  END

WriteFile                     PROCEDURE(TXFerInfo xferinfo)
curl                            TCurlClassEx
res                             CURLcode
  CODE  
  ?lblBytesWritten{PROP:Text} = 'Bytes written:'

  curl.Init()

  res = curl.SetUserPwd(xferinfo.User, xferinfo.Pwd)
  IF res <> CURLE_OK
    MESSAGE('SetUserPwd failed: '& curl.StrError(res), 'libcurl', ICON:Exclamation)
  END

  res = curl.WriteFile(xferinfo.Url, xferinfo.Filename)
  IF res = CURLE_OK
    MESSAGE('File successfully uploaded.', 'libcurl', ICON:Asterisk)
  ELSIF res = -1 
    MESSAGE('Cannot open local file', 'libcurl', ICON:Exclamation)
  ELSE
    MESSAGE('WriteFile failed: '& curl.StrError(res), 'libcurl', ICON:Exclamation)
  END

SendRequest                   PROCEDURE(TXFerInfo xferinfo, THttpHeaders headers, TSSLInfo ssl, BOOL pGetResponse, BOOL pSaveToFile)
curl                            TCurlClassEx
res                             CURLcode
qIndex                          LONG, AUTO

respBuffer                      STRING(32768) !big enuff to hold received response

  CODE  
  curl.Init()
    
  curl.FreeHttpHeaders()
  IF RECORDS(headers)
    LOOP qIndex = 1 TO RECORDS(headers)
      GET(headers, qIndex)
      curl.AddHttpHeader(headers.HttpHeader)
    END
    
    curl.SetHttpHeaders()
  END
  
  IF pGetResponse
    res = curl.SetHttpGET(TRUE)
  END

  res = curl.SetUserPwd(xferinfo.User, xferinfo.Pwd)
  IF res <> CURLE_OK
    MESSAGE('SetUserPwd failed: '& curl.StrError(res), 'libcurl', ICON:Exclamation)
  END

  IF ssl.bUseSSL
    res = curl.SetSSLVerifyHost(ssl.bVerifyHost)
    IF res <> CURLE_OK
      MESSAGE('SetSSLVerifyHost failed: '& curl.StrError(res), 'libcurl', ICON:Exclamation)
    END
  
    res = curl.SetSSLVerifyPeer(ssl.bVerifyPeer)
    IF res <> CURLE_OK
      MESSAGE('SetSSLVerifyPeer failed: '& curl.StrError(res), 'libcurl', ICON:Exclamation)
    END
  
    res = curl.SetSSLVersion(ssl.Version)
    IF res <> CURLE_OK
      MESSAGE('SetSSLVersion failed: '& curl.StrError(res), 'libcurl', ICON:Exclamation)
    END
    
    IF ssl.Certificate
      res = curl.SetCAInfo(ssl.Certificate)
      IF res <> CURLE_OK
        MESSAGE('SetCAInfo failed: '& curl.StrError(res), 'libcurl', ICON:Exclamation)
      END
    END
  END
  
  IF pSaveToFile
    res = curl.SendRequest(xferinfo.Url, xferinfo.PostParams, xferinfo.Filename)
  ELSE
    res = curl.SendRequestStr(xferinfo.Url, xferinfo.PostParams, respBuffer)
  END
  
  IF res = CURLE_OK
    MESSAGE('Request sent.', 'libcurl', ICON:Asterisk)
    
    IF NOT pSaveToFile
      ?txtHttpResponse{PROP:Text} = CLIP(respBuffer)
      DISPLAY(?txtHttpResponse)
      SELECT(?txtHttpResponse)
    END
    
  ELSIF res = -1 
    MESSAGE('Cannot open local file', 'libcurl', ICON:Exclamation)
  ELSE
    MESSAGE('SendRequest failed: '& curl.StrError(res), 'libcurl', ICON:Exclamation)
  END
