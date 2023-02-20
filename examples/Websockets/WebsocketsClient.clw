  PROGRAM

  INCLUDE('libcurl.inc'), ONCE

  MAP
    DisplayResponse(STRING pText)
    INCLUDE('printf.inc'), ONCE
  END

ws                            CLASS(TCurlWebsocketClass)
Connect                         PROCEDURE(STRING pUrl), CURLcode, PROC, DERIVED
                              END

host                          STRING(256)
txtRequest                    STRING(256)
ds                            &IDynStr
rc                            CURLcode, AUTO

Window                        WINDOW('Websockets libcurl client'),AT(,,397,173),CENTER,GRAY,SYSTEM, |
                                FONT('Segoe UI',9)
                                PROMPT('URL:'),AT(10,16),USE(?PROMPT1)
                                ENTRY(@s255),AT(33,15,240),USE(host)
                                BUTTON('Connect'),AT(278,14,51),USE(?btnConnect)
                                BUTTON('Disconnect'),AT(338,14,51),USE(?btnDisconnect)
                                BUTTON('Send'),AT(278,43,110),USE(?btnSend),DISABLE
                                PROMPT('Text to send:'),AT(10,47),USE(?PROMPT2)
                                ENTRY(@s255),AT(60,45,213),USE(txtRequest)
                                PROMPT('Server response:'),AT(10,71),USE(?PROMPT3)
                                TEXT,AT(10,84,378,62),USE(?txtResponse),VSCROLL,READONLY
                                BUTTON('Exit'),AT(346,153,43),USE(?BUTTON1),STD(STD:Close)
                              END
  CODE
  !- create websockets client
  ws.Init()
  !- server response
  ds &= NewDynStr()
    
  !- Postman’s WebSocket Echo Service
  !- see https://blog.postman.com/introducing-postman-websocket-echo-service/
  host = 'wss://ws.postman-echo.com/raw'
  
  txtRequest = 'Hello there!'

  OPEN(Window)
  SELECT(?btnConnect)
  
  ACCEPT
    CASE ACCEPTED()
    OF ?btnConnect
      rc = ws.Connect(host)
      IF rc = CURLE_OK
        ?btnSend{PROP:Disable} = FALSE
        DisplayResponse('Connected')
      ELSE
        !- Connect error
        ?btnSend{PROP:Disable} = TRUE
        DisplayResponse(printf('Connect error %i (%s)', rc, ws.StrError(rc)))
      END

    OF ?btnDisconnect
      !- disconnect
      ws.Disconnect()

      ?btnSend{PROP:Disable} = TRUE
      DisplayResponse('Disconnected')

    OF ?btnSend
      !- send a request and waiting for a response
      rc = ws.SendText(txtRequest)
      IF rc = CURLE_OK
        !- reset response buffer
        ds.Trunc(0)
        !- receive a response
        rc = ws.Receive(ds)
        IF rc = CURLE_OK
          DisplayResponse(ds.Str())
        ELSE
          !- Receive error
          DisplayResponse(printf('Receive error %i (%s)', rc, ws.StrError(rc)))
        END
      ELSE
        !- Send error
        DisplayResponse(printf('Send error %i (%s)', rc, ws.StrError(rc)))
      END
    END
  END
  
  !- dispose dynstr
  ds.Kill()
  DisposeDynStr(ds)
  
 
ws.Connect                    PROCEDURE(STRING pUrl)
  CODE
  !- reset all previous connection settings
  SELF.Reset()
  !- no SSL verification
  SELF.SetSSLVerifyHost(FALSE)
  SELF.SetSSLVerifyPeer(FALSE)
  !- timeout
  SELF.SetOpt(CURLOPT_TIMEOUT, 10)
  
  !- connect
  RETURN PARENT.Connect(pUrl)
  
DisplayResponse               PROCEDURE(STRING pText)
  CODE
  ?txtResponse{PROP:Text} = printf('%s%t@t4@: %s%|', ?txtResponse{PROP:Text}, CLOCK(), pText)
  DISPLAY(?txtResponse)
  SELECT(?txtResponse, LEN(?txtResponse{PROP:Text}))
