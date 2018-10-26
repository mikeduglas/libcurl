!** libcurl for Clarion v1.38
!** 26.10.2018
!** mikeduglas66@gmail.com

  INCLUDE('DynStr.inc'), ONCE

CURL                          EQUATE(LONG)

size_t                        EQUATE(UNSIGNED)

TLONGLONG                     GROUP,  TYPE  !INT64. Has been changed from LONGLONG due to naming conflict with Office Inside LONGLONG.
lo                              LONG
hi                              LONG
                              END

curl_off_t                    EQUATE(TLONGLONG)

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


!/* Mime/form handling support. */
!typedef struct curl_mime_s      curl_mime;      /* Mime context. */
!typedef struct curl_mimepart_s  curl_mimepart;  /* Mime part context. */
curl_mime                     EQUATE(LONG)
curl_mimepart                 EQUATE(LONG)

!/* Special size_t value signaling a zero-terminated string. */
!#define CURL_ZERO_TERMINATED ((size_t) -1) 
CURL_ZERO_TERMINATED          EQUATE(-1)


CURLE                         EQUATE(CURLcode)
CURLE_OK                      EQUATE(0)
CURLE_UNSUPPORTED_PROTOCOL    EQUATE(1)
CURLE_FAILED_INIT             EQUATE(2)
CURLE_URL_MALFORMAT           EQUATE(3)
CURLE_NOT_BUILT_IN            EQUATE(4)   ![was obsoleted in August 2007 for 7.17.0, reused in April 2011 for 7.21.5]
CURLE_COULDNT_RESOLVE_PROXY   EQUATE(5)
CURLE_COULDNT_RESOLVE_HOST    EQUATE(6)
CURLE_COULDNT_CONNECT         EQUATE(7)
CURLE_WEIRD_SERVER_REPLY      EQUATE(8)
CURLE_FTP_WEIRD_SERVER_REPLY  EQUATE(CURLE_WEIRD_SERVER_REPLY)
CURLE_REMOTE_ACCESS_DENIED    EQUATE(9)   !a service was denied by the server due to lack of access - when login fails this is not returned.
CURLE_FTP_ACCEPT_FAILED       EQUATE(10)  ![was obsoleted in April 2006 for 7.15.4, reused in Dec 2011 for 7.24.0]
CURLE_FTP_WEIRD_PASS_REPLY    EQUATE(11)
CURLE_FTP_ACCEPT_TIMEOUT      EQUATE(12)  !timeout occurred accepting server [was obsoleted in August 2007 for 7.17.0, reused in Dec 2011 for 7.24.0]
CURLE_FTP_WEIRD_PASV_REPLY    EQUATE(13)
CURLE_FTP_WEIRD_227_FORMAT    EQUATE(14)
CURLE_FTP_CANT_GET_HOST       EQUATE(15)
CURLE_HTTP2                   EQUATE(16)  !A problem in the http2 framing layer. [was obsoleted in August 2007 for 7.17.0, reused in July 2014 for 7.38.0]
CURLE_FTP_COULDNT_SET_TYPE    EQUATE(17)
CURLE_PARTIAL_FILE            EQUATE(18)
CURLE_FTP_COULDNT_RETR_FILE   EQUATE(19)
CURLE_OBSOLETE20              EQUATE(20)  !NOT USED
CURLE_QUOTE_ERROR             EQUATE(21)  !quote command failure
CURLE_HTTP_RETURNED_ERROR     EQUATE(22)
CURLE_WRITE_ERROR             EQUATE(23)
CURLE_OBSOLETE24              EQUATE(24)  !NOT USED
CURLE_UPLOAD_FAILED           EQUATE(25)  !failed upload "command"
CURLE_READ_ERROR              EQUATE(26)  !couldn't open/read from file
CURLE_OUT_OF_MEMORY           EQUATE(27)
!/* Note: CURLE_OUT_OF_MEMORY may sometimes indicate a conversion error
!         instead of a memory allocation error if CURL_DOES_CONVERSIONS
!         is defined
!*/
CURLE_OPERATION_TIMEDOUT      EQUATE(28)  !the timeout time was reached
CURLE_OBSOLETE29              EQUATE(29)  !NOT USED
CURLE_FTP_PORT_FAILED         EQUATE(30)  !FTP PORT operation failed
CURLE_FTP_COULDNT_USE_REST    EQUATE(31)  !the REST command failed
CURLE_OBSOLETE32              EQUATE(32)  !NOT USED
CURLE_RANGE_ERROR             EQUATE(33)  !RANGE "command" didn't work
CURLE_HTTP_POST_ERROR         EQUATE(34)
CURLE_SSL_CONNECT_ERROR       EQUATE(35)  !wrong when connecting with SSL
CURLE_BAD_DOWNLOAD_RESUME     EQUATE(36)  !couldn't resume download
CURLE_FILE_COULDNT_READ_FILE  EQUATE(37)
CURLE_LDAP_CANNOT_BIND        EQUATE(38)
CURLE_LDAP_SEARCH_FAILED      EQUATE(39)
CURLE_OBSOLETE40              EQUATE(40)  !NOT USED
CURLE_FUNCTION_NOT_FOUND      EQUATE(41)
CURLE_ABORTED_BY_CALLBACK     EQUATE(42)
CURLE_BAD_FUNCTION_ARGUMENT   EQUATE(43)
CURLE_OBSOLETE44              EQUATE(44)  !NOT USED
CURLE_INTERFACE_FAILED        EQUATE(45)  !CURLOPT_INTERFACE failed
CURLE_OBSOLETE46              EQUATE(46)  !NOT USED
CURLE_TOO_MANY_REDIRECTS      EQUATE(47)  !catch endless re-direct loops
CURLE_UNKNOWN_OPTION          EQUATE(48)  !User specified an unknown option
CURLE_TELNET_OPTION_SYNTAX    EQUATE(49)  !Malformed telnet option
CURLE_OBSOLETE50              EQUATE(50)  !NOT USED
CURLE_PEER_FAILED_VERIFICATION  EQUATE(51)!peer's certificate or fingerprint wasn't verified fine
CURLE_GOT_NOTHING             EQUATE(52)  !when this is a specific error
CURLE_SSL_ENGINE_NOTFOUND     EQUATE(53)  !SSL crypto engine not found
CURLE_SSL_ENGINE_SETFAILED    EQUATE(54)  !can not set SSL crypto engine as default
CURLE_SEND_ERROR              EQUATE(55)  !failed sending network data
CURLE_RECV_ERROR              EQUATE(56)  !failure in receiving network data
CURLE_OBSOLETE57              EQUATE(57)  !NOT IN USE
CURLE_SSL_CERTPROBLEM         EQUATE(58)  !problem with the local certificate
CURLE_SSL_CIPHER              EQUATE(59)  !couldn't use specified cipher
CURLE_SSL_CACERT              EQUATE(60)  !problem with the CA cert (path?)
CURLE_BAD_CONTENT_ENCODING    EQUATE(61)  !Unrecognized/bad encoding
CURLE_LDAP_INVALID_URL        EQUATE(62)  !Invalid LDAP URL
CURLE_FILESIZE_EXCEEDED       EQUATE(63)  !Maximum file size exceeded
CURLE_USE_SSL_FAILED          EQUATE(64)  !Requested FTP SSL level failed
CURLE_SEND_FAIL_REWIND        EQUATE(65)  !Sending the data requires a rewind that failed
CURLE_SSL_ENGINE_INITFAILED   EQUATE(66)  !failed to initialise ENGINE
CURLE_LOGIN_DENIED            EQUATE(67)  !user, password or similar was not accepted and we failed to login
CURLE_TFTP_NOTFOUND           EQUATE(68)  !file not found on server
CURLE_TFTP_PERM               EQUATE(69)  !permission problem on server
CURLE_REMOTE_DISK_FULL        EQUATE(70)  !out of disk space on server
CURLE_TFTP_ILLEGAL            EQUATE(71)  !Illegal TFTP operation
CURLE_TFTP_UNKNOWNID          EQUATE(72)  !Unknown transfer ID
CURLE_REMOTE_FILE_EXISTS      EQUATE(73)  !File already exists
CURLE_TFTP_NOSUCHUSER         EQUATE(74)  !No such user
CURLE_CONV_FAILED             EQUATE(75)  !conversion failed
CURLE_CONV_REQD               EQUATE(76)  !caller must register conversion callbacks using curl_easy_setopt options CURLOPT_CONV_FROM_NETWORK_FUNCTION, CURLOPT_CONV_TO_NETWORK_FUNCTION, and CURLOPT_CONV_FROM_UTF8_FUNCTION
CURLE_SSL_CACERT_BADFILE      EQUATE(77)  !could not load CACERT file, missing or wrong format
CURLE_REMOTE_FILE_NOT_FOUND   EQUATE(78)  !remote file not found
CURLE_SSH                     EQUATE(79)  !error from the SSH layer, somewhat generic so the error message will be of interest when this has happened
CURLE_SSL_SHUTDOWN_FAILED     EQUATE(80)  !Failed to shut down the SSL connection
CURLE_AGAIN                   EQUATE(81)  !socket is not ready for send/recv, wait till it's ready and try again (Added in 7.18.2)
CURLE_SSL_CRL_BADFILE         EQUATE(82)  !could not load CRL file, missing or wrong format (Added in 7.19.0)
CURLE_SSL_ISSUER_ERROR        EQUATE(83)  !Issuer check failed.  (Added in 7.19.0)
CURLE_FTP_PRET_FAILED         EQUATE(84)  !a PRET command failed
CURLE_RTSP_CSEQ_ERROR         EQUATE(85)  !mismatch of RTSP CSeq numbers
CURLE_RTSP_SESSION_ERROR      EQUATE(86)  !mismatch of RTSP Session Ids
CURLE_FTP_BAD_FILE_LIST       EQUATE(87)  !unable to parse FTP file list
CURLE_CHUNK_FAILED            EQUATE(88)  !chunk callback reported error
CURLE_NO_CONNECTION_AVAILABLE EQUATE(89)  !No connection available, the session will be queued
CURLE_SSL_PINNEDPUBKEYNOTMATCH    EQUATE(90) !specified pinned public key did not match

