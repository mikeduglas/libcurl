!** libcurl for Clarion v1.54
!** 11.05.2022
!** mikeduglas@yandex.com
!** mikeduglas66@gmail.com


  MEMBER

  INCLUDE('libcurl.inc'), ONCE

TFtpDirListItem               GROUP, TYPE
Mask                            STRING(20)
Subdirs                         STRING(10)
UID                             STRING(255)
GID                             STRING(255)
Size                            STRING(20)
Month                           STRING(3)
Day                             STRING(2)
YearTime                        STRING(5)
Filename                        STRING(255)
                              END

  MAP
    ParseFullListResponse(STRING pSrc, *QUEUE pQ), PRIVATE
    ParseFullListItem(STRING pSrc, *TFtpDirListItem pItem), PRIVATE
    ParseBareListResponse(STRING pSrc, *QUEUE pQ), PRIVATE
    FtpDateToClaDate(STRING pMonth, STRING pDay, STRING pYearOrTime), STRING, PRIVATE
  END

!!!region static functions
ParseFullListResponse         PROCEDURE(STRING pSrc, *QUEUE pQ)
BufLen                          LONG, AUTO
StartPos                        LONG, AUTO
EndPos                          LONG, AUTO
MatchPos                        LONG, AUTO
StrIndex                        LONG, AUTO
aFld1                           ANY

  CODE
  FREE(pQ)
  
  IF NOT pSrc
    RETURN
  END
  
  !pSrc contains items separated by <13> or <10> or <13,10>
  
  BufLen = LEN(CLIP(pSrc))
  StartPos = 1

  LOOP StrIndex = 1 TO BufLen
    IF INLIST(pSrc[StrIndex], '<13>', '<10>')
      ! new line separator found
      
      aFld1 &= WHAT(pQ, 1)
      aFld1 = pSrc[StartPos : StrIndex - 1]
      ADD(pQ)
      
      ! search for next non-new line char
      LOOP
        StrIndex += 1
        IF StrIndex > BufLen
          BREAK
        END
        
        IF NOT INLIST(pSrc[StrIndex], '<13>', '<10>')
          BREAK
        END
      END
      
      StartPos = StrIndex
    END
  END
  
ParseFullListItem             PROCEDURE(STRING pSrc, *TFtpDirListItem pItem)
BufLen                          LONG, AUTO
StartPos                        LONG, AUTO
EndPos                          LONG, AUTO
MatchPos                        LONG, AUTO
StrIndex                        LONG, AUTO
FieldNo                         LONG, AUTO
aFld                            ANY

  CODE
  CLEAR(pItem)
  
  IF NOT pSrc
    RETURN
  END
  
  !pSrc contains items separated by <13> or <10> or <13,10>
  
  BufLen = LEN(CLIP(pSrc))
  StartPos = 1
  FieldNo = 1
  LOOP StrIndex = 1 TO BufLen
    IF pSrc[StrIndex] = ' '
      ! space separator found
      aFld &= WHAT(pItem, FieldNo)
      aFld = pSrc[StartPos : StrIndex - 1]
      
      ! search for next non-new line char
      LOOP
        StrIndex += 1
        IF StrIndex > BufLen
          BREAK
        END
        
        IF pSrc[StrIndex] <> ' '
          BREAK
        END
      END
      
      StartPos = StrIndex
      FieldNo += 1
      IF FieldNo = 9  ! filename column
        aFld &= WHAT(pItem, FieldNo)
        aFld = pSrc[StartPos : BufLen]

        BREAK
      END
    END
  END
  
ParseBareListResponse         PROCEDURE(STRING pSrc, *QUEUE pQ)
BufLen                          LONG, AUTO
StartPos                        LONG, AUTO
EndPos                          LONG, AUTO
MatchPos                        LONG, AUTO
StrIndex                        LONG, AUTO
aFld1                           ANY

  CODE
  FREE(pQ)
  
  IF NOT pSrc
    RETURN
  END
  
  !pSrc contains items separated by <13> or <10> or <13,10>
  
  BufLen = LEN(CLIP(pSrc))
  StartPos = 1

  LOOP StrIndex = 1 TO BufLen
    IF INLIST(pSrc[StrIndex], '<13>', '<10>')
      ! new line separator found
      
      aFld1 &= WHAT(pQ, 1)
      aFld1 = pSrc[StartPos : StrIndex - 1]
      
      IF CLIP(aFld1) <> '.' AND CLIP(aFld1) <> '..'
        ADD(pQ)
      END
      
      ! search for next non-new line char
      LOOP
        StrIndex += 1
        IF StrIndex > BufLen
          BREAK
        END
        
        IF NOT INLIST(pSrc[StrIndex], '<13>', '<10>')
          BREAK
        END
      END
      
      StartPos = StrIndex
    END
  END
  
