  MEMBER

  INCLUDE('libcurl.inc')

  MAP
    MODULE('libcurl API')
      curl_easy_cleanup(CURL curl), C, RAW, NAME('curl_easy_cleanup')

!      * Creates a new curl session handle with the same options set for the handle
!      * passed in. Duplicating a handle could only be a matter of cloning data and
!      * options, internal state info and things like persistent connections cannot
!      * be transferred. It is useful in multithreaded applications when you can run
!      * curl_easy_duphandle() for each new thread to avoid a series of identical
!      * curl_easy_setopt() invokes in every thread.       
      curl_easy_duphandle(CURL curl), CURL, C, RAW, NAME('curl_easy_duphandle')

!      * Escapes URL strings (converts all letters consider illegal in URLs to their
!      * %XX versions). This function returns a new allocated string or NULL if an
!      * error occurred.       
!CURL_EXTERN char *curl_easy_escape(CURL *handle,
!                                   const char *string,
!                                   int length); 
      curl_easy_escape(CURL handle, *STRING str, LONG length), LONG, C, RAW, NAME('curl_easy_escape')

!      * Request internal information from the curl session with this function.  The
!      * third argument MUST be a pointer to a long, a pointer to a char * or a
!      * pointer to a double (as the documentation describes elsewhere).  The data
!      * pointed to will be filled in accordingly and can be relied upon only if the
!      * function returns CURLE_OK.  This function is intended to get used *AFTER* a
!      * performed transfer, all results from this function are undefined until the
!      * transfer is completed.
!CURL_EXTERN CURLcode curl_easy_getinfo(CURL *curl, CURLINFO info, ...); 
      curl_easy_getinfo(CURL curl, CURLINFO info, LONG arg), CURLcode, C, RAW, NAME('curl_easy_getinfo')

      curl_easy_init(), CURL, C, RAW, NAME('curl_easy_init')

!      * The curl_easy_pause function pauses or unpauses transfers. Select the new
!      * state by setting the bitmask, use the convenience defines below.      
!#define CURLPAUSE_RECV      (1<<0)
!#define CURLPAUSE_RECV_CONT (0)
!
!#define CURLPAUSE_SEND      (1<<2)
!#define CURLPAUSE_SEND_CONT (0)
!
!#define CURLPAUSE_ALL       (CURLPAUSE_RECV|CURLPAUSE_SEND)
!#define CURLPAUSE_CONT      (CURLPAUSE_RECV_CONT|CURLPAUSE_SEND_CONT) 
      curl_easy_pause(CURL curl, LONG bitmask), CURLcode, C, RAW, NAME('curl_easy_pause')

      curl_easy_perform(CURL curl), CURLcode, C, RAW, NAME('curl_easy_perform')

!      * Receives data from the connected socket. Use after successful
!      * curl_easy_perform() with CURLOPT_CONNECT_ONLY option.       
!CURL_EXTERN CURLcode curl_easy_recv(CURL *curl, void *buffer, size_t buflen,
!                                    size_t *n); 
      curl_easy_recv(CURL curl, LONG buffer, size_t buflen, *size_t n), CURLcode, C, RAW, NAME('curl_easy_recv')
      
! * Re-initializes a CURL handle to the default values. This puts back the
! * handle to the same state as it was in when it was just created.
! *
! * It does keep: live connections, the Session ID cache, the DNS cache and the
! * cookies.  
      curl_easy_reset(CURL curl), C, RAW, NAME('curl_easy_reset')

!      * Sends data over the connected socket. Use after successful
!      * curl_easy_perform() with CURLOPT_CONNECT_ONLY option.       
!CURL_EXTERN CURLcode curl_easy_send(CURL *curl, const void *buffer,
!                                    size_t buflen, size_t *n); 
      curl_easy_send(CURL curl, LONG buffer, size_t buflen, *size_t n), CURLcode, C, RAW, NAME('curl_easy_send')

