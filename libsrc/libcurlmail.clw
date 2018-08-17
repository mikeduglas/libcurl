!** libcurl for Clarion v1.29
!** 16.08.2018
!** mikeduglas66@gmail.com

  MEMBER

  INCLUDE('libcurl.inc')

  MAP
    MODULE('WinAPI')
      curl::memcpy(LONG lpDest,LONG lpSource,LONG nCount), LONG, PROC, NAME('_memcpy')
    END

    ConvertToCodePage(STRING pStr, SIGNED pCodePage = CP_UTF8), STRING, PRIVATE  ! convert ASCII to UTF8
    GetMIMETypeFromFileExt(STRING pFilename), STRING, PRIVATE
    ExtractMailAddress(STRING pMailAddress), STRING, PRIVATE  !extracts 'user@gmail.com' from 'Joe Doe <user@gmail.com>'
    ExtractName(STRING pMailAddress), STRING, PRIVATE  !extracts 'Joe Doe' from 'Joe Doe <user@gmail.com>'
    EncodeHeaderPart(STRING pText), STRING  !subject, from, to, cc, bcc

    Base64::EncodeBlock(STRING in, *STRING out, LONG len), PRIVATE
    Base64::Encode(STRING input_buf), STRING, PRIVATE
    !read email callback
    curl::EmailRead(LONG buffer, size_t bufsize, size_t nmemb, LONG userp), size_t, C, PRIVATE

    AddBody(*TCurlMailData mail, STRING pType, STRING pharset, CONST *STRING pBody, <STRING pBoundary>), PRIVATE
  END

TCurlMailData                 CLASS, TYPE
lines_read                      LONG, PRIVATE
qData                           &TCurlMailDataQueue, PRIVATE

Construct                       PROCEDURE()
Destruct                        PROCEDURE()
AddLine                         PROCEDURE(<STRING pText>, BOOL pAddCRLF = TRUE)
ReadNext                        PROCEDURE(LONG pBuffer), LONG   !pBuffer is buffer address (from curl::EmailRead callback); returns buffer length
                              END

TCurlMailAttachment           GROUP, TYPE
filename                        CSTRING(256)
shortname                       CSTRING(256)
contentType                     CSTRING(256)
charset                         CSTRING(33)
inline                          BOOL
cid                             CSTRING(256)
                              END

TCurlMailAttachments          QUEUE(TCurlMailAttachment), TYPE
                              END

TCurlMailDataQueue            QUEUE, TYPE
line                            &STRING
                              END

TCurlMailHeaderLines          QUEUE, TYPE
Key                             STRING(256)
Value                           STRING(256)
                              END

cb64                          STRING('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/')
szUserAgent                   CSTRING('curl/7.52.1')

DECODED_BUF_SIZE              EQUATE(54)    !54 characters per line
ENCODED_BUF_SIZE              EQUATE(72)    !54 * 4 / 3

!!!region static functions
ConvertToCodePage             PROCEDURE(STRING pStr, SIGNED pCodePage = CP_UTF8)
UnicodeText                     STRING(LEN(pStr)*2+2)
UtfText                         STRING(LEN(pStr)*2+2)
Len                             LONG, AUTO
bytesWritten                    LONG, AUTO
  CODE
  Len = LEN(pStr)*2 + 2
  bytesWritten = winapi::MultiByteToWideChar(CP_ACP, 0, ADDRESS(pStr), LEN(pStr), ADDRESS(UnicodeText), Len)
  UnicodeText[Len-1 : Len] = '<0><0>'
  Len = winapi::WideCharToMultiByte(pCodePage, 0, ADDRESS(UnicodeText), -1, ADDRESS(UTFText), Len, 0, 0)
  LOOP
    IF UtfText[Len] = '<0>'
      Len -= 1
    ELSE
      BREAK
    END
  END
  RETURN UtfText[1 : Len]