FtpDateToClaDate              PROCEDURE(STRING pMonth, STRING pDay, STRING pYearOrTime)
iMonth                          LONG, AUTO
iDay                            LONG, AUTO
iYear                           LONG, AUTO
iTime                           LONG, AUTO
  CODE
  CASE pMonth
  OF 'Jan'; iMonth = 1
  OF 'Feb'; iMonth = 2
  OF 'Mar'; iMonth = 3
  OF 'Apr'; iMonth = 4
  OF 'May'; iMonth = 5
  OF 'Jun'; iMonth = 6
  OF 'Jul'; iMonth = 7
  OF 'Aug'; iMonth = 8
  OF 'Sep'; iMonth = 9
  OF 'Oct'; iMonth = 10
  OF 'Nov'; iMonth = 11
  OF 'Dec'; iMonth = 12
  ELSE
    iMonth = 0
  END
  
  iDay = pDay
  iYear = CHOOSE(INSTRING(':', pYearOrTime, 1, 1) = 0, pYearOrTime, YEAR(TODAY()))
  iTime = CHOOSE(INSTRING(':', pYearOrTime, 1, 1) > 0, DEFORMAT(pYearOrTime, @t1), 0)
  
  RETURN FORMAT(DATE(iMonth, iDay, iYear), @d17) &' '& FORMAT(iTime, @t07b)
  
!!!endregion
 
!!!region TCurlFtpClass
TCurlFtpClass.Init            PROCEDURE()
  CODE
  PARENT.Init()
  SELF.SetDefaultProtocol('ftp')
  
TCurlFtpClass.SSHAuth         PROCEDURE(TSSHSettings pSSH)
res                             CURLcode, AUTO
  CODE
  !http://curl.haxx.se/mail/lib-2013-07/0102.html
  
  res = SELF.SetOpt(CURLOPT_SSH_AUTH_TYPES, pSSH.AuthMethod)
  IF res <> CURLE_OK
    RETURN res
  END

  IF pSSH.PublicKeyFile
    res = SELF.SetOpt(CURLOPT_SSH_PUBLIC_KEYFILE, pSSH.PublicKeyFile)
    IF res <> CURLE_OK
      RETURN res
    END
  END
  
  IF pSSH.PrivateKeyFile
    res = SELF.SetOpt(CURLOPT_SSH_PRIVATE_KEYFILE, pSSH.PrivateKeyFile)
    IF res <> CURLE_OK
      RETURN res
    END
  END
  
  IF pSSH.KnownHosts
    res = SELF.SetOpt(CURLOPT_SSH_KNOWNHOSTS, pSSH.KnownHosts)
    IF res <> CURLE_OK
      RETURN res
    END
  END
  
  IF pSSH.KeyPassword
    res = SELF.SetOpt(CURLOPT_KEYPASSWD, pSSH.KeyPassword)
    IF res <> CURLE_OK
      RETURN res
    END
  END
  
  IF pSSH.PublicKeyMD5
    res = SELF.SetOpt(CURLOPT_SSH_HOST_PUBLIC_KEY_MD5, pSSH.PublicKeyMD5)
    IF res <> CURLE_OK
      RETURN res
    END
  END
  
  SELF.AuthMethod = pSSH.AuthMethod
  
  RETURN CURLE_OK

TCurlFtpClass.LoadDir         PROCEDURE(STRING pUrl, *TFtpFilesInfo dirlist)
ds                              &IDynStr
res                             CURLcode, AUTO
RespQ                           QUEUE, PRE(RespQ)
Item                              STRING(255)
                                END
DirItem                         GROUP(TFtpDirListItem), PRE(DirItem)
                                END
