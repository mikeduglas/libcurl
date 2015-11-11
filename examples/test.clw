  PROGRAM

  PRAGMA('project(#compile libcurl.clw)')
  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')

TXFerInfo                     GROUP, TYPE
Url                             STRING(256)
Filename                        STRING(256)
User                            STRING(20)
Pwd                             STRING(20)
                              END

  MAP
    ReadFile(TXFerInfo xferinfo)
    WriteFile(TXFerInfo xferinfo)
  END

Download                      LIKE(TXFerInfo), PRE(Download)
Upload                        LIKE(TXFerInfo), PRE(Upload)

bShowDownloadPwd              BYTE
bShowUploadPwd                BYTE

Window                        WINDOW('libcurl demo'),AT(,,425,233),CENTER,GRAY,FONT('Microsoft Sans Serif',8)
                                SHEET,AT(3,2,420,198),USE(?SHEET1)
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
                                    BUTTON('Start!'),AT(17,122,50),USE(?bDownload)
                                    PROMPT('Bytes read:'),AT(119,123),USE(?lblBytesRead)
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
                                    BUTTON('Start!'),AT(17,122,50),USE(?bUpload)
                                    PROMPT('Bytes written:'),AT(119,123),USE(?lblBytesWritten)
                                  END
                                END
                                BUTTON('Close'),AT(374,209,47),USE(?bClose),STD(STD:Close)
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

  OPEN(Window)
  ACCEPT
    CASE ACCEPTED()
    OF ?bShowDownloadPwd
      ?Download:Pwd{PROP:Password} = 1 - bShowDownloadPwd
    OF ?bShowUploadPwd
      ?Upload:Pwd{PROP:Password} = 1 - bShowUploadPwd
    OF ?bDownload
      ReadFile(Download)
    OF ?bUpload
      WriteFile(Upload)
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
    MESSAGE('SetUserPwd failed: '& curl.StrError(res))
  END

  res = curl.ReadFile(xferinfo.Url, xferinfo.Filename)
  IF res = CURLE_OK
    MESSAGE('File successfully downloaded.', ICON:Asterisk)
  ELSIF res = -1 
    MESSAGE('Cannot create local file')
  ELSE
    MESSAGE('ReadFile failed: '& curl.StrError(res))
  END

WriteFile                     PROCEDURE(TXFerInfo xferinfo)
curl                            TCurlClassEx
res                             CURLcode

  CODE  
  ?lblBytesWritten{PROP:Text} = 'Bytes written:'

  curl.Init()
  
  res = curl.SetUserPwd(xferinfo.User, xferinfo.Pwd)
  IF res <> CURLE_OK
    MESSAGE('SetUserPwd failed: '& curl.StrError(res))
  END

  res = curl.WriteFile(xferinfo.Url, xferinfo.Filename)
  IF res = CURLE_OK
    MESSAGE('File successfully uploaded.', ICON:Asterisk)
  ELSIF res = -1 
    MESSAGE('Cannot open local file')
  ELSE
    MESSAGE('WriteFile failed: '& curl.StrError(res))
  END

