  PROGRAM

CURL                          EQUATE(LONG)

size_t                        EQUATE(UNSIGNED)

CURLcode                      EQUATE(LONG)
CURLE_OK                      EQUATE(0)

!CURLE_OK = 0,
!CURLE_UNSUPPORTED_PROTOCOL,    /* 1 */
!CURLE_FAILED_INIT,             /* 2 */
!CURLE_URL_MALFORMAT,           /* 3 */
!CURLE_NOT_BUILT_IN,            /* 4 - [was obsoleted in August 2007 for
!                                  7.17.0, reused in April 2011 for 7.21.5] */
!CURLE_COULDNT_RESOLVE_PROXY,   /* 5 */
!CURLE_COULDNT_RESOLVE_HOST,    /* 6 */
!CURLE_COULDNT_CONNECT,         /* 7 */
!CURLE_FTP_WEIRD_SERVER_REPLY,  /* 8 */
!CURLE_REMOTE_ACCESS_DENIED,    /* 9 a service was denied by the server
!                                  due to lack of access - when login fails
!                                  this is not returned. */
!CURLE_FTP_ACCEPT_FAILED,       /* 10 - [was obsoleted in April 2006 for
!                                  7.15.4, reused in Dec 2011 for 7.24.0]*/
!CURLE_FTP_WEIRD_PASS_REPLY,    /* 11 */
!CURLE_FTP_ACCEPT_TIMEOUT,      /* 12 - timeout occurred accepting server
!                                  [was obsoleted in August 2007 for 7.17.0,
!                                  reused in Dec 2011 for 7.24.0]*/
!CURLE_FTP_WEIRD_PASV_REPLY,    /* 13 */
!CURLE_FTP_WEIRD_227_FORMAT,    /* 14 */
!CURLE_FTP_CANT_GET_HOST,       /* 15 */
!CURLE_HTTP2,                   /* 16 - A problem in the http2 framing layer.
!                                  [was obsoleted in August 2007 for 7.17.0,
!                                  reused in July 2014 for 7.38.0] */
!CURLE_FTP_COULDNT_SET_TYPE,    /* 17 */
!CURLE_PARTIAL_FILE,            /* 18 */
!CURLE_FTP_COULDNT_RETR_FILE,   /* 19 */
!CURLE_OBSOLETE20,              /* 20 - NOT USED */
!CURLE_QUOTE_ERROR,             /* 21 - quote command failure */
!CURLE_HTTP_RETURNED_ERROR,     /* 22 */
!CURLE_WRITE_ERROR,             /* 23 */
!CURLE_OBSOLETE24,              /* 24 - NOT USED */
!CURLE_UPLOAD_FAILED,           /* 25 - failed upload "command" */
!CURLE_READ_ERROR,              /* 26 - couldn't open/read from file */
!CURLE_OUT_OF_MEMORY,           /* 27 */
!/* Note: CURLE_OUT_OF_MEMORY may sometimes indicate a conversion error
!         instead of a memory allocation error if CURL_DOES_CONVERSIONS
!         is defined
!*/
!CURLE_OPERATION_TIMEDOUT,      /* 28 - the timeout time was reached */
!CURLE_OBSOLETE29,              /* 29 - NOT USED */
!CURLE_FTP_PORT_FAILED,         /* 30 - FTP PORT operation failed */
!CURLE_FTP_COULDNT_USE_REST,    /* 31 - the REST command failed */
!CURLE_OBSOLETE32,              /* 32 - NOT USED */
!CURLE_RANGE_ERROR,             /* 33 - RANGE "command" didn't work */
!CURLE_HTTP_POST_ERROR,         /* 34 */
!CURLE_SSL_CONNECT_ERROR,       /* 35 - wrong when connecting with SSL */
!CURLE_BAD_DOWNLOAD_RESUME,     /* 36 - couldn't resume download */
!CURLE_FILE_COULDNT_READ_FILE,  /* 37 */
!CURLE_LDAP_CANNOT_BIND,        /* 38 */
!CURLE_LDAP_SEARCH_FAILED,      /* 39 */
!CURLE_OBSOLETE40,              /* 40 - NOT USED */
!CURLE_FUNCTION_NOT_FOUND,      /* 41 */
!CURLE_ABORTED_BY_CALLBACK,     /* 42 */
!CURLE_BAD_FUNCTION_ARGUMENT,   /* 43 */
!CURLE_OBSOLETE44,              /* 44 - NOT USED */
!CURLE_INTERFACE_FAILED,        /* 45 - CURLOPT_INTERFACE failed */
!CURLE_OBSOLETE46,              /* 46 - NOT USED */
!CURLE_TOO_MANY_REDIRECTS ,     /* 47 - catch endless re-direct loops */
!CURLE_UNKNOWN_OPTION,          /* 48 - User specified an unknown option */
!CURLE_TELNET_OPTION_SYNTAX ,   /* 49 - Malformed telnet option */
!CURLE_OBSOLETE50,              /* 50 - NOT USED */
!CURLE_PEER_FAILED_VERIFICATION, /* 51 - peer's certificate or fingerprint
!                                   wasn't verified fine */
!CURLE_GOT_NOTHING,             /* 52 - when this is a specific error */
!CURLE_SSL_ENGINE_NOTFOUND,     /* 53 - SSL crypto engine not found */
!CURLE_SSL_ENGINE_SETFAILED,    /* 54 - can not set SSL crypto engine as
!                                  default */
!CURLE_SEND_ERROR,              /* 55 - failed sending network data */
!CURLE_RECV_ERROR,              /* 56 - failure in receiving network data */
!CURLE_OBSOLETE57,              /* 57 - NOT IN USE */
!CURLE_SSL_CERTPROBLEM,         /* 58 - problem with the local certificate */
!CURLE_SSL_CIPHER,              /* 59 - couldn't use specified cipher */
!CURLE_SSL_CACERT,              /* 60 - problem with the CA cert (path?) */
!CURLE_BAD_CONTENT_ENCODING,    /* 61 - Unrecognized/bad encoding */
!CURLE_LDAP_INVALID_URL,        /* 62 - Invalid LDAP URL */
!CURLE_FILESIZE_EXCEEDED,       /* 63 - Maximum file size exceeded */
!CURLE_USE_SSL_FAILED,          /* 64 - Requested FTP SSL level failed */
!CURLE_SEND_FAIL_REWIND,        /* 65 - Sending the data requires a rewind
!                                  that failed */
!CURLE_SSL_ENGINE_INITFAILED,   /* 66 - failed to initialise ENGINE */
!CURLE_LOGIN_DENIED,            /* 67 - user, password or similar was not
!                                  accepted and we failed to login */
!CURLE_TFTP_NOTFOUND,           /* 68 - file not found on server */
!CURLE_TFTP_PERM,               /* 69 - permission problem on server */
!CURLE_REMOTE_DISK_FULL,        /* 70 - out of disk space on server */
!CURLE_TFTP_ILLEGAL,            /* 71 - Illegal TFTP operation */
!CURLE_TFTP_UNKNOWNID,          /* 72 - Unknown transfer ID */
!CURLE_REMOTE_FILE_EXISTS,      /* 73 - File already exists */
!CURLE_TFTP_NOSUCHUSER,         /* 74 - No such user */
!CURLE_CONV_FAILED,             /* 75 - conversion failed */
!CURLE_CONV_REQD,               /* 76 - caller must register conversion
!                                  callbacks using curl_easy_setopt options
!                                  CURLOPT_CONV_FROM_NETWORK_FUNCTION,
!                                  CURLOPT_CONV_TO_NETWORK_FUNCTION, and
!                                  CURLOPT_CONV_FROM_UTF8_FUNCTION */
!CURLE_SSL_CACERT_BADFILE,      /* 77 - could not load CACERT file, missing
!                                  or wrong format */
!CURLE_REMOTE_FILE_NOT_FOUND,   /* 78 - remote file not found */
!CURLE_SSH,                     /* 79 - error from the SSH layer, somewhat
!                                  generic so the error message will be of
!                                  interest when this has happened */
!
!CURLE_SSL_SHUTDOWN_FAILED,     /* 80 - Failed to shut down the SSL
!                                  connection */
!CURLE_AGAIN,                   /* 81 - socket is not ready for send/recv,
!                                  wait till it's ready and try again (Added
!                                  in 7.18.2) */
!CURLE_SSL_CRL_BADFILE,         /* 82 - could not load CRL file, missing or
!                                  wrong format (Added in 7.19.0) */
!CURLE_SSL_ISSUER_ERROR,        /* 83 - Issuer check failed.  (Added in
!                                  7.19.0) */
!CURLE_FTP_PRET_FAILED,         /* 84 - a PRET command failed */
!CURLE_RTSP_CSEQ_ERROR,         /* 85 - mismatch of RTSP CSeq numbers */
!CURLE_RTSP_SESSION_ERROR,      /* 86 - mismatch of RTSP Session Ids */
!CURLE_FTP_BAD_FILE_LIST,       /* 87 - unable to parse FTP file list */
!CURLE_CHUNK_FAILED,            /* 88 - chunk callback reported error */
!CURLE_NO_CONNECTION_AVAILABLE, /* 89 - No connection available, the
!                                  session will be queued */
!CURLE_SSL_PINNEDPUBKEYNOTMATCH, /* 90 - specified pinned public key did not
!                                   match */
!CURL_LAST /* never use! */ 

