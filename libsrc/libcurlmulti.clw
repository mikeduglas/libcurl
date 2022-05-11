!** libcurl for Clarion v1.54
!** 11.05.2022
!** mikeduglas@yandex.com
!** mikeduglas66@gmail.com

  MEMBER

  INCLUDE('libcurl.inc'), ONCE

  MAP
    MODULE('libcurl API')
      curl_multi_init(), CURLM, C, NAME('curl_multi_init')
      curl_multi_add_handle(CURLM multi_handle, CURL curl_handle), CURLMcode, PROC, C, NAME('curl_multi_add_handle')
      curl_multi_remove_handle(CURLM multi_handle, CURL curl_handle), CURLMcode, PROC, C, NAME('curl_multi_remove_handle')
      curl_multi_wait(CURLM multi_handle, LONG extra_fds, UNSIGNED extra_nfds, LONG timeout_ms, *LONG ret), CURLMcode, PROC, C, NAME('curl_multi_wait')
      curl_multi_wait(CURLM multi_handle, LONG extra_fds, UNSIGNED extra_nfds, LONG timeout_ms, LONG retAddr), CURLMcode, PROC, C, NAME('curl_multi_wait')
      curl_multi_perform(CURLM multi_handle, *LONG running_handles), CURLMcode, C, NAME('curl_multi_perform')
      curl_multi_cleanup(CURLM multi_handle), CURLMcode, PROC, C, NAME('curl_multi_cleanup')
      curl_multi_info_read(CURLM multi_handle, *LONG msgs_in_queue), LONG, C, NAME('curl_multi_info_read')
      curl_multi_strerror(CURLMcode errcode), *CSTRING, C, RAW, NAME('curl_multi_strerror')
      curl_multi_timeout(CURLM multi_handle, *LONG milliseconds), CURLMcode, PROC, C, NAME('curl_multi_timeout')
      curl_multi_setopt(CURLM multi_handle, CURLMoption option, LONG param), CURLMcode, PROC, C, NAME('curl_multi_setopt')
      curl_multi_setopt(CURLM multi_handle, CURLMoption option, *CSTRING param), CURLMcode, PROC, C, NAME('curl_multi_setopt')
    END

    ReportError(CURLMcode errcode), PRIVATE
  END
  
curlm::StrError               PROCEDURE(CURLMcode errcode)
  CODE
  RETURN curl_multi_strerror(errcode)

ReportError                   PROCEDURE(CURLMcode errcode)
  CODE
  IF errcode <> CURLM_OK
    curl::DebugInfo('[multi] Error: '& curlm::StrError(errcode) &' ('& errcode &')')
  END
  
TCurlMultiClass.Construct     PROCEDURE()
  CODE
  SELF.handle = 0
  SELF.list &= NEW TCurlInstances
  
TCurlMultiClass.Destruct      PROCEDURE()
ndx                             LONG, AUTO
  CODE
  LOOP ndx = RECORDS(SELF.list) TO 1 BY -1
    GET(SELF.list, ndx)
    SELF.list.ce.Cleanup()
    DISPOSE(SELF.list.ce)
    SELF.list.ce &= NULL
    PUT(SELF.list)
  END
  
  FREE(SELF.list)
  DISPOSE(SELF.list)
  
TCurlMultiClass.Init          PROCEDURE()
  CODE
  SELF.handle = curl_multi_init()
  
TCurlMultiClass.Cleanup       PROCEDURE()
  CODE
  IF SELF.handle
    SELF.lasterr = curl_multi_cleanup(SELF.handle)
    ReportError(SELF.lasterr)
    SELF.handle = 0
  END
  
TCurlMultiClass.GetHandle     PROCEDURE()
  CODE
  RETURN SELF.handle
  
TCurlMultiClass.SetOpt        PROCEDURE(CURLMoption option, LONG param)
  CODE
  SELF.lasterr = curl_multi_setopt(SELF.handle, option, param)
  ReportError(SELF.lasterr)
  RETURN SELF.lasterr

