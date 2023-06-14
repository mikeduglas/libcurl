!** libcurl for Clarion v1.59
!** 14.06.2023
!** mikeduglas@yandex.com
!** mikeduglas66@gmail.com

  MEMBER

  PRAGMA('link(libcurl.lib)')

  INCLUDE('libcurl.inc'), ONCE
  INCLUDE('libcurl.trn'), ONCE

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
      curl_easy_getinfo(CURL curl, CURLINFO info, *CSTRING arg), CURLcode, C, RAW, NAME('curl_easy_getinfo')
      curl_easy_getinfo(CURL curl, CURLINFO info, *REAL arg), CURLcode, C, RAW, NAME('curl_easy_getinfo')
      curl_easy_getinfo(CURL curl, CURLINFO info, *curl_off_t arg), CURLcode, C, RAW, NAME('curl_easy_getinfo')

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
      curl_easy_setopt(CURL curl, CURLoption option, *CSTRING param), CURLcode, C, RAW, NAME('curl_easy_setopt')
      curl_easy_setopt(CURL curl, CURLoption option, curl::ReadWriteProcType cbproc), CURLcode, C, RAW, NAME('curl_easy_setopt')
      curl_easy_setopt(CURL curl, CURLoption option, curl::ProgressDataProcType cbproc), CURLcode, C, RAW, NAME('curl_easy_setopt')
!      curl_easy_setopt(CURL curl, CURLoption option, curl::XFerInfoProcType cbproc), CURLcode, C, RAW, NAME('curl_easy_setopt')
      curl_easy_setopt(CURL curl, CURLoption option, curl::DebugProcType cbproc), CURLcode, C, RAW, NAME('curl_easy_setopt')
      curl_easy_setopt(CURL curl, CURLoption option, curl::ChunkBgnProcType cbproc), CURLcode, C, RAW, NAME('curl_easy_setopt')
      curl_easy_setopt(CURL curl, CURLoption option, curl::ChunkEndProcType cbproc), CURLcode, C, RAW, NAME('curl_easy_setopt')

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

!     * Pretty advanced function for building multi-part formposts. Each invoke
!     * adds one part that together construct a full post. Then use
!     * CURLOPT_HTTPPOST to send it off to libcurl. 
!CURL_EXTERN CURLFORMcode curl_formadd(struct curl_httppost **httppost,
!                                      struct curl_httppost **last_post,
!                                      ...); 
      curl_formadd(LONG pphttppost, LONG pplast_post, CURLformoption option1, *CSTRING option1name, CURLformoption option2, *CSTRING option2name, CURLformoption endoption), CURLFORMcode, PROC, C, RAW, NAME('curl_formadd')


!      * Free a multipart formpost previously built with curl_formadd(). 
!CURL_EXTERN void curl_formfree(struct curl_httppost *form); 
      curl_formfree(LONG pform), C, RAW, NAME('curl_formfree')


!      curl_formget @17

!      curl_free @18
      ! Provided for de-allocation in the same translation unit that did the
      ! allocation. Added in libcurl 7.10
      curl_free(LONG p), C, RAW, NAME('curl_free')
      curl_free(*CSTRING p), C, RAW, NAME('curl_free')

!      curl_getdate @19
!      curl_getenv @20


!      * curl_global_init() should be invoked exactly once for each application that
!      * uses libcurl and before any call of other libcurl functions.       
!      *
!      * This function is not thread-safe!     
      curl_global_init(LONG flags), CURLcode, C, PROC, RAW, NAME('curl_global_init')

!      * curl_global_cleanup() should be invoked exactly once for each application
!      * that uses libcurl       
      curl_global_cleanup(), C, NAME('curl_global_cleanup')

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

! * Appends a string to a linked list. If no list exists, it will be created
! * first. Returns the new list, after appending.
!CURL_EXTERN struct curl_slist *curl_slist_append(struct curl_slist *,
!                                                 const char *); 
      curl_slist_append(LONG slist, *CSTRING sdata), LONG, PROC, C, RAW, NAME('curl_slist_append')

! * free a previously built curl_slist.
!CURL_EXTERN void curl_slist_free_all(struct curl_slist *);
      curl_slist_free_all(LONG slist), C, RAW, NAME('curl_slist_free_all')

!      curl_strequal @55
!      curl_strnequal @56
!      curl_unescape @57
!      curl_version @58
!      curl_version_info @59
    END

    MODULE('Windows API')
      winapi::CreateFile(*cstring szFileName, long dwDesiredAccess, long dwShareMode, long lpSecurityAttributes, |
        long dwCreationDisposition, long dwFlagsAndAttributes, HANDLE hTemplateFile),HANDLE, |
        name('CreateFileA'),pascal,raw
      winapi::GetFileSize(HANDLE hFile, *long FileSizeHigh),long,raw,pascal,name('GetFileSize')
      winapi::ReadFile(HANDLE hFile, long lpBuffer, long dwBytes, *long dwBytesRead, long lpOverlapped),bool,raw,pascal,name('ReadFile')
      winapi::WriteFile(HANDLE hFile, long lpBuffer, long dwBytes, *long dwBytesWritten, long lpOverlapped),bool,raw,pascal,proc,name('WriteFile')
      winapi::SetFilePointer(HANDLE hFile, LONG lDistanceToMove, LONG lpDistanceToMoveHigh, ULONG dwMoveMethod),ULONG,RAW,PASCAL,NAME('SetFilePointer')
      winapi::GetFileSize(HANDLE hFile, LONG pFileSizeHigh),LONG,RAW,PASCAL,NAME('GetFileSize')
      winapi::CloseHandle(HANDLE),bool,raw,pascal,proc,name('CloseHandle')

      curl::OutputDebugString(*CSTRING lpOutputString), PASCAL, RAW, NAME('OutputDebugStringA')
    END
  END

curl::UserAgent               CSTRING('curl/8.1.2')

winapi::INVALID_FILE_SIZE         EQUATE(-1)
winapi::INVALID_SET_FILE_POINTER  EQUATE(-1)



!/* This is a magic return code for the write callback that, when returned,
!   will signal libcurl to pause receiving on the current transfer. */
CURL_WRITEFUNC_PAUSE          EQUATE(010000001h)
!/* This is a magic return code for the write callback that, when returned,
!   will signal an error from the callback. */
CURL_WRITEFUNC_ERROR          EQUATE(0FFFFFFFFh)


!!!region static functions
curl::DebugInfo               PROCEDURE(STRING s)
prefix                          STRING('[libcurl] ')
cs                              CSTRING(LEN(s) + LEN(prefix) + 1)
  CODE
  cs = prefix & s
  curl::OutputDebugString(cs)
  
