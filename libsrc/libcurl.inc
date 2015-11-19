!** libcurl for Clarion v1.01
!** 13.11.2015
!** mikeduglas66@gmail.com


CURL                          EQUATE(LONG)

size_t                        EQUATE(UNSIGNED)
!curl_off_t                    EQUATE(INT64)

CURLcode                      EQUATE(LONG)


!/* linked-list structure for the CURLOPT_QUOTE option (and other) */
!struct curl_slist {
!  char *data;
!  struct curl_slist *next;
!}; 
curl_slist                    GROUP, TYPE
pdata                           LONG  !&CSTRING
pnext                           LONG  !&curl_slist
                              END



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
CURLE_READ_ERROR              EQUATE(26)              !/* 26 - couldn't open/read from file */
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

CURLINFO_STRING               EQUATE(0100000h)
CURLINFO_LONG                 EQUATE(0200000h)
CURLINFO_DOUBLE               EQUATE(0300000h)
CURLINFO_SLIST                EQUATE(0400000h)
CURLINFO_MASK                 EQUATE(00fffffh)
CURLINFO_TYPEMASK             EQUATE(0f00000h)

CURLINFO                      EQUATE(LONG)
CURLINFO_NONE                 EQUATE(0)             !/* first, never use this */
CURLINFO_EFFECTIVE_URL        EQUATE(CURLINFO_STRING + 1)
CURLINFO_RESPONSE_CODE        EQUATE(CURLINFO_LONG   + 2)
CURLINFO_TOTAL_TIME           EQUATE(CURLINFO_DOUBLE + 3)
CURLINFO_NAMELOOKUP_TIME      EQUATE(CURLINFO_DOUBLE + 4)
CURLINFO_CONNECT_TIME         EQUATE(CURLINFO_DOUBLE + 5)
CURLINFO_PRETRANSFER_TIME     EQUATE(CURLINFO_DOUBLE + 6)
CURLINFO_SIZE_UPLOAD          EQUATE(CURLINFO_DOUBLE + 7)
CURLINFO_SIZE_DOWNLOAD        EQUATE(CURLINFO_DOUBLE + 8)
CURLINFO_SPEED_DOWNLOAD       EQUATE(CURLINFO_DOUBLE + 9)
CURLINFO_SPEED_UPLOAD         EQUATE(CURLINFO_DOUBLE + 10)
CURLINFO_HEADER_SIZE          EQUATE(CURLINFO_LONG   + 11)
CURLINFO_REQUEST_SIZE         EQUATE(CURLINFO_LONG   + 12)
CURLINFO_SSL_VERIFYRESULT     EQUATE(CURLINFO_LONG   + 13)
CURLINFO_FILETIME             EQUATE(CURLINFO_LONG   + 14)
CURLINFO_CONTENT_LENGTH_DOWNLOAD  EQUATE(CURLINFO_DOUBLE + 15)
CURLINFO_CONTENT_LENGTH_UPLOAD    EQUATE(CURLINFO_DOUBLE + 16)
CURLINFO_STARTTRANSFER_TIME   EQUATE(CURLINFO_DOUBLE + 17)
CURLINFO_CONTENT_TYPE         EQUATE(CURLINFO_STRING + 18)
CURLINFO_REDIRECT_TIME        EQUATE(CURLINFO_DOUBLE + 19)
CURLINFO_REDIRECT_COUNT       EQUATE(CURLINFO_LONG   + 20)
CURLINFO_PRIVATE              EQUATE(CURLINFO_STRING + 21)
CURLINFO_HTTP_CONNECTCODE     EQUATE(CURLINFO_LONG   + 22)
CURLINFO_HTTPAUTH_AVAIL       EQUATE(CURLINFO_LONG   + 23)
CURLINFO_PROXYAUTH_AVAIL      EQUATE(CURLINFO_LONG   + 24)
CURLINFO_OS_ERRNO             EQUATE(CURLINFO_LONG   + 25)
CURLINFO_NUM_CONNECTS         EQUATE(CURLINFO_LONG   + 26)
CURLINFO_SSL_ENGINES          EQUATE(CURLINFO_SLIST  + 27)
CURLINFO_COOKIELIST           EQUATE(CURLINFO_SLIST  + 28)
CURLINFO_LASTSOCKET           EQUATE(CURLINFO_LONG   + 29)
CURLINFO_FTP_ENTRY_PATH       EQUATE(CURLINFO_STRING + 30)
CURLINFO_REDIRECT_URL         EQUATE(CURLINFO_STRING + 31)
CURLINFO_PRIMARY_IP           EQUATE(CURLINFO_STRING + 32)
CURLINFO_APPCONNECT_TIME      EQUATE(CURLINFO_DOUBLE + 33)
CURLINFO_CERTINFO             EQUATE(CURLINFO_SLIST  + 34)
CURLINFO_CONDITION_UNMET      EQUATE(CURLINFO_LONG   + 35)
CURLINFO_RTSP_SESSION_ID      EQUATE(CURLINFO_STRING + 36)
CURLINFO_RTSP_CLIENT_CSEQ     EQUATE(CURLINFO_LONG   + 37)
CURLINFO_RTSP_SERVER_CSEQ     EQUATE(CURLINFO_LONG   + 38)
CURLINFO_RTSP_CSEQ_RECV       EQUATE(CURLINFO_LONG   + 39)
CURLINFO_PRIMARY_PORT         EQUATE(CURLINFO_LONG   + 40)
CURLINFO_LOCAL_IP             EQUATE(CURLINFO_STRING + 41)
CURLINFO_LOCAL_PORT           EQUATE(CURLINFO_LONG   + 42)
CURLINFO_TLS_SESSION          EQUATE(CURLINFO_SLIST  + 43)