!CURL_EXTERN   CURLcode curl_easy_setopt(CURL *curl, CURLoption option, ...);       
      curl_easy_setopt(CURL curl, CURLoption option, LONG param), CURLcode, C, RAW, NAME('curl_easy_setopt')
      curl_easy_setopt(CURL curl, CURLoption option, curl::CapWriteProcType cbproc), CURLcode, C, RAW, NAME('curl_easy_setopt')
      curl_easy_setopt(CURL curl, CURLoption option, curl::ProgressDataProcType cbproc), CURLcode, C, RAW, NAME('curl_easy_setopt')
!      curl_easy_setopt(CURL curl, CURLoption option, curl::XFerInfoProcType cbproc), CURLcode, C, RAW, NAME('curl_easy_setopt')

!      * The curl_easy_strerror function may be used to turn a CURLcode value
!      * into the equivalent human readable error string.  This is useful
!      * for printing meaningful error messages.      
!CURL_EXTERN const char *curl_easy_strerror(CURLcode); 
      curl_easy_strerror(CURLcode errcode), *CSTRING, C, RAW, NAME('curl_easy_strerror')

!     * Unescapes URL encoding in strings (converts all %XX codes to their 8bit
!     * versions). This function returns a new allocated string or NULL if an error
!     * occurred.
!     * Conversion Note: On non-ASCII platforms the ASCII %XX codes are
!     * converted into the host encoding.       
!CURL_EXTERN char *curl_easy_unescape(CURL *handle,
!                                     const char *string,
!                                     int length,
!                                     int *outlength); 
      curl_easy_unescape(CURL handle, *STRING str, LONG length, *LONG outlength), *CSTRING, C, RAW, NAME('curl_easy_unescape')

!      * Escapes URL strings (converts all letters consider illegal in URLs to their
!      * %XX versions). This function returns a new allocated string or NULL if an
!      * error occurred. 
!CURL_EXTERN char *curl_easy_escape(CURL *handle,
!                                   const char *string,
!                                   int length); 
      curl_escape(CURL handle, *STRING str, LONG length), *CSTRING, C, RAW, NAME('curl_escape')

!      curl_formadd @15
!      curl_formfree @16
!      curl_formget @17
!      curl_free @18
!      curl_getdate @19
!      curl_getenv @20


!      * curl_global_cleanup() should be invoked exactly once for each application
!      * that uses libcurl       
      curl_global_cleanup(), C, NAME('curl_global_cleanup')

!      * curl_global_init() should be invoked exactly once for each application that
!      * uses libcurl and before any call of other libcurl functions.       
!      *
!      * This function is not thread-safe!     
      curl_global_init(LONG flags), CURLcode, C, RAW, NAME('curl_global_init')

!      curl_global_init_mem @23
!      curl_maprintf @24
!      curl_mfprintf @25
!      curl_mprintf @26
!      curl_msnprintf @27
!      curl_msprintf @28
!      curl_multi_add_handle @29
!      curl_multi_assign @30
!      curl_multi_cleanup @31
!      curl_multi_fdset @32
!      curl_multi_info_read @33
!      curl_multi_init @34
!      curl_multi_perform @35
!      curl_multi_remove_handle @36
!      curl_multi_setopt @37
!      curl_multi_socket @38
!      curl_multi_socket_action @39
!      curl_multi_socket_all @40
!      curl_multi_strerror @41
!      curl_multi_timeout @42
!      curl_multi_wait @43
!      curl_mvaprintf @44
!      curl_mvfprintf @45
!      curl_mvprintf @46
!      curl_mvsnprintf @47
!      curl_mvsprintf @48
!      curl_share_cleanup @49
!      curl_share_init @50
!      curl_share_setopt @51
!      curl_share_strerror @52
!      curl_slist_append @53
!      curl_slist_free_all @54
!      curl_strequal @55
!      curl_strnequal @56
!      curl_unescape @57
!      curl_version @58
!      curl_version_info @59
    END

    MODULE('WinAPI')
      curl::OutputDebugString(*CSTRING lpOutputString), PASCAL, RAW, NAME('OutputDebugStringA')
    END
  END