!http://webdesign.about.com/od/multimedia/a/mime-types-by-file-extension.htm
GetMIMETypeFromFileExt        PROCEDURE(STRING pFilename)
dotpos                          LONG, AUTO
  CODE
  dotpos = INSTRING('.', pFilename, -1, LEN(CLIP(pFilename)))
  IF NOT dotpos
    RETURN 'application/octet-stream'
  END
  
  CASE LOWER(pFilename[dotpos + 1 : LEN(CLIP(pFilename))])
  OF '323'
    RETURN 'text/h323'
  OF 'acx'
    RETURN 'application/internet-property-stream'
  OF 'ai'
    RETURN 'application/postscript'
  OF 'aif' OROF 'aifc' OROF 'aiff'
    RETURN 'audio/x-aiff'
  OF 'asf' OROF 'asr' OROF 'asx'
    RETURN 'video/x-ms-asf'
  OF 'au'
    RETURN 'audio/basic'
  OF 'avi'
    RETURN 'video/x-msvideo'
  OF 'axs'
    RETURN 'application/olescript'
  OF 'bas' OROF 'c' OROF 'h'
    RETURN 'text/plain'
  OF 'bcpio'
    RETURN 'application/x-bcpio'
  OF 'bin'
    RETURN 'application/octet-stream'
  OF 'bmp'
    RETURN 'image/bmp'
  OF 'cat'
    RETURN 'application/vnd.ms-pkiseccat'
  OF 'cdf'
    RETURN 'application/x-cdf'
  OF 'cer' OROF 'crt' OROF 'der'
    RETURN 'application/x-x509-ca-cert'
  OF 'class'
    RETURN 'application/octet-stream'
  OF 'clp'
    RETURN 'application/x-msclip'
  OF 'cmx'
    RETURN 'image/x-cmx'
  OF 'cod'
    RETURN 'image/cis-cod'
  OF 'cpio'
    RETURN 'application/x-cpio'
  OF 'crd'
    RETURN 'application/x-mscardfile'
  OF 'crl'
    RETURN 'application/pkix-crl'
  OF 'csh'
    RETURN 'application/x-csh'
  OF 'css'
    RETURN 'text/css'
  OF 'dcr' OROF 'dir' OROF 'dxr'
    RETURN 'application/x-director'
  OF 'dll'
    RETURN 'application/x-msdownload'
  OF 'dms'
    RETURN 'application/octet-stream'
  OF 'doc' OROF 'dot'
    RETURN 'application/msword'
  OF 'dvi'
    RETURN 'application/x-dvi'
  OF 'eps'
    RETURN 'application/postscript'
  OF 'etx'
    RETURN 'text/x-setext'
  OF 'evy'
    RETURN 'application/envoy'
  OF 'exe'
    RETURN 'application/octet-stream'
  OF 'fif'
    RETURN 'application/fractals'
  OF 'flr'
    RETURN 'x-world/x-vrml'
  OF 'gif'
    RETURN 'image/gif'
  OF 'gtar'
    RETURN 'application/x-gtar'
  OF 'gz'
    RETURN 'application/x-gzip'
  OF 'hdf'
    RETURN 'application/x-hdf'
  OF 'hlp'
    RETURN 'application/winhlp'
  OF 'hqx'
    RETURN 'application/mac-binhex40'
  OF 'hta'
    RETURN 'application/hta'
  OF 'htc'
    RETURN 'text/x-component'
  OF 'htm' OROF 'html'
    RETURN 'text/html'
  OF 'htt'
    RETURN 'text/webviewhtml'
  OF 'ico'
    RETURN 'image/x-icon'
  OF 'ief'
    RETURN 'image/ief'
  OF 'iii'
    RETURN 'application/x-iphone'
  OF 'ins' OROF 'isp'
    RETURN 'application/x-internet-signup'
  OF 'jfif'
    RETURN 'image/pipeg'
  OF 'jpe' OROF 'jpeg' OROF 'jpg'
    RETURN 'image/jpeg'
  OF 'js'
    RETURN 'application/x-javascript'
  OF 'latex'
    RETURN 'application/x-latex'
  OF 'lha'
    RETURN 'application/octet-stream'
  OF 'lsf' OROF 'lsx'
    RETURN 'video/x-la-asf'
  OF 'lzh'
    RETURN 'application/octet-stream'
  OF 'm13' OROF 'm14'
    RETURN 'application/x-msmediaview'
  OF 'm3u'
    RETURN 'audio/x-mpegurl'
  OF 'man'
    RETURN 'application/x-troff-man'
  OF 'mdb'
    RETURN 'application/x-msaccess'
  OF 'me'
    RETURN 'application/x-troff-me'
  OF 'mht' OROF 'mhtml'
    RETURN 'message/rfc822'
  OF 'mid'
    RETURN 'audio/mid'
  OF 'mny'
    RETURN 'application/x-msmoney'
  OF 'mov'
    RETURN 'video/quicktime'
  OF 'movie'
    RETURN 'video/x-sgi-movie'
  OF 'mp2' OROF 'mpa' OROF 'mpe' OROF 'mpeg' OROF 'mpg' OROF 'mpv2'
    RETURN 'video/mpeg'
  OF 'mp3'
    RETURN 'audio/mpeg'
  OF 'mpp'
    RETURN 'application/vnd.ms-project'
  OF 'ms'
    RETURN 'application/x-troff-ms'
  OF 'msg'
    RETURN 'application/vnd.ms-outlook'
  OF 'mvb'
    RETURN 'application/x-msmediaview'
  OF 'nc'
    RETURN 'application/x-netcdf'
  OF 'nws'
    RETURN 'message/rfc822'
  OF 'oda'
    RETURN 'application/oda'
  OF 'p10'
    RETURN 'application/pkcs10'
  OF 'p12'
    RETURN 'application/x-pkcs12'
  OF 'p7b'
    RETURN 'application/x-pkcs7-certificates'
  OF 'p7c' OROF 'p7m'
    RETURN 'application/x-pkcs7-mime'
  OF 'p7r'
    RETURN 'application/x-pkcs7-certreqresp'
  OF 'p7s'
    RETURN 'application/x-pkcs7-signature'
  OF 'pbm'
    RETURN 'image/x-portable-bitmap'
  OF 'pdf'
    RETURN 'application/pdf'
  OF 'pfx'
    RETURN 'application/x-pkcs12'
  OF 'pgm'
    RETURN 'image/x-portable-graymap'
  OF 'pko'
    RETURN 'application/ynd.ms-pkipko'
  OF 'pma' OROF 'pmc' OROF 'pml' OROF 'pmr' OROF 'pmw'
    RETURN 'application/x-perfmon'
  OF 'pnm'
    RETURN 'image/x-portable-anymap'
  OF 'pot'
    RETURN 'application/vnd.ms-powerpoint'
  OF 'ppm'
    RETURN 'image/x-portable-pixmap'
  OF 'pps' OROF 'ppt'
    RETURN 'application/vnd.ms-powerpoint'
  OF 'prf'
    RETURN 'application/pics-rules'
  OF 'ps'
    RETURN 'application/postscript'
  OF 'pub'
    RETURN 'application/x-mspublisher'
  OF 'qt'
    RETURN 'video/quicktime'
  OF 'ra' OROF 'ram'
    RETURN 'audio/x-pn-realaudio'
  OF 'ras'
    RETURN 'image/x-cmu-raster'
  OF 'rgb'
    RETURN 'image/x-rgb'
  OF 'rmi'
    RETURN 'audio/mid'
  OF 'roff'
    RETURN 'application/x-troff'
  OF 'rtf'
    RETURN 'application/rtf'
  OF 'rtx'
    RETURN 'text/richtext'
  OF 'scd'
    RETURN 'application/x-msschedule'
  OF 'sct'
    RETURN 'text/scriptlet'
  OF 'setpay'
    RETURN 'application/set-payment-initiation'
  OF 'setreg'
    RETURN 'application/set-registration-initiation'
  OF 'sh'
    RETURN 'application/x-sh'
  OF 'shar'
    RETURN 'application/x-shar'
  OF 'sit'
    RETURN 'application/x-stuffit'
  OF 'snd'
    RETURN 'audio/basic'
  OF 'spc'
    RETURN 'application/x-pkcs7-certificates'
  OF 'spl'
    RETURN 'application/futuresplash'
  OF 'src'
    RETURN 'application/x-wais-source'
  OF 'sst'
    RETURN 'application/vnd.ms-pkicertstore'
  OF 'stl'
    RETURN 'application/vnd.ms-pkistl'
  OF 'stm'
    RETURN 'text/html'
  OF 'sv4cpio'
    RETURN 'application/x-sv4cpio'
  OF 'sv4crc'
    RETURN 'application/x-sv4crc'
  OF 'svg'
    RETURN 'image/svg+xml'
  OF 'swf'
    RETURN 'application/x-shockwave-flash'
  OF 't'
    RETURN 'application/x-troff'
  OF 'tar'
    RETURN 'application/x-tar'
  OF 'tcl'
    RETURN 'application/x-tcl'
  OF 'tex'
    RETURN 'application/x-tex'
  OF 'texi' OROF 'texinfo'
    RETURN 'application/x-texinfo'
  OF 'tgz'
    RETURN 'application/x-compressed'
  OF 'tif' OROF 'tiff'
    RETURN 'image/tiff'
  OF 'tr'
    RETURN 'application/x-troff'
  OF 'trm'
    RETURN 'application/x-msterminal'
  OF 'tsv'
    RETURN 'text/tab-separated-values'
  OF 'txt'
    RETURN 'text/plain'
  OF 'uls'
    RETURN 'text/iuls'
  OF 'ustar'
    RETURN 'application/x-ustar'
  OF 'vcf'
    RETURN 'text/x-vcard'
  OF 'vrml'
    RETURN 'x-world/x-vrml'
  OF 'wav'
    RETURN 'audio/x-wav'
  OF 'wcm' OROF 'wdb' OROF 'wks' OROF 'wps'
    RETURN 'application/vnd.ms-works'
  OF 'wmf'
    RETURN 'application/x-msmetafile'
  OF 'wri'
    RETURN 'application/x-mswrite'
  OF 'wrl' OROF 'wrz' OROF 'xaf'
    RETURN 'x-world/x-vrml'
  OF 'xbm'
    RETURN 'image/x-xbitmap'
  OF 'xla' OROF 'xlc' OROF 'xlm' OROF 'xls' OROF 'xlt' OROF 'xlw'
    RETURN 'application/vnd.ms-excel'
  OF 'xof'
    RETURN 'x-world/x-vrml'
  OF 'xpm'
    RETURN 'image/x-xpixmap'
  OF 'xwd'
    RETURN 'image/x-xwindowdump'
  OF 'z'
    RETURN 'application/x-compress'
  OF 'zip'
    RETURN 'application/zip'
  END
  
  RETURN 'application/octet-stream'