!-- v7.52
CURLE_SSL_INVALIDCERTSTATUS   EQUATE(91)  !invalid certificate status
CURLE_HTTP2_STREAM            EQUATE(92)  !stream error in HTTP/2 framing layer

!CURL_LAST /* never use! */ 

CURLINFO_STRING               EQUATE(0100000h)
CURLINFO_LONG                 EQUATE(0200000h)
CURLINFO_DOUBLE               EQUATE(0300000h)
CURLINFO_SLIST                EQUATE(0400000h)
CURLINFO_SOCKET               EQUATE(0500000h)
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
!v7.52
CURLINFO_ACTIVESOCKET         EQUATE(CURLINFO_SOCKET + 44)
CURLINFO_TLS_SSL_PTR          EQUATE(CURLINFO_SLIST  + 45)
CURLINFO_HTTP_VERSION         EQUATE(CURLINFO_LONG   + 46)
CURLINFO_PROXY_SSL_VERIFYRESULT   EQUATE(CURLINFO_LONG + 47)
CURLINFO_PROTOCOL             EQUATE(CURLINFO_LONG   + 48)
CURLINFO_SCHEME               EQUATE(CURLINFO_STRING + 49)

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
CURLOPTTYPE_STRINGPOINT       EQUATE(CURLOPTTYPE_OBJECTPOINT) !STRINGPOINT is an alias for OBJECTPOINT to allow tools to extract the string options from the header file
CURLOPTTYPE_FUNCTIONPOINT     EQUATE(20000)
CURLOPTTYPE_OFF_T             EQUATE(30000)

CURLOPT_URL                   EQUATE(2 + CURLOPTTYPE_STRINGPOINT)       !The full URL to get/put
CURLOPT_PORT                  EQUATE(3 + CURLOPTTYPE_LONG)              !Port number to connect to, if other than default
CURLOPT_PROXY                 EQUATE(4 + CURLOPTTYPE_STRINGPOINT)       !Name of proxy to use
CURLOPT_USERPWD               EQUATE(5 + CURLOPTTYPE_STRINGPOINT)       !"user:password;options" to use when fetching
CURLOPT_PROXYUSERPWD          EQUATE(6 + CURLOPTTYPE_STRINGPOINT)       !"user:password" to use with proxy

CURLOPT_DEFAULT_PROTOCOL      EQUATE(238 + CURLOPTTYPE_STRINGPOINT)     !Set the protocol used when curl is given a URL without a protocol

CURLOPT_RANGE                 EQUATE(7 + CURLOPTTYPE_STRINGPOINT)       !Range to get, specified as an ASCII string.

CURLOPT_TIMEOUT               EQUATE(13 + CURLOPTTYPE_LONG)             !Time-out the read operation after this amount of seconds

CURLOPT_FTPPORT               EQUATE(17 + CURLOPTTYPE_STRINGPOINT)      !Set the FTP PORT string (interface name, named or numerical IP address). Use i.e '-' to use default address.


CURLOPT_CONNECTTIMEOUT        EQUATE(78 + CURLOPTTYPE_LONG)             !Time-out connect operations after this amount of seconds, if connects are OK within this time, then fine... This only aborts the connect phase
CURLOPT_TIMEOUT_MS            EQUATE(155 + CURLOPTTYPE_LONG)            !Same as TIMEOUT, but with ms resolution
CURLOPT_CONNECTTIMEOUT_MS     EQUATE(156 + CURLOPTTYPE_LONG)            !Same as CONNECTTIMEOUT, but with ms resolution

CURLOPT_USERAGENT             EQUATE(18 + CURLOPTTYPE_STRINGPOINT)      !Set the User-Agent string (examined by some CGIs)

!  /* FTP option that changes the timeout, in seconds, associated with
!     getting a response.  This is different from transfer timeout time and
!     essentially places a demand on the FTP server to acknowledge commands
!     in a timely manner. */ 
CURLOPT_FTP_RESPONSE_TIMEOUT  EQUATE(112 + CURLOPTTYPE_LONG)
CURLOPT_SERVER_RESPONSE_TIMEOUT   EQUATE(CURLOPT_FTP_RESPONSE_TIMEOUT)

CURLOPT_ACCEPTTIMEOUT_MS      EQUATE(212 + CURLOPTTYPE_LONG)            !Time-out accept operations (currently for FTP only) after this amount of miliseconds

CURLOPT_POSTFIELDS            EQUATE(15 + CURLOPTTYPE_OBJECTPOINT)      !POST static input fields.
CURLOPT_POSTFIELDSIZE         EQUATE(60 + CURLOPTTYPE_LONG)
CURLOPT_POSTFIELDSIZE_LARGE   EQUATE(120 + CURLOPTTYPE_OFF_T)

CURLOPT_COOKIE                EQUATE(22 + CURLOPTTYPE_STRINGPOINT)      !Set cookie in request
CURLOPT_COOKIEFILE            EQUATE(31 + CURLOPTTYPE_STRINGPOINT)      !point to a file to read the initial cookies from, also enables "cookie awareness"
CURLOPT_COOKIEJAR             EQUATE(82 + CURLOPTTYPE_STRINGPOINT)      !Specify which file name to write all known cookies in after completed operation. Set file name to "-" (dash) to make it go to stdout.
CURLOPT_COOKIESESSION         EQUATE(96 + CURLOPTTYPE_LONG)             !mark this as start of a cookie session
CURLOPT_COOKIELIST            EQUATE(135 + CURLOPTTYPE_STRINGPOINT)     !feed cookie into cookie engine

CURLOPT_HTTPPOST              EQUATE(24 + CURLOPTTYPE_OBJECTPOINT)      !This points to a linked list of post entries, struct curl_httppost

CURLOPT_SSLCERT               EQUATE(25 + CURLOPTTYPE_STRINGPOINT)      !name of the file keeping your private SSL-certificate
CURLOPT_SSLCERTTYPE           EQUATE(86 + CURLOPTTYPE_STRINGPOINT)      !type of the file keeping your SSL-certificate ("DER", "PEM", "ENG")
CURLOPT_SSLKEY                EQUATE(87 + CURLOPTTYPE_STRINGPOINT)      !name of the file keeping your private SSL-key
CURLOPT_SSLKEYTYPE            EQUATE(88 + CURLOPTTYPE_STRINGPOINT)      !type of the file keeping your private SSL-key ("DER", "PEM", "ENG")
CURLOPT_SSLENGINE             EQUATE(89 + CURLOPTTYPE_STRINGPOINT)      !crypto engine for the SSL-sub system
CURLOPT_SSLENGINE_DEFAULT     EQUATE(90 + CURLOPTTYPE_LONG)             !set the crypto engine for the SSL-sub system as default. The param has no meaning...

CURLOPT_CRLFILE               EQUATE(169 + CURLOPTTYPE_STRINGPOINT)     !CRL file
CURLOPT_ISSUERCERT            EQUATE(170 + CURLOPTTYPE_STRINGPOINT)     !Issuer certificate

CURLOPT_KEYPASSWD             EQUATE(26 + CURLOPTTYPE_STRINGPOINT)      !password for the SSL or SSH private key

CURLOPT_QUOTE                 EQUATE(28 + CURLOPTTYPE_OBJECTPOINT)      !send linked-list of QUOTE commands
CURLOPT_HEADERDATA            EQUATE(29 + CURLOPTTYPE_OBJECTPOINT)      !send FILE * or void * to store headers to, if you use a callback it is simply passed to the callback unmodified
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

CURLOPT_SSH_PUBLIC_KEYFILE    EQUATE(152 + CURLOPTTYPE_STRINGPOINT)     !Used by scp/sftp to do public/private key authentication
CURLOPT_SSH_PRIVATE_KEYFILE   EQUATE(153 + CURLOPTTYPE_STRINGPOINT)     !Used by scp/sftp to do public/private key authentication
CURLOPT_SSH_HOST_PUBLIC_KEY_MD5   EQUATE(162 + CURLOPTTYPE_STRINGPOINT) !used by scp/sftp to verify the host's public key
CURLOPT_SSH_KNOWNHOSTS        EQUATE(183 + CURLOPTTYPE_STRINGPOINT)     !set the SSH knownhost file name to use
CURLOPT_SSH_KEYFUNCTION       EQUATE(184 + CURLOPTTYPE_FUNCTIONPOINT)   !set the SSH host key callback, must point to a curl_sshkeycallback function
CURLOPT_SSH_KEYDATA           EQUATE(185 + CURLOPTTYPE_OBJECTPOINT)     !set the SSH host key callback custom pointer

CURLOPT_HTTPHEADER            EQUATE(23 + CURLOPTTYPE_OBJECTPOINT)      !This points to a linked list of headers, struct curl_slist kind. This list is also used for RTSP (in spite of its name)
CURLOPT_HTTPGET               EQUATE(80 + CURLOPTTYPE_LONG)             !Set this to force the HTTP request to get back to GET. Only really usable if POST, PUT or a custom request have been used first.

