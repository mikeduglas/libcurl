  PROGRAM

  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')

  MAP
  END

curl                          TCurlMailClass
res                           CURLcode

account                       CSTRING('pop3s://pop.gmail.com:995/')
id                            LONG, AUTO  !email ID

  CODE
  
  curl.Init()

  curl.SetUserPwd('user@gmail.com', 'password')

  curl.UseSSL(CURLUSESSL_ALL)
  curl.SetSSLVerifyPeer(FALSE)
  curl.SetSSLVerifyHost(FALSE)
 
  !some servers needs this validation
  curl.SetOpt(CURLOPT_USERAGENT, 'libcurl-agent/1.0')

  !-- list of emails
  curl.SendRequest(account, , 'gmail_list.txt')
  IF res = CURLE_OK
    MESSAGE('Email List in file gmail_list.txt', 'ReceiveMail', ICON:Asterisk)
  ELSE
    MESSAGE('Email List reading failed: '& curl.StrError(res), 'ReceiveMail', ICON:Exclamation)
  END

  !-- read email with ID=1
  id = 1
  res = curl.SendRequest(account & id, , 'gmail_'& id &'.txt')
  IF res = CURLE_OK
    MESSAGE('Email #'& id &' received, file gmail_'& id &'.txt', 'ReceiveMail', ICON:Asterisk)
  ELSE
    MESSAGE('Email #'& id &' failed: '& curl.StrError(res), 'ReceiveMail', ICON:Exclamation)
  END