ExtractMailAddress            PROCEDURE(STRING pMailAddress)
startAngleBrPos                 LONG, AUTO
endAngleBrPos                   LONG, AUTO
  CODE
  startAngleBrPos = INSTRING('<', pMailAddress, 1, 1)
  IF NOT startAngleBrPos
    RETURN CLIP(pMailAddress)
  END
  
  endAngleBrPos = INSTRING('>', pMailAddress, -1, LEN(CLIP(pMailAddress)))
  IF endAngleBrPos > startAngleBrPos
    RETURN CLIP(LEFT(SUB(pMailAddress, startAngleBrPos + 1, endAngleBrPos - startAngleBrPos - 1)))
  END

  !recover if no closing bracket found or >...< found
  RETURN pMailAddress[startAngleBrPos + 1 : LEN(CLIP(pMailAddress))]
  
ExtractName                   PROCEDURE(STRING pMailAddress)
startAngleBrPos                 LONG, AUTO
  CODE
  startAngleBrPos = INSTRING('<', pMailAddress, 1, 1)
  IF startAngleBrPos < 2
    RETURN ''
  END
  
  RETURN CLIP(pMailAddress[1 : startAngleBrPos - 1])

!http://ncona.com/2011/06/using-utf-8-characters-on-an-e-mail-subject/
EncodeHeaderPart              PROCEDURE(STRING pText)
  CODE
  RETURN '=?utf-8?B?'& Base64::Encode(ConvertToCodePage(CLIP(pText))) &'?='