curl::GetFileContents         PROCEDURE(STRING pFile)
OS_INVALID_HANDLE_VALUE         EQUATE(-1)
szFile                          CSTRING(LEN(pFile) + 1)
sData                           &STRING
hFile                           HANDLE
dwFileSize                      LONG
lpFileSizeHigh                  LONG
pvData                          LONG
dwBytesRead                     LONG
bRead                           BOOL
  CODE
  szFile=CLIP(pFile)
  hFile = winapi::CreateFile(szFile,GENERIC_READ,0,0,OPEN_EXISTING,0,0)
  IF hFile <> OS_INVALID_HANDLE_VALUE
    dwFileSize = winapi::GetFileSize(hFile,lpFileSizeHigh)
    IF dwFileSize > 0
      sData &= NEW STRING(dwFileSize)
      bRead = winapi::ReadFile(hFile,ADDRESS(sData),dwFileSize,dwBytesRead,0)
    END
    winapi::CloseHandle(hFile)
  END

  RETURN sData
  
curl::StrError                PROCEDURE(CURLcode errcode)
  CODE
  RETURN curl_easy_strerror(errcode)

curl::UnixTime                PROCEDURE(LONG pClaDate, LONG pClaTime)
Unix0                           EQUATE(61730)     !-- Unix zero date (1970-01-01)
SecPerDay                       EQUATE(86400)     !-- seconds per day
normilized_time                 ULONG, AUTO
  CODE
  normilized_time = CHOOSE(pClaTime > 1, pClaTime - 1, 0)
  RETURN (pClaDate - Unix0) * SecPerDay + INT(normilized_time / 100)
!!!endregion
  
!!!region curl global functions
curl::GlobalInit              PROCEDURE(CURL_GLOBAL_ENUM pFlag = CURL_GLOBAL_DEFAULT)
  CODE
  RETURN curl_global_init(pFlag)
  
curl::GlobalCleanup           PROCEDURE()
  CODE
  curl_global_cleanup()
!!!endregion
  
!!!region curl::free
curl::free                    PROCEDURE(LONG p)
  CODE
  curl_free(p)
  
curl::free                    PROCEDURE(*CSTRING p)
  CODE
  curl_free(p)
!!!endregion

!!!region callbacks
curl::FileWrite               PROCEDURE(LONG buffer, size_t bufsize, size_t nmemb, LONG pFileStruct)
fs                              &TCurlFileStruct
bytesWritten                    size_t
  CODE
  IF pFileStruct = 0
    ! tell curl how many bytes we handled
    RETURN bufsize * nmemb
  END
  
  fs &= (pFileStruct)
  
  ! create file
  IF NOT fs.CreateFile()
    curl::DebugInfo('CreateFile('& fs.GetFileName() &') error')
    RETURN CURL_WRITEFUNC_ERROR
  END
  
  ! write data
  IF fs.WriteFile(buffer, bufsize * nmemb, bytesWritten)
    fs.fPosition += bytesWritten
    RETURN bytesWritten
  END
  
  curl::DebugInfo('WriteFile('& fs.GetFileName() &') error '& winapi::GetLastError())
  
  RETURN CURL_WRITEFUNC_ERROR
  
curl::FileAppend              PROCEDURE(LONG buffer, size_t bufsize, size_t nmemb, LONG pFileStruct)
fs                              &TCurlFileStruct
bytesWritten                    size_t
  CODE
  IF pFileStruct = 0
    ! tell curl how many bytes we handled
    RETURN bufsize * nmemb
  END
  
  fs &= (pFileStruct)
  
  ! create file if not exists, otherwise open it
  IF NOT fs.CreateFile(,,OPEN_ALWAYS)
    curl::DebugInfo('CreateFile('& fs.GetFileName() &') error')
    RETURN -1
  end

  ! seek to the end of file
  IF fs.SetFilePointer(0, FILE_END) <> winapi::INVALID_SET_FILE_POINTER
    ! append data
    IF fs.WriteFile(buffer, bufsize * nmemb, bytesWritten)
      fs.fPosition += bytesWritten
      RETURN bytesWritten
    END

    curl::DebugInfo('WriteFile('& fs.GetFileName() &') error '& winapi::GetLastError())
  ELSE
    curl::DebugInfo('SetFilePointer('& fs.GetFileName() &') error: Unable to seek to EOF.')
  END
  
  RETURN -1 !error

curl::FileRead                PROCEDURE(LONG buffer, size_t bufsize, size_t nmemb, LONG pFileStruct)
fs                              &TCurlFileStruct
bytesRead                       size_t
  CODE
  IF pFileStruct = 0
    RETURN -1
  END
  
  fs &= (pFileStruct)
  
  ! open file
  IF NOT fs.OpenFile()
    curl::DebugInfo('OpenFile('& fs.GetFileName() &' error')
    RETURN -1
  END
  
  IF fs.ReadFile(buffer, bufsize * nmemb, bytesRead)
    RETURN bytesRead
  END
  
  curl::DebugInfo('ReadFile('& fs.GetFileName() &' error '& winapi::GetLastError())
  RETURN -1 !error

curl::StringWrite             PROCEDURE(LONG buffer, size_t bufsize, size_t nmemb, LONG pStringStruct)
ss                              &TCurlStringStruct
bytesReceived                   size_t, AUTO
bytesWritten                    size_t, AUTO
rc                              BOOL
  CODE
  IF pStringStruct = 0
    RETURN -1
  END
  
  ss &= (pStringStruct)
  IF ss.buffer = 0
    RETURN -1
  END

  bytesReceived = bufsize * nmemb
  IF bytesReceived <= ss.bufsize - ss.filled
    bytesWritten = bytesReceived
  ELSE
!    bytesWritten = ss.bufsize - ss.filled
!    RETURN 0
    RETURN -1 ! raise error
  END
  
  IF bytesWritten
    curl::memcpy(ss.buffer + ss.filled, buffer, bytesWritten)
    ss.filled += bytesWritten
  
    RETURN bytesWritten
  END
  
  RETURN -1

curl::DynStrWrite             PROCEDURE(LONG buffer, size_t bufsize, size_t nmemb, LONG pDynStr)
bytesReceived                   size_t, AUTO
ds                              &IDynStr
sbuffer                         STRING(bufsize * nmemb)
rc                              BOOL
  CODE
  IF pDynStr = 0
    RETURN -1
  END

  ds &= (pDynStr)
  
  bytesReceived = bufsize * nmemb
  curl::memcpy(ADDRESS(sbuffer), buffer, bytesReceived)
  ds.Cat(sbuffer)
  
  RETURN bytesReceived