qIndex                          LONG, AUTO
  CODE
  FREE(dirlist)
  
  res = SELF.SetOpt(CURLOPT_FTPLISTONLY, 0)
  IF res <> CURLE_OK
    RETURN res
  END

  ds &= NewDynStr()
  res = SELF.SendRequest(pUrl, ds)
  IF res = CURLE_OK
    ParseFullListResponse(ds.Str(), RespQ)
  END
  
  ds.Kill()
  DisposeDynStr(ds)
  
  IF res <> CURLE_OK
    RETURN res
  END
  
  !http://superuser.com/questions/482763/what-do-different-things-mean-in-ftp-dir-output
  
  !example:
  !drwxrwxrwx   2 0        0        16384 Oct  3 12:54 Andrew
  
  !In drwxrwxrwx, d means it is a directory, 
  !the first rwx (r=read, w=write, x=execute) in rwxrwxrwx is the permission for the owner/user, 
  !the second rwx is the permission for the group, 
  !and the third rwx is the permission for others.  

  !2 0        0        16384 Oct  3 12:54 Andrew
  !The 2 here is the number of _immediate_ subdirectories it has plus its parent directory and itself. 
  !So in this case it suggests directory Andrew has no subdirectories. 

  LOOP qIndex = 1 TO RECORDS(RespQ)
    GET(RespQ, qIndex)
    ParseFullListItem(RespQ.Item, DirItem)
    
    IF DirItem.Filename <> '.'  ! don't include '.' folder
      CLEAR(dirlist)
      dirlist.IsFolder = CHOOSE(DirItem.Mask[1] = 'd')
      dirlist.Name = DirItem.Filename
      dirlist.DisplayName = CHOOSE(dirlist.IsFolder = TRUE, '['& CLIP(DirItem.Filename) &']', DirItem.Filename)
      dirlist.SortName = CHOOSE(dirlist.Name <> '..', UPPER(DirItem.Filename), '<2>'& UPPER(DirItem.Filename))  ! force sort before names starting with # etc
      
      IF dirlist.Name <> '..'
        dirlist.FileMask = DirItem.Mask
!        dirlist.LastModified = DirItem.Month &' '& DirItem.Day &' '& DirItem.YearTime
        dirlist.LastModified = FtpDateToClaDate(DirItem.Month, DirItem.Day, DirItem.YearTime)
      END
      
      IF NOT dirlist.IsFolder
        dirlist.FileSize = DirItem.Size
      END
      
      ADD(dirlist)
    END
  END
  
  !add parent dir '..' if does not exist
  CLEAR(dirlist)
  dirlist.IsFolder = TRUE
  dirlist.Name = '..'
  GET(dirlist, dirlist.IsFolder, dirlist.Name)
  IF ERRORCODE()
    dirlist.IsFolder = TRUE
    dirlist.Name = '..'
    dirlist.DisplayName = '[..]'
    dirlist.SortName = '<2>'& '..'  ! force sort before [..]
    dirlist.FileMask = ''
    dirlist.LastModified = ''
    dirlist.FileSize = ''
    ADD(dirlist)
  END
  
  RETURN CURLE_OK

TCurlFtpClass.LoadDirListOnly PROCEDURE(STRING pUrl, *TFtpDirList barelist)
ds                              &IDynStr
res                             CURLcode, AUTO
  CODE
  FREE(barelist)

  res = SELF.SetOpt(CURLOPT_FTPLISTONLY, 1)
  IF res <> CURLE_OK
    RETURN res
  END

  ds &= NewDynStr()
  res = SELF.SendRequest(pUrl, ds)
  IF res = CURLE_OK
    ParseBareListResponse(ds.Str(), barelist)
  END
  
  ds.Kill()
  DisposeDynStr(ds)
  
  RETURN res
  
!pUrl is ftp://user@95.96.97.98, pFilename is /home/files/testfile.txt
TCurlFtpClass.DeleteFile      PROCEDURE(STRING pUrl, STRING pFilename)
szcmd                           CSTRING(10)
ftpcmd                          TCurlSList
res                             CURLcode, AUTO
  CODE
  IF SELF.AuthMethod = CURLSSH_AUTH_NONE
    szcmd = 'DELE '
  ELSE
    szcmd = 'rm '
  END
  
  ftpcmd.AppendData(szcmd & CLIP(pFilename))
  res = SELF.SetQuote(ftpcmd)  
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_URL, pUrl)
  IF res <> CURLE_OK
    RETURN res
  END
  
  ! set WriteFile callback, otherwise libcure could fail with CURLE_WRITE_ERROR
  ! http://stackoverflow.com/questions/31900862/curl-simple-example-returning-curle-write-error
  res = SELF.SetWriteCallback(curl::FileWrite, 0)
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.Perform()
  IF res <> CURLE_OK
    curl::DebugInfo('DeleteFile failed: '& SELF.StrError(res))
  END
  
  RETURN res

