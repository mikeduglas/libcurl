  PROGRAM
  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')

  MAP
    init_q()
    kill_q()
    add_url_to_q(STRING pUrl)
    extract_name(STRING pUrl), STRING
    add_transfer(TCurlMultiClass cm, LONG i)
    add_output(STRING pText)

    INCLUDE('cwutil.inc')
  END

multi                         &TCurlMultiClass

q                             QUEUE
url                             STRING(64)
fs                              &TCurlFileStruct
                              END

html_folder                   STRING('.\html')

MAX_PARALLEL                  EQUATE(10)    !number of simultaneous transfers
NUM_URLS                      LONG, AUTO    !number of urls in the queue
transfers                     LONG, AUTO    !counter

Window                        WINDOW('10-at-a-time example'),AT(,,363,241),CENTER,GRAY,SYSTEM, |
                                FONT('Segoe UI',9)
                                BUTTON('Start'),AT(227,214,53),USE(?bStart)
                                BUTTON('Exit'),AT(302,214,53),USE(?bExit)
                                TEXT,AT(9,13,345,191),USE(?txtOutput),HVSCROLL,READONLY
                              END
  CODE
  !- fill queue
  init_q()
  NUM_URLS = RECORDS(q)
    
  !- create folder to store downloaded htmls
  CreateDirectory(html_folder)

  curl::GlobalInit(CURL_GLOBAL_ALL)
  
  multi &= NEW TCurlMultiClass
  multi.Init()
  
  !- Limit the amount of simultaneous connections curl should allow:
  multi.SetOpt(CURLMOPT_MAXCONNECTS, MAX_PARALLEL)
    
  !- add first 10 urls
  LOOP transfers = 1 TO MAX_PARALLEL
    add_transfer(multi, transfers)
  END
  !- at this point transfers = 11 (MAX_PARALLEL + 1)

  OPEN(Window)
  ACCEPT
    CASE ACCEPTED()
    OF ?bStart
      DISABLE(?bStart)
      SETCURSOR(CURSOR:Wait)
      DO Routine::Transfer
      SETCURSOR()
    OF ?bExit
      POST(EVENT:CloseWindow)
    END
  END
  
  kill_q()
  multi.Cleanup()
  DISPOSE(multi)
  curl::GlobalCleanup()
  
Routine::Transfer             ROUTINE
  DATA
still_alive                   LONG, AUTO
cmsg                          LIKE(TCURLMsg)
easy                          &TCurlClass
httpRespCode                  LONG, AUTO
qIndex                        LONG, AUTO
  CODE
  add_output('TRANSFER STARTED...')
  
  LOOP
    !- Perform returns a number of handles that still transfer data
    still_alive = multi.Perform()  

    LOOP WHILE multi.ReadInfo(cmsg)
      IF cmsg.msg = CURLMSG_DONE
        !- find current curl instance
        easy &= multi.Find(cmsg.easy_handle)
        IF NOT easy &= NULL
          !- get index of queue item bound to this curl
          easy.GetInfo(CURLINFO_PRIVATE, qIndex)
          !- get queue item
          GET(q, qIndex)
          IF NOT ERRORCODE()
            IF cmsg.result = CURLE_OK
              !- get HTTP response code
              httpRespCode = easy.GetResponseCode()
              IF httpRespCode = 200 !- OK
                add_output('<<'& CLIP(q.url) &'> DONE.')
              ELSE                  !- not OK
                !- if respcode <> 200 (OK), notify a user.
                add_output('<<'& CLIP(q.url) &'> DONE. Response code '& httpRespCode)
              END
            ELSE
              add_output('<<'& CLIP(q.url) &'> ERROR: '& curl::StrError(cmsg.result))
            END
          END
          
          !- remove completed transfer
          multi.Remove(cmsg.easy_handle)
        END
      ELSE
        add_output('ReadInfo Error: '& cmsg.msg)
      END
      
      IF transfers <= NUM_URLS
        !- add next transfer
        add_transfer(multi, transfers)
        transfers += 1
      END
    END
    
    IF still_alive
      multi.Wait(1000)
    END
    
  WHILE (still_alive <> 0) OR (transfers <= NUM_URLS)
  
  add_output('TRANSFER COMPLETE! Downloaded files are in "'& LONGPATH(html_folder) &'"')