CURLOPT_HTTP_VERSION          EQUATE(84 + CURLOPTTYPE_LONG)             !Specify which HTTP version to use! This must be set to one of the CURL_HTTP_VERSION* enums set below.
!  /* These enums are for use with the CURLOPT_HTTP_VERSION option. */ 
CURL_HTTP_VERSION_NONE              EQUATE(0)                           !setting this means we don't care, and that we'd like the library to choose the best possible for us!
CURL_HTTP_VERSION_1_0               EQUATE(1)                           !please use HTTP 1.0 in the request
CURL_HTTP_VERSION_1_1               EQUATE(2)                           !please use HTTP 1.1 in the request
CURL_HTTP_VERSION_2_0               EQUATE(3)                           !please use HTTP 2 in the request
CURL_HTTP_VERSION_2TLS              EQUATE(4)                           !use version 2 for HTTPS, version 1.1 for HTTP
CURL_HTTP_VERSION_2_PRIOR_KNOWLEDGE EQUATE(5)                           !please use HTTP 2 without HTTP/1.1 Upgrade
CURL_HTTP_VERSION_LAST              EQUATE(6)                           !*ILLEGAL* http version

!  /* set to zero to disable the libcurl's decoding and thus pass the raw body
!     data to the application even when it is encoded/compressed */
CURLOPT_HTTP_TRANSFER_DECODING  EQUATE(157 + CURLOPTTYPE_LONG)
CURLOPT_HTTP_CONTENT_DECODING   EQUATE(158 + CURLOPTTYPE_LONG)
    
CURLOPT_CUSTOMREQUEST         EQUATE(36 + CURLOPTTYPE_STRINGPOINT)      !Custom request, for customizing the get command like HTTP: DELETE, TRACE and others, FTP: to use a different list command 

!Set if we should verify the Common name from the peer certificate in ssl 
!handshake, set 1 to check existence, 2 to ensure that it matches the 
!provided hostname.
CURLOPT_SSL_VERIFYHOST        EQUATE(81 + CURLOPTTYPE_LONG)
CURLOPT_SSL_VERIFYPEER        EQUATE(64 + CURLOPTTYPE_LONG)             !Set if we should verify the peer in ssl handshake, set 1 to verify.
CURLOPT_SSL_VERIFYSTATUS      EQUATE(232 + CURLOPTTYPE_LONG)            !Set if we should verify the certificate status.

CURLOPT_MAXREDIRS             EQUATE(68 + CURLOPTTYPE_LONG)             !Maximum number of http redirects to follow

!  /* Enable SSL/TLS for FTP, pick one of:
!  CURLUSESSL_TRY     - try using SSL, proceed anyway otherwise
!  CURLUSESSL_CONTROL - SSL for the control connection or fail
!  CURLUSESSL_ALL     - SSL for all communication or fail
!  */
CURLOPT_USE_SSL               EQUATE(119 + CURLOPTTYPE_LONG)

!Enable/disable specific SSL features with a bitmask, see CURLSSLOPT_*
CURLOPT_SSL_OPTIONS           EQUATE(216 + CURLOPTTYPE_LONG)
! - ALLOW_BEAST tells libcurl to allow the BEAST SSL vulnerability in the
!   name of improving interoperability with older servers. Some SSL libraries
!   have introduced work-arounds for this flaw but those work-arounds sometimes
!   make the SSL communication fail. To regain functionality with those broken
!   servers, a user can this way allow the vulnerability back.
CURLSSLOPT_ALLOW_BEAST        EQUATE(00000001b)
! - NO_REVOKE tells libcurl to disable certificate revocation checks for those
!   SSL backends where such behavior is present.
CURLSSLOPT_NO_REVOKE          EQUATE(00000010b)


CURLOPT_CONNECT_ONLY          EQUATE(141 + CURLOPTTYPE_LONG)            !no transfer, set up connection and let application use the socket by extracting it with CURLINFO_LASTSOCKET

!"name" and "pwd" to use when fetching.
CURLOPT_USERNAME              EQUATE(173 + CURLOPTTYPE_STRINGPOINT)
CURLOPT_PASSWORD              EQUATE(174 + CURLOPTTYPE_STRINGPOINT)
!"name" and "pwd" to use with Proxy when fetching.
CURLOPT_PROXYUSERNAME         EQUATE(175 + CURLOPTTYPE_STRINGPOINT)
CURLOPT_PROXYPASSWORD         EQUATE(176 + CURLOPTTYPE_STRINGPOINT)

!  /* Comma separated list of hostnames defining no-proxy zones. These should
!     match both hostnames directly, and hostnames within a domain. For
!     example, local.com will match local.com and www.local.com, but NOT
!     notlocal.com or www.notlocal.com. For compatibility with other
!     implementations of this, .local.com will be considered to be the same as
!     local.com. A single * is the only valid wildcard, and effectively
!     disables the use of proxy. */
CURLOPT_NOPROXY               EQUATE(177 + CURLOPTTYPE_STRINGPOINT)

CURLOPT_MAIL_FROM             EQUATE(186 + CURLOPTTYPE_STRINGPOINT) !set the SMTP mail originator
CURLOPT_MAIL_RCPT             EQUATE(187 + CURLOPTTYPE_OBJECTPOINT) !set the list of SMTP mail receiver(s)
CURLOPT_MAIL_AUTH             EQUATE(217 + CURLOPTTYPE_OBJECTPOINT) !set the SMTP auth originator

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
 
!  /* Set this to a bitmask value to enable the particular authentications
!     methods you like. Use this in combination with CURLOPT_USERPWD.
!     Note that setting multiple bits may cause extra network round-trips. */
CURLOPT_HTTPAUTH              EQUATE(107 + CURLOPTTYPE_LONG)

!  /*
!  * Bitmasks for CURLOPT_HTTPAUTH and CURLOPT_PROXYAUTH options:
!  *
!  * CURLAUTH_NONE         - No HTTP authentication
!  * CURLAUTH_BASIC        - HTTP Basic authentication (default)
!  * CURLAUTH_DIGEST       - HTTP Digest authentication
!  * CURLAUTH_NEGOTIATE    - HTTP Negotiate (SPNEGO) authentication
!  * CURLAUTH_GSSNEGOTIATE - Alias for CURLAUTH_NEGOTIATE (deprecated)
!  * CURLAUTH_NTLM         - HTTP NTLM authentication
!  * CURLAUTH_DIGEST_IE    - HTTP Digest authentication with IE flavour
!  * CURLAUTH_NTLM_WB      - HTTP NTLM authentication delegated to winbind helper
!  * CURLAUTH_ONLY         - Use together with a single other type to force no
!  *                         authentication or just that single type
!  * CURLAUTH_ANY          - All fine types set
!  * CURLAUTH_ANYSAFE      - All fine types except Basic
!  */

!  #define CURLAUTH_NONE         ((unsigned long)0)
!  #define CURLAUTH_BASIC        (((unsigned long)1)<<0)
!  #define CURLAUTH_DIGEST       (((unsigned long)1)<<1)
!  #define CURLAUTH_NEGOTIATE    (((unsigned long)1)<<2)
!  /* Deprecated since the advent of CURLAUTH_NEGOTIATE */
!  #define CURLAUTH_GSSNEGOTIATE CURLAUTH_NEGOTIATE
!  #define CURLAUTH_NTLM         (((unsigned long)1)<<3)
!  #define CURLAUTH_DIGEST_IE    (((unsigned long)1)<<4)
!  #define CURLAUTH_NTLM_WB      (((unsigned long)1)<<5)
!  #define CURLAUTH_ONLY         (((unsigned long)1)<<31)
!  #define CURLAUTH_ANY          (~CURLAUTH_DIGEST_IE)
!  #define CURLAUTH_ANYSAFE      (~(CURLAUTH_BASIC|CURLAUTH_DIGEST_IE))
! 
CURLAUTH_NONE                 EQUATE(0)
CURLAUTH_BASIC                EQUATE(1)
CURLAUTH_DIGEST               EQUATE(2)
CURLAUTH_NEGOTIATE            EQUATE(4)
CURLAUTH_NTLM                 EQUATE(8)
CURLAUTH_DIGEST_IE            EQUATE(16)
CURLAUTH_NTLM_WB              EQUATE(32)
CURLAUTH_BEARER               EQUATE(64)
CURLAUTH_ONLY                 EQUATE(080000000h)
CURLAUTH_ANY                  EQUATE(0FFFFFFEFh)
CURLAUTH_ANYSAFE              EQUATE(0FFFFFFEEh)

CURL_SSLVERSION_ENUM          EQUATE(LONG)
CURL_SSLVERSION_DEFAULT       EQUATE(0)
CURL_SSLVERSION_TLSv1         EQUATE(1) !/* TLS 1.x */
CURL_SSLVERSION_SSLv2         EQUATE(2)
CURL_SSLVERSION_SSLv3         EQUATE(3)
CURL_SSLVERSION_TLSv1_0       EQUATE(4)
CURL_SSLVERSION_TLSv1_1       EQUATE(5)
CURL_SSLVERSION_TLSv1_2       EQUATE(6)
CURL_SSLVERSION_TLSv1_3       EQUATE(7)
!CURL_SSLVERSION_MAX_xxx constants
CURL_SSLVERSION_MAX_DEFAULT   EQUATE(010000h)  !CURL_SSLVERSION_TLSv1   << 16
CURL_SSLVERSION_MAX_TLSv1_0   EQUATE(040000h)  !CURL_SSLVERSION_TLSv1_0 << 16
CURL_SSLVERSION_MAX_TLSv1_1   EQUATE(050000h)  !CURL_SSLVERSION_TLSv1_1 << 16
CURL_SSLVERSION_MAX_TLSv1_2   EQUATE(060000h)  !CURL_SSLVERSION_TLSv1_2 << 16
CURL_SSLVERSION_MAX_TLSv1_3   EQUATE(070000h)  !CURL_SSLVERSION_TLSv1_3 << 16


CURLOPT_SSLVERSION            EQUATE(32 + CURLOPTTYPE_LONG)             !What version to specifically try to use. 