curl::XFerInfo                PROCEDURE(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
curl                            &TCurlClass
  CODE
  IF ptr
    curl &= (ptr)
    RETURN curl.XFerInfo(dltotal, dlnow, ultotal, ulnow)
  END
  
  RETURN 0

curl::DebugCallback           PROCEDURE(LONG phandle, CURL_INFOTYPE ptype, LONG pdata, size_t psize, LONG userptr)
curl                            &TCurlClass
txt                             STRING(psize)
infotype                        STRING(20)
  CODE
  IF userptr
    CASE ptype
    OF CURLINFO_TEXT
      infotype = 'TEXT'
    OF CURLINFO_HEADER_IN
      infotype = 'HEADER_IN'
    OF CURLINFO_HEADER_OUT
      infotype = 'HEADER_OUT'
    OF CURLINFO_DATA_IN
      infotype = 'DATA_IN'
    OF CURLINFO_DATA_OUT
      infotype = 'DATA_OUT'
    OF CURLINFO_SSL_DATA_IN
      infotype = 'SSL_DATA_IN'
    OF CURLINFO_SSL_DATA_OUT
      infotype = 'SSL_DATA_OUT'
    ELSE
      infotype = 'Unknown info type'
    END
  
    curl &= (userptr)
    curl::memcpy(ADDRESS(txt), pdata, psize)
    curl.TalkCallback(ptype, txt)
    curl.DebugCallback(ptype, infotype, txt)
  END
  
  RETURN 0

curl::ChunkBgnCallback        PROCEDURE(LONG transfer_info, LONG ptr, LONG remains)
fs                              &TCurlFileStruct
finfo                           &curl_fileinfo
fname                           &CSTRING
  CODE
  IF NOT transfer_info
    RETURN CURL_CHUNK_BGN_FUNC_SKIP
  END

  finfo &= (transfer_info)

  IF NOT finfo.pfilename
    RETURN CURL_CHUNK_BGN_FUNC_SKIP
  END

  fname &= (finfo.pfilename)

  CASE finfo.filetype
  OF CURLFILETYPE_DIRECTORY
    curl::DebugInfo('Coming: DIR '& fname)
  OF CURLFILETYPE_FILE
    curl::DebugInfo('Coming: FILE '& fname)
  ELSE
    curl::DebugInfo('Coming: object of type '& finfo.filetype &' '& fname)
  END
  
  IF NOT ptr
    RETURN CURL_CHUNK_BGN_FUNC_SKIP
  END
  
  fs &= (ptr)

  IF finfo.filetype = CURLFILETYPE_FILE
    !do not transfer files >= 50b
!    IF finfo.size.lo > 50
!      RETURN CURL_CHUNK_BGN_FUNC_SKIP
!    END
    
    ! open file
    IF NOT fs.CreateFile()
      curl::DebugInfo('CreateFile('& fs.GetFileName() &' error')
      RETURN CURL_CHUNK_BGN_FUNC_SKIP
    END
  END
  
  RETURN CURL_CHUNK_BGN_FUNC_OK
  
curl::ChunkEndCallback        PROCEDURE(LONG ptr)
fs                              &TCurlFileStruct
  CODE
  IF ptr
    fs &= (ptr)
    curl::DebugInfo('Downloaded: '& fs.GetFileName())
    fs.Close()
  END
  
  RETURN CURL_CHUNK_END_FUNC_OK

curl::HeaderCallback          PROCEDURE(LONG buffer, size_t bufsize, size_t nitems, LONG userptr)
curl                            &TCurlClass
hdrSize                         LONG, AUTO
hdrLine                         &STRING
  CODE
  hdrSize = bufsize*nitems
  
  IF userptr
    curl &= (userptr)
    hdrLine &= NEW STRING(hdrSize)
    curl::memcpy(ADDRESS(hdrLine), buffer, hdrSize)
    curl.HeaderCallback(hdrLine)
    DISPOSE(hdrLine)
  END
    
  RETURN hdrSize
  
!!!endregion

!!!region TCurlFileStruct
TCurlFileStruct.Destruct      PROCEDURE()
  CODE
  SELF.Close()
  
TCurlFileStruct.Init          PROCEDURE(STRING pFilename)
  CODE
  SELF.filename = CLIP(pFilename)
  SELF.fhandle = 0

TCurlFileStruct.Close         PROCEDURE()
ret                             BOOL, AUTO
  CODE
  IF SELF.fhandle
    ret = winapi::CloseHandle(SELF.fhandle)
    IF ret
      SELF.fhandle = 0
    ELSE
      curl::DebugInfo('CloseHandle failed, win error '& winapi::GetLastError())
    END
    SELF.fPosition = 0
    RETURN ret
  END
  
  RETURN TRUE

TCurlFileStruct.CreateFile    PROCEDURE(LONG dwDesiredAccess = GENERIC_WRITE, LONG dwShareMode = FILE_SHARE_READ, LONG dwCreationDisposition = CREATE_ALWAYS, LONG dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL)
  CODE
  IF NOT SELF.fhandle
    SELF.fhandle = winapi::CreateFile(SELF.filename, dwDesiredAccess, dwShareMode, 0, dwCreationDisposition, dwFlagsAndAttributes, 0)
  END
  
  RETURN CHOOSE(SELF.fhandle <> 0)

TCurlFileStruct.OpenFile                      PROCEDURE(LONG dwDesiredAccess = GENERIC_READ, LONG dwShareMode = FILE_SHARE_READ, LONG dwCreationDisposition = OPEN_EXISTING, LONG dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL)
  CODE
  IF NOT SELF.fhandle
    SELF.fhandle = winapi::CreateFile(SELF.filename, dwDesiredAccess, dwShareMode, 0, dwCreationDisposition, dwFlagsAndAttributes, 0)
  END
  
  RETURN CHOOSE(SELF.fhandle <> 0)

TCurlFileStruct.ReadFile      PROCEDURE(LONG lpBuffer, LONG dwBytes, *LONG dwBytesRead)
  CODE
  RETURN winapi::ReadFile(SELF.fhandle, lpBuffer, dwBytes, dwBytesRead, 0)
  
TCurlFileStruct.WriteFile     PROCEDURE(LONG lpBuffer, LONG dwBytes, *LONG dwBytesWritten)
  CODE
  RETURN winapi::WriteFile(SELF.fhandle, lpBuffer, dwBytes, dwBytesWritten, 0)
  
TCurlFileStruct.GetFileName   PROCEDURE()
  CODE
  RETURN CLIP(SELF.filename)
  
TCurlFileStruct.SetFilePointer    PROCEDURE(LONG plDistanceToMove, ULONG pdwMoveMethod)
  CODE
  IF SELF.fhandle
    RETURN winapi::SetFilePointer(SELF.fhandle, plDistanceToMove, 0, pdwMoveMethod)
  ELSE
    RETURN winapi::INVALID_SET_FILE_POINTER
  END
  
TCurlFileStruct.GetFilePointer    PROCEDURE()
  CODE
  RETURN SELF.SetFilePointer(0, FILE_CURRENT)
  
TCurlFileStruct.GetFileSize   PROCEDURE(<*LONG pFileSizeHigh>)
bDoClose                        BOOL(FALSE)
lpFileSizeLo                    LONG, AUTO
lpFileSizeHi                    LONG, AUTO
  CODE
  IF NOT SELF.fhandle
    !- file not opened, open it first and close on exit
    bDoClose = TRUE
  END
  
  IF SELF.OpenFile()
    lpFileSizeLo = winapi::GetFileSize(SELF.fhandle, ADDRESS(lpFileSizeHi))
    IF lpFileSizeLo = winapi::INVALID_FILE_SIZE
      lpFileSizeLo = 0
    END
    IF NOT OMITTED(pFileSizeHigh)
      pFileSizeHigh = lpFileSizeHi
    END
  ELSE
    IF NOT OMITTED(pFileSizeHigh)
      pFileSizeHigh = 0
    END
    lpFileSizeLo = 0
  END
  
  IF bDoClose
    SELF.Close()
  END

  RETURN lpFileSizeLo
!!!endregion
  
!!!region TCurlMailStruct
!TCurlMailStruct.Construct     PROCEDURE()
!  CODE
!  SELF.buf &= NEW TFileBufContent
!  
!TCurlMailStruct.Destruct      PROCEDURE()
!qIndex                          LONG, AUTO
!  CODE
!  LOOP qIndex = 1 TO RECORDS(SELF.buf)
!    GET(SELF.buf, qIndex)
!    DISPOSE(SELF.buf.fdata)
!    SELF.buf.fdata &= NULL
!  END
!  FREE(SELF.buf)
!  DISPOSE(SELF.buf)
  
!!!endregion
  
!!!region TCurlSList
TCurlSList.Construct          PROCEDURE()
  CODE
  SELF.plist = 0

TCurlSList.Destruct           PROCEDURE()
  CODE
  SELF.Free()
  
TCurlSList.AssignPtr          PROCEDURE(LONG pListPtr)
  CODE
  SELF.plist = pListPtr
  
TCurlSList.AppendData         PROCEDURE(STRING pData)
szData                          CSTRING(LEN(pData) + 1)
  CODE
  szData = pData
  SELF.plist = curl_slist_append(SELF.plist, szData)
  RETURN
  
TCurlSList.Free               PROCEDURE()
  CODE
  IF SELF.plist <> 0
    curl_slist_free_all(SELF.plist)
    SELF.plist = 0
  END
!TCurlSList.Free               PROCEDURE()
!lst                             &curl_slist
!szdata                          &CSTRING
!i                               LONG, AUTO
!  CODE
!  IF SELF.plist <> 0
!    
!    lst &= (SELF.plist)
!    i = 1
!    LOOP
!      szdata &= (lst.pdata)
!      curl::DebugInfo('slist['& i &']='& CLIP(szdata))
!      IF lst.pnext = 0
!        BREAK
!      END
!      
!      i+=1
!      lst &= (lst.pnext)
!    END
!      
!    
!    curl_slist_free_all(SELF.plist)
!    SELF.plist = 0
!  END
  
TCurlSList.GetList            PROCEDURE()
  CODE
  RETURN SELF.plist

TCurlSList.GetQueue           PROCEDURE(*TCurlSQueue pQ)
lst                             &curl_slist
szdata                          &CSTRING
i                               LONG, AUTO
  CODE
  IF SELF.plist <> 0
    lst &= (SELF.plist)
    i = 1
    LOOP
      szdata &= (lst.pdata)
!      curl::DebugInfo('slist['& i &']='& CLIP(szdata))
      CLEAR(pQ)
      ASSERT(SIZE(pQ.item) >= SIZE(szdata), 'TCurlSList.GetQueue: data truncation')
      pQ.item = szdata
      ADD(pQ)
      
      IF lst.pnext = 0
        BREAK
      END
      
      i+=1
      lst &= (lst.pnext)
    END
  END

!!!endregion
  
!!!region TCurlClass
TCurlClass.Construct          PROCEDURE()
  CODE
  SELF.headers &= NEW TCurlSList
  SELF.Errors &= NEW curl::ErrorEntry
  SELF.urlp &= NEW TCurlUrlApiClass
  SELF.debugInfoMask = CURL_DEBUGINFO_ALL
  
TCurlClass.Destruct           PROCEDURE()
  CODE
  SELF.Cleanup()

  DISPOSE(SELF.urlp)
  DISPOSE(SELF.headers)
  DISPOSE(SELF.headers)
  
TCurlClass.Init               PROCEDURE()
  CODE
  SELF.curl = curl_easy_init()
  SELF.urlp.Init()
  SELF.AddErrors(curl::DefaultErrors)
  SELF.SetUserAgent(curl::UserAgent)
  
TCurlClass.Cleanup            PROCEDURE()
  CODE
  SELF.FreeHttpHeaders()
  IF SELF.curl
    curl_easy_cleanup(SELF.curl)
    SELF.curl = 0
  END
  SELF.urlp.Cleanup()

TCurlClass.Reset              PROCEDURE()
  CODE
  SELF.FreeHttpHeaders()
  IF SELF.curl
    curl_easy_reset(SELF.curl)
  END

TCurlClass.GetHandle          PROCEDURE()
  CODE
  RETURN SELF.curl
  
TCurlClass.AddError           PROCEDURE(CURLE Id, *STRING Message)
!critProc                        CriticalProcedure
  CODE
!  critProc.init(SELF.critSect)
? ASSERT(NOT SELF.Errors &= NULL,'TCurlClass.Errors incorrectly initialized.')
  SELF.Errors.Id = Id
  SELF.Errors.Message &= Message
  ADD(SELF.Errors)
? ASSERT(~ERRORCODE(),'Unable to add new error message to queue.')

TCurlClass.AddErrors          PROCEDURE(curl::ErrorBlock ErrsIn)
Follow                          USHORT(3)
Slen                            BYTE,AUTO
Errs                            &STRING
!critProc                        CriticalProcedure
  CODE
!  critProc.init(SELF.critSect)
  Errs &= ErrsIn
? ASSERT(NOT SELF.Errors &= NULL,'TCurlClass.Errors incorrectly initialized.')
  LOOP ErrsIn.Number TIMES
    SELF.Errors.Id = VAL(Errs[Follow])+256 * VAL(Errs[Follow+1])      ! Id is a little-endian binary 16 bit word
    Follow += 4
    Slen = VAL(Errs[Follow])
    Follow += 1
    SELF.Errors.Message &= Errs[Follow :Follow+Slen-1]
    ADD(SELF.Errors)
?   ASSERT(~ERRORCODE(),'Unable to add new error message to queue.')
    Follow += Slen
  END

TCurlClass.SetOpt             PROCEDURE(CURLoption option, LONG param)
  CODE
  RETURN curl_easy_setopt(SELF.curl, option, param)
  
TCurlClass.SetOpt             PROCEDURE(CURLoption option, *STRING param)
aparamAddr                      LONG
aparam                          ASTRING, OVER(aparamAddr)
szparam                         &CSTRING
  CODE
  aparam  = CLIP(param) &'<0>'
  szparam &= (aparamAddr)
  RETURN SELF.SetOpt(option, szparam)

TCurlClass.SetOpt             PROCEDURE(CURLoption option, *CSTRING param)
  CODE
  RETURN curl_easy_setopt(SELF.curl, option, param)
  
TCurlClass.SetOpt             PROCEDURE(CURLoption option, curl::ReadWriteProcType cbproc)
  CODE
  RETURN curl_easy_setopt(SELF.curl, option, cbproc)
  
TCurlClass.SetOpt             PROCEDURE(CURLoption option, curl::ProgressDataProcType cbproc)
  CODE
  RETURN curl_easy_setopt(SELF.curl, option, cbproc)
  
TCurlClass.SetOpt             PROCEDURE(CURLoption option, curl::DebugProcType debugproc)
  CODE
  RETURN curl_easy_setopt(SELF.curl, option, debugproc)

TCurlClass.SetOpt             PROCEDURE(CURLoption option, curl::ChunkBgnProcType chunkbgnproc)
  CODE
  RETURN curl_easy_setopt(SELF.curl, option, chunkbgnproc)

TCurlClass.SetOpt             PROCEDURE(CURLoption option, curl::ChunkEndProcType chunkendproc)
  CODE
  RETURN curl_easy_setopt(SELF.curl, option, chunkendproc)

!TCurlClass.SetOpt             PROCEDURE(CURLoption option, curl::XFerInfoProcType cbproc)
!  CODE
!  RETURN curl_easy_setopt(SELF.curl, option, cbproc)

TCurlClass.SetOpt             PROCEDURE(CURLoption option, TCurlSList plist)
  CODE
  RETURN curl_easy_setopt(SELF.curl, option, plist.GetList())

!TCurlClass.SetUrl             PROCEDURE(STRING pUrl)
!url                             CSTRING(LEN(pUrl) + 1)
!  CODE
!  url = CLIP(pUrl)
!  RETURN SELF.SetOpt(CURLOPT_URL, ADDRESS(url))
TCurlClass.SetUrl             PROCEDURE(STRING pUrl)
rcu                             CURLUcode, AUTO
  CODE
  rcu = SELF.urlp.SetPart(CURLUPART_URL, pUrl, CURLU_ALLOW_SPACE)
  IF rcu <> CURLUE_OK
    curl::DebugInfo('TCurlClass.SetUrl('& CLIP(pUrl) &') error: '& curl::url:StrError(rcu))
    RETURN CURLE_URL_MALFORMAT
  END
  
  RETURN SELF.SetOpt(CURLOPT_CURLU, SELF.urlp.GetPtr())

TCurlClass.Perform            PROCEDURE()
res                             CURLcode, AUTO
  CODE
  res = SELF.SetDebugCallback(curl::DebugCallback)
  RETURN curl_easy_perform(SELF.curl)
  
TCurlClass.StrError           PROCEDURE(CURLcode errcode)
  CODE
  IF NOT SELF.Errors &= NULL
    SELF.Errors.Id = errcode
    GET(SELF.Errors, SELF.Errors.Id)
    IF NOT ERRORCODE()
      RETURN SELF.Errors.Message
    END
  END
  
  RETURN curl_easy_strerror(errcode)
  
TCurlClass.SetUserPwd         PROCEDURE(STRING pUser, STRING pPwd)
userpwd                         CSTRING(LEN(pUser) + LEN(pPwd) + 1 + 1), AUTO
  CODE
  IF pUser !- blank password is allowed.
    userpwd = CLIP(pUser) &':'& CLIP(pPwd)
  ELSE
    userpwd = ''
  END
  
  RETURN SELF.SetOpt(CURLOPT_USERPWD, ADDRESS(userpwd))
  
TCurlClass.SetReadCallback    PROCEDURE(curl::ReadWriteProcType readproc, LONG pData)
res                             CURLcode, AUTO
  CODE
  ! set callback
  res = SELF.SetOpt(CURLOPT_READFUNCTION, readproc)
  IF res <> CURLE_OK
    RETURN res
  END

  ! data passed to callback proc
  res = SELF.SetOpt(CURLOPT_READDATA, pData)
  IF res <> CURLE_OK
    RETURN res
  END
  
  RETURN CURLE_OK

TCurlClass.ResetReadCallback  PROCEDURE()
  CODE
  SELF.SetOpt(CURLOPT_READFUNCTION, 0)
  SELF.SetOpt(CURLOPT_READDATA, 0)
  RETURN CURLE_OK

TCurlClass.SetWriteCallback   PROCEDURE(curl::ReadWriteProcType writeproc, LONG pData)
res                             CURLcode, AUTO
  CODE
  ! set callback
  res = SELF.SetOpt(CURLOPT_WRITEFUNCTION, writeproc)
  IF res <> CURLE_OK
    RETURN res
  END

  ! data passed to callback proc
  res = SELF.SetOpt(CURLOPT_WRITEDATA, pData)
  IF res <> CURLE_OK
    RETURN res
  END
  
  RETURN CURLE_OK

TCurlClass.ResetWriteCallback PROCEDURE()
  CODE
  SELF.SetOpt(CURLOPT_WRITEFUNCTION, 0)
  SELF.SetOpt(CURLOPT_WRITEDATA, 0)
  RETURN CURLE_OK

TCurlClass.SetXFerCallback    PROCEDURE(<curl::ProgressDataProcType xferproc>)
res                             CURLcode, AUTO
  CODE
  IF OMITTED(xferproc)
    res = SELF.SetOpt(CURLOPT_PROGRESSFUNCTION, curl::XFerInfo)
  
    ! pass self to progress function
    res = SELF.SetOpt(CURLOPT_PROGRESSDATA, ADDRESS(SELF))
    IF res <> CURLE_OK
      RETURN res
    END
  ELSE
    res = SELF.SetOpt(CURLOPT_PROGRESSFUNCTION, xferproc)
  END
  IF res <> CURLE_OK
    RETURN res
  END

  ! enable progress
  res = SELF.SetOpt(CURLOPT_NOPROGRESS, FALSE)
  IF res <> CURLE_OK
    RETURN res
  END
  
  RETURN CURLE_OK

TCurlClass.ResetXFerCallback  PROCEDURE()
  CODE
  SELF.SetOpt(CURLOPT_PROGRESSFUNCTION, 0)
  SELF.SetOpt(CURLOPT_PROGRESSDATA, 0)
  SELF.SetOpt(CURLOPT_NOPROGRESS, TRUE)
  RETURN CURLE_OK

TCurlClass.SetDebugCallback   PROCEDURE(curl::DebugProcType debugproc)
res                             CURLcode, AUTO
  CODE
  res = SELF.SetOpt(CURLOPT_DEBUGFUNCTION, debugproc)
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_DEBUGDATA, ADDRESS(SELF))
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_VERBOSE, 1)
  IF res <> CURLE_OK
    RETURN res
  END
    
  RETURN CURLE_OK