!!!region static functions
curl::DebugInfo               PROCEDURE(STRING s)
prefix                          STRING('[libcurl] ')
cs                              CSTRING(LEN(s) + LEN(prefix) + 1)
  CODE
  cs = prefix & s
  curl::OutputDebugString(cs)
!!!endregion

!!!region callbacks
curl::CapWrite                PROCEDURE(LONG buffer, size_t bufsize, size_t nmemb, LONG pFileStruct)
fs                              &curl::FileStruct
filename                        CSTRING(256)
bytesWritten                    size_t
rc                              BOOL
  CODE
  IF pFileStruct = 0
    RETURN -1
  END
  
  fs &= (pFileStruct)
  
  IF fs.fhandle = 0
    ! create file
    filename = CLIP(fs.filename)
    fs.fhandle = CreateFile(filename, GENERIC_WRITE, FILE_SHARE_READ, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0)
    IF fs.fhandle = 0
      RETURN -1
    END
  END
  
  rc = WriteFile(fs.fhandle, buffer, bufsize * nmemb, bytesWritten, 0)
  IF rc
    RETURN bytesWritten
  END
  
  RETURN -1 !error
  
curl::CapRead                 PROCEDURE(LONG buffer, size_t bufsize, size_t nmemb, LONG pFileStruct)
fs                              &curl::FileStruct
filename                        CSTRING(256)
bytesRead                       size_t
rc                              BOOL
  CODE
  IF pFileStruct = 0
    RETURN -1
  END
  
  fs &= (pFileStruct)
  
  IF fs.fhandle = 0
    ! open file
    filename = CLIP(fs.filename)
    fs.fhandle = CreateFile(filename, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0)
    IF fs.fhandle = 0
      RETURN -1
    END
  END
  
  rc = ReadFile(fs.fhandle, buffer, bufsize * nmemb, bytesRead, 0)
  IF rc
    RETURN bytesRead
  END
  
  RETURN -1 !error

curl::XFerInfo                PROCEDURE(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
curl                            &TCurlClass
  CODE
  IF ptr
    curl &= (ptr)
    RETURN curl.XFerInfo(dltotal, dlnow, ultotal, ulnow)
  END
  
  RETURN 0

!!!endregion

!!!region TCurlClass
TCurlClass.Construct          PROCEDURE()
  CODE
  
TCurlClass.Destruct           PROCEDURE()
  CODE
  SELF.Cleanup()
  
TCurlClass.Init               PROCEDURE()
  CODE
  SELF.curl = curl_easy_init()
  
TCurlClass.Cleanup            PROCEDURE()
  CODE
  IF SELF.curl
    curl_easy_cleanup(SELF.curl)
  END

TCurlClass.SetOpt             PROCEDURE(CURLoption option, LONG param)
  CODE
  RETURN curl_easy_setopt(SELF.curl, option, param)
  
TCurlClass.SetOpt             PROCEDURE(CURLoption option, curl::CapWriteProcType cbproc)
  CODE
  RETURN curl_easy_setopt(SELF.curl, option, cbproc)
  
TCurlClass.SetOpt             PROCEDURE(CURLoption option, curl::ProgressDataProcType cbproc)
  CODE
  RETURN curl_easy_setopt(SELF.curl, option, cbproc)
  
!TCurlClass.SetOpt             PROCEDURE(CURLoption option, curl::XFerInfoProcType cbproc)
!  CODE
!  RETURN curl_easy_setopt(SELF.curl, option, cbproc)

TCurlClass.Perform            PROCEDURE()
  CODE
  RETURN curl_easy_perform(SELF.curl)
  
TCurlClass.StrError           PROCEDURE(CURLcode errcode)
  CODE
  RETURN curl_easy_strerror(errcode)
  
TCurlClass.SetUserPwd         PROCEDURE(STRING pUser, STRING pPwd)
userpwd                         CSTRING(256)
  CODE
  IF pUser AND pPwd
    userpwd = CLIP(pUser) &':'& CLIP(pPwd)
  ELSE
    userpwd = ''
  END
  
  RETURN SELF.SetOpt(CURLOPT_USERPWD, ADDRESS(userpwd))

TCurlClass.ReadFile           PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType cbproc>)
res                             CURLcode
fs                              LIKE(curl::FileStruct)
url                             CSTRING(256)
  CODE
  ! set WriteFile callback
  res = SELF.SetOpt(CURLOPT_WRITEFUNCTION, curl::CapWrite)
  IF res <> CURLE_OK
    RETURN res
  END

  ! destination
  fs.filename = pLocalFile
  fs.fhandle = 0
  res = SELF.SetOpt(CURLOPT_WRITEDATA, ADDRESS(fs))
  IF res <> CURLE_OK
    RETURN res
  END

  IF OMITTED(cbproc)
    res = SELF.SetOpt(CURLOPT_PROGRESSFUNCTION, curl::XFerInfo)
  
    ! pass self to progress function
    res = SELF.SetOpt(CURLOPT_PROGRESSDATA, ADDRESS(SELF))
    IF res <> CURLE_OK
      RETURN res
    END
  ELSE
    res = SELF.SetOpt(CURLOPT_PROGRESSFUNCTION, cbproc)
  END
  IF res <> CURLE_OK
    RETURN res
  END

  ! enable progress
  res = SELF.SetOpt(CURLOPT_NOPROGRESS, FALSE)
  IF res <> CURLE_OK
    RETURN res
  END
  
  ! remote file
  url = CLIP(pRemoteFile)    
  res = SELF.SetOpt(CURLOPT_URL, ADDRESS(url))
  IF res <> CURLE_OK
    RETURN res
  END
  
  ! perform request
  res = SELF.Perform()
  IF res <> CURLE_OK
    RETURN res
  END
 
  CloseHandle(fs.fhandle)
  
  RETURN CURLE_OK