Base64::EncodeBlock           PROCEDURE(STRING in, *STRING out, LONG len)
  CODE
!  {
!  out[0] = cb64[ in[0] >> 2 ];
!  out[1] = cb64[ ((in[0] & 0x03) << 4) | ((in[1] & 0xf0) >> 4) ];
!  out[2] = (unsigned char) (len > 1 ? cb64[ ((in[1] & 0x0f) << 2) | ((in[2] & 0xc0) >> 6) ] : '=');
!  out[3] = (unsigned char) (len > 2 ? cb64[ in[2] & 0x3f ] : '=');
!  }

  ASSERT(LEN(in) = 3 AND LEN(out) = 4)
  out[1] = cb64[BSHIFT(VAL(in[1]), -2) + 1]
  out[2] = cb64[BOR(BSHIFT(BAND(VAL(in[1]), 003h), 4), BSHIFT(BAND(VAL(in[2]), 0f0h), -4)) + 1]
  IF len > 1
    out[3] = cb64[BOR(BSHIFT(BAND(VAL(in[2]), 00fh), 2), BSHIFT(BAND(VAL(in[3]), 0c0h), -6)) + 1]
  ELSE
    out[3] = '='
  END
  IF len > 2
    out[4] = cb64[BAND(VAL(in[3]), 03fh) + 1]
  ELSE
    out[4] = '='
  END
    
Base64::Encode                PROCEDURE(STRING input_buf)
input_size                      LONG, AUTO
output_buf                      STRING((LEN(input_buf)/DECODED_BUF_SIZE + 1) * ENCODED_BUF_SIZE)
in                              STRING(3), AUTO
out                             STRING(4), AUTO
iIndex                          LONG, AUTO
block_size                      LONG, AUTO    !block size
sIndex                          LONG, AUTO    !pos in input_buf
n_block                         LONG, AUTO    !block number
  CODE
  input_size = LEN(input_buf)
  n_block = 0
  
  LOOP sIndex = 1 TO input_size BY 3
    block_size = 0
    LOOP iIndex = 1 TO 3
      IF sIndex + (iIndex - 1) <= input_size
        in[iIndex] = input_buf[sIndex + (iIndex - 1)]
        block_size += 1
      ELSE
        in[iIndex] = 0
      END
    END
    
    IF block_size
      Base64::EncodeBlock(in, out, block_size)

      n_block += 1
      output_buf[(n_block - 1) * 4 + 1 : n_block * 4] = out
    END
  END
  
  RETURN CLIP(output_buf)
  