!#define CURL_GLOBAL_SSL (1<<0)
!#define CURL_GLOBAL_WIN32 (1<<1)
!#define CURL_GLOBAL_ALL (CURL_GLOBAL_SSL|CURL_GLOBAL_WIN32)
!#define CURL_GLOBAL_NOTHING 0
!#define CURL_GLOBAL_DEFAULT CURL_GLOBAL_ALL
!#define CURL_GLOBAL_ACK_EINTR (1<<2)

CURL_GLOBAL_ENUM              EQUATE(LONG)
CURL_GLOBAL_SSL               EQUATE(0001b)
CURL_GLOBAL_WIN32             EQUATE(0010b)
CURL_GLOBAL_ALL               EQUATE(BOR(CURL_GLOBAL_SSL, CURL_GLOBAL_WIN32))
CURL_GLOBAL_NOTHING           EQUATE(0)
CURL_GLOBAL_DEFAULT           EQUATE(CURL_GLOBAL_ALL)
CURL_GLOBAL_ACK_EINTR         EQUATE(0100b)


!/* parameter for the CURLOPT_USE_SSL option */
CURL_USESSL                   EQUATE(LONG)
                              ITEMIZE
CURLUSESSL_NONE                 EQUATE(0) !/* do not attempt to use SSL */
CURLUSESSL_TRY                  EQUATE    !/* try using SSL, proceed anyway otherwise */
CURLUSESSL_CONTROL              EQUATE    !/* SSL for the control connection or fail */
CURLUSESSL_ALL                  EQUATE    !/* SSL for all communication or fail */
CURLUSESSL_LAST                 EQUATE    !/* not an option, never use */
                              END

CURLoption                    EQUATE(LONG)
CURLOPTTYPE_LONG              EQUATE(0)
CURLOPTTYPE_OBJECTPOINT       EQUATE(10000)
CURLOPTTYPE_FUNCTIONPOINT     EQUATE(20000)
CURLOPTTYPE_OFF_T             EQUATE(30000)

CURLOPT_URL                   EQUATE(2 + CURLOPTTYPE_OBJECTPOINT)       !The full URL to get/put
CURLOPT_PORT                  EQUATE(3 + CURLOPTTYPE_LONG)              !Port number to connect to, if other than default
CURLOPT_PROXY                 EQUATE(4 + CURLOPTTYPE_OBJECTPOINT)       !Name of proxy to use
CURLOPT_USERPWD               EQUATE(5 + CURLOPTTYPE_OBJECTPOINT)       !"user:password;options" to use when fetching
CURLOPT_PROXYUSERPWD          EQUATE(6 + CURLOPTTYPE_OBJECTPOINT)       !"user:password" to use with proxy