CURLOPT_TLSAUTH_USERNAME      EQUATE(204 + CURLOPTTYPE_STRINGPOINT)     !Set a username for authenticated TLS
CURLOPT_TLSAUTH_PASSWORD      EQUATE(205 + CURLOPTTYPE_STRINGPOINT)     !Set a password for authenticated TLS
CURLOPT_TLSAUTH_TYPE          EQUATE(206 + CURLOPTTYPE_STRINGPOINT)     !Set authentication type for authenticated TLS

CURLOPT_SSL_FALSESTART        EQUATE(233 + CURLOPTTYPE_LONG)            !Set if we should enable TLS false start.

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
CURLOPT_CAINFO                EQUATE(65 + CURLOPTTYPE_STRINGPOINT)
CURLOPT_CAPATH                EQUATE(97 + CURLOPTTYPE_STRINGPOINT)    !The CApath directory used to validate the peer certificate. This option is used only if SSL_VERIFYPEER is true.

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

CURLOPT_WILDCARDMATCH         EQUATE(197 + CURLOPTTYPE_LONG)    !Turn on wildcard matching

CURLOPT_CHUNK_BGN_FUNCTION    EQUATE(198 + CURLOPTTYPE_FUNCTIONPOINT) !Directory matching callback called before downloading of an individual file (chunk) started
CURLOPT_CHUNK_END_FUNCTION    EQUATE(199 + CURLOPTTYPE_FUNCTIONPOINT) !Directory matching callback called after the file (chunk) was downloaded, or skipped
CURLOPT_FNMATCH_FUNCTION      EQUATE(200 + CURLOPTTYPE_FUNCTIONPOINT) !Change match (fnmatch-like) callback for wildcard matching
CURLOPT_CHUNK_DATA            EQUATE(201 + CURLOPTTYPE_OBJECTPOINT)   !Let the application define custom chunk data pointer
CURLOPT_FNMATCH_DATA          EQUATE(202 + CURLOPTTYPE_OBJECTPOINT)   !FNMATCH_FUNCTION user pointer
CURLOPT_TCP_KEEPALIVE         EQUATE(213 + CURLOPTTYPE_LONG)          !Set TCP keepalive

! Set the Accept-Encoding string. Use this to tell a server you would like
! the response to be compressed. Before 7.21.6, this was known as
! CURLOPT_ENCODING
CURLOPT_ACCEPT_ENCODING       EQUATE(102 + CURLOPTTYPE_STRINGPOINT)

CURLOPT_REQUEST_TARGET        EQUATE(266 + CURLOPTTYPE_STRINGPOINT)     !The request target, instead of extracted from the URL
CURLOPT_XOAUTH2_BEARER        EQUATE(220 + CURLOPTTYPE_STRINGPOINT)     !The XOAUTH2 bearer token
CURLOPT_MIMEPOST              EQUATE(269 + CURLOPTTYPE_OBJECTPOINT)     !Post MIME data

CURLOPT_FTP_ALTERNATIVE_TO_USER   EQUATE(147 + CURLOPTTYPE_STRINGPOINT) !Pointer to command string to send if USER/PASS fails.

! FTP Option that causes missing dirs to be created on the remote server.
! In 7.19.4 we introduced the convenience enums for this option using the
! CURLFTP_CREATE_DIR prefix.
CURLOPT_FTP_CREATE_MISSING_DIRS   EQUATE(110 + CURLOPTTYPE_LONG)

! parameter for the CURLOPT_FTP_CREATE_MISSING_DIRS option
CURLFTP_CREATE_DIR_ENUM       EQUATE(LONG)
CURLFTP_CREATE_DIR_NONE       EQUATE(0) !do NOT create missing dirs! Default value.
CURLFTP_CREATE_DIR            EQUATE(1) !(FTP/SFTP) if CWD (Change working directory) fails, try MKD (Make directory) and then CWD again if MKD succeeded, for SFTP this does similar magic.
CURLFTP_CREATE_DIR_RETRY      EQUATE(2) !(FTP only) if CWD fails, try MKD and then CWD again  even if MKD failed!
CURLFTP_CREATE_DIR_LAST       EQUATE(4) !not an option, never use
          
!return codes for CURLOPT_CHUNK_BGN_FUNCTION
CURL_CHUNK_BGN_FUNC_OK        EQUATE(0)
CURL_CHUNK_BGN_FUNC_FAIL      EQUATE(1)             !tell the lib to end the task
CURL_CHUNK_BGN_FUNC_SKIP      EQUATE(2)             !skip this chunk over

!return codes for CURLOPT_CHUNK_END_FUNCTION
CURL_CHUNK_END_FUNC_OK        EQUATE(0)
CURL_CHUNK_END_FUNC_FAIL      EQUATE(1)             !tell the lib to end the task

!return codes for FNMATCHFUNCTION
CURL_FNMATCHFUNC_MATCH        EQUATE(0)             !string corresponds to the pattern
CURL_FNMATCHFUNC_NOMATCH      EQUATE(1)             !pattern doesn't match the string
CURL_FNMATCHFUNC_FAIL         EQUATE(2)             !an error occurred


!enumeration of file types
CURLFILETYPE                  EQUATE(LONG)
                              ITEMIZE
CURLFILETYPE_FILE               EQUATE(0)
CURLFILETYPE_DIRECTORY          EQUATE
CURLFILETYPE_SYMLINK            EQUATE
CURLFILETYPE_DEVICE_BLOCK       EQUATE
CURLFILETYPE_DEVICE_CHAR        EQUATE
CURLFILETYPE_NAMEDPIPE          EQUATE
CURLFILETYPE_SOCKET             EQUATE
CURLFILETYPE_DOOR               EQUATE              !is possible only on Sun Solaris now

CURLFILETYPE_UNKNOWN            EQUATE              !should never occur
                              END

CURLFINFOFLAG_KNOWN_FILENAME  EQUATE(1)           !(1<<0)
CURLFINFOFLAG_KNOWN_FILETYPE  EQUATE(2)           !(1<<1)
CURLFINFOFLAG_KNOWN_TIME      EQUATE(4)           !(1<<2)
CURLFINFOFLAG_KNOWN_PERM      EQUATE(8)           !(1<<3)
CURLFINFOFLAG_KNOWN_UID       EQUATE(16)          !(1<<4)
CURLFINFOFLAG_KNOWN_GID       EQUATE(32)          !(1<<5)
CURLFINFOFLAG_KNOWN_SIZE      EQUATE(64)          !(1<<6)
CURLFINFOFLAG_KNOWN_HLINKCOUNT    EQUATE(128)         !(1<<7)
 


!/* Content of this structure depends on information which is known and is
!   achievable (e.g. by FTP LIST parsing). Please see the url_easy_setopt(3) man
!   page for callbacks returning this structure -- some fields are mandatory,
!   some others are optional. The FLAG field has special meaning. */
curl_fileinfo                 GROUP, TYPE
pfilename                       LONG      !char *filename;
filetype                        CURLFILETYPE
ptime                           LONG      !time_t time;
perm                            UNSIGNED
uid                             LONG
gid                             LONG
size                            LIKE(curl_off_t)
hardlinks                       LONG

!  struct {
!   If some of these fields is not NULL, it is a pointer to b_data.
string_time                     LONG      !char *time;
string_perm                     LONG      !char *perm;
string_user                     LONG      !char *user;
string_group                    LONG      !char *group;
string_target                   LONG      !char *target; /* pointer to the target filename of a symlink */
!  } strings;

flags                           UNSIGNED

! used internally
b_data                          LONG      !char * b_data;
b_size                          size_t
b_used                          size_t
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
filename                        CSTRING(256), PROTECTED
fhandle                         HANDLE, PROTECTED

Destruct                        PROCEDURE(), VIRTUAL  !closes file handle
Init                            PROCEDURE(STRING pFilename)
Close                           PROCEDURE(), BOOL, VIRTUAL, PROC
CreateFile                      PROCEDURE(LONG dwDesiredAccess = GENERIC_WRITE, LONG dwShareMode = FILE_SHARE_READ, LONG dwCreationDisposition = CREATE_ALWAYS, LONG dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL), BOOL
OpenFile                        PROCEDURE(LONG dwDesiredAccess = GENERIC_READ, LONG dwShareMode = FILE_SHARE_READ, LONG dwCreationDisposition = OPEN_EXISTING, LONG dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL), BOOL
ReadFile                        PROCEDURE(LONG lpBuffer, LONG dwBytes, *LONG dwBytesRead), BOOL
WriteFile                       PROCEDURE(long lpBuffer, long dwBytes, *long dwBytesWritten), BOOL
GetFileName                     PROCEDURE(), STRING
                              END