AddBody                       PROCEDURE(*TCurlMailData mail, STRING pType, STRING pharset, CONST *STRING pBody, <STRING pBoundary>)
  CODE
  IF pBoundary
    mail.AddLine(pBoundary)
  END
  
  !Content-Type, charset
  mail.AddLine('Content-Type: '& pType &''& CHOOSE(pharset <> '', '; charset='& pharset &'', ''))
  !Encoding
  mail.AddLine('Content-Transfer-Encoding: '& 'base64')
  !empty line to divide headers from body, see RFC5322 
  mail.AddLine()
  !body
  mail.AddLine(Base64::Encode(ConvertToCodePage(pBody)))

  IF pBoundary
    mail.AddLine()
  END

!!!endregion
  
!!!region callbacks
curl::EmailRead               PROCEDURE(LONG buffer, size_t bufsize, size_t nmemb, LONG userp)
mailData                        &TCurlMailData
  CODE
  IF bufsize = 0 OR nmemb = 0 OR bufsize*nmemb < 1
    RETURN 0
  END

  IF userp = 0
    RETURN -1
  END
  
  mailData &= (userp)
  RETURN mailData.ReadNext(buffer)
!!!endregion
  
!!!region TCurlMailDataQueue
TCurlMailData.Construct       PROCEDURE()
  CODE
  SELF.qData &= NEW TCurlMailDataQueue
  
TCurlMailData.Destruct        PROCEDURE()
qIndex                          LONG, AUTO
  CODE
  LOOP qIndex = 1 TO RECORDS(SELF.qData)
    GET(SELF.qData, qIndex)
    DISPOSE(SELF.qData.line)
    SELF.qData.line &= NULL
  END
  FREE(SELF.qData)
  SELF.qData &= NULL
  
TCurlMailData.AddLine         PROCEDURE(<STRING pText>, BOOL pAddCRLF = TRUE)
  CODE
  IF pAddCRLF
    SELF.qData.line &= NEW STRING(LEN(CLIP(pText)) + 2) ! 2 extra bytes for \r\n
    SELF.qData.line = CLIP(pText) &'<13,10>'
    ADD(SELF.qData)
  ELSIF LEN(CLIP(pText)) > 0
    SELF.qData.line &= NEW STRING(LEN(CLIP(pText)))
    SELF.qData.line = CLIP(pText)
    ADD(SELF.qData)
  END  
  
TCurlMailData.ReadNext        PROCEDURE(LONG pBuffer)
nextLine                        LONG, AUTO
buflen                          LONG, AUTO
  CODE
  nextLine = SELF.lines_read + 1
  GET(SELF.qData, nextLine)
  IF NOT ERRORCODE()
    buflen = LEN(SELF.qData.line)
    curl::memcpy(pBuffer, ADDRESS(SELF.qData.line), buflen)
    SELF.lines_read = nextLine
    RETURN buflen
  END
  
  RETURN 0

!!!endregion
  
!!!region TCurlMailClass
TCurlMailClass.Construct      PROCEDURE()
  CODE
  SELF.mailto &= NEW TCurlSList

  SELF.attachments &= NEW TCurlMailAttachments
  
  SELF.mailsubject &= NEW STRING(1)
  SELF.mailsubject = ' '
  SELF.mailbody &= NEW STRING(1)
  SELF.mailbody = ' '
  SELF.mailaltbody &= NEW STRING(1)
  SELF.mailaltbody = ' '

  SELF.bodyContentType = 'text/plain'
  SELF.bodyCharset = 'UTF-8'
  
  SELF.boundary  = '001a11444b948e1888052560b246'
  SELF.boundary2 = '002a11444b948e1888052560b246'

  SELF.customHeaderLines &= NEW TCurlMailHeaderLines

TCurlMailClass.Destruct       PROCEDURE()
  CODE
  SELF.FreeRecipients()
  SELF.FreeAttachments()
  SELF.FreeCustomHeaders()

  DISPOSE(SELF.customHeaderLines)
  DISPOSE(SELF.attachments)
  DISPOSE(SELF.mailbody)
  DISPOSE(SELF.mailaltbody)
  DISPOSE(SELF.mailsubject)
  DISPOSE(SELF.mailto)
  
TCurlMailClass.Server         PROCEDURE(STRING pServer, LONG pPort, <STRING pHelo>)
  CODE
  IF NOT pHelo
    SELF.url = CLIP(pServer) &':'& pPort
  ELSE
    SELF.url = CLIP(pServer) &':'& pPort &'/'& pHelo
  END
  