CURLOPT_TIMEOUT               EQUATE(13 + CURLOPTTYPE_LONG)             !Time-out the read operation after this amount of seconds
CURLOPT_CONNECTTIMEOUT        EQUATE(78 + CURLOPTTYPE_LONG)             !Time-out connect operations after this amount of seconds, if connects are OK within this time, then fine... This only aborts the connect phase
CURLOPT_TIMEOUT_MS            EQUATE(155 + CURLOPTTYPE_LONG)            !Same as TIMEOUT, but with ms resolution
CURLOPT_CONNECTTIMEOUT_MS     EQUATE(156 + CURLOPTTYPE_LONG)            !Same as CONNECTTIMEOUT, but with ms resolution

!  /* FTP option that changes the timeout, in seconds, associated with
!     getting a response.  This is different from transfer timeout time and
!     essentially places a demand on the FTP server to acknowledge commands
!     in a timely manner. */ 
CURLOPT_FTP_RESPONSE_TIMEOUT  EQUATE(112 + CURLOPTTYPE_LONG)
CURLOPT_SERVER_RESPONSE_TIMEOUT   EQUATE(CURLOPT_FTP_RESPONSE_TIMEOUT)

CURLOPT_ACCEPTTIMEOUT_MS      EQUATE(212 + CURLOPTTYPE_LONG)            !Time-out accept operations (currently for FTP only) after this amount of miliseconds

CURLOPT_POSTFIELDS            EQUATE(15 + CURLOPTTYPE_OBJECTPOINT)      !POST static input fields.

CURLOPT_HTTPPOST              EQUATE(24 + CURLOPTTYPE_OBJECTPOINT)      !This points to a linked list of post entries, struct curl_httppost

CURLOPT_SSLCERT               EQUATE(25 + CURLOPTTYPE_OBJECTPOINT)      !name of the file keeping your private SSL-certificate
CURLOPT_KEYPASSWD             EQUATE(26 + CURLOPTTYPE_OBJECTPOINT)      !password for the SSL or SSH private key

CURLOPT_QUOTE                 EQUATE(28 + CURLOPTTYPE_OBJECTPOINT)      !send linked-list of QUOTE commands
CURLOPT_PREQUOTE              EQUATE(93 + CURLOPTTYPE_OBJECTPOINT)      !send linked-list of pre-transfer QUOTE commands
CURLOPT_POSTQUOTE             EQUATE(39 + CURLOPTTYPE_OBJECTPOINT)      !send linked-list of post-transfer QUOTE commands

CURLOPT_DEBUGFUNCTION         EQUATE(94 + CURLOPTTYPE_FUNCTIONPOINT)    !set the debug function
CURLOPT_DEBUGDATA             EQUATE(95 + CURLOPTTYPE_OBJECTPOINT)      !set the data for the debug function

CURLOPT_VERBOSE               EQUATE(41 + CURLOPTTYPE_LONG)             !talk a lot
CURLOPT_HEADER                EQUATE(42 + CURLOPTTYPE_LONG)             !throw the header out too
CURLOPT_NOPROGRESS            EQUATE(43 + CURLOPTTYPE_LONG)             !shut off the progress meter
CURLOPT_NOBODY                EQUATE(44 + CURLOPTTYPE_LONG)             !use HEAD to get http document
CURLOPT_FAILONERROR           EQUATE(45 + CURLOPTTYPE_LONG)             !no output on http error codes >= 400
CURLOPT_UPLOAD                EQUATE(46 + CURLOPTTYPE_LONG)             !this is an upload
CURLOPT_POST                  EQUATE(47 + CURLOPTTYPE_LONG)             !HTTP POST method
CURLOPT_DIRLISTONLY           EQUATE(48 + CURLOPTTYPE_LONG)             !bare names when listing directories
CURLOPT_FTPLISTONLY           EQUATE(CURLOPT_DIRLISTONLY)
CURLOPT_APPEND                EQUATE(50 + CURLOPTTYPE_LONG)             !Append instead of overwrite on upload!

!Specify whether to read the user+password from the .netrc or the URL.
!This must be one of the CURL_NETRC_* enums below.
CURLOPT_NETRC                 EQUATE(51 + CURLOPTTYPE_LONG)

CURLOPT_FOLLOWLOCATION        EQUATE(52 + CURLOPTTYPE_LONG)

CURLOPT_TRANSFERTEXT          EQUATE(53 + CURLOPTTYPE_LONG)             !transfer data in text/ASCII format
CURLOPT_PUT                   EQUATE(54 + CURLOPTTYPE_LONG)             !HTTP PUT
    
CURLOPT_WRITEFUNCTION         EQUATE(11 + CURLOPTTYPE_FUNCTIONPOINT)
CURLOPT_WRITEDATA             EQUATE(1 + CURLOPTTYPE_OBJECTPOINT)