TCurlStringStruct             GROUP, TYPE
buffer                          LONG  !address of the string
bufsize                         LONG  !declared size of the string
filled                          LONG  !bytes written
                              END

  MAP
    ! CURL callback procedure prototypes
    curl::ReadWriteProcType(LONG buffer, size_t bufsize, size_t nmemb, LONG pData), size_t, C, TYPE

    ! This is the CURLOPT_PROGRESSFUNCTION callback proto. It is now considered deprecated but was the only choice up until 7.31.0
    curl::ProgressDataProcType(LONG ptr, REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, C, TYPE
!    ! This is the CURLOPT_XFERINFOFUNCTION callback proto. It was introduced in 7.32.0, it avoids floating point and provides more detailed information.
!    curl::XFerInfoProcType(LONG ptr, curl_off_t dltotal, curl_off_t dlnow, curl_off_t ultotal, curl_off_t ulnow), LONG, C, TYPE

    curl::DebugProcType(LONG phandle, CURL_INFOTYPE ptype, LONG pdata, size_t psize, LONG userptr), LONG, C, TYPE

!/* if splitting of data transfer is enabled, this callback is called before
!   download of an individual chunk started. Note that parameter "remains" works
!   only for FTP wildcard downloading (for now), otherwise is not used */     
    curl::ChunkBgnProcType(LONG transfer_info, LONG ptr, LONG remains), LONG, C, TYPE

!/* If splitting of data transfer is enabled this callback is called after
!   download of an individual chunk finished.
!   Note! After this callback was set then it have to be called FOR ALL chunks.
!   Even if downloading of this chunk was skipped in CHUNK_BGN_FUNC.
!   This is the reason why we don't need "transfer_info" parameter in this
!   callback and we are not interested in "remains" parameter too. */     
    curl::ChunkEndProcType(LONG ptr), LONG, C, TYPE

!/* callback type for wildcard downloading pattern matching. If the
!   string matches the pattern, return CURL_FNMATCHFUNC_MATCH value, etc. */ 
    curl::FnMatchProc(LONG ptr, *CSTRING pattern, *CSTRING string), LONG, C, TYPE

!int seekfunc(void *arg, curl_off_t offset, int origin); 
    curl::SeekProcType(LONG arg, curl_off_t offset, LONG origin), LONG, C, TYPE

!void freefunc(void *arg);
    curl::FreeProcType(LONG arg), C, TYPE

    MODULE('libcurl')
      curl::DebugInfo(STRING s)
      curl::GetFileContents(STRING pFile), *STRING

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
      !curl_chunk_bgn_callback
      curl::ChunkBgnCallback(LONG transfer_info, LONG ptr, LONG remains), LONG, C
      !curl_chunk_end_callback
      curl::ChunkEndCallback(LONG ptr), LONG, C
      !curl_fnmatch_callback
!      curl::FnMatchCallback(LONG ptr, *CSTRING pattern, *CSTRING string), LONG, C

      curl::DynStrWrite(LONG buffer, size_t bufsize, size_t nmemb, LONG pDynStr), size_t, C

      curl::GlobalInit(CURL_GLOBAL_ENUM pFlag = CURL_GLOBAL_DEFAULT), CURLcode, PROC 
      curl::GlobalCleanup()

      curl::StrError(CURLcode errcode), STRING
    END

    ! CreateFile, WriteFile, CloseHandle etc
!    INCLUDE('svapifnc.inc')
    MODULE('WIN API')
      winapi::CreateDirectory(*CString szPathName, <*SECURITY_ATTRIBUTES SecurityAttributes>),bool,pascal,proc,raw,name('CreateDirectoryA')
      winapi::GetLastError(),long,pascal,name('GetLastError')
      winapi::CreateFile(*cstring szFileName, long dwDesiredAccess, long dwShareMode, long lpSecurityAttributes, |
        long dwCreationDisposition, long dwFlagsAndAttributes, HANDLE hTemplateFile),HANDLE, |
        name('CreateFileA'),pascal,raw
      winapi::GetFileSize(HANDLE hFile, *long FileSizeHigh),long,raw,pascal,name('GetFileSize')
      winapi::ReadFile(HANDLE hFile, long lpBuffer, long dwBytes, *long dwBytesRead, long lpOverlapped),bool,raw,pascal,name('ReadFile')
      winapi::WriteFile(HANDLE hFile, long lpBuffer, long dwBytes, *long dwBytesWritten, long lpOverlapped),bool,raw,pascal,proc,name('WriteFile')
      winapi::CloseHandle(HANDLE),bool,raw,pascal,proc,name('CloseHandle')
      winapi::MultiByteToWideChar(long CodePage, long dwFlags, long lpMultiByteStr, long cbMultiByte, |
        long lpWideCharStr, long cchWideCharStr),long,pascal,name('MultiByteToWideChar')
      winapi::WideCharToMultiByte(long CodePage, long dwFlags, long lpWideCharStr, long cchWideChar, |
        long lpMultiByteStr, long cbMultiByte, long lpDefaultChar, |
        long lpUsedDefaultChar),long,pascal,name('WideCharToMultiByte')
      winapi::ShellExecute(LONG phWnd, <*CSTRING pAction>, *CSTRING pFilename, <*CSTRING pParameters>, <*CSTRING pDirectory>, LONG pFlags=1), LONG, PASCAL, RAW, PROC, NAME('ShellExecuteA')
    END
  END

TCurlSQueue                   QUEUE, TYPE
item                            CSTRING(1024)
                              END

TCurlSList                    CLASS, TYPE, MODULE('libcurl.clw'), LINK('libcurl.clw')
plist                           LONG, PRIVATE

Construct                       PROCEDURE()
Destruct                        PROCEDURE(), VIRTUAL

AssignPtr                       PROCEDURE(LONG pListPtr)
Append                          PROCEDURE(STRING pData)
Free                            PROCEDURE()
GetList                         PROCEDURE(), LONG
GetQueue                        PROCEDURE(*TCurlSQueue pQ)
                              END


curl::ErrorBlock              GROUP,TYPE                          ! Parameter to AddErrors procedure
Number                          USHORT                            ! Current error message identifier
                              END

curl::ErrorEntryGroup         GROUP, TYPE                         ! List of all translated error messages
Id                              CURLE                             ! Error message identifier
Message                         &STRING                           ! Message text
                              END
curl::ErrorEntry              QUEUE(curl::ErrorEntryGroup), TYPE  ! List of all translated error messages
                              END



!---------------------------- TCurlClass---- -----------------------------!
TCurlClass                    CLASS, TYPE, MODULE('libcurl.clw'), LINK('libcurl.clw')
curl                            CURL, PROTECTED

!linked list of http headers
headers                         &TCurlSList, PROTECTED
Errors                          &curl::ErrorEntry, PROTECTED       ! Queue to hold all translated error messages

AddError                        PROCEDURE(CURLE Id, *STRING Message), VIRTUAL
AddErrors                       PROCEDURE(curl::ErrorBlock ErrsIn), VIRTUAL

SetReadCallback                 PROCEDURE(curl::ReadWriteProcType readproc, LONG pData), CURLcode, PROC
SetWriteCallback                PROCEDURE(curl::ReadWriteProcType writeproc, LONG pData), CURLcode, PROC
SetXFerCallback                 PROCEDURE(<curl::ProgressDataProcType xferproc>), CURLcode, PROC
SetDebugCallback                PROCEDURE(curl::DebugProcType debugproc), CURLcode, PROC

Construct                       PROCEDURE()
Destruct                        PROCEDURE(), VIRTUAL

Init                            PROCEDURE(), VIRTUAL
Cleanup                         PROCEDURE(), VIRTUAL
Reset                           PROCEDURE(), VIRTUAL

GetHandle                       PROCEDURE(), CURL                  ! returns curl handle

SetOpt                          PROCEDURE(CURLoption option, LONG param), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, *STRING param), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, *CSTRING param), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, curl::ReadWriteProcType xferproc), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, curl::ProgressDataProcType xferproc), CURLcode, PROC
!SetOpt                          PROCEDURE(CURLoption option, curl::XFerInfoProcType cbproc), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, curl::DebugProcType debugproc), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, curl::ChunkBgnProcType chunkbgnproc), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, curl::ChunkEndProcType chunkendproc), CURLcode, PROC
SetOpt                          PROCEDURE(CURLoption option, TCurlSList plist), CURLcode, PROC

SetUrl                          PROCEDURE(STRING pUrl), CURLcode, PROC

Perform                         PROCEDURE(), CURLcode

StrError                        PROCEDURE(CURLcode errcode), STRING, VIRTUAL


!set user and password in form "user:password"
SetUserPwd                      PROCEDURE(STRING pUser, STRING pPwd), CURLcode, PROC
!download file
ReadFile                        PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>), CURLcode, VIRTUAL, PROC
!upload file
WriteFile                       PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>), CURLcode, PROC

