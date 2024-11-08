!** libcurl for Clarion v1.66.0
!** 11.08.2024
!** mikeduglas@yandex.com
!** mikeduglas66@gmail.com

  MEMBER

  INCLUDE('libcurl.inc'), ONCE

  MAP
    MODULE('LIBCURL WEBSOCKET API')
!/*
! * NAME curl_ws_recv()
! *
! * DESCRIPTION
! *
! * Receives data from the websocket connection. Use after successful
! * curl_easy_perform() with CURLOPT_CONNECT_ONLY option.
! */
!CURL_EXTERN CURLcode curl_ws_recv(CURL *curl, void *buffer, size_t buflen,
!                                  size_t *recv,
!                                  struct curl_ws_frame **metap);
!      curl_ws_recv(CURL curl, LONG buffer, size_t buflen, *size_t recv, *curl_ws_frame metap), CURLcode, C, RAW, NAME('curl_ws_recv')
      curl_ws_recv(CURL curl, LONG buffer, size_t buflen, *size_t recv, *LONG metap), CURLcode, C, RAW, NAME('curl_ws_recv')

!/*
! * NAME curl_easy_send()
! *
! * DESCRIPTION
! *
! * Sends data over the websocket connection. Use after successful
! * curl_easy_perform() with CURLOPT_CONNECT_ONLY option.
! */
!CURL_EXTERN CURLcode curl_ws_send(CURL *curl, const void *buffer,
!                                  size_t buflen, size_t *sent,
!                                  curl_off_t framesize,
!                                  unsigned int sendflags);
      curl_ws_send(CURL curl, LONG buffer, size_t buflen, *size_t sent, LONG fragsizeLo, LONG fragsizeHi, UNSIGNED sendflags), CURLcode, C, NAME('curl_ws_send')
      curl_ws_send(CURL curl, LONG buffer, size_t buflen, *size_t sent, curl_off_t fragsize, UNSIGNED sendflags), CURLcode, C, RAW, NAME('curl_ws_send')


!CURL_EXTERN   struct curl_ws_frame *curl_ws_meta(CURL *curl);
      curl_ws_meta(CURL curl), LONG, CURLcode, C, NAME('curl_ws_meta')
    END

!    curl::ws:WriteCB(LONG buffer, size_t bufsize, size_t nmemb, LONG pUserData), size_t, C
  END

!The current implementation only supports frame sizes up to a max (64K right now). 
!This is because the API delivers full frames and it then cannot manage the full 2^63 bytes size.
MAX_FRAME_SIZE                EQUATE(64000)
MAX_CHUNK_SIZE                EQUATE(126)

!curl::ws:WriteCB              PROCEDURE(LONG buffer, size_t bufsize, size_t nmemb, LONG pUserData)
!bytesReceived                   size_t, AUTO
!ws                              &TCurlWebsocketClass
!sbuffer                         STRING(bufsize * nmemb)
!rc                              BOOL
!  CODE
!  IF pUserData = 0
!    RETURN -1
!  END
!
!  ws &= (pUserData)
!  
!  bytesReceived = bufsize * nmemb
!  curl::memcpy(ADDRESS(sbuffer), buffer, bytesReceived)
!!  ws.ds.Cat(sbuffer)
!  curl::DebugInfo('curl::ws:WriteCB('& sbuffer &')')
!  
!  RETURN bytesReceived

!!!region TCurlWebsocketClass
TCurlWebsocketClass.Construct PROCEDURE()
  CODE
  SELF.connRes = CURLE_COULDNT_CONNECT
!  SELF.ds &= NewDynStr()
  
TCurlWebsocketClass.Destruct  PROCEDURE()
  CODE
  SELF.Disconnect()
!  SELF.ds.Kill()
!  DisposeDynStr(SELF.ds)

TCurlWebsocketClass.Connect   PROCEDURE(STRING pUrl)
  CODE
  SELF.SetUrl(pUrl)
  SELF.SetDebugCallback(curl::DebugCallback)
!  SELF.SetWriteCallback(curl::ws:WriteCB, ADDRESS(SELF))

  !make libcurl do an HTTP GET + Upgrade: request 
  SELF.SetOpt(CURLOPT_CONNECT_ONLY, 2)
  
  !Make a handshake
  SELF.connRes = SELF.Perform()
  IF SELF.connRes <> CURLE_OK
    curl::DebugInfo('TCurlWebsocketClass.Connect('& CLIP(pUrl) &'): '& SELF.StrError(SELF.connRes))
  END
  RETURN SELF.connRes

TCurlWebsocketClass.Disconnect    PROCEDURE(<STRING pReason>)
res                                 CURLcode, AUTO
  CODE
  IF SELF.connRes = CURLE_OK
    res = SELF.Send(pReason, CURLWS_CLOSE)
    SELF.connRes = CURLE_COULDNT_CONNECT
  ELSE
    res = CURLE_OK
  END
  RETURN res
  