CURLOPT_READFUNCTION          EQUATE(12 + CURLOPTTYPE_FUNCTIONPOINT)
CURLOPT_READDATA              EQUATE(9 + CURLOPTTYPE_OBJECTPOINT)

CURLOPT_PROGRESSFUNCTION      EQUATE(56 + CURLOPTTYPE_FUNCTIONPOINT)
CURLOPT_XFERINFOFUNCTION      EQUATE(219 + CURLOPTTYPE_FUNCTIONPOINT)
CURLOPT_PROGRESSDATA          EQUATE(57 + CURLOPTTYPE_OBJECTPOINT)
CURLOPT_XFERINFODATA          EQUATE(CURLOPT_PROGRESSDATA)

CURLOPT_SSH_AUTH_TYPES        EQUATE(151 + CURLOPTTYPE_LONG)            !allowed SSH authentication methods

CURLOPT_SSH_PUBLIC_KEYFILE    EQUATE(152 + CURLOPTTYPE_OBJECTPOINT)     !Used by scp/sftp to do public/private key authentication
CURLOPT_SSH_PRIVATE_KEYFILE   EQUATE(153 + CURLOPTTYPE_OBJECTPOINT)     !Used by scp/sftp to do public/private key authentication
CURLOPT_SSH_HOST_PUBLIC_KEY_MD5   EQUATE(162 + CURLOPTTYPE_OBJECTPOINT) !used by scp/sftp to verify the host's public key
CURLOPT_SSH_KNOWNHOSTS        EQUATE(183 + CURLOPTTYPE_OBJECTPOINT)     !set the SSH knownhost file name to use
CURLOPT_SSH_KEYFUNCTION       EQUATE(184 + CURLOPTTYPE_FUNCTIONPOINT)   !set the SSH host key callback, must point to a curl_sshkeycallback function
CURLOPT_SSH_KEYDATA           EQUATE(185 + CURLOPTTYPE_OBJECTPOINT)     !set the SSH host key callback custom pointer

CURLOPT_HTTPHEADER            EQUATE(23 + CURLOPTTYPE_OBJECTPOINT)      !This points to a linked list of headers, struct curl_slist kind. This list is also used for RTSP (in spite of its name)
CURLOPT_HTTPGET               EQUATE(80 + CURLOPTTYPE_LONG)             !Set this to force the HTTP request to get back to GET. Only really usable if POST, PUT or a custom request have been used first.

CURLOPT_CUSTOMREQUEST         EQUATE(36 + CURLOPTTYPE_OBJECTPOINT)      !Custom request, for customizing the get command like HTTP: DELETE, TRACE and others, FTP: to use a different list command 

!Set if we should verify the Common name from the peer certificate in ssl 
!handshake, set 1 to check existence, 2 to ensure that it matches the 
!provided hostname.
CURLOPT_SSL_VERIFYHOST        EQUATE(81 + CURLOPTTYPE_LONG)
!Set if we should verify the peer in ssl handshake, set 1 to verify.
CURLOPT_SSL_VERIFYPEER        EQUATE(64 + CURLOPTTYPE_LONG)

!  /* Enable SSL/TLS for FTP, pick one of:
!  CURLUSESSL_TRY     - try using SSL, proceed anyway otherwise
!  CURLUSESSL_CONTROL - SSL for the control connection or fail
!  CURLUSESSL_ALL     - SSL for all communication or fail
!  */
CURLOPT_USE_SSL               EQUATE(119 + CURLOPTTYPE_LONG)


!"name" and "pwd" to use when fetching.
CURLOPT_USERNAME              EQUATE(173 + CURLOPTTYPE_OBJECTPOINT)
CURLOPT_PASSWORD              EQUATE(174 + CURLOPTTYPE_OBJECTPOINT)

!  /* set the SMTP mail originator */
CURLOPT_MAIL_FROM             EQUATE(186 + CURLOPTTYPE_OBJECTPOINT)
!  /* set the SMTP mail receiver(s) */
CURLOPT_MAIL_RCPT             EQUATE(187 + CURLOPTTYPE_OBJECTPOINT)