!GET/POST, saves server response in pResponseFile
SendRequest                     PROCEDURE(STRING pUrl, <STRING pPostFields>, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
!GET/POST, saves server response in pResponseBuf string
SendRequestStr                  PROCEDURE(STRING pUrl, <STRING pPostFields>, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC

SendRequest                     PROCEDURE(STRING pUrl, *IDynStr pDynStr, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
SendRequest                     PROCEDURE(STRING pUrl, <STRING pPostFields>, *IDynStr pDynStr, <curl::ProgressDataProcType xferproc>), CURLcode, PROC

!send a file using POST
PostFile                        PROCEDURE(STRING pUrl, STRING pArgname, STRING pFilename, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
PostFileStr                     PROCEDURE(STRING pUrl, STRING pArgname, STRING pFilename, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC

!derive XFerInfo to display prgress info
XFerInfo                        PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, PROC, VIRTUAL

!derive Debug to display debug info
DebugCallback                   PROCEDURE(CURL_INFOTYPE ptype, STRING ptypetxt, STRING ptext), VIRTUAL
TalkCallback                    PROCEDURE(CURL_INFOTYPE ptype, STRING ptext), VIRTUAL

AddHttpHeader                   PROCEDURE(STRING pHeader)
FreeHttpHeaders                 PROCEDURE()
SetHttpHeaders                  PROCEDURE(), CURLcode, PROC

SetCustomRequest                PROCEDURE(STRING pCustomRequest), CURLcode, PROC

SetHttpGET                      PROCEDURE(BOOL pValue = TRUE), CURLcode, PROC

UseSSL                          PROCEDURE(CURL_USESSL pSSL), CURLcode, PROC  !default CURLUSESSL_NONE 

SetSSLVerifyHost                PROCEDURE(BOOL pValue), CURLcode, PROC
SetSSLVerifyPeer                PROCEDURE(BOOL pValue), CURLcode, PROC
SetCAInfo                       PROCEDURE(STRING pCert), CURLcode, PROC
SetSSLVersion                   PROCEDURE(CURL_SSLVERSION_ENUM pSSLVersion), CURLcode, PROC

GetInfo                         PROCEDURE(CURLINFO info, *LONG value), CURLcode, PROC
GetInfo::LONG                   PROCEDURE(CURLINFO info), LONG
GetInfo::SLIST                  PROCEDURE(CURLINFO info), LONG
GetInfo::STRING                 PROCEDURE(CURLINFO info), STRING
GetInfo::DOUBLE                 PROCEDURE(CURLINFO info), REAL

GetContentType                  PROCEDURE(), STRING
GetResponseCode                 PROCEDURE(), LONG ! returns the last received HTTP or FTP code

SetQuote                        PROCEDURE(TCurlSList plist), CURLcode, PROC !call in after AddHttpHeader()
PreQuote                        PROCEDURE(TCurlSList plist), CURLcode, PROC !call in after AddHttpHeader()
PostQuote                       PROCEDURE(TCurlSList plist), CURLcode, PROC !call in after AddHttpHeader()

SetDefaultProtocol              PROCEDURE(STRING pSchema), CURLcode, PROC
SetPostFields                   PROCEDURE(STRING pPostFields), CURLcode, PROC
SetPostFields                   PROCEDURE(*IDynStr pPostFields), CURLcode, PROC

SetUserAgent                    PROCEDURE(STRING pUserAgent), CURLcode, PROC

SetMimePost                     PROCEDURE(TCurlMimeClass mime), CURLcode, PROC  !set post/send data from mime structure
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

TFtpDirList                   QUEUE, TYPE, PRE(TFtpDirList)   !bare names when listing directories
Name                            STRING(255)
                              END

TSSHSettings                  GROUP, TYPE, PRE(TSSHSettings)
AuthMethod                      CURLSSH_AUTH_ENUM     !allowed SSH authentication methods
PublicKeyFile                   STRING(256)           !Used by scp/sftp to do public/private key authentication
PrivateKeyFile                  STRING(256)           !Used by scp/sftp to do public/private key authentication
KnownHosts                      STRING(256)           !set the SSH knownhost file name to use
KeyPassword                     STRING(40)            !password for the SSL or SSH private key
PublicKeyMD5                    STRING(32)            !used by scp/sftp to verify the host's public key
                              END

!*** Important ***!
!FTP commands (using in QUOTE)
!http://muff.kiev.ua/content/ftp-osnovnye-komandy
!
!SFTP commands (using in QUOTE)
!http://www.tecmint.com/sftp-command-examples/

TCurlFtpClass                 CLASS(TCurlClass), TYPE, MODULE('libcurlftp.clw'), LINK('libcurlftp.clw')
AuthMethod                      CURLSSH_AUTH_ENUM, PROTECTED

Init                            PROCEDURE(), DERIVED

SSHAuth                         PROCEDURE(TSSHSettings pSSH), CURLcode, PROC
                                  
LoadDir                         PROCEDURE(STRING pUrl, *TFtpFilesInfo dirlist), CURLcode, PROC
LoadDirListOnly                 PROCEDURE(STRING pUrl, *TFtpDirList barelist), CURLcode, PROC
CreateDir                       PROCEDURE(STRING pUrl, STRING pDirname), CURLcode, PROC   !pUrl is ftp://user@95.96.97.98, pDirname is /home/files/temp
IsDirExist                      PROCEDURE(STRING pUrl, STRING pDirname), CURLcode, PROC   !Returns CURLE_OK if dir exists.

! delete file or empty dir
DeleteFile                      PROCEDURE(STRING pUrl, STRING pFilename), CURLcode, PROC  !pUrl is ftp://user@95.96.97.98, pFilename is /home/files/testfile.txt
RenameFile                      PROCEDURE(STRING pUrl, STRING pOldname, STRING pNewname), CURLcode, PROC  !pUrl is ftp://user@95.96.97.98, pOldname/pNewname is /home/files/testfile.txt
RenameDir                       PROCEDURE(STRING pUrl, STRING pOldname, STRING pNewname), CURLcode, PROC  !pUrl is ftp://user@95.96.97.98, pOldname/pNewname is /home/files/testfile.txt

ReadFile                        PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>), CURLcode, DERIVED, PROC

! create missing dirs for FTP and SFTP
! https://curl.haxx.se/libcurl/c/CURLOPT_FTP_CREATE_MISSING_DIRS.html
CreateMissingDirs               PROCEDURE(CURLFTP_CREATE_DIR_ENUM pValue), CURLcode, PROC
                              END

!---------------------------- TCurlMailClass ----------------------------!
!Send mails: SMTP protocol
TCurlMailClass                CLASS(TCurlClass), TYPE, MODULE('libcurlmail.clw'), LINK('libcurlmail.clw')
url                             STRING(256), PRIVATE        !smtp.gmail.com:587
username                        STRING(128), PRIVATE
pwd                             STRING(32), PRIVATE  
mailfrom                        STRING(256), PRIVATE  
mailto                          &TCurlSList, PRIVATE
mailsubject                     &STRING, PRIVATE
bEncodeSubject                  BOOL, PRIVATE
mailbody                        &STRING, PRIVATE
mailaltbody                     &STRING, PRIVATE
attachments                     &TCurlMailAttachments, PRIVATE

customHeaderLines               &TCurlMailHeaderLines, PRIVATE

!body's property
bodyContentType                 CSTRING(256), PRIVATE
!body's property
bodyCharset                     CSTRING(33), PRIVATE

ToStr                           STRING(256), PRIVATE
CCStr                           STRING(256), PRIVATE
BCCStr                          STRING(256), PRIVATE

Construct                       PROCEDURE()
Destruct                        PROCEDURE(), DERIVED

Init                            PROCEDURE(), DERIVED

SetOptions                      PROCEDURE(), CURLcode, PROC, VIRTUAL, PROTECTED

CreateHeader                    PROCEDURE(*TCurlMailData mail), PRIVATE
CreateBody                      PROCEDURE(*TCurlMailData mail), PRIVATE
CreateAttachments               PROCEDURE(*TCurlMailData mail), PRIVATE

HasInlineAttachments            PROCEDURE(), BOOL, PRIVATE

Server                          PROCEDURE(STRING pServer, LONG pPort, <STRING pHelo>)     !smtp.gmail.com, 587
Account                         PROCEDURE(STRING pUsername, STRING pPwd)                  !username: username@gmail.com
From                            PROCEDURE(STRING pFrom)                                   !username@gmail.com; 'LName FName <username@gmail.com>'
AddRecipient                    PROCEDURE(STRING pRecipient, <STRING pCC>, <STRING pBCC>)
Subject                         PROCEDURE(STRING pSubject, BOOL pEncode = TRUE)           !in Outlook, the subject is unreadable in UTF-8, so pass pEncode=FALSE

!!!<summary>
!!!Adds custom mail header line in form key: value
!!!Examples:
!!!X-Confirm-Reading-To: mikeduglas66@gmail.com
!!!Return-Receipt-To: mikeduglas66@gmail.com
!!!Disposition-Notification-To: mikeduglas66@gmail.com
!!!X-Priority: 1
!!!X-MSMail-Priority: High
!!!Importance: High
!!!</summary>
AddCustomHeader                 PROCEDURE(STRING pKey, STRING pValue)

!Default content type: "text/plain"
Body                            PROCEDURE(STRING pBody)
AltBody                         PROCEDURE(STRING pBody)                                   !forces to use 'text/html' content-type
ContentType                     PROCEDURE(STRING pContentType)
Charset                         PROCEDURE(STRING pCharset)

!Examples of content types include "text/plain", "text/html", "text/css", "image/png", "image/gif", "image/jpeg", "video/mpeg", "audio/basic"
!See GetMIMETypeFromFileExt()
AddAttachment                   PROCEDURE(STRING pFilename, <STRING pContentType>, <STRING pCharset>)
AddEmbeddedImage                PROCEDURE(STRING pFilename, STRING pCid, <STRING pName>)  !forces to use 'text/html' content-type

Send                            PROCEDURE(), CURLcode, PROC

FreeRecipients                  PROCEDURE()
FreeAttachments                 PROCEDURE()
FreeCustomHeaders               PROCEDURE()

Reset                           PROCEDURE(), DERIVED
                              END

!!---------------------------- TCurlPOP3Class ----------------------------!
!!Receive mails: POP3 protocol
!!received emails
!TPOP3MailList                 QUEUE, TYPE
!MsgID                           LONG
!MsgSize                         LONG
!                              END
!
!TPOP3MailFailure              QUEUE, TYPE
!Acct                            STRING(25)
!MsgID                           LONG
!ErrMsg                          STRING(255)
!                              END
!
!TCurlPOP3Class                CLASS(TCurlClass), TYPE, MODULE('libcurlpop3.clw'), LINK('libcurlpop3.clw')
!tmpInboxFolder                  CSTRING(255)   !default '.'
!tmpMailListFile                 CSTRING(255)   !default '.\maillist.$$$'
!
!Construct                       PROCEDURE()
!Destruct                        PROCEDURE(), DERIVED
!
!!!!<summary>
!!!!Returns mail list from account.
!!!!pAccount in form 'pop3s://pop.gmail.com:995/'.
!!!!User, password and SSL must be set prior this call
!!!!</summary>
!GetMailList                     PROCEDURE(STRING pAccount, *TPOP3MailList plistQ, BOOL pFreeQueue = TRUE), CURLcode, PROC
!
!!!!<summary>
!!!!Saves email by its ID as mime-file
!!!!</summary>
!GetMail                         PROCEDURE(STRING pAccount, LONG pMsgID, <STRING pFilename>), CURLcode, PROC
!
!!!!<summary>
!!!!Saves emails as set of mime-files
!!!!</summary>
!!!!<param name="pMaxMailsToGet">maximum number of mails to read, 0 - all emals</param>
!GetMails                        PROCEDURE(STRING pAccount, LONG pMaxMailsToGet = 100, <*TPOP3MailFailure pErrQ>), CURLcode, PROC
!
!OnMailSaved                     PROCEDURE(STRING pFilename), VIRTUAL, PROTECTED !event
!                              END
!
!!---------------------------- TCurlIMAPClass ----------------------------!
!TIMAPFolderTree               QUEUE, TYPE
!Name                            STRING(256)
!Level                           LONG
!ParentFolder                    STRING(256)
!                              END
!
!TIMAPFetchData                QUEUE, TYPE
!Line                            STRING(256)
!                              END
!
!TIMAPMsgHeader                GROUP, TYPE
!MsgID                           LONG        !ordinal number of email in a folder (returned by SEARCH command)
!DateTime                        STRING(64)
!From                            STRING(256)
!Subject                         STRING(256)
!                              END
!
!TIMAPMsgHeaders               QUEUE(TIMAPMsgHeader), TYPE
!                              END
!
!TCurlIMAPClass                CLASS(TCurlClass), TYPE, MODULE('libcurlimap.clw'), LINK('libcurlimap.clw')
!baseUrl                         CSTRING(256), PRIVATE
!userName                        CSTRING(256), PRIVATE
!password                        CSTRING(256), PRIVATE
!SSL                             CURL_USESSL, PRIVATE
!VerifyPeer                      BOOL, PRIVATE
!VerifyHost                      BOOL, PRIVATE
!
!curFolder                       CSTRING(256), PRIVATE ! a folder where FETCH is performed, set by 'SEARCH folder' call
!
!bFetching                       BOOL, PRIVATE   !FETCH call in progress
!FetchData                       &TIMAPFetchData, PRIVATE
!
!Construct                       PROCEDURE()
!Destruct                        PROCEDURE(), DERIVED
!
!SetConnection                   PROCEDURE(), PROTECTED
!Reset                           PROCEDURE(), DERIVED
!
!!!!<summary>
!!!!Sets imap credentials
!!!!</summary>
!!!!<param name="pBaseUrl">for gmail: 'imaps://imap.gmail.com:993'</param>
!!!!<param name="pUser">User name</param>
!!!!<param name="pPsw">Password</param>
!!!!<param name="pSSL">Use SSL</param>
!!!!<param name="pVerifyPeer"Verify peer</param>
!!!!<param name="pVerifyHost"Verify host</param>
!Credentials                     PROCEDURE(STRING pBaseUrl, STRING pUser, STRING pPsw, CURL_USESSL pSSL = CURLUSESSL_ALL, BOOL pVerifyPeer = FALSE, BOOL pVerifyHost = FALSE)
!
!!!!<summary>
!!!!Sends a command
!!!!</summary>
!!!!<param name="pCommand">any available command like 'SEARCH NEW'</param>
!!!!<param name="pDynStr">server response</param>
!SendCommand                     PROCEDURE(STRING pCommand, *IDynStr pDynStr), CURLcode, PROC
!
!!!!<summary>
!!!!Sends a command
!!!!</summary>
!!!!<param name="pFolder">folder name to request; like 'INBOX'</param>
!!!!<param name="pCommand">any available command like 'SEARCH NEW'</param>
!!!!<param name="pDynStr">server response</param>
!SendCommand                     PROCEDURE(STRING pFolder, STRING pCommand, *IDynStr pDynStr), CURLcode, PROC
!
!!!!<summary>
!!!!Sends a SEARCH command
!!!!</summary>
!!!!<param name="pFolder">folder name to request; like 'INBOX'</param>
!!!!<param name="pCriteria">Search criteria keywords including flags such as ALL, ANSWERED, DELETED, DRAFT, FLAGGED, NEW, RECENT and SEEN.
!!!!Ex.:  SEARCH FLAGGED SINCE 1-Feb-1994 NOT FROM "Smith"
!!!!</param>
!!!!<param name="msglist">List of MsgIDs</param>
!Search                          PROCEDURE(STRING pFolder, STRING pCriteria, *IDynStr msglist), CURLcode, PROC
!
!FetchHeaders                    PROCEDURE(STRING pMsgList, *TIMAPMsgHeaders headers), CURLcode, PROC
!FetchHeaders                    PROCEDURE(STRING pFolder, STRING pCriteria, *TIMAPMsgHeaders headers), CURLcode, PROC
!FetchHeaders                    PROCEDURE(STRING pFolder, STRING pCriteria, LONG pRecsPerPage, LONG pPageNum, *TIMAPMsgHeaders headers), CURLcode, PROC
!
!FetchText                       PROCEDURE(LONG pMsgID, *IDynStr ptext), CURLcode, PROC
!FetchText                       PROCEDURE(LONG pMsgID), STRING
!
!TalkCallback                    PROCEDURE(CURL_INFOTYPE ptype, STRING ptext), DERIVED
!
!!!!<summary>
!!!!Builds folder tree, calling 'LIST "" *"' command
!!!!</summary>
!!!!<param name="tree">queue ready to use as data source in Clarion Tree List control</param>
!BuildFolderTree                 PROCEDURE(*TIMAPFolderTree tree), CURLcode, PROC
!
!!TIMAPFolder test
!ParseFolder                     PROCEDURE(STRING input), STRING
!                              END


!---------------------------- TCurlHttpClass ----------------------------!
TCurlHttpClass                CLASS(TCurlClass), TYPE, MODULE('libcurlhttp.clw'), LINK('libcurlhttp.clw')
!- used in curl_formadd etc
httppost                        LONG, PROTECTED
postend                         LONG, PROTECTED

Destruct                        PROCEDURE(), DERIVED

FollowLocation                  PROCEDURE(BOOL pFollowLocation = TRUE, LONG pContentLength = 0), CURLcode, PROC !libcurl bug: "http error 411 (Length required)"; explicit 0 fixes this
MaxRedirs                       PROCEDURE(LONG pValue), CURLcode, PROC
GetRedirectUrl                  PROCEDURE(), STRING !if CURLOPT_FOLLOWLOCATION set to 1

!Cookie: see http://curl.haxx.se/libcurl/c/libcurl-tutorial.html  "Cookies Without Chocolate Chips" topic

!http://curl.haxx.se/libcurl/c/CURLOPT_COOKIE.html
!!!<summary>
!!!Sets a cookie in the HTTP request. 
!!!</summary>
AddHeaderCookie                 PROCEDURE(STRING pCookieString), CURLcode, PROC   !pCookieString like 'name=var' or 'name1=var1; name2=var2;'

!!!<summary>
!!!The list of cookies in pCookieFile will not be imported until right
!!!before a transfer is performed. Cookies in the list that have the same
!!!hostname, path and name as in my_cookie are skipped. That is because
!!!libcurl has already imported my_cookie and it's considered a "live"
!!!cookie. A live cookie won't be replaced by one read from a file.
!!!</summary>
ImportCookies                   PROCEDURE(<STRING pCookieFile>), CURLcode, PROC   !omit pCookieFile to just enable cookie engine

!!!<summary>
!!!Cookies are exported after curl_easy_cleanup is called. The server 
!!!may have added, deleted or modified cookies by then. The cookies that
!!!were skipped on import are not exported.
!!!</summary>
ExportCookies                   PROCEDURE(STRING pCookieFile), CURLcode, PROC

!http://curl.haxx.se/libcurl/c/CURLOPT_COOKIELIST.html
!!!<summary>
!!!cookie can be either a single line in Netscape / Mozilla format or just regular HTTP-style header (Set-Cookie: ...) format.
!!!Additionally, there are commands available that perform actions if you pass in these exact strings:
!!!'ALL' erases all cookies held in memory, 
!!!'SESS' erases all session cookies held in memory, 
!!!'FLUSH' writes all known cookies to the file specified by ImportCookies, 
!!!'RELOAD' loads all cookies from the files specified by ExportCookies
!!!</summary>
AddCookie                       PROCEDURE(STRING pCookie), CURLcode, PROC

!http://curl.haxx.se/libcurl/c/CURLINFO_COOKIELIST.html
!!!<summary>
!!!get all known cookies (expired ones, too). 
!!!Since 7.43.0 cookies that were imported in the Set-Cookie format without a domain name are not exported by this option
!!!</summary>
GetCookieList                   PROCEDURE(*TCurlSQueue pQ), BOOL, PROC

!--  post form fields
FormAdd                         PROCEDURE(STRING pFieldName, STRING pContents), CURLFORMcode, PROC
FormAddFile                     PROCEDURE(STRING pFieldName, STRING pFileName, <STRING pContentType>), CURLFORMcode, PROC !ContentType like 'image/jpeg'
FormPost                        PROCEDURE(STRING pUrl, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
FormPost                        PROCEDURE(STRING pUrl, *IDynStr pDynStr, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
FormPostStr                     PROCEDURE(STRING pUrl, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
FormFree                        PROCEDURE()

StrFormAddError                 PROCEDURE(CURLFORMcode errcode), STRING, VIRTUAL

!Shortcuts for curl.exe --data-binary [@file].
!ContentType like 'image/jpeg'
SendFile                        PROCEDURE(STRING pUrl, STRING pFileName, STRING pContentType, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
SendFileStr                     PROCEDURE(STRING pUrl, STRING pFileName, STRING pContentType, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
!pDataLen=0 means LEN(pBinData)
SendBinData                     PROCEDURE(STRING pUrl, CONST *STRING pBinData, LONG pDataLen = 0, STRING pContentType, <STRING pResponseFile>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
SendBinDataStr                  PROCEDURE(STRING pUrl, CONST *STRING pBinData, LONG pDataLen = 0, STRING pContentType, <*STRING pResponseBuf>, <curl::ProgressDataProcType xferproc>), CURLcode, PROC
                              END

!---------------------------- TCurlDropboxClass ----------------------------!
TDbxThumbnailFormat           EQUATE(STRING)
TDbxThumbnailFormat:JPEG      EQUATE('jpeg')
TDbxThumbnailFormat:PNG       EQUATE('png')

TDbxThumbnailSize             EQUATE(STRING)
TDbxThumbnailSize:w32h32      EQUATE('w32h32')
TDbxThumbnailSize:w64h64      EQUATE('w64h64')
TDbxThumbnailSize:w128h128    EQUATE('w128h128')
TDbxThumbnailSize:w640h480    EQUATE('w640h480')
TDbxThumbnailSize:1024h768    EQUATE('1024h768')


TCurlDropboxClass             CLASS(TCurlHttpClass), TYPE, MODULE('libcurldropbox.clw'), LINK('libcurldropbox.clw')
_accessToken                    CSTRING(128), PROTECTED
_response                       &IDynStr, PROTECTED
_lastCurlCode                   CURLcode, PROTECTED

Construct                       PROCEDURE()
Destruct                        PROCEDURE(), DERIVED

!!!<summary>Redirect to authorization page</summary>
!!!<param name="pAppKey">Application key</param>
Authorize                       PROCEDURE(STRING pAppKey)

!!!<summary>Acquire a bearer token once the user has authorized the app</summary>
!!!<param name="pAuthCode">The authorization code, which can be used to attain a bearer token</param>
!!!<param name="pAppKey">Application key</param>
!!!<param name="pAppSecret">Application secret</param>
AccessToken                     PROCEDURE(STRING pAuthCode, STRING pAppKey, STRING pAppSecret), BOOL, PROC

AccessToken                     PROCEDURE(STRING pAccessToken)
AccessToken                     PROCEDURE(), STRING

SetAuthEndpoint                 PROCEDURE(STRING pPostFields), CURLcode, PROC, PROTECTED
SetRPCEndpoint                  PROCEDURE(STRING pJsonArgs), CURLcode, PROC, PROTECTED
SetContentUploadEndpoint        PROCEDURE(STRING pJsonArgs), CURLcode, PROC, PROTECTED
SetContentDownloadEndpoint      PROCEDURE(STRING pJsonArgs), CURLcode, PROC, PROTECTED

Send                            PROCEDURE(STRING pDomain, STRING pNamespace, STRING pFunction), CURLcode, PROC, PROTECTED


!- public API
Copy                            PROCEDURE(STRING pFromPath, STRING pToPath), BOOL, PROC
Move                            PROCEDURE(STRING pFromPath, STRING pToPath), BOOL, PROC
CreateFolder                    PROCEDURE(STRING pPath), BOOL, PROC
Delete                          PROCEDURE(STRING pPath), BOOL, PROC
Download                        PROCEDURE(STRING pRemotePath, STRING pLocalPath), BOOL, PROC
Upload                          PROCEDURE(STRING pLocalPath, STRING pRemotePath, <STRING pMode>, BOOL pAutorename = FALSE), BOOL, PROC
ListFolder                      PROCEDURE(STRING pPath, BOOL pRecursive = FALSE), BOOL, PROC
!- v1.11
Get_Copy_Reference              PROCEDURE(STRING pPath), BOOL, PROC
Save_Copy_Reference             PROCEDURE(STRING pPath, STRING pCopyReference), BOOL, PROC
!!!<summary>
!!!Gets a preview of a file. Previews are only generated for the files with the following extensions: 
!!!.doc, .docx, .docm, .ppt, .pps, .ppsx, .ppsm, .pptx, .pptm, .xls, .xlsx, .xlsm, .rtf
!!!</summary>
!!!<param name="pPath">The absolute path to the file you want to preview.</param>
!!!<param name="pTmpFile">The absolute local path to the tempory file, without extension. On return, gets an extension of 'html' or 'pdf'</param>
Preview                         PROCEDURE(STRING pPath, *STRING pTmpFile), BOOL, PROC
!!!<summary>
!!!Get a thumbnail for an image. This method currently supports files with the following file extensions:
!!!jpg, jpeg, png, tiff, tif, gif and bmp. Photos that are larger than 20MB in size won't be converted to a thumbnail.
!!!</summary>
!!!<param name="pPath">The path to the image file you want to thumbnail.</param>
!!!<param name="pFormat">The format for the thumbnail image, jpeg (default) or png. For images that are photos, jpeg should be preferred, while png is better for screenshots and digital arts. The default for this union is jpeg.</param>
!!!<param name="pSize">The size for the thumbnail image. The default for this union is w64h64.</param>
!!!<param name="pTmpFile">The absolute local path to the tempory file, without extension. On return, gets an extension of 'html' or 'pdf'</param>
Thumbnail                       PROCEDURE(STRING pPath, TDbxThumbnailFormat pFormat, TDbxThumbnailSize pSize, *STRING pTmpFile), BOOL, PROC


!- responses
DropboxResponse                 PROCEDURE(), STRING !- HTTP response
CurlResponse                    PROCEDURE(), CURLcode
!GetResponseCode                 PROCEDURE(), LONG  !- HTTP response code (defined in parent class)
                              END


!---------------------------- TCurlMimeClass ----------------------------!
!https://curl.haxx.se/libcurl/c/allfuncs.html
!see curl_mime_xxx functions

TCurlMimeClass                CLASS, TYPE, MODULE('libcurlmime.clw'), LINK('libcurlmime.clw')
mime                            curl_mime, PROTECTED

Construct                       PROCEDURE()
Destruct                        PROCEDURE(), VIRTUAL

!!!<summary>create a mime handle</summary>
!!!<param name="curl">Curl instance</param>
Init                            PROCEDURE(*TCurlClass curl), VIRTUAL

!!!<summary>free a previously built mime structure</summary>
Kill                            PROCEDURE(), VIRTUAL

!!!<summary>returns this mime handle.</summary>
GetMime                         PROCEDURE(), curl_mime

!!!<summary>creates and appends a new empty part to the given mime structure and returns a handle to it.</summary>
AddPart                         PROCEDURE(), curl_mimepart

!!!<summary>set a mime part's body data from memory</summary>
!!!<param name="pData">data bytes, those are copied to the part and their storage may safely be reused after call.</param>
SetData                         PROCEDURE(curl_mimepart part, STRING pData), CURLcode, PROC

!!!<summary>set a mime part's body data from a file contents.
!!! As a side effect, the part's remote file name is set to the base name of the given filename if it is a valid named file. 
!!! This can be undone or overridden by a subsequent call to SetFileName.
!!!</summary>
!!!<param name="pFileName">file's path name</param>
SetFileData                     PROCEDURE(curl_mimepart part, STRING pFileName), CURLcode, PROC

!!!<summary>set a mime part's name. This is the way HTTP form fields are named.</summary>
!!!<param name="pName">a mime part's name</param>
SetName                         PROCEDURE(curl_mimepart part, STRING pName), CURLcode, PROC

!!!<summary>set a mime part's encoder and content transfer encoding.</summary>
!!!<param name="pEncoding">encoding scheme. Supported encoding schemes are: 
!!! "binary": the data is left unchanged, the header is added. 
!!! "8bit": header added, no data change. 
!!! "7bit": the data is unchanged, but is each byte is checked to be a 7-bit value; if not, a read error occurs.
!!! "base64": Data is converted to base64 encoding, then split in CRLF-terminated lines of at most 76 characters. 
!!! "quoted-printable": data is encoded in quoted printable lines of at most 76 characters. 
!!!</param>
SetEncoder                      PROCEDURE(curl_mimepart part, STRING pEncoding), CURLcode, PROC

!!!<summary>set a mime part's content type.</summary>
!!!<param name="pType">mime type</param>
SetType                         PROCEDURE(curl_mimepart part, STRING pType), CURLcode, PROC

!!!<summary>set a mime part's remote file name.
!!! When remote file name is set, content data is processed as a file, whatever is the part's content source. 
!!! A part's remote file name is transmitted to the server in the associated Content-Disposition generated header.
!!!</summary>
!!!<param name="pRemoteFileName">mime part's remote file name</param>
SetFileName                     PROCEDURE(curl_mimepart part, STRING pRemoteFileName), CURLcode, PROC

!!!<summary>set a mime part's custom headers.</summary>
!!!<param name="headers">list of custom headers.</param>
!!!<param name="take_ownership">when TRUE, causes the list to be freed upon replacement or mime structure deletion;
!!! in this case the list must not be freed explicitly.</param>
SetHeaders                      PROCEDURE(curl_mimepart part, TCurlSList headers, BOOL take_ownership = FALSE), CURLcode, PROC

!!!<summary>sets a multipart mime part's content from a mime structure.
!!! After SetSubparts succeeds, the mime structure handle belongs to the multipart part and must not be freed explicitly.
!!! It may however be updated by subsequent calls to mime API functions.
!!!</summary>
!!!<param name="subparts">a mime class instance holding the subparts.</param>
SetSubparts                     PROCEDURE(curl_mimepart part, TCurlMimeClass subparts), CURLcode, PROC

!!!<summary>set a callback-based data source for a mime part's body.</summary>
!!!<param name="pHugeData">pointer to the data bytes.</param>
!!!<param name="pDoDispose">call DISPOSE(pHugeData) after the transfer terminates.</param>
SetDataCB                       PROCEDURE(curl_mimepart part, CONST *STRING pHugeData, BOOL pDoDispose = FALSE), CURLcode, PROC


                              END