TCurlClass.ResetDebugCallback PROCEDURE()
  CODE
  SELF.SetOpt(CURLOPT_DEBUGFUNCTION, 0)
  SELF.SetOpt(CURLOPT_DEBUGDATA, 0)
  SELF.SetOpt(CURLOPT_VERBOSE, 0)
  RETURN CURLE_OK

TCurlClass.SetHeaderCallback  PROCEDURE(<curl::HeaderProcType headerproc>)
res                             CURLcode, AUTO
  CODE
  IF OMITTED(headerproc)
    res = SELF.SetOpt(CURLOPT_HEADERFUNCTION, curl::HeaderCallback)
  ELSE
    res = SELF.SetOpt(CURLOPT_HEADERFUNCTION, headerproc)
  END
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_HEADERDATA, ADDRESS(SELF))
  IF res <> CURLE_OK
    RETURN res
  END
  
  RETURN CURLE_OK
  
TCurlClass.ResetHeaderCallback    PROCEDURE()
  CODE
  SELF.SetOpt(CURLOPT_HEADERFUNCTION, 0)
  SELF.SetOpt(CURLOPT_HEADERDATA, 0)
  RETURN CURLE_OK

TCurlClass.SetDebugInfoFilter PROCEDURE(UNSIGNED pDebugInfoFilter)
  CODE
  SELF.debugInfoMask = pDebugInfoFilter
  