!  /* If the CURLOPT_INFILE is used, this can be used to inform libcurl about
!  * how large the file being sent really is. That allows better error
!  * checking and better verifies that the upload was successful. -1 means
!  * unknown size.
!  *
!  * For large file support, there is also a _LARGE version of the key
!  * which takes an off_t type, allowing platforms with larger off_t
!  * sizes to handle larger files.  See below for INFILESIZE_LARGE.
!  */
CURLOPT_INFILESIZE            EQUATE(14 + CURLOPTTYPE_LONG)
 
CURL_SSLVERSION_ENUM          EQUATE(LONG)
CURL_SSLVERSION_DEFAULT       EQUATE(0)
CURL_SSLVERSION_TLSv1         EQUATE(1) !/* TLS 1.x */
CURL_SSLVERSION_SSLv2         EQUATE(2)
CURL_SSLVERSION_SSLv3         EQUATE(3)
CURL_SSLVERSION_TLSv1_0       EQUATE(4)
CURL_SSLVERSION_TLSv1_1       EQUATE(5)
CURL_SSLVERSION_TLSv1_2       EQUATE(6)

CURLOPT_SSLVERSION            EQUATE(32 + CURLOPTTYPE_LONG)             !What version to specifically try to use. 

!/* When FTP over SSL/TLS is selected (with CURLOPT_USE_SSL), this option
!   can be used to change libcurl's default action which is to first try
!   "AUTH SSL" and then "AUTH TLS" in this order, and proceed when a OK
!   response has been received.
!
!   Available parameters are:
!   CURLFTPAUTH_DEFAULT - let libcurl decide
!   CURLFTPAUTH_SSL     - try "AUTH SSL" first, then TLS
!   CURLFTPAUTH_TLS     - try "AUTH TLS" first, then SSL
!*/ 
CURLOPT_FTPSSLAUTH            EQUATE(129 + CURLOPTTYPE_LONG)

!/* parameter for the CURLOPT_FTPSSLAUTH option */
CURLFTPAUTH                   EQUATE(LONG)
CURLFTPAUTH_DEFAULT           EQUATE(0)       !let libcurl decide
CURLFTPAUTH_SSL               EQUATE(1)       !use "AUTH SSL"
CURLFTPAUTH_TLS               EQUATE(2)       !use "AUTH TLS"
CURLFTPAUTH_LAST              EQUATE(3)       !not an option, never use

!The CApath or CAfile used to validate the peer certificate
!this option is used only if SSL_VERIFYPEER is true
CURLOPT_CAINFO                EQUATE(65 + CURLOPTTYPE_OBJECTPOINT)

CURLSSH_AUTH_ENUM             EQUATE(LONG)
                              ITEMIZE
CURLSSH_AUTH_ANY                EQUATE(-1)          !~0     !/* all types supported by the server */
CURLSSH_AUTH_NONE               EQUATE(0)                   !/* none allowed, silly but complete */
CURLSSH_AUTH_PUBLICKEY          EQUATE(00001b)      !(1<<0) !/* public/private key files */
CURLSSH_AUTH_PASSWORD           EQUATE(00010b)      !(1<<1) !/* password */
CURLSSH_AUTH_HOST               EQUATE(00100b)      !(1<<2) !/* host key files */
CURLSSH_AUTH_KEYBOARD           EQUATE(01000b)      !(1<<3) !/* keyboard interactive */
CURLSSH_AUTH_AGENT              EQUATE(10000b)      !(1<<4) !/* agent (ssh-agent, pageant...) */
CURLSSH_AUTH_DEFAULT            EQUATE(CURLSSH_AUTH_ANY)
                              END

CURLformoption                EQUATE(LONG)
                              ITEMIZE
CURLFORM_NOTHING                EQUATE(0)           !the first one is unused

CURLFORM_COPYNAME               EQUATE
CURLFORM_PTRNAME                EQUATE
CURLFORM_NAMELENGTH             EQUATE
CURLFORM_COPYCONTENTS           EQUATE
CURLFORM_PTRCONTENTS            EQUATE
CURLFORM_CONTENTSLENGTH         EQUATE
CURLFORM_FILECONTENT            EQUATE
CURLFORM_ARRAY                  EQUATE
CURLFORM_OBSOLETE               EQUATE
CURLFORM_FILE                   EQUATE

CURLFORM_BUFFER                 EQUATE
CURLFORM_BUFFERPTR              EQUATE
CURLFORM_BUFFERLENGTH           EQUATE

CURLFORM_CONTENTTYPE            EQUATE
CURLFORM_CONTENTHEADER          EQUATE
CURLFORM_FILENAME               EQUATE
CURLFORM_END                    EQUATE
CURLFORM_OBSOLETE2              EQUATE