TCurlWebsocketClass.Connected PROCEDURE()
  CODE
  RETURN CHOOSE(SELF.connRes = CURLE_OK)

TCurlWebsocketClass.SendFrame PROCEDURE(*STRING pData, UNSIGNED pFlags)
dataPtr                         LONG, AUTO
dataLen                         size_t, AUTO
fragmentLen                     size_t, AUTO
bufLen                          size_t, AUTO
cbSent                          size_t, AUTO
cbLeft                          size_t, AUTO
flags                           UNSIGNED, AUTO
numFragments                    LONG, AUTO  !- a number of fragments to send
nextFragmentNo                  LONG, AUTO
res                             CURLcode, AUTO
  CODE
  !To send a fragment in smaller pieces: send the first part with fragsize set to the total fragment size. 
  !You must know and provide the size of the entire fragment before you can send it. 
  
  dataPtr = ADDRESS(pData)
  dataLen = LEN(CLIP(pData))
  ASSERT(dataLen > MAX_CHUNK_SIZE)
  
  numFragments = INT((dataLen-1) / MAX_CHUNK_SIZE)+1
  ASSERT(numFragments > 1)
  
  flags = BOR(pFlags, CURLWS_OFFSET)
  bufLen = MAX_CHUNK_SIZE
  fragmentLen = dataLen
  cbLeft = fragmentLen
  
  LOOP nextFragmentNo=1 TO numFragments
    res = curl_ws_send(SELF.curl, dataPtr, bufLen, cbSent, fragmentLen, 0, flags)
    IF res <> CURLE_OK
      BREAK
    END
          
    !- data offset.
    dataPtr += cbSent
    cbLeft  -= cbSent
    
    !In subsequent calls to curl_ws_send() you send the next pieces of the fragment with fragsize set to zero but with the CURLWS_OFFSET bit sets in the flags argument. 
    !Repeat until all pieces have been sent that constitute the whole fragment.
    
    fragmentLen = 0  !- in subsequent call we pass 0 as fragment size

    IF nextFragmentNo = numFragments-1
      !- before last fragment sending calculate its size.
      bufLen = cbLeft
    END
  END
  
  RETURN res

TCurlWebsocketClass.SendMultiFrame    PROCEDURE(*STRING pData, UNSIGNED pFlags)
dataRef                                 &STRING, AUTO
dataPtr                                 LONG, AUTO
dataLen                                 size_t, AUTO
flags                                   UNSIGNED, AUTO
numFrames                               LONG, AUTO  !- a number of frames to send
nextFrameNo                             LONG, AUTO
lastBytes                               LONG, AUTO
res                                     CURLcode, AUTO
  CODE
  dataPtr = ADDRESS(pData)
  dataLen = LEN(CLIP(pData))
  ASSERT(dataLen > MAX_FRAME_SIZE)
  
  numFrames = INT((dataLen-1) / MAX_FRAME_SIZE)+1
  ASSERT(numFrames > 1)

  lastBytes = dataLen - (numFrames-1)*MAX_FRAME_SIZE
  
  LOOP nextFrameNo=1 TO numFrames
    IF nextFrameNo < numFrames
      flags = BOR(pFlags, CURLWS_CONT)
      dataRef &= (dataPtr) &':'& MAX_FRAME_SIZE
    ELSE
      flags = pFlags
      dataRef &= (dataPtr) &':'& lastBytes
    END

    res = SELF.Send(dataRef, flags)
    IF res <> CURLE_OK
      BREAK
    END
    
    dataPtr += MAX_FRAME_SIZE
  END
  
  RETURN res
    
TCurlWebsocketClass.Send      PROCEDURE(STRING pData, UNSIGNED pFlags)
  CODE
  RETURN SELF.Send(pData, pFlags)

TCurlWebsocketClass.Send      PROCEDURE(*STRING pData, UNSIGNED pFlags)
dataLen                         LONG, AUTO
cbSent                          size_t, AUTO
res                             CURLcode, AUTO
  CODE
  IF SELF.connRes <> CURLE_OK
    curl::DebugInfo('TCurlWebsocketClass.Send(): Couldn''t connect to the server.')
    RETURN SELF.connRes
  END

  dataLen = LEN(CLIP(pData))
  
  IF dataLen > MAX_FRAME_SIZE
    !- send data as many frames
    res = SELF.SendMultiFrame(pData, pFlags)
  ELSIF dataLen > MAX_CHUNK_SIZE
    !- send single frame as many fragments
    res = SELF.SendFrame(pData, pFlags)
  ELSE
    !- send single frame (fragment)
    !To send a complete WebSocket fragment, set fragsize to zero and provide data for all other arguments.
    res = curl_ws_send(SELF.curl, ADDRESS(pData), dataLen, cbSent, 0, 0, pFlags)
  END
  
  IF res <> CURLE_OK
    curl::DebugInfo('TCurlWebsocketClass.Send(): '& SELF.StrError(res))
  END

  RETURN res