TCurlMailClass.Account        PROCEDURE(STRING pUsername, STRING pPwd)
  CODE
  SELF.username = pUsername
  SELF.pwd = pPwd
  
TCurlMailClass.From           PROCEDURE(STRING pFrom)
  CODE
  SELF.mailfrom = CLIP(pFrom)
  
TCurlMailClass.AddRecipient   PROCEDURE(STRING pRecipient, <STRING pCC>, <STRING pBCC>)
  CODE
  IF pRecipient
    SELF.mailto.Append(ExtractMailAddress(pRecipient))
      
    IF SELF.ToStr
      SELF.ToStr = CLIP(SELF.ToStr) &';'
    END
    SELF.ToStr = CLIP(SELF.ToStr) & pRecipient
  END
  
  IF pCC
    SELF.mailto.Append(ExtractMailAddress(pCC))
  
    IF SELF.CCStr
      SELF.CCStr = CLIP(SELF.CCStr) &';'
    END
    SELF.CCStr = CLIP(SELF.CCStr) & pCC
  END
  
  IF pBCC
    SELF.mailto.Append(ExtractMailAddress(pBCC))
 
    IF SELF.BCCStr
      SELF.BCCStr = CLIP(SELF.BCCStr) &';'
    END
    SELF.BCCStr = CLIP(SELF.BCCStr) & pBCC
  END
  
TCurlMailClass.HasInlineAttachments   PROCEDURE()
qIndex                                  LONG, AUTO
  CODE
  LOOP qIndex = 1 TO RECORDS(SELF.attachments)
    GET(SELF.attachments, qIndex)
    IF SELF.attachments.inline
      RETURN TRUE
    END
  END
  RETURN FALSE

TCurlMailClass.AddAttachment  PROCEDURE(STRING pFilename, <STRING pContentType>, <STRING pCharset>)
trailingSlashPos                LONG, AUTO
  CODE
  CLEAR(SELF.attachments.filename)
  
  SELF.attachments.filename = CLIP(pFilename)
  
  trailingSlashPos = INSTRING('\', SELF.attachments.filename, -1, LEN(SELF.attachments.filename))
  SELF.attachments.shortname = SELF.attachments.filename[trailingSlashPos + 1 : LEN(SELF.attachments.filename)]
  
  IF pContentType
    SELF.attachments.contentType = CLIP(pContentType)
  ELSE
    SELF.attachments.contentType = GetMIMETypeFromFileExt(SELF.attachments.shortname)
  END
  
  SELF.attachments.charset = CLIP(pCharset)
  
  ADD(SELF.attachments)

TCurlMailClass.AddEmbeddedImage   PROCEDURE(STRING pFilename, STRING pCid, <STRING pName>)
trailingSlashPos                    LONG, AUTO
  CODE
  CLEAR(SELF.attachments.filename)
  
  SELF.attachments.filename = CLIP(pFilename)
  
  IF pName
    SELF.attachments.shortname = CLIP(pName)
  ELSE
    trailingSlashPos = INSTRING('\', SELF.attachments.filename, -1, LEN(SELF.attachments.filename))
    SELF.attachments.shortname = SELF.attachments.filename[trailingSlashPos + 1 : LEN(SELF.attachments.filename)]
  END
  
  SELF.attachments.contentType = GetMIMETypeFromFileExt(SELF.attachments.shortname)
  SELF.attachments.inline = TRUE
  SELF.attachments.cid = CLIP(pCid)
  
  ADD(SELF.attachments)

TCurlMailClass.Subject        PROCEDURE(STRING pSubject, BOOL pEncode = TRUE)
  CODE
  ASSERT(pSubject <> '')
  DISPOSE(SELF.mailsubject)
  IF pSubject <> ''
    SELF.mailsubject &= NEW STRING(LEN(CLIP(pSubject)))
    SELF.mailsubject = CLIP(pSubject)
  ELSE
    SELF.mailsubject &= NEW STRING(1)
    SELF.mailsubject = ' '
  END
  SELF.bEncodeSubject = pEncode

TCurlMailClass.AddCustomHeader    PROCEDURE(STRING pKey, STRING pValue)
  CODE
  SELF.customHeaderLines.Key = pKey
  SELF.customHeaderLines.Value = pValue
  ADD(SELF.customHeaderLines)
  
TCurlMailClass.Body           PROCEDURE(STRING pBody)
  CODE
  ASSERT(pBody <> '')
  IF pBody <> ''
    SELF.mailbody &= NEW STRING(LEN(CLIP(pBody)))
    SELF.mailbody = CLIP(pBody)
  ELSE
    SELF.mailbody &= NEW STRING(1)
    SELF.mailbody = ' '
  END
  
TCurlMailClass.AltBody        PROCEDURE(STRING pBody)
  CODE
  ASSERT(pBody <> '')
  DISPOSE(SELF.mailaltbody)
  IF pBody <> ''
    SELF.mailaltbody &= NEW STRING(LEN(CLIP(pBody)))
    SELF.mailaltbody = CLIP(pBody)
  ELSE
    SELF.mailaltbody &= NEW STRING(1)
    SELF.mailaltbody = ' '
  END

TCurlMailClass.ContentType    PROCEDURE(STRING pContentType)
  CODE
  SELF.bodyContentType = CLIP(pContentType)
  IF SELF.bodyContentType = 'text/plain' AND NOT SELF.bodyCharset
    SELF.bodyCharset = 'UTF-8'
  END

TCurlMailClass.Charset        PROCEDURE(STRING pCharset)
  CODE
  SELF.bodyCharset = CLIP(pCharset)

TCurlMailClass.SetOptions     PROCEDURE()
mailfrom                        CSTRING(256)
res                             CURLcode, AUTO
  CODE
  res = SELF.SetOpt(CURLOPT_URL, SELF.url);
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_UPLOAD, 1)
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetUserPwd(SELF.username, SELF.pwd)
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_USERAGENT, szUserAgent)
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_MAXREDIRS, 50)
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_TCP_KEEPALIVE, 1)
  IF res <> CURLE_OK
    RETURN res
  END
  