CURLFORM_STREAM                 EQUATE

CURLFORM_LASTENTRY              EQUATE              !the last unused
                              END

CURLFORMcode                  EQUATE(LONG)
                              ITEMIZE
CURL_FORMADD_OK                 EQUATE(0)           !first, no error */

CURL_FORMADD_MEMORY             EQUATE
CURL_FORMADD_OPTION_TWICE       EQUATE
CURL_FORMADD_NULL               EQUATE
CURL_FORMADD_UNKNOWN_OPTION     EQUATE
CURL_FORMADD_INCOMPLETE         EQUATE
CURL_FORMADD_ILLEGAL_ARRAY      EQUATE
CURL_FORMADD_DISABLED           EQUATE              !libcurl was built with this disabled */

CURL_FORMADD_LAST               EQUATE              !last
                              END

!/* the kind of data that is passed to information_callback*/
CURL_INFOTYPE                 EQUATE(LONG)
                              ITEMIZE
CURLINFO_TEXT                   EQUATE(0)
CURLINFO_HEADER_IN              EQUATE      !1 
CURLINFO_HEADER_OUT             EQUATE      !2
CURLINFO_DATA_IN                EQUATE      !3
CURLINFO_DATA_OUT               EQUATE      !4
CURLINFO_SSL_DATA_IN            EQUATE      !5
CURLINFO_SSL_DATA_OUT           EQUATE      !6
CURLINFO_END                    EQUATE
                              END


  INCLUDE('svapi.inc')

!structure to pass a file to callbacks
TCurlFileStruct              CLASS, TYPE, MODULE('libcurl.clw'), LINK('libcurl.clw')
Destruct                        PROCEDURE(), VIRTUAL  !closes file handle
filename                        STRING(256)
fhandle                         HANDLE
                              END

TCurlStringStruct             GROUP, TYPE
buffer                          LONG  !address of the string
bufsize                         LONG  !declared size of the string
filled                          LONG  !bytes written
                              END

TFileBufContent               QUEUE, TYPE
fdata                           &STRING
                              END

TCurlMailStruct               CLASS, TYPE, MODULE('libcurl.clw'), LINK('libcurl.clw')
Construct                       PROCEDURE()
Destruct                        PROCEDURE(), VIRTUAL
lines_read                      LONG
buf                             &TFileBufContent
                              END

  MAP
    ! CURL callback procedure prototypes
    curl::ReadWriteProcType(LONG buffer, size_t bufsize, size_t nmemb, LONG pData), size_t, C, TYPE

    ! This is the CURLOPT_PROGRESSFUNCTION callback proto. It is now considered deprecated but was the only choice up until 7.31.0
    curl::ProgressDataProcType(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, C, TYPE
!    ! This is the CURLOPT_XFERINFOFUNCTION callback proto. It was introduced in 7.32.0, it avoids floating point and provides more detailed information.
!    curl::XFerInfoProcType(LONG ptr, curl_off_t dltotal, curl_off_t dlnow, curl_off_t ultotal, curl_off_t ulnow), LONG, C, TYPE

    curl::DebugProcType(LONG phandle, CURL_INFOTYPE ptype, LONG pdata, size_t psize, LONG userptr), LONG, C, TYPE

    MODULE('libcurl')
      curl::DebugInfo(STRING s)
      GetFileContents(STRING pFile), *STRING

      !writes to a file
      curl::FileWrite(LONG buffer, size_t bufsize, size_t nmemb, LONG pFileStruct), size_t, C
      !reads from a file
      curl::FileRead(LONG buffer, size_t bufsize, size_t nmemb, LONG pFileStruct), size_t, C
      !writes to a string
      curl::StringWrite(LONG buffer, size_t bufsize, size_t nmemb, LONG pStringStruct), size_t, C
      !progress function
      curl::XFerInfo(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, C
      !debug function
      curl::DebugCallback(LONG phandle, CURL_INFOTYPE ptype, LONG pdata, size_t psize, LONG userptr), LONG, C

      curl::GlobalInit(CURL_GLOBAL_ENUM pFlag = CURL_GLOBAL_DEFAULT), CURLcode, PROC 
      curl::GlobalCleanup()
    END

    ! CreateFile, WriteFile, CloseHandle etc
    INCLUDE('svapifnc.inc')
  END

TCurlSList                    CLASS, TYPE, MODULE('libcurl.clw'), LINK('libcurl.clw')
plist                           LONG, PRIVATE

Construct                       PROCEDURE()
Destruct                        PROCEDURE(), VIRTUAL

Append                          PROCEDURE(STRING pData)
Free                            PROCEDURE()
GetList                         PROCEDURE(), LONG
                              END


TCurlClass                    CLASS, TYPE, MODULE('libcurl.clw'), LINK('libcurl.clw')
curl                            CURL, PROTECTED

!linked list of http headers
headers                         &TCurlSList, PROTECTED

SetReadCallback                 PROCEDURE(curl::ReadWriteProcType readproc, LONG pData), CURLcode, PROC, PRIVATE
SetWriteCallback                PROCEDURE(curl::ReadWriteProcType writeproc, LONG pData), CURLcode, PROC, PRIVATE
SetXFerCallback                 PROCEDURE(<curl::ProgressDataProcType xferproc>), CURLcode, PROC, PRIVATE
SetDebugCallback                PROCEDURE(curl::DebugProcType debugproc), CURLcode, PROC, PRIVATE

Construct                       PROCEDURE()
Destruct                        PROCEDURE(), VIRTUAL

Init                            PROCEDURE()
Cleanup                         PROCEDURE()

SetOpt                          PROCEDURE(CURLoption option, LONG param), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, *STRING param), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, *CSTRING param), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, curl::ReadWriteProcType xferproc), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, curl::ProgressDataProcType xferproc), CURLcode, PROC
!SetOpt                          PROCEDURE(CURLoption option, curl::XFerInfoProcType cbproc), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, curl::DebugProcType debugproc), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, TCurlSList plist), CURLcode, PROC

