  PROGRAM

  PRAGMA('project(#compile libcurl.clw)')

  INCLUDE('libcurl.inc')

  MAP
    Main()
    ProgressData(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, C
  END

  CODE
  Main()
  
    
ProgressData                  PROCEDURE(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
  CODE
  curl::DebugInfo('Downloaded '& dlnow &' bytes')
  RETURN 0

Main                          PROCEDURE()
curl                            TCurlClass
res                             CURLcode
fhandle                         HANDLE
filename                        CSTRING(256)
url                             CSTRING(256)

  CODE  
  curl.Init()
  
  ! указываем функцию записи в файл
  res = curl.SetOpt(CURLOPT_WRITEFUNCTION, curl::CapWrite)
  IF res <> CURLE_OK
    MESSAGE('SetOpt(CURLOPT_WRITEFUNCTION) failed: '& curl.StrError(res))
    RETURN
  END
  
  ! создаём файл
  filename = 'rss.php'
  fhandle = CreateFile(filename, GENERIC_WRITE, FILE_SHARE_READ, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0)
  IF fhandle = 0
    MESSAGE('Cannot create file '& fhandle)
    RETURN
  END

  ! говорим, в какой файл писать
  res = curl.SetOpt(CURLOPT_WRITEDATA, ADDRESS(fhandle))
  IF res <> CURLE_OK
    MESSAGE('SetOpt(CURLOPT_WRITEDATA) failed: '& curl.StrError(res))
    RETURN
  END

  ! указываем функцию прогресса
  res = curl.SetOpt(CURLOPT_PROGRESSFUNCTION, ProgressData)
  IF res <> CURLE_OK
    MESSAGE('SetOpt(CURLOPT_PROGRESSFUNCTION) failed: '& curl.StrError(res))
    RETURN
  END

  ! разрешаем прогресс
  res = curl.SetOpt(CURLOPT_NOPROGRESS, FALSE)
  IF res <> CURLE_OK
    MESSAGE('SetOpt(CURLOPT_NOPROGRESS) failed: '& curl.StrError(res))
    RETURN
  END

  ! файл в интернете
  url = 'http://www.ingasoftplus.com/rss.php'
  res = curl.SetOpt(CURLOPT_URL, ADDRESS(url))
  IF res <> CURLE_OK
    MESSAGE('SetOpt(CURLOPT_URL) failed: '& curl.StrError(res))
    RETURN
  END
    
!!    /* url is redirected, so we tell libcurl to follow redirection */     
!    res = curl.SetOpt(CURLOPT_FOLLOWLOCATION, 1)
!    IF res <> CURLE_OK
!      MESSAGE('SetOpt(CURLOPT_FOLLOWLOCATION) failed: '& curl.StrError(res))
!      RETURN
!    END

  ! выполняем запрсо
  res = curl.Perform()
  IF res <> CURLE_OK
    MESSAGE('Perform failed: '& curl.StrError(res))
    RETURN
  END
  
  MESSAGE('File '& filename &' successfully downloaded.', ICON:Asterisk)
 
  CloseHandle(fhandle)