!  res = SELF.SetOpt(CURLOPT_MAIL_FROM, SELF.mailfrom)
  mailfrom = ExtractMailAddress(SELF.mailfrom)
  res = SELF.SetOpt(CURLOPT_MAIL_FROM, mailfrom)
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_MAIL_RCPT, SELF.mailto)
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_VERBOSE, 1)
  IF res <> CURLE_OK
    RETURN res
  END

  RETURN CURLE_OK

!with utf-8 encoding of from/to/cc/bcc/subject
!http://ncona.com/2011/06/using-utf-8-characters-on-an-e-mail-subject/
TCurlMailClass.CreateHeader   PROCEDURE(*TCurlMailData mail)
sname                           STRING(256)
qIndex                          LONG, AUTO
  CODE
  !MIME-Version
  mail.AddLine('MIME-Version: '& '1.0')

  !TO
  sname = ExtractName(SELF.ToStr)
  IF NOT sname
    mail.AddLine('To: '& CLIP(SELF.ToStr))
  ELSE
    mail.AddLine('To: '& EncodeHeaderPart(sname) &' <'& ExtractMailAddress(SELF.ToStr) &'>')
  END
  
  !CC
  IF SELF.CCStr
    sname = ExtractName(SELF.CCStr)
    IF NOT sname
      mail.AddLine('CC: '& CLIP(SELF.CCStr))
    ELSE
      mail.AddLine('CC: '& EncodeHeaderPart(sname) &' <'& ExtractMailAddress(SELF.CCStr) &'>')
    END
  END
  
  !BCC
  IF SELF.BCCStr
    sname = ExtractName(SELF.BCCStr)
    IF NOT sname
      mail.AddLine('BCC: '& CLIP(SELF.BCCStr))
    ELSE
      mail.AddLine('BCC: '& EncodeHeaderPart(sname) &' <'& ExtractMailAddress(SELF.BCCStr) &'>')
    END
  END

  !FROM
  sname = ExtractName(SELF.mailfrom)
  IF NOT sname
    mail.AddLine('From: '& CLIP(SELF.mailfrom))
  ELSE
    mail.AddLine('From: '& EncodeHeaderPart(sname) &' <'& ExtractMailAddress(SELF.mailfrom) &'>')
  END
 
  !SUBJECT
  IF SELF.bEncodeSubject
    mail.AddLine('Subject: '& EncodeHeaderPart(SELF.mailsubject))
  ELSE
    !- in Outlook, the subject is unreadable in UTF-8
    mail.AddLine('Subject: '& SELF.mailsubject)
  END
  
  !custom header lines
  LOOP qIndex = 1 TO RECORDS(SELF.customHeaderLines)
    GET(SELF.customHeaderLines, qIndex)
    mail.AddLine(CLIP(SELF.customHeaderLines.Key) &': '& CLIP(SELF.customHeaderLines.Value))
  END