Perform                         PROCEDURE(), CURLcode

StrError                        PROCEDURE(CURLcode errcode), STRING


!set user and password in form "user:password"
SetUserPwd                      PROCEDURE(STRING pUser, STRING pPwd), CURLcode, PROC
!download file
ReadFile                        PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
!upload file
WriteFile                       PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
!GET/POST, saves server response in pResponseFile
SendRequest                     PROCEDURE(STRING pUrl, <STRING pPostFields>, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
!GET/POST, saves server response in pResponseBuf string
SendRequestStr                  PROCEDURE(STRING pUrl, <STRING pPostFields>, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
!send a file using POST
PostFile                        PROCEDURE(STRING pUrl, STRING pArgname, STRING pFilename, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
PostFileStr                     PROCEDURE(STRING pUrl, STRING pArgname, STRING pFilename, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC

!derive XFerInfo to display prgress info
XFerInfo                        PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, PROC, VIRTUAL

!derive Debug to display debug info
DebugCallback                   PROCEDURE(CURL_INFOTYPE ptype, STRING ptypetxt, STRING ptext), VIRTUAL

AddHttpHeader                   PROCEDURE(STRING pHeader)
FreeHttpHeaders                 PROCEDURE()
SetHttpHeaders                  PROCEDURE(), CURLcode, PROC

SetCustomRequest                PROCEDURE(STRING pCustomRequest), CURLcode, PROC

SetHttpGET                      PROCEDURE(BOOL pValue = TRUE), CURLcode, PROC

SetSSLVerifyHost                PROCEDURE(BOOL pValue), CURLcode, PROC
SetSSLVerifyPeer                PROCEDURE(BOOL pValue), CURLcode, PROC
SetCAInfo                       PROCEDURE(STRING pCert), CURLcode, PROC
SetSSLVersion                   PROCEDURE(CURL_SSLVERSION_ENUM pSSLVersion), CURLcode, PROC

GetContentType                  PROCEDURE(), STRING
GetResponseCode                 PROCEDURE(), LONG ! returns the last received HTTP or FTP code

SetQuote                        PROCEDURE(TCurlSList plist), CURLcode, PROC !call in after AddHttpHeader()
PreQuote                        PROCEDURE(TCurlSList plist), CURLcode, PROC !call in after AddHttpHeader()
PostQuote                       PROCEDURE(TCurlSList plist), CURLcode, PROC !call in after AddHttpHeader()
                              END

!---------------------------- TCurlFtpClass -----------------------------!
TFtpFileInfo                  GROUP, TYPE, PRE(TFtpFileInfo) !FTP files and folders info
DisplayName                     STRING(255)
LastModified                    STRING(20)
FileSize                        STRING(20)
fileMask                        STRING(10)
Name                            STRING(255)
SortName                        STRING(255)
IsFolder                        BYTE
                              END

TFtpFilesInfo                 QUEUE(TFtpFileInfo), TYPE, PRE(TFtpFilesInfo)
                              END

TSSHSettings                  GROUP, TYPE, PRE(TSSHSettings)
AuthMethod                      CURLSSH_AUTH_ENUM
PublicKeyFile                   STRING(256)
PrivateKeyFile                  STRING(256)
KnownHosts                      STRING(256)
KeyPassword                     STRING(40)
                              END

!sFTP commands (using in QUOTE)
!http://www.tecmint.com/sftp-command-examples/

TCurlFtpClass                 CLASS(TCurlClass), TYPE, MODULE('libcurlftp.clw'), LINK('libcurlftp.clw')
AuthMethod                      CURLSSH_AUTH_ENUM, PROTECTED

SSHAuth                         PROCEDURE(TSSHSettings pSSH), CURLcode, PROC !sets CURLSSH_AUTH_ANY
                                  
LoadDir                         PROCEDURE(STRING pUrl, *TFtpFilesInfo dirlist), CURLcode, PROC
CreateDir                       PROCEDURE(STRING pUrl, STRING pDirname), CURLcode, PROC   !pUrl is ftp://user@95.96.97.98, pDirname is /home/files/temp
DeleteFile                      PROCEDURE(STRING pUrl, STRING pFilename), CURLcode, PROC  !pUrl is ftp://user@95.96.97.98, pFilename is /home/files/testfile.txt
RenameFile                      PROCEDURE(STRING pUrl, STRING pOldname, STRING pNewname), CURLcode, PROC  !pUrl is ftp://user@95.96.97.98, pOldname/pNewname is /home/files/testfile.txt
RenameDir                       PROCEDURE(STRING pUrl, STRING pOldname, STRING pNewname), CURLcode, PROC  !pUrl is ftp://user@95.96.97.98, pOldname/pNewname is /home/files/testfile.txt
                              END

!---------------------------- TCurlMailClass ----------------------------!
!TCurlMailAttachment           GROUP, TYPE
!filename                        STRING(256)
!                              END
!
!TCurlMailAttachments          QUEUE(TCurlMailAttachment), TYPE
!                              END
!
!TCurlMailClass                CLASS(TCurlClass), TYPE, MODULE('libcurlmail.clw'), LINK('libcurlmail.clw')
!url                             STRING(256), PRIVATE !smtp://smtp.gmail.com:587
!username                        STRING(128), PRIVATE
!pwd                             STRING(32), PRIVATE  
!!url                             STRING(256), PRIVATE  
!ssl                             CURL_USESSL, PRIVATE
!cert                            STRING(256), PRIVATE
!mailfrom                        STRING(256), PRIVATE  
!!mailto                          &TCurlMailRecipients, PRIVATE
!mailto                          &TCurlSList, PRIVATE         !*curl_slist
!mailtostr                       STRING(256), PRIVATE
!mailcc                          &TCurlSList, PRIVATE         !*curl_slist
!mailbcc                         &TCurlSList, PRIVATE         !*curl_slist
!attachments                     &TCurlMailAttachments, PRIVATE
!mailsubject                     &STRING, PRIVATE
!mailbody                        &STRING, PRIVATE
!
!Construct                       PROCEDURE()
!Destruct                        PROCEDURE(), DERIVED
!
!Server                          PROCEDURE(STRING pServer, LONG pPort)           !smtp.gmail.com, 587
!Account                         PROCEDURE(STRING pUsername, STRING pPwd)        !username: username@gmail.com
!SSL                             PROCEDURE(CURL_USESSL pSSL)                     !see CURL_USESSL enum
!Certificate                     PROCEDURE(STRING pCert)                         !google.pem
!From                            PROCEDURE(STRING pFrom)                         !<xxxxx@gmail.com>
!AddTo                           PROCEDURE(STRING pRecipient)
!!AddCC                           PROCEDURE(STRING pRecipient)
!!AddBCC                          PROCEDURE(STRING pRecipient)
!AddAttachment                   PROCEDURE(STRING pFilename)
!Subject                         PROCEDURE(STRING pSubject)
!Body                            PROCEDURE(STRING pBody)
!
!Send                            PROCEDURE(), CURLcode, PROC
!                              END
