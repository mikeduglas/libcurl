!** libcurl for Clarion v1.60
!** 14.09.2023
!** mikeduglas@yandex.com
!** mikeduglas66@gmail.com

  MEMBER

  INCLUDE('libcurl.inc'), ONCE

  MAP
    MODULE('Windows API')
      winapi::GetLocalTime(LONG lpSystemTime), PASCAL, NAME('GetLocalTime')
      winapi::GetTimeZoneInformation(LONG lpTimeZoneInformation), ULONG, PROC, PASCAL, NAME('GetTimeZoneInformation')
      winapi::MultiByteToWideChar(long CodePage, long dwFlags, long lpMultiByteStr, long cbMultiByte, |
        long lpWideCharStr, long cchWideCharStr),long,pascal,name('MultiByteToWideChar'),proc
      winapi::WideCharToMultiByte(long CodePage, long dwFlags, long lpWideCharStr, long cchWideChar, |
        long lpMultiByteStr, long cbMultiByte, long lpDefaultChar, |
        long lpUsedDefaultChar),long,pascal,name('WideCharToMultiByte'),proc
    END

    ConvertToCodePage(STRING pStr, SIGNED pInputCodePage, SIGNED pOutputCodePage), STRING, PRIVATE  ! convert ASCII to UTF8
    ConvertToCodePage(STRING pStr, SIGNED pOutputCodePage = CP_UTF8), STRING, PRIVATE  ! convert ASCII to UTF8
    GetMIMETypeFromFileExt(STRING pFilename), STRING, PRIVATE
    GetShortFileName(STRING pFilename), STRING, PRIVATE
    ExtractMailAddress(STRING pMailAddress), STRING, PRIVATE  !extracts 'user@gmail.com' from 'Joe Doe <user@gmail.com>'
    ExtractName(STRING pMailAddress), STRING, PRIVATE  !extracts 'Joe Doe' from 'Joe Doe <user@gmail.com>'
    EncodeHeaderPart(STRING pText), STRING  !subject, from, to, cc, bcc

    Base64::EncodeBlock(STRING in, *STRING out, LONG len), PRIVATE
    Base64::Encode(STRING input_buf), STRING, PRIVATE

    Header::DateTime(), STRING, PRIVATE  !Returns the current local date and time as string "Wed, 22 Aug 2018 12:32:25 +0300"
    Header::Recipient(STRING pRecipient), STRING, PRIVATE
    
    Body::Add(*TCurlMimeClass mime, curl_mimepart part, STRING pType, STRING pcharset, CONST *STRING pBody), PRIVATE
  END

!- MultiByteToWideChar/WideCharToMultiByte
  OMIT('**_CP_UTF16_**', CP_UTF16 = 0FFFFFFFFh)
CP_UTF16  EQUATE(0FFFFFFFFh)
!'**_CP_UTF16_**'

TCurlMailData                 CLASS, TYPE
mime                            &TCurlMimeClass, PRIVATE  !multipart/mixed
alt                             &TCurlMimeClass, PRIVATE  !multipart/alternative
rel                             &TCurlMimeClass, PRIVATE  !multipart/related
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

DECODED_BUF_SIZE              EQUATE(54)    !54 characters per line
ENCODED_BUF_SIZE              EQUATE(72)    !54 * 4 / 3

!!!region static functions
ConvertToCodePage             PROCEDURE(STRING pInput, LONG pInputCodePage, LONG pOutputCodePage)
szInput                         CSTRING(LEN(pInput) + 1)
UnicodeText                     CSTRING(LEN(pInput)*2+2)
DecodedText                     CSTRING(LEN(pInput)*2+2)
Len                             LONG, AUTO
  CODE
  IF NOT pInput
    RETURN ''
  END
  
  IF pInputCodepage <> CP_UTF16
    szInput = pInput
    !- get length of UnicodeText in characters
    Len = winapi::MultiByteToWideChar(pInputCodePage, 0, ADDRESS(szInput), -1, 0, 0)
    IF Len = 0
      curl::DebugInfo('MultiByteToWideChar failed, error '& winapi::GetLastError())
      RETURN ''
    END
    !- get UnicodeText terminated by <0,0>
    winapi::MultiByteToWideChar(pInputCodePage, 0, ADDRESS(szInput), -1, ADDRESS(UnicodeText), Len)
  ELSE
    Len = LEN(pInput) / 2
    UnicodeText = pInput & '<0,0>'
  END
  
  IF pOutputCodepage = CP_UTF16
    RETURN UnicodeText[1 : Len*2]
  END
  
  !- get length of DecodedText in bytes
  Len = winapi::WideCharToMultiByte(pOutputCodePage, 0, ADDRESS(UnicodeText), -1, 0, 0, 0, 0)
  IF Len = 0
    curl::DebugInfo('WideCharToMultiByte failed, error '& winapi::GetLastError())
    RETURN ''
  END
  winapi::WideCharToMultiByte(pOutputCodePage, 0, ADDRESS(UnicodeText), -1, ADDRESS(DecodedText), Len, 0, 0)
  RETURN DecodedText

