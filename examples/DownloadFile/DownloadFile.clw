  PROGRAM

  INCLUDE('libcurl.inc'), ONCE

  MAP
    INCLUDE('printf.inc'), ONCE
  END

curl                          TCurlHttpClass
sRemoteFile                   STRING(1024), AUTO
sLocalFile                    STRING(256), AUTO
nBufSize                      ULONG(0)
bResumeDownload               BOOL(FALSE)
nRemoteFileLength             ULONG, AUTO
nLocalFileLength              ULONG, AUTO
res                           CURLE, AUTO

  CODE
  !- Download big file (OpenOffice ~140MB)
  sRemoteFile = 'https://sourceforge.net/projects/openofficeorg.mirror/files/4.1.13/binaries/ru/Apache_OpenOffice_4.1.13_Win_x86_install_ru.exe/download'

  !- Save it in the folder .\downloads
  sLocalFile = 'downloads\'

  !- Partial buffer size
  nBufSize = 2000000
  
  bResumeDownload = TRUE    !- TRUE: Resume the download. if local file exists, then it will be appended with downloaded data.
                            !- FALSE: Download from scratch: if local file exists, then it will be rewritten.
  curl.Init()

  !- Connection timeout in seconds.
  curl.SetOpt(CURLOPT_CONNECTTIMEOUT, 5)

  !- insecure
  curl.SetSSLVerifyHost(FALSE)
  curl.SetSSLVerifyPeer(FALSE)

  !- Filter debugview log output
  curl.SetDebugInfoFilter(CURL_DEBUGINFO_HEADER_OUT)

  !- Start downloading  
  res = curl.DownloadFile(sRemoteFile, sLocalFile, nBufSize, bResumeDownload,, nRemoteFileLength, nLocalFileLength)

  IF res = CURLE_OK
    printd('[DownloadFile] File %s downloaded!%|..Original size %i%|..Bytes written %i', sLocalFile, nRemoteFileLength, nLocalFileLength)
    MESSAGE(printf('File %s downloaded!', sLocalFile))
  ELSE
    printd('[DownloadFile] Error %i (%s)%|..Original size %i%|..Bytes written %i', res, curl.StrError(res), nRemoteFileLength, nLocalFileLength)
    MESSAGE(printf('Error %i (%s)', res, curl.StrError(res)))
  END