TCurlWebsocketClass.SendText  PROCEDURE(STRING pText)
  CODE
  RETURN SELF.SendText(pText)
  
TCurlWebsocketClass.SendText  PROCEDURE(*STRING pText)
  CODE
  RETURN SELF.Send(pText, CURLWS_TEXT)

TCurlWebsocketClass.SendBinary    PROCEDURE(STRING pData)
  CODE
  RETURN SELF.SendBinary(pData)
  
TCurlWebsocketClass.SendBinary    PROCEDURE(*STRING pData)
  CODE
  RETURN SELF.Send(pData, CURLWS_BINARY)

TCurlWebsocketClass.SendFile  PROCEDURE(STRING pFileName, BOOL pAsText=FALSE)
fc                              &STRING, AUTO
res                             CURLcode, AUTO
  CODE
  fc &= curl::GetFileContents(pFileName)
  IF NOT fc &= NULL
    IF NOT pAsText
      res = SELF.SendBinary(fc)
    ELSE
      res = SELF.SendText(fc)
    END
    DISPOSE(fc)
  ELSE
    res = CURLE_READ_ERROR
  END
  RETURN res
  
TCurlWebsocketClass.Receive   PROCEDURE(*STRING pResponse)
ds                              &IDynStr
fs                              TCurlFileStruct
dwBytes                         LONG, AUTO
res                             CURLcode, AUTO
  CODE
  CLEAR(pResponse)
  ds &= NewDynStr()
  res = SELF.Receive(ds, SIZE(pResponse))
  IF res = CURLE_OK
    pResponse = ds.Str()
  END
  ds.Kill()
  DisposeDynStr(ds)
  RETURN res

TCurlWebsocketClass.Receive   PROCEDURE(*IDynStr pResponse, LONG pBufSize=256)
buf                             &STRING, AUTO
bufPtr                          LONG, AUTO
bufLen                          LONG, AUTO
cbRecv                          size_t, AUTO
meta                            &curl_ws_frame, AUTO
metap                           LONG, AUTO
flagMask                        EQUATE(0111b) ! CURLWS_TEXT | CURLWS_BINARY | CURLWS_CONT
res                             CURLcode, AUTO
  CODE
  IF pBufSize <= 0
    pBufSize = 256
  END
  
  IF SELF.connRes <> CURLE_OK
    !- no connection
    curl::DebugInfo('TCurlWebsocketClass.Receive(): Connection was not established.')
    RETURN SELF.connRes
  END

  buf &= NEW STRING(pBufSize)
  bufPtr = ADDRESS(buf)
  bufLen = SIZE(buf)
  
  LOOP
    res = curl_ws_recv(SELF.curl, bufPtr, bufLen, cbRecv, metap)
    IF res <> CURLE_OK
      !- error
      BREAK
    END

    meta &= (metap)
    IF NOT BAND(meta.flags, flagMask)
      !- invalid flag
      curl::DebugInfo('Received unexpected frame flag: '& meta.flags)
      BREAK
    END
    
    !- append received bytes
    IF cbRecv
      pResponse.Cat(buf[1:cbRecv])
    END
    
    IF meta.bytesleftLo = 0
      !- no more data in this frame
      IF BAND(meta.flags, CURLWS_CONT) = 0
        !- no more frames
        BREAK
      END
    END
  END
  
  DISPOSE(buf)
  
  IF res <> CURLE_OK
    CASE res
    OF CURLE_GOT_NOTHING  !connection closed
      curl::DebugInfo('TCurlWebsocketClass.Receive: connection closed.')
    ELSE
      curl::DebugInfo('TCurlWebsocketClass.Receive: '& SELF.StrError(res))
    END
  END
  RETURN res
  
TCurlWebsocketClass.ReceiveFile   PROCEDURE(STRING pFileName, LONG pBufSize=256)
ds                                  &IDynStr
fs                                  TCurlFileStruct
dwBytes                             LONG, AUTO
res                                 CURLcode, AUTO
  CODE
  ds &= NewDynStr()
  res = SELF.Receive(ds, pBufSize)
  IF res = CURLE_OK
    fs.Init(pFileName)
    IF fs.CreateFile()
      IF fs.WriteFile(ds.CStrRef(), ds.StrLen(), dwBytes)
        ;
      ELSE
        res = CURLE_WRITE_ERROR
      END
    ELSE
      res = CURLE_WRITE_ERROR
    END
    fs.Close()
  END
  ds.Kill()
  DisposeDynStr(ds)
  RETURN res
!!!endregion