TCurlClass.ReadFile           PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>)
fs                              LIKE(TCurlFileStruct)
uapi                            TCurlUrlApiClass
sSchema                         STRING(20), AUTO
res                             CURLcode, AUTO
  CODE
  ! set WriteFile callback
  fs.Init(pLocalFile)
  res = SELF.SetWriteCallback(curl::FileWrite, ADDRESS(fs))
  IF res <> CURLE_OK
    RETURN res
  END
  
  ! progress
  res = SELF.SetXFerCallback(xferproc)
  IF res <> CURLE_OK
    RETURN res
  END

  ! remote file
  res = SELF.SetUrl(pRemoteFile)
  IF res <> CURLE_OK
    RETURN res
  END

  !- set options regarding a protocol
  uapi.Init()
  uapi.SetPart(CURLUPART_URL, pRemoteFile, CURLU_DEFAULT_SCHEME)
  uapi.GetPart(CURLUPART_SCHEME, sSchema)
  IF sSchema = 'ftp'  ! relevant if CURLOPT_WILDCARDMATCH set to 1
    !callback is called before download of concrete file started
    res = SELF.SetOpt(CURLOPT_CHUNK_BGN_FUNCTION, curl::ChunkBgnCallback)  
    IF res <> CURLE_OK
      RETURN res
    END
  
    !callback is called after data from the file have been transferred 
    res = SELF.SetOpt(CURLOPT_CHUNK_END_FUNCTION, curl::ChunkEndCallback)  
    IF res <> CURLE_OK
      RETURN res
    END

    !put transfer data into callbacks
    fs.Init(pLocalFile)
    res = SELF.SetOpt(CURLOPT_CHUNK_DATA, ADDRESS(fs))  
    IF res <> CURLE_OK
      RETURN res
    END
  END
  uapi.Cleanup()
  
  ! perform request
  res = SELF.Perform()
  IF res <> CURLE_OK
    RETURN res
  END
  
  RETURN CURLE_OK