!http://curl.haxx.se/libcurl/c/ftpupload.html
TCurlClass.WriteFile          PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType cbproc>)
res                             CURLcode
fs                              LIKE(curl::FileStruct)
url                             CSTRING(256)
  CODE
  ! set ReadFile callback
  res = SELF.SetOpt(CURLOPT_READFUNCTION, curl::CapRead)
  IF res <> CURLE_OK
    RETURN res
  END

  ! source
  fs.filename = pLocalFile
  fs.fhandle = 0
  res = SELF.SetOpt(CURLOPT_READDATA, ADDRESS(fs))
  IF res <> CURLE_OK
    RETURN res
  END

  IF OMITTED(cbproc)
    res = SELF.SetOpt(CURLOPT_PROGRESSFUNCTION, curl::XFerInfo)
  
    ! pass self to progress function
    res = SELF.SetOpt(CURLOPT_PROGRESSDATA, ADDRESS(SELF))
    IF res <> CURLE_OK
      RETURN res
    END
  ELSE
    res = SELF.SetOpt(CURLOPT_PROGRESSFUNCTION, cbproc)
  END
  IF res <> CURLE_OK
    RETURN res
  END

  ! enable progress
  res = SELF.SetOpt(CURLOPT_NOPROGRESS, FALSE)
  IF res <> CURLE_OK
    RETURN res
  END
  
  ! enable uploading
  res = SELF.SetOpt(CURLOPT_UPLOAD, TRUE)
  IF res <> CURLE_OK
    RETURN res
  END

  ! remote file
  url = CLIP(pRemoteFile)
  res = SELF.SetOpt(CURLOPT_URL, ADDRESS(url))
  IF res <> CURLE_OK
    RETURN res
  END
  
  ! perform request
  res = SELF.Perform()
  IF res <> CURLE_OK
    RETURN res
  END
 
  CloseHandle(fs.fhandle)
  
  RETURN CURLE_OK

TCurlClass.XFerInfo           PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
  CODE
  RETURN 0
  
!!!endregion