CURLINFO                      EQUATE(LONG)
!CURLINFO_NONE, /* first, never use this */
!CURLINFO_EFFECTIVE_URL    = CURLINFO_STRING + 1,
!CURLINFO_RESPONSE_CODE    = CURLINFO_LONG   + 2,
!CURLINFO_TOTAL_TIME       = CURLINFO_DOUBLE + 3,
!CURLINFO_NAMELOOKUP_TIME  = CURLINFO_DOUBLE + 4,
!CURLINFO_CONNECT_TIME     = CURLINFO_DOUBLE + 5,
!CURLINFO_PRETRANSFER_TIME = CURLINFO_DOUBLE + 6,
!CURLINFO_SIZE_UPLOAD      = CURLINFO_DOUBLE + 7,
!CURLINFO_SIZE_DOWNLOAD    = CURLINFO_DOUBLE + 8,
!CURLINFO_SPEED_DOWNLOAD   = CURLINFO_DOUBLE + 9,
!CURLINFO_SPEED_UPLOAD     = CURLINFO_DOUBLE + 10,
!CURLINFO_HEADER_SIZE      = CURLINFO_LONG   + 11,
!CURLINFO_REQUEST_SIZE     = CURLINFO_LONG   + 12,
!CURLINFO_SSL_VERIFYRESULT = CURLINFO_LONG   + 13,
!CURLINFO_FILETIME         = CURLINFO_LONG   + 14,
!CURLINFO_CONTENT_LENGTH_DOWNLOAD   = CURLINFO_DOUBLE + 15,
!CURLINFO_CONTENT_LENGTH_UPLOAD     = CURLINFO_DOUBLE + 16,
!CURLINFO_STARTTRANSFER_TIME = CURLINFO_DOUBLE + 17,
!CURLINFO_CONTENT_TYPE     = CURLINFO_STRING + 18,
!CURLINFO_REDIRECT_TIME    = CURLINFO_DOUBLE + 19,
!CURLINFO_REDIRECT_COUNT   = CURLINFO_LONG   + 20,
!CURLINFO_PRIVATE          = CURLINFO_STRING + 21,
!CURLINFO_HTTP_CONNECTCODE = CURLINFO_LONG   + 22,
!CURLINFO_HTTPAUTH_AVAIL   = CURLINFO_LONG   + 23,
!CURLINFO_PROXYAUTH_AVAIL  = CURLINFO_LONG   + 24,
!CURLINFO_OS_ERRNO         = CURLINFO_LONG   + 25,
!CURLINFO_NUM_CONNECTS     = CURLINFO_LONG   + 26,
!CURLINFO_SSL_ENGINES      = CURLINFO_SLIST  + 27,
!CURLINFO_COOKIELIST       = CURLINFO_SLIST  + 28,
!CURLINFO_LASTSOCKET       = CURLINFO_LONG   + 29,
!CURLINFO_FTP_ENTRY_PATH   = CURLINFO_STRING + 30,
!CURLINFO_REDIRECT_URL     = CURLINFO_STRING + 31,
!CURLINFO_PRIMARY_IP       = CURLINFO_STRING + 32,
!CURLINFO_APPCONNECT_TIME  = CURLINFO_DOUBLE + 33,
!CURLINFO_CERTINFO         = CURLINFO_SLIST  + 34,
!CURLINFO_CONDITION_UNMET  = CURLINFO_LONG   + 35,
!CURLINFO_RTSP_SESSION_ID  = CURLINFO_STRING + 36,
!CURLINFO_RTSP_CLIENT_CSEQ = CURLINFO_LONG   + 37,
!CURLINFO_RTSP_SERVER_CSEQ = CURLINFO_LONG   + 38,
!CURLINFO_RTSP_CSEQ_RECV   = CURLINFO_LONG   + 39,
!CURLINFO_PRIMARY_PORT     = CURLINFO_LONG   + 40,
!CURLINFO_LOCAL_IP         = CURLINFO_STRING + 41,
!CURLINFO_LOCAL_PORT       = CURLINFO_LONG   + 42,
!CURLINFO_TLS_SESSION      = CURLINFO_SLIST  + 43, 