!http://curl.haxx.se/libcurl/c/ftpupload.html
TCurlClass.WriteFile          PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>)
res                             CURLcode, AUTO
fs                              LIKE(TCurlFileStruct)
  CODE
  ! set ReadFile callback
  fs.Init(pLocalFile)
  res = SELF.SetReadCallback(curl::FileRead, ADDRESS(fs))
  IF res <> CURLE_OK
    RETURN res
  END

  ! enable uploading
  res = SELF.SetOpt(CURLOPT_UPLOAD, TRUE)
  IF res <> CURLE_OK
    RETURN res
  END
    
  ! progress
  res = SELF.SetXFerCallback(xferproc)
  IF res <> CURLE_OK
    RETURN res
  END

  ! remote file
  res = SELF.SetUrl(pRemoteFile)
  IF res <> CURLE_OK
    RETURN res
  END
  
  ! perform request
  res = SELF.Perform()
  IF res <> CURLE_OK
    RETURN res
  END
  
  RETURN CURLE_OK

TCurlClass.SendRequest        PROCEDURE(STRING pUrl, *IDynStr pDynStr, <curl::ProgressDataProcType xferproc>)
res                             CURLcode, AUTO
  CODE
  IF NOT pDynStr &= NULL
    res = SELF.SetWriteCallback(curl::DynStrWrite, ADDRESS(pDynStr))
    IF res <> CURLE_OK
      RETURN res
    END
  END
  
  res = SELF.SetXFerCallback(xferproc)
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetUrl(pUrl)
  IF res <> CURLE_OK
    RETURN res
  END
  
  ! perform request
  RETURN SELF.Perform()

TCurlClass.SendRequest        PROCEDURE(STRING pUrl, <STRING pPostFields>, *IDynStr pDynStr, <curl::ProgressDataProcType xferproc>)
  CODE
  SELF.SetPostFields(pPostFields)
  RETURN SELF.SendRequest(pUrl, pDynStr, xferproc)

TCurlClass.SendRequest        PROCEDURE(STRING pUrl, <STRING pPostFields>, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>)
res                             CURLcode, AUTO
fs                              LIKE(TCurlFileStruct)
  CODE
  IF pResponseFile <> ''
    fs.Init(pResponseFile)
    res = SELF.SetWriteCallback(curl::FileWrite, ADDRESS(fs))
    IF res <> CURLE_OK
      RETURN res
    END
  END
 
  res = SELF.SetXFerCallback(xferproc)
  IF res <> CURLE_OK
    RETURN res
  END