ConvertToCodePage             PROCEDURE(STRING pStr, SIGNED pOutputCodePage = CP_UTF8)
  CODE
  RETURN ConvertToCodePage(pStr, CP_ACP, pOutputCodePage)

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

GetShortFileName              PROCEDURE(STRING pFilename)
trailingSlashPos                LONG, AUTO
  CODE
  trailingSlashPos = INSTRING('\', pFilename, -1, LEN(CLIP(pFilename)))
  IF NOT trailingSlashPos
    trailingSlashPos = INSTRING('/', pFilename, -1, LEN(CLIP(pFilename)))
  END
  
  RETURN pFilename[trailingSlashPos + 1 : LEN(CLIP(pFilename))]
  
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

Body::Add                     PROCEDURE(*TCurlMimeClass mime, curl_mimepart part, STRING pType, STRING pcharset, CONST *STRING pBody)
  CODE
  !data
  mime.SetData(part, ConvertToCodePage(pBody))
  !Content-Type, charset
  mime.SetType(part, CLIP(pType) & CHOOSE(pcharset <> '', '; charset='& pcharset &'', ''))
  !Encoding
  mime.SetEncoder(part, 'base64')

Header::DateTime              PROCEDURE()
TSYSTEMTYPE                     GROUP, TYPE
wYear                             SHORT
wMonth                            SHORT
wDayOfWeek                        SHORT
wDay                              SHORT
wHour                             SHORT
wMinute                           SHORT
wSecond                           SHORT
wMilliseconds                     SHORT
                                END
TTIME_ZONE_INFORMATION          GROUP, TYPE
Bias                              LONG
StandardName                      STRING(64)
StandardDate                      LIKE(TSYSTEMTYPE)
StandardBias                      LONG
DaylightName                      STRING(64)
DaylightDate                      LIKE(TSYSTEMTYPE)
DaylightBias                      LONG
                                END

lt                              LIKE(TSYSTEMTYPE), AUTO
tz                              LIKE(TTIME_ZONE_INFORMATION), AUTO

weekDay                         STRING(3), AUTO
monthName                       STRING(3), AUTO
timezone                        STRING(5), AUTO
  CODE
  !Date and Time Specification
  !https://tools.ietf.org/html/rfc2822#section-3.3
  
  !- read local time and time zne info
  winapi::GetLocalTime(ADDRESS(lt))
  winapi::GetTimeZoneInformation(ADDRESS(tz))
  
  !- return date time in format of "Wed, 22 Aug 2018 12:32:25 +0300"
  
  EXECUTE lt.wDayOfWeek + 1 
    weekDay = 'Sun'
    weekDay = 'Mon'
    weekDay = 'Tue'
    weekDay = 'Wed'
    weekDay = 'Thu'
    weekDay = 'Fri'
    weekDay = 'Sat'
  END
  
  EXECUTE lt.wMonth
    monthName = 'Jan'
    monthName = 'Feb'
    monthName = 'Mar'
    monthName = 'Apr'
    monthName = 'May'
    monthName = 'Jun'
    monthName = 'Jul'
    monthName = 'Aug'
    monthName = 'Sep'
    monthName = 'Oct'
    monthName = 'Nov'
    monthName = 'Dec'
  END
  
  !- The zone specifies the offset from Coordinated Universal Time (UTC).
  !- The "+" or "-" indicates whether the time-of-day is ahead of (i.e., east of) or behind (i.e., west of) Universal Time.
  !- The first two digits indicate the number of hours difference from Universal Time, 
  !- and the last two digits indicate the number of minutes difference from Universal Time.
  timezone = CHOOSE(tz.Bias < 0, '+', '-') & FORMAT(ABS(tz.Bias) / 60, @n02) & FORMAT(ABS(tz.Bias) % 60, @n02)
  
  RETURN weekDay &', '& | 
    lt.wDay &' '& monthName &' '& lt.wYear &' '& | 
    FORMAT(lt.wHour, @n02) &':'& FORMAT(lt.wMinute, @n02) &':'& FORMAT(lt.wSecond, @n02) &' '& | 
    timezone
  
Header::Recipient             PROCEDURE(STRING pRecipient)
sname                           STRING(256), AUTO
  CODE
  sname = ExtractName(pRecipient)
  RETURN CHOOSE(sname <> '', EncodeHeaderPart(sname) &' <'& ExtractMailAddress(pRecipient) &'>', CLIP(pRecipient))

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
  
TCurlMailClass.Init           PROCEDURE()
  CODE
  PARENT.Init()
  SELF.SetDefaultProtocol('smtp')

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
    SELF.mailto.AppendData(ExtractMailAddress(pRecipient))
      
    IF SELF.ToStr
      SELF.ToStr = CLIP(SELF.ToStr) &';'
    END
    SELF.ToStr = CLIP(SELF.ToStr) & pRecipient
  END
  
  IF pCC
    SELF.mailto.AppendData(ExtractMailAddress(pCC))
  
    IF SELF.CCStr
      SELF.CCStr = CLIP(SELF.CCStr) &';'
    END
    SELF.CCStr = CLIP(SELF.CCStr) & pCC
  END
  
  IF pBCC
    SELF.mailto.AppendData(ExtractMailAddress(pBCC))
 
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
  CODE
  CLEAR(SELF.attachments)
  SELF.attachments.filename = CLIP(pFilename)
  SELF.attachments.shortname = GetShortFileName(pFilename)
  
  IF pContentType
    SELF.attachments.contentType = CLIP(pContentType)
  ELSE
    SELF.attachments.contentType = GetMIMETypeFromFileExt(SELF.attachments.shortname)
  END
  
  SELF.attachments.charset = CLIP(pCharset)
  
  ADD(SELF.attachments)

TCurlMailClass.AddEmbeddedImage   PROCEDURE(STRING pFilename, STRING pCid, <STRING pName>)
  CODE
  CLEAR(SELF.attachments)
  
  SELF.attachments.filename = CLIP(pFilename)
  
  IF pName
    SELF.attachments.shortname = CLIP(pName)
  ELSE
    SELF.attachments.shortname = GetShortFileName(pFilename)
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
!  IF SELF.username
!    res = SELF.SetOpt(CURLOPT_USERNAME, SELF.username)
!    IF res <> CURLE_OK
!      RETURN res
!    END
!  END
!  IF SELF.pwd
!    res = SELF.SetOpt(CURLOPT_PASSWORD, SELF.pwd)
!    IF res <> CURLE_OK
!      RETURN res
!    END
!  END
  
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
qIndex                          LONG, AUTO
  CODE
  !MIME-Version
  SELF.AddHttpHeader('MIME-Version: '& '1.0')

  !DATE
  SELF.AddHttpHeader('Date: '& Header::DateTime())

  !TO
  SELF.AddHttpHeader('To: '& Header::Recipient(SELF.ToStr))
  
  !CC
  IF SELF.CCStr
    SELF.AddHttpHeader('CC: '& Header::Recipient(SELF.CCStr))
  END
  
  !BCC
  IF SELF.BCCStr
    SELF.AddHttpHeader('BCC: '& Header::Recipient(SELF.BCCStr))
  END

  !FROM
  SELF.AddHttpHeader('From: '& Header::Recipient(SELF.mailfrom))
 
  !SUBJECT
  IF SELF.bEncodeSubject
    SELF.AddHttpHeader('Subject: '& EncodeHeaderPart(SELF.mailsubject))
  ELSE
    !- in Outlook, the subject is unreadable in UTF-8
    SELF.AddHttpHeader('Subject: '& SELF.mailsubject)
  END
  
  !custom header lines
  LOOP qIndex = 1 TO RECORDS(SELF.customHeaderLines)
    GET(SELF.customHeaderLines, qIndex)
    SELF.AddHttpHeader(CLIP(SELF.customHeaderLines.Key) &': '& CLIP(SELF.customHeaderLines.Value))
  END
  
  SELF.SetHttpHeaders()

TCurlMailClass.CreateBody     PROCEDURE(*TCurlMailData mail)
part                            curl_mimepart, AUTO
mimeHeaders                     TCurlSList
  CODE
  !- set 'text/html' content type if there are either altBody or inline images
  IF SELF.mailaltbody OR SELF.HasInlineAttachments()
    SELF.ContentType('text/html')
  END

  !- multipart/alternative
  part = mail.mime.AddPart()
  mail.mime.SetSubparts(part, mail.alt)
  mail.alt.SetType(part, 'multipart/alternative')
  mimeHeaders.AppendData('Content-Disposition: inline')
  mail.alt.SetHeaders(part, mimeHeaders, TRUE) !dispose slist when mime will be destoyed
  mimeHeaders.AssignPtr(0)  !don't dispose slist right now

  !- Text body
  IF SELF.mailaltbody
    part = mail.alt.AddPart()
    Body::Add(mail.alt, part, 'text/plain', SELF.bodyCharset, SELF.mailaltbody)
  END
  
  !- multipart/related for Html + embedded images
  part = mail.alt.AddPart()
  mail.alt.SetSubparts(part, mail.rel)
  mail.rel.SetType(part, 'multipart/related; type="'& SELF.bodyContentType &'"')

  !- Html body
  part = mail.rel.AddPart()
  Body::Add(mail.rel, part, SELF.bodyContentType, SELF.bodyCharset, SELF.mailbody)

TCurlMailClass.CreateAttachments  PROCEDURE(*TCurlMailData mail)
qIndex                              LONG, AUTO
part                                curl_mimepart, AUTO
fileHeaders                         TCurlSList
filedata                            &STRING
  CODE
  LOOP qIndex = 1 TO RECORDS(SELF.attachments)
    GET(SELF.attachments, qIndex)
    IF EXISTS(SELF.attachments.filename)
      IF NOT SELF.attachments.inline
        !- real attachments come into multipart/mixed
        part = mail.mime.AddPart()
        mail.mime.SetFileData(part, SELF.attachments.filename)
        mail.mime.SetName(part, SELF.attachments.shortname)
        mail.mime.SetType(part, SELF.attachments.contentType & CHOOSE(SELF.attachments.charset <> '', '; charset='& SELF.attachments.charset &'', ''))
        mail.mime.SetEncoder(part, 'base64')
      ELSE
        !- embedded images come into multipart/related
        part = mail.rel.AddPart()

        !- file as binary data
        filedata &= curl::GetFileContents(SELF.attachments.filename)
        IF LEN(filedata) <= 16386
          !- small files (size <= 16K)
          mail.rel.SetData(part, filedata)
          DISPOSE(filedata)
        ELSE
          !- big files (size > 16K), use callback to read data
          mail.rel.SetDataCB(part, filedata, TRUE)  !filedata will be DISPOSEd in curl::MimeFree callback
        END
        
        !- set part's headers
        fileHeaders.AppendData('Content-Disposition: render')
        fileHeaders.AppendData('Content-ID:<' & SELF.attachments.cid & '>')
        mail.rel.SetHeaders(part, fileHeaders, TRUE) !inner slist will be destroyed by mime itself
        fileHeaders.AssignPtr(0)  !next Append will create new slist

        !- "name" must be set here in SetType (Content-Type). SetName() puts file name into Content-Disposition instead.
        mail.rel.SetType(part, SELF.attachments.contentType &''& CHOOSE(SELF.attachments.charset <> '', '; charset='& SELF.attachments.charset &'', '') &'; name="'& SELF.attachments.shortname &'"')
        
        !- base64 encoder
        mail.rel.SetEncoder(part, 'base64')
      END
    ELSE
      curl::DebugInfo('File '& SELF.attachments.filename &' not found.')
    END
  END

TCurlMailClass.Send           PROCEDURE()
mail                            TCurlMailData
mime                            TCurlMimeClass
alt                             TCurlMimeClass
rel                             TCurlMimeClass
res                             CURLcode, AUTO
  CODE
  !create mime
  mime.Init(SELF)
  alt.Init(SELF)
  rel.Init(SELF)
  mail.mime &= mime
  mail.alt &= alt
  mail.rel &= rel
  
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
  
  !mime post
  SELF.SetMimePost(mime)

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