TCurlMultiClass.SetOpt        PROCEDURE(CURLMoption option, *STRING param)
aparamAddr                      LONG
aparam                          ASTRING, OVER(aparamAddr)
szparam                         &CSTRING
  CODE
  aparam  = CLIP(param) &'<0>'
  szparam &= (aparamAddr)
  RETURN SELF.SetOpt(option, szparam)
  
TCurlMultiClass.SetOpt        PROCEDURE(CURLMoption option, *CSTRING param)
  CODE
  SELF.lasterr = curl_multi_setopt(SELF.handle, option, param)
  ReportError(SELF.lasterr)
  RETURN SELF.lasterr

TCurlMultiClass.AddCurl       PROCEDURE()
ce                              &TCurlClass
  CODE
  ce &= NEW TCurlClass
  ce.Init()
  
  CLEAR(SELF.list)
  SELF.list.ce &= ce
  SELF.list.eh = ce.GetHandle()
  
  SELF.lasterr = curl_multi_add_handle(SELF.handle, SELF.list.eh)
  ReportError(SELF.lasterr)
  IF SELF.lasterr = CURLM_OK
    ADD(SELF.list)
  ELSE
    ce.Cleanup()
    DISPOSE(ce)
    ce &= NULL
    CLEAR(SELF.list)
  END
  
  RETURN ce
  
TCurlMultiClass.Remove        PROCEDURE(CURL eh)
ce                              &TCurlClass
  CODE
  ce &= SELF.Find(eh)
  IF NOT ce &= NULL
    SELF.lasterr = curl_multi_remove_handle(SELF.handle, eh)
    ReportError(SELF.lasterr)

    ce.Cleanup()
    DISPOSE(ce)
    
    SELF.list.ce &= NULL
    DELETE(SELF.list)
  ELSE
    SELF.lasterr = CURLM_BAD_HANDLE
  END
  
  RETURN SELF.lasterr
  
TCurlMultiClass.Perform       PROCEDURE()
handles                         LONG(-1)
  CODE
  SELF.lasterr = curl_multi_perform(SELF.handle, handles)
  ReportError(SELF.lasterr)
  IF SELF.lasterr = CURLM_OK
    RETURN handles
  END
  
  RETURN 0
  
TCurlMultiClass.Wait          PROCEDURE(LONG timeout_ms)
  CODE
  SELF.lasterr = curl_multi_wait(SELF.handle, 0, 0, timeout_ms, 0)
  ReportError(SELF.lasterr)
  RETURN SELF.lasterr
  
TCurlMultiClass.ReadInfo      PROCEDURE(*TCURLMsg pMsg, <*LONG msgs_in_queue>)
amsg                            LONG, AUTO
refmsg                          &TCURLMsg
nmessages                       LONG(-1)
  CODE
  CLEAR(pMsg)
  
  amsg = curl_multi_info_read(SELF.handle, nmessages)
  IF amsg = 0
    RETURN FALSE
  END
  
  refmsg &= (amsg)
  IF NOT OMITTED(msgs_in_queue)
    msgs_in_queue = nmessages
  END
  
  IF refmsg &= NULL
    RETURN FALSE
  END
  
  pMsg.easy_handle = refmsg.easy_handle
  pMsg.msg = refmsg.msg
  pMsg.result = refmsg.result
  
  RETURN TRUE
  
TCurlMultiClass.Find          PROCEDURE(CURL eh)
  CODE
  SELF.list.eh = eh
  GET(SELF.list, SELF.list.eh)
  IF NOT ERRORCODE()
    RETURN SELF.list.ce
  ELSE
    RETURN NULL
  END

TCurlMultiClass.StrError      PROCEDURE(CURLMcode errcode)
  CODE
  RETURN curl_multi_strerror(errcode)
