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
    ! CURL callback procedure prototypes
    curl::CapWriteProcType(LONG buffer, size_t bufsize, size_t nmemb, *HANDLE userdata), size_t, C, TYPE
    curl::ProgressDataProcType(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, C, TYPE

    MODULE('libcurl')
      curl::DebugInfo(STRING s)
      curl::CapWrite(LONG buffer, size_t bufsize, size_t nmemb, *HANDLE fhandle), size_t, C
    END

    ! CreateFile, WriteFile, CloseHandle etc
    INCLUDE('svapifnc.inc')
  END

TCurlClass                    CLASS, TYPE, MODULE('libcurl.clw'), LINK('libcurl.clw')
curl                            CURL, PROTECTED

Construct                       PROCEDURE()
Destruct                        PROCEDURE(), VIRTUAL

Init                            PROCEDURE()
Cleanup                         PROCEDURE()

SetOpt                          PROCEDURE(CURLoption option, LONG param), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, curl::CapWriteProcType cbproc), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, curl::ProgressDataProcType cbproc), CURLcode, PROC

Perform                         PROCEDURE(), CURLcode

StrError                        PROCEDURE(CURLcode errcode), STRING


!
ReadFile                        PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType cbproc>), CURLcode, PROC
                              END