init_q                        PROCEDURE()
  CODE
  add_url_to_q('https://www.microsoft.com') !
  add_url_to_q('https://www.google.com')
  add_url_to_q('https://www.yahoo.com') !
  add_url_to_q('https://www.ibm.com')
  add_url_to_q('https://www.mysql.com') !
  add_url_to_q('https://www.oracle.com')
  add_url_to_q('https://www.ripe.net')  !
  add_url_to_q('https://www.iana.org')      !
  add_url_to_q('https://www.amazon.com')      !
  add_url_to_q('https://www.netcraft.com')  !
  add_url_to_q('https://www.heise.de')  !
  add_url_to_q('https://www.chip.de') !
  add_url_to_q('https://www.ca.com')  !
  add_url_to_q('https://www.cnet.com')  !
  add_url_to_q('https://www.mozilla.org')
  add_url_to_q('https://www.cnn.com')
  add_url_to_q('https://www.wikipedia.org') !
  add_url_to_q('https://www.dell.com')  !
  add_url_to_q('https://www.hp.com')  !
  add_url_to_q('https://www.cert.org')
  add_url_to_q('https://www.mit.edu') !
  add_url_to_q('https://www.nist.gov')  !
  add_url_to_q('https://www.ebay.com')  !
  add_url_to_q('https://www.playstation.com')
  add_url_to_q('https://www.uefa.com')    !
  add_url_to_q('https://www.ieee.org')  !
  add_url_to_q('https://www.apple.com') !
  add_url_to_q('https://www.symantec.com')  !
  add_url_to_q('https://www.zdnet.com') !
  add_url_to_q('https://www.fujitsu.com/global/') !
  add_url_to_q('https://www.supermicro.com')  !
  add_url_to_q('https://www.hotmail.com')
  add_url_to_q('https://www.ietf.org')  !
  add_url_to_q('https://www.bbc.co.uk') !
  add_url_to_q('https://www.foxnews.com') !
  add_url_to_q('https://www.msn.com') !
  add_url_to_q('https://www.wired.com') !
  add_url_to_q('https://www.sky.com') !
  add_url_to_q('https://www.usatoday.com')  !
  add_url_to_q('https://www.cbs.com') !
  add_url_to_q('https://www.nbc.com') !
  add_url_to_q('https://slashdot.org')  !
  add_url_to_q('https://www.informationweek.com') !
  add_url_to_q('https://apache.org')  !
  add_url_to_q('https://www.un.org')
  
kill_q                        PROCEDURE()
ndx                             LONG, AUTO
  CODE
  LOOP ndx = RECORDS(q) TO 1 BY -1
    GET(q, ndx)
    DISPOSE(q.fs)
    q.fs &= NULL
    PUT(q)
  END
  
  FREE(q)
  
add_url_to_q                  PROCEDURE(STRING pUrl)
  CODE
  CLEAR(q)
  q.url = pUrl
  q.fs &= NEW TCurlFileStruct
  !- set file name as xxx.com.htm
  q.fs.Init(html_folder &'\'& extract_name(pUrl) &'.htm')
  ADD(q)

!- extract a site name from full url (removes https://, www, etc)
extract_name                  PROCEDURE(STRING pUrl)
startpos                        UNSIGNED, AUTO
endpos                          UNSIGNED, AUTO
  CODE
  startpos = INSTRING('://', pUrl, 1, 1)
  IF startpos
    startpos += 3
  ELSE
    startpos = 1
  END
  
  IF SUB(pUrl, startpos, 4) = 'www.'
    startpos += 4
  END
  
  endpos = INSTRING('/', pUrl, 1, startpos)
  IF endpos
    endpos -= 1
  ELSE
    endpos = LEN(CLIP(pUrl))
  END

  RETURN pUrl[startpos : endpos]
  
add_transfer                  PROCEDURE(TCurlMultiClass cm, LONG i)
ce                              &TCurlClass
  CODE
  GET(q, i)
  IF NOT ERRORCODE()
    ce &= cm.Add()
    IF NOT ce &= NULL
      ce.SetUrl(q.url)
      ce.SetSSLVerifyHost(FALSE)
      ce.SetSSLVerifyPeer(FALSE)
      ce.SetOpt(CURLOPT_PRIVATE, i)
      ce.SetWriteCallback(curl::FileWrite, ADDRESS(q.fs))
!      ce.SetDebugCallback(curl::DebugCallback)
    END
  END
  
add_output                    PROCEDURE(STRING pText)
  CODE
  ?txtOutput{PROP:Text} = ?txtOutput{PROP:Text} & pText &'<13,10>'
  SELECT(?txtOutput, LEN(?txtOutput{PROP:Text}))
  DISPLAY(?txtOutput)