!  /* First set the URL that is about to receive our POST. This URL can
!     just as well be a https:// URL if that is what should receive the
!     data. */ 
  res = SELF.SetUrl(pUrl)
  IF res <> CURLE_OK
    RETURN res
  END

!  /* Now specify the POST data */ 
  SELF.SetPostFields(pPostFields)
  
  ! perform request
  RETURN SELF.Perform()

TCurlClass.SendRequestStr     PROCEDURE(STRING pUrl, <STRING pPostFields>, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>)
res                             CURLcode, AUTO
ss                              LIKE(TCurlStringStruct)
  CODE
  IF NOT OMITTED(pResponseBuf)
    ss.buffer = ADDRESS(pResponseBuf)
    ss.bufsize = LEN(pResponseBuf)
    ss.filled = 0
    res = SELF.SetWriteCallback(curl::StringWrite, ADDRESS(ss))
    IF res <> CURLE_OK
      RETURN res
    END
  END
  
  res = SELF.SetXFerCallback(xferproc)
  IF res <> CURLE_OK
    RETURN res
  END

!  /* First set the URL that is about to receive our POST. This URL can
!     just as well be a https:// URL if that is what should receive the
!     data. */ 
  res = SELF.SetUrl(pUrl)
  IF res <> CURLE_OK
    RETURN res
  END
  
!  /* Now specify the POST data */ 
  SELF.SetPostFields(pPostFields)

  ! perform request
  RETURN SELF.Perform()

TCurlClass.PostFile           PROCEDURE(STRING pUrl, STRING pArgname, STRING pFilename, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>)
httppost                        LONG(0)
lastptr                         LONG(0)
szarg                           CSTRING(LEN(pArgname) + 1)
szfilename                      CSTRING(LEN(pFilename) + 1)
res                             CURLcode, AUTO
cfres                           CURLFORMcode, AUTO
  CODE
  
  szarg = CLIP(pArgname)
  szfilename = CLIP(pFilename)
  
  cfres = curl_formadd(ADDRESS(httppost), ADDRESS(lastptr), CURLFORM_COPYNAME, szarg, CURLFORM_FILE, szfilename, CURLFORM_END)
  IF cfres <> CURL_FORMADD_OK
    RETURN -1
  END
  
  res = SELF.SetOpt(CURLOPT_HTTPPOST, httppost)
  IF res <> CURLE_OK
    RETURN res
  END

  ! perform request
  res = SELF.SendRequest(pUrl, '', pResponseFile, xferproc)
  
  curl_formfree(httppost)

  RETURN res

TCurlClass.PostFileStr        PROCEDURE(STRING pUrl, STRING pArgname, STRING pFilename, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>)
httppost                        LONG(0)
lastptr                         LONG(0)
szarg                           CSTRING(LEN(pArgname) + 1)
szfilename                      CSTRING(LEN(pFilename) + 1)
res                             CURLcode, AUTO
cfres                           CURLFORMcode, AUTO
  CODE
  
  szarg = CLIP(pArgname)
  szfilename = CLIP(pFilename)
  
  cfres = curl_formadd(ADDRESS(httppost), ADDRESS(lastptr), CURLFORM_COPYNAME, szarg, CURLFORM_FILE, szfilename, CURLFORM_END)
  IF cfres <> CURL_FORMADD_OK
    RETURN -1
  END
  
  res = SELF.SetOpt(CURLOPT_HTTPPOST, httppost)
  IF res <> CURLE_OK
    RETURN res
  END

  ! perform request
  res = SELF.SendRequestStr(pUrl, '', pResponseBuf, xferproc)
  
  curl_formfree(httppost)

  RETURN res

TCurlClass.XFerInfo           PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
  CODE
  RETURN 0
  
TCurlClass.DebugCallback      PROCEDURE(CURL_INFOTYPE ptype, STRING ptypetxt, STRING ptext)
  CODE
  IF BAND(SELF.debugInfoMask, BSHIFT(1, ptype))
    curl::DebugInfo(CLIP(ptypetxt) &': '& CLIP(ptext))
  END
  
TCurlClass.TalkCallback       PROCEDURE(CURL_INFOTYPE ptype, STRING ptext)
  CODE
    
TCurlClass.HeaderCallback     PROCEDURE(STRING pHeaderLine)
  CODE

TCurlClass.AddHttpHeader      PROCEDURE(STRING pHeader)
  CODE
  SELF.headers.AppendData(pHeader)
  
TCurlClass.FreeHttpHeaders    PROCEDURE()
  CODE
  SELF.headers.Free()
  SELF.SetOpt(CURLOPT_HTTPHEADER, 0) !--  reset back to no custom headers

TCurlClass.SetHttpHeaders     PROCEDURE()
  CODE
  RETURN SELF.SetOpt(CURLOPT_HTTPHEADER, SELF.headers)
  
TCurlClass.SetCustomRequest   PROCEDURE(STRING pCustomRequest)
szVerb                          CSTRING(LEN(CLIP(pCustomRequest)) + 1)
  CODE
  IF pCustomRequest
    szVerb = CLIP(pCustomRequest)
    RETURN SELF.SetOpt(CURLOPT_CUSTOMREQUEST, ADDRESS(szVerb))
  END
  
  RETURN CURLE_OK

TCurlClass.SetHttpGET         PROCEDURE(BOOL pValue = TRUE)
  CODE
  RETURN SELF.SetOpt(CURLOPT_HTTPGET, pValue)

TCurlClass.UseSSL             PROCEDURE(CURL_USESSL pSSL)
  CODE
  RETURN SELF.SetOpt(CURLOPT_USE_SSL, pSSL)

TCurlClass.SetSSLVerifyHost   PROCEDURE(BOOL pValue)
  CODE
  !default value is 2
  !1 is not supported
  !http://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYHOST.html#DESCRIPTION
  RETURN SELF.SetOpt(CURLOPT_SSL_VERIFYHOST, CHOOSE(pValue = TRUE, 2, 0))
  
TCurlClass.SetSSLVerifyPeer   PROCEDURE(BOOL pValue)
  CODE
  RETURN SELF.SetOpt(CURLOPT_SSL_VERIFYPEER, pValue)

TCurlClass.SetCAInfo          PROCEDURE(STRING pCert)
szcert                          CSTRING(LEN(pCert) + 1)
  CODE
  szcert = CLIP(pCert)
  RETURN SELF.SetOpt(CURLOPT_CAINFO, ADDRESS(szcert))
  