!#define CURL_GLOBAL_SSL (1<<0)
!#define CURL_GLOBAL_WIN32 (1<<1)
!#define CURL_GLOBAL_ALL (CURL_GLOBAL_SSL|CURL_GLOBAL_WIN32)
!#define CURL_GLOBAL_NOTHING 0
!#define CURL_GLOBAL_DEFAULT CURL_GLOBAL_ALL
!#define CURL_GLOBAL_ACK_EINTR (1<<2)
CURL_GLOBAL_SSL               EQUATE(0001b)
CURL_GLOBAL_WIN32             EQUATE(0010b)
CURL_GLOBAL_ALL               EQUATE(BOR(CURL_GLOBAL_SSL, CURL_GLOBAL_WIN32))
CURL_GLOBAL_NOTHING           EQUATE(0)
CURL_GLOBAL_DEFAULT           EQUATE(CURL_GLOBAL_ALL)
CURL_GLOBAL_ACK_EINTR         EQUATE(0100b)


CURLoption                    EQUATE(LONG)
CURLOPTTYPE_LONG              EQUATE(0)
CURLOPTTYPE_OBJECTPOINT       EQUATE(10000)
CURLOPTTYPE_FUNCTIONPOINT     EQUATE(20000)
CURLOPTTYPE_OFF_T             EQUATE(30000)