!pUrl is ftp://user@95.96.97.98, pDirname is /home/files/temp  
TCurlFtpClass.CreateDir       PROCEDURE(STRING pUrl, STRING pDirname)
szcmd                           CSTRING(10)
ftpcmd                          TCurlSList
res                             CURLcode, AUTO
  CODE
  IF SELF.AuthMethod = CURLSSH_AUTH_NONE
    szcmd = 'MKD '
  ELSE
    szcmd = 'mkdir '
  END
  
  ftpcmd.AppendData(szcmd & CLIP(pDirname))
  res = SELF.SetQuote(ftpcmd)  
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_URL, pUrl)
  IF res <> CURLE_OK
    RETURN res
  END
  
  ! set WriteFile callback, otherwise libcure could fail with CURLE_WRITE_ERROR
  ! http://stackoverflow.com/questions/31900862/curl-simple-example-returning-curle-write-error
  res = SELF.SetWriteCallback(curl::FileWrite, 0)
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.Perform()
  IF res <> CURLE_OK
    curl::DebugInfo('CreateDir failed: '& SELF.StrError(res))
  END
  
  RETURN res
    
TCurlFtpClass.IsDirExist      PROCEDURE(STRING pUrl, STRING pDirname)
res                             CURLcode, AUTO
  CODE
  SELF.SetOpt(CURLOPT_NOBODY, 1)

  res = SELF.SetUrl(CLIP(pUrl) & CLIP(pDirname) &'/')  
  IF res <> CURLE_OK
    RETURN res
  END

  RETURN SELF.Perform()

TCurlFtpClass.RenameFile      PROCEDURE(STRING pUrl, STRING pOldname, STRING pNewname)
ftpcmd                          TCurlSList
res                             CURLcode, AUTO
  CODE
  IF SELF.AuthMethod = CURLSSH_AUTH_NONE
    ftpcmd.AppendData('RNFR '& CLIP(pOldname))
    ftpcmd.AppendData('RNTO '& CLIP(pNewname))
  ELSE
    ftpcmd.AppendData('rename '& CLIP(pOldname) &' '& CLIP(pNewname))
  END

!  res = SELF.SetQuote(ftpcmd)  
  res = SELF.PostQuote(ftpcmd)  
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_URL, pUrl)
  IF res <> CURLE_OK
    RETURN res
  END
  
  RETURN SELF.Perform()

TCurlFtpClass.RenameDir       PROCEDURE(STRING pUrl, STRING pOldname, STRING pNewname)
ftpcmd                          TCurlSList
res                             CURLcode, AUTO
  CODE
  IF SELF.AuthMethod = CURLSSH_AUTH_NONE
    ftpcmd.AppendData('RNFR '& CLIP(pOldname))
    ftpcmd.AppendData('RNTO '& CLIP(pNewname))
  ELSE
    ftpcmd.AppendData('rmdir '& CLIP(pOldname) &' '& CLIP(pNewname))
  END
  
!  res = SELF.SetQuote(ftpcmd)  
  res = SELF.PostQuote(ftpcmd)  
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_URL, pUrl)
  IF res <> CURLE_OK
    RETURN res
  END
  
  RETURN SELF.Perform()

TCurlFtpClass.ReadFile           PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>)
res                                 CURLcode, AUTO
  CODE
  !turn on wildcard matching
  !this also turns on curl::ChunkBgnCallback() and curl::ChunkEndCallback()
  !for FTP only (not SFTP)
  IF UPPER(SUB(pRemoteFile, 1, 7)) <> 'SFTP://'
    res = SELF.SetOpt(CURLOPT_WILDCARDMATCH, 1)  
    IF res <> CURLE_OK
      RETURN res
    END
  END
  
  RETURN PARENT.ReadFile(pRemoteFile, pLocalFile, xferproc)

TCurlFtpClass.CreateMissingDirs   PROCEDURE(CURLFTP_CREATE_DIR_ENUM pValue)
  CODE
  RETURN SELF.SetOpt(CURLOPT_FTP_CREATE_MISSING_DIRS, pValue)
!!!endregion