TCurlClass.SetSSLVersion      PROCEDURE(CURL_SSLVERSION_ENUM pSSLVersion)
  CODE
  RETURN SELF.SetOpt(CURLOPT_SSLVERSION, pSSLVersion)

TCurlClass.GetInfo            PROCEDURE(CURLINFO info, *LONG value)
refval                          LONG, AUTO
res                             CURLcode, AUTO
  CODE
  res = curl_easy_getinfo(SELF.curl, info, ADDRESS(refval))
  IF res = CURLE_OK
    value = refval
  END
  
  RETURN res

TCurlClass.GetInfo            PROCEDURE(CURLINFO info, *REAL value)
refval                          REAL, AUTO
res                             CURLcode, AUTO
  CODE
  res = curl_easy_getinfo(SELF.curl, info, refval)
  IF res = CURLE_OK
    value = refval
  END
  
  RETURN res
  
TCurlClass.GetInfo            PROCEDURE(CURLINFO pInfo, *curl_off_t pValue)
off_t_val                       LIKE(curl_off_t), AUTO
res                             CURLcode, AUTO
  CODE
  res = curl_easy_getinfo(SELF.curl, pInfo, off_t_val)
  IF res = CURLE_OK
    pValue = off_t_val
  END
  
  RETURN res

TCurlClass.GetInfo::LONG      PROCEDURE(CURLINFO info)
lVal                            LONG, AUTO
  CODE
  ASSERT(BAND(info, CURLINFO_TYPEMASK) = CURLINFO_LONG)
  SELF.GetInfo(info, lVal)
  RETURN lVal
  
TCurlClass.GetInfo::SLIST     PROCEDURE(CURLINFO info)
lVal                            LONG, AUTO
  CODE
  ASSERT(BAND(info, CURLINFO_TYPEMASK) = CURLINFO_SLIST)
  SELF.GetInfo(info, lVal)
  RETURN lVal

TCurlClass.GetInfo::STRING    PROCEDURE(CURLINFO info)
lVal                            LONG, AUTO
sVal                            &CSTRING
  CODE
  ASSERT(BAND(info, CURLINFO_TYPEMASK) = CURLINFO_STRING)
  IF SELF.GetInfo(info, lVal) = CURLE_OK
    IF lVal
      sVal &= (lVal)
      RETURN CLIP(sVal)
    END
  END
  
  RETURN ''

TCurlClass.GetInfo::DOUBLE    PROCEDURE(CURLINFO info)
rVal                            REAL
  CODE
  ASSERT(BAND(info, CURLINFO_TYPEMASK) = CURLINFO_DOUBLE)
  IF SELF.GetInfo(info, rVal) = CURLE_OK
    RETURN rVal
  END
  
  RETURN 0.0
  
TCurlClass.GetInfo::OFF_T     PROCEDURE(CURLINFO info, <*UNSIGNED pHighPart>)
off_t_val                       LIKE(curl_off_t)
  CODE
  ASSERT(BAND(info, CURLINFO_TYPEMASK) = CURLINFO_OFF_T)
  IF SELF.GetInfo(info, off_t_val) = CURLE_OK
    IF NOT OMITTED(pHighPart)
      pHighPart = off_t_val.hi
    END
    RETURN off_t_val.lo
  END

  IF NOT OMITTED(pHighPart)
    pHighPart = 0
  END
  RETURN 0

TCurlClass.GetContentType     PROCEDURE()
  CODE
  RETURN SELF.GetInfo::STRING(CURLINFO_CONTENT_TYPE)
  
TCurlClass.GetResponseCode    PROCEDURE()
  CODE
  RETURN SELF.GetInfo::LONG(CURLINFO_RESPONSE_CODE)
  
TCurlClass.GetDefaultCAInfo   PROCEDURE()
  CODE
  RETURN SELF.GetInfo::STRING(CURLINFO_CAINFO)
  
TCurlClass.GetDefaultCAPath   PROCEDURE()
  CODE
  RETURN SELF.GetInfo::STRING(CURLINFO_CAPATH)


TCurlClass.SetQuote           PROCEDURE(TCurlSList plist)
  CODE
  RETURN SELF.SetOpt(CURLOPT_QUOTE, plist)
  
TCurlClass.PreQuote           PROCEDURE(TCurlSList plist)
  CODE
  RETURN SELF.SetOpt(CURLOPT_PREQUOTE, plist)
  
TCurlClass.PostQuote          PROCEDURE(TCurlSList plist)
  CODE
  RETURN SELF.SetOpt(CURLOPT_POSTQUOTE, plist)
  
TCurlClass.SetDefaultProtocol PROCEDURE(STRING pSchema)
  CODE
  RETURN SELF.SetOpt(CURLOPT_DEFAULT_PROTOCOL, pSchema)
  
TCurlClass.SetPostFields      PROCEDURE(STRING pPostFields)
res                             CURLcode, AUTO
  CODE                 
  IF pPostFields
    res = SELF.SetOpt(CURLOPT_POSTFIELDS, pPostFields)
    IF res <> CURLE_OK
      RETURN res
    END

    res = SELF.SetOpt(CURLOPT_POSTFIELDSIZE, LEN(CLIP(pPostFields)))
    IF res <> CURLE_OK
      RETURN res
    END
  END
  
  RETURN CURLE_OK

TCurlClass.SetPostFields      PROCEDURE(*IDynStr pPostFields)
res                             CURLcode, AUTO
  CODE                 
  IF NOT pPostFields &= NULL
    IF pPostFields.StrLen() > 0
      res = SELF.SetOpt(CURLOPT_POSTFIELDS, pPostFields.CStrRef())
      IF res <> CURLE_OK
        RETURN res
      END

      res = SELF.SetOpt(CURLOPT_POSTFIELDSIZE, pPostFields.StrLen())
      IF res <> CURLE_OK
        RETURN res
      END
    END
  ELSE
    curl::DebugInfo('SetPostFields: NULL reference passed')
    RETURN -1
  END
  
  RETURN CURLE_OK

TCurlClass.SetUserAgent       PROCEDURE(STRING pUserAgent)
res                             CURLcode, AUTO
  CODE
  res = SELF.SetOpt(CURLOPT_USERAGENT, pUserAgent)
  IF res <> CURLE_OK
    RETURN res
  END

  RETURN CURLE_OK

TCurlClass.SetMimePost        PROCEDURE(TCurlMimeClass mime)
res                             CURLcode, AUTO
  CODE
  res = SELF.SetOpt(CURLOPT_MIMEPOST, mime.GetMime())
  IF res <> CURLE_OK
    RETURN res
  END

  RETURN CURLE_OK
  
!!!endregion
  