CURLOPT_URL                   EQUATE(2 + CURLOPTTYPE_OBJECTPOINT)
CURLOPT_FOLLOWLOCATION        EQUATE(52 + CURLOPTTYPE_LONG)

CURLOPT_WRITEFUNCTION         EQUATE(11 + CURLOPTTYPE_FUNCTIONPOINT)
CURLOPT_WRITEDATA             EQUATE(1 + CURLOPTTYPE_OBJECTPOINT)

CURLOPT_PROGRESSFUNCTION      EQUATE(56 + CURLOPTTYPE_FUNCTIONPOINT)
CURLOPT_NOPROGRESS            EQUATE(43 + CURLOPTTYPE_LONG)




  INCLUDE('svapi.inc')

  MAP
    ! callback prototypes
    CapWriteProcType(LONG buffer, size_t bufsize, size_t nmemb, *HANDLE userdata), size_t, C, TYPE
    ProgressDataProcType(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, C, TYPE


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
      curl_easy_setopt(CURL curl, CURLoption option, CapWriteProcType cbproc), CURLcode, C, RAW, NAME('curl_easy_setopt')
      curl_easy_setopt(CURL curl, CURLoption option, ProgressDataProcType cbproc), CURLcode, C, RAW, NAME('curl_easy_setopt')

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

    ! CreateFile, WriteFile
    INCLUDE('svapifnc.inc')

    CapWrite(LONG buffer, size_t bufsize, size_t nmemb, *HANDLE fhandle), size_t, C
    ProgressData(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, C

    Main()
  END

  CODE
  Main()
  
  
CapWrite                      PROCEDURE(LONG buffer, size_t bufsize, size_t nmemb, *HANDLE fhandle)
bytesWritten                    size_t
rc                              BOOL
  CODE
  rc = WriteFile(fhandle, buffer, bufsize * nmemb, bytesWritten, 0)
  IF rc
    RETURN bytesWritten
  END
  
  RETURN -1 !error
  
ProgressData                  PROCEDURE(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
  CODE
  MESSAGE('Total '& dltotal &' now '& dlnow &' ultotal '& ultotal &' ulnow '& ulnow)
  RETURN 0
  
Main                          PROCEDURE()
curl                            CURL
res                             CURLcode
fhandle                         HANDLE
filename                        CSTRING('d:\development\apps\libcurl\clarion\rss.php')
url                             CSTRING(256)

  CODE  
  curl = curl_easy_init()
  IF curl
    res = curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, CapWrite)
    IF res <> CURLE_OK
      MESSAGE('curl_easy_setopt(CURLOPT_WRITEFUNCTION) failed: '& curl_easy_strerror(res))
      RETURN
    END

    fhandle = CreateFile(filename, GENERIC_WRITE, FILE_SHARE_READ, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0)
    IF fhandle = 0
      MESSAGE('Cannot create file '& fhandle)
      RETURN
    END

    res = curl_easy_setopt(curl, CURLOPT_WRITEDATA, ADDRESS(fhandle))
    IF res <> CURLE_OK
      MESSAGE('curl_easy_setopt(CURLOPT_WRITEDATA) failed: '& curl_easy_strerror(res))
      RETURN
    END

    res = curl_easy_setopt(curl, CURLOPT_PROGRESSFUNCTION, ProgressData)
    IF res <> CURLE_OK
      MESSAGE('curl_easy_setopt(CURLOPT_PROGRESSFUNCTION) failed: '& curl_easy_strerror(res))
      RETURN
    END

    res = curl_easy_setopt(curl, CURLOPT_NOPROGRESS, FALSE)
    IF res <> CURLE_OK
      MESSAGE('curl_easy_setopt(CURLOPT_NOPROGRESS) failed: '& curl_easy_strerror(res))
      RETURN
    END

    url = 'http://www.ingasoftplus.com/rss.php'
    res = curl_easy_setopt(curl, CURLOPT_URL, ADDRESS(url))
    IF res <> CURLE_OK
      MESSAGE('curl_easy_setopt(CURLOPT_URL) failed: '& curl_easy_strerror(res))
      RETURN
    END
    
!!    /* url is redirected, so we tell libcurl to follow redirection */     
!    res = curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1)
!    IF res <> CURLE_OK
!      MESSAGE('curl_easy_setopt(CURLOPT_FOLLOWLOCATION) failed: '& curl_easy_strerror(res))
!      RETURN
!    END

!    /* Perform the request, res will get the return code */ 
    res = curl_easy_perform(curl)
    IF res <> CURLE_OK
      MESSAGE('curl_easy_perform failed: '& curl_easy_strerror(res))
      RETURN
    END
 
    CloseHandle(fhandle)
    
!    /* always cleanup */
    curl_easy_cleanup(curl)
  END
