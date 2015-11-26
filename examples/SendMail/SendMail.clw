  PROGRAM

  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')

  MAP
  END

curl                          TCurlMailClass
res                           CURLcode

EMailProvider                 STRING(20)

  CODE

  curl.Init()

  
  EMailProvider = 'gmail'
!  EMailProvider = 'yandex'
  
  CASE LOWER(EMailProvider)
  OF 'gmail'

    curl.Server('smtp.gmail.com', 587)
    curl.Account('username@gmail.com', '12345')
    curl.From('username@gmail.com')
    curl.AddRecipient('username@yandex.ru') !to/cc/bcc

  OF 'yandex'

    curl.Server('smtp.yandex.ru', 25)
    curl.Account('username@yandex.ru', '54321')
    curl.From('username@yandex.ru')
    curl.AddRecipient('username@gmail.com') !to/cc/bcc

  END
  
  curl.UseSSL(CURLUSESSL_ALL)
  curl.SetSSLVerifyPeer(FALSE)  !curl --insecure

  curl.Subject('Test email')
  curl.Body('Test email using libcurl')
  curl.AddAttachment('.\doc\how-to.txt')
  curl.AddAttachment('c:\images\logo.jpg')
  
  !connection timeout (seconds)
  curl.SetOpt(CURLOPT_CONNECTTIMEOUT, 30)

  res = curl.Send()
  IF res = CURLE_OK
    MESSAGE('Email sent', 'SendMail', ICON:Asterisk)
  ELSE
    MESSAGE('Send failed: '& curl.StrError(res), 'SendMail', ICON:Exclamation)
  END