TCurlMailClass.CreateBody     PROCEDURE(*TCurlMailData mail)
boundary                        STRING(28), AUTO
  CODE
  !set 'text/html' content type if there are wheter altBody or inline images
  IF SELF.mailaltbody OR SELF.HasInlineAttachments()
    SELF.ContentType('text/html')
  END

  IF RECORDS(SELF.attachments) > 0
    !attachments
    
    IF SELF.HasInlineAttachments()
      mail.AddLine('Content-Type: multipart/related; type="text/html"; boundary='& SELF.boundary)
    ELSE
      mail.AddLine('Content-Type: multipart/mixed; boundary='& SELF.boundary)
    END

    mail.AddLine()
    mail.AddLine('--'& SELF.boundary)
 
    boundary = SELF.boundary2
  ELSE
    boundary = SELF.boundary
  END

  IF SELF.mailaltbody = ''
    AddBody(mail, SELF.bodyContentType, SELF.bodyCharset, SELF.mailbody)
    mail.AddLine()
  ELSE
    !alternative contents

    mail.AddLine('Content-Type: multipart/alternative; boundary=' & boundary) 
    mail.AddLine()
  
    AddBody(mail, 'text/plain',          SELF.bodyCharset, SELF.mailaltbody, '--'& boundary)
    AddBody(mail, SELF.bodyContentType,  SELF.bodyCharset, SELF.mailbody,    '--'& boundary)
    
    mail.AddLine('--'& boundary &'--')  !end of last part
  END
  
TCurlMailClass.CreateAttachments  PROCEDURE(*TCurlMailData mail)
qIndex                              LONG, AUTO
sIndex                              LONG, AUTO
filedata                            &STRING
encdata                             &STRING
  CODE
  LOOP qIndex = 1 TO RECORDS(SELF.attachments)
    GET(SELF.attachments, qIndex)
    IF EXISTS(SELF.attachments.filename)    
      !attachment contents
      filedata &= curl::GetFileContents(SELF.attachments.filename)
      IF NOT filedata &= NULL
        !boundary to divide attachments from body or another attachment
        mail.AddLine('--'& SELF.boundary)
    
        mail.AddLine('Content-Type: '& SELF.attachments.contentType &''& CHOOSE(SELF.attachments.charset <> '', '; charset='& SELF.attachments.charset &'', '') &'; name="'& SELF.attachments.shortname &'"')
        IF SELF.attachments.inline
          mail.AddLine('Content-ID:<' & SELF.attachments.cid & '>')
        ELSE
          mail.AddLine('Content-Disposition: attachment; filename="'& SELF.attachments.shortname &'"')
        END
        mail.AddLine('Content-Transfer-Encoding: base64')
        mail.AddLine()

        encdata &= NEW STRING((LEN(filedata)/DECODED_BUF_SIZE + 1) * ENCODED_BUF_SIZE)
        encdata = Base64::Encode(filedata)
          
        !split base64 encoded string into 72 chars length parts
        LOOP sIndex = 1 TO (LEN(encdata) - 1) / ENCODED_BUF_SIZE
          mail.AddLine(SUB(encdata, (sIndex - 1) * ENCODED_BUF_SIZE + 1, ENCODED_BUF_SIZE))
        END

        DISPOSE(encdata)
        encdata &= NULL
        DISPOSE(filedata)
        filedata &= NULL
      END
    END
  END

TCurlMailClass.Send           PROCEDURE()
mail                            TCurlMailData
res                             CURLcode, AUTO
  CODE
  res = SELF.SetOptions()
  IF res <> CURLE_OK
    RETURN res
  END
  
  !header
  SELF.CreateHeader(mail)

  !body
  SELF.CreateBody(mail)
  
  !attachments
  SELF.CreateAttachments(mail)
  
  !pass mail to callback
  res = SELF.SetOpt(CURLOPT_READFUNCTION, curl::EmailRead)
  IF res <> CURLE_OK
    RETURN res
  END

  res = SELF.SetOpt(CURLOPT_READDATA, ADDRESS(mail))
  IF res <> CURLE_OK
    RETURN res
  END

  RETURN SELF.Perform()
  
TCurlMailClass.FreeRecipients PROCEDURE()
  CODE
  SELF.mailto.Free()
  CLEAR(SELF.ToStr)
  CLEAR(SELF.CCStr)
  CLEAR(SELF.BCCStr)
  
TCurlMailClass.FreeAttachments    PROCEDURE()
  CODE
  FREE(SELF.attachments)

TCurlMailClass.FreeCustomHeaders  PROCEDURE()
  CODE
  FREE(SELF.customHeaderLines)

TCurlMailClass.Reset          PROCEDURE()
  CODE
  SELF.FreeRecipients()
  SELF.FreeAttachments()
  SELF.FreeCustomHeaders()
  
  CLEAR(SELF.mailsubject)
  CLEAR(SELF.mailbody)
  CLEAR(SELF.mailaltbody)

  SELF.bodyContentType = 'text/plain'
  SELF.bodyCharset = 'UTF-8'

  PARENT.Reset()
  
!!!endregion
