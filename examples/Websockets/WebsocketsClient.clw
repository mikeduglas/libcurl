  PROGRAM

  INCLUDE('libcurl.inc'), ONCE

  MAP
    INCLUDE('printf.inc'), ONCE

    MODULE('')
      Sleep(LONG pTimeoutMs), PASCAL
    END
  
    DisplayResponse(SIGNED pTextbox, STRING pText, <STRING pDirection>)
  END

WS_DIRECTION_SEND             EQUATE('->')
WS_DIRECTION_RECV             EQUATE('<<-')

ws                            CLASS(TCurlWebsocketClass)
Connect                         PROCEDURE(STRING pUrl), CURLcode, PROC, DERIVED
Disconnect                      PROCEDURE(<STRING pReason>), CURLcode, PROC, DERIVED
                              END

host                          STRING(256)

txtRequest                    STRING(256)
txtResponse                   STRING(256)

fileToSend                    STRING(256)
fileToRecv                    STRING(256)

Window                        WINDOW('Websockets libcurl client'),AT(,,441,254),CENTER,GRAY,SYSTEM, |
                                      FONT('Segoe UI',9)
                                PROMPT('URL:'),AT(10,16),USE(?PROMPT1)
                                ENTRY(@s255),AT(33,15,343),USE(host)
                                BUTTON('Connect'),AT(380,15,51),USE(?btnConnect)
                                SHEET,AT(2,36,438,197),USE(?SHEET1)
                                  TAB('Send text'),USE(?TAB1)
                                    PROMPT('Text to send:'),AT(10,60),USE(?PROMPT2)
                                    ENTRY(@s255),AT(60,58,294),USE(txtRequest)
                                    BUTTON('Send'),AT(366,57,51),USE(?btnSend),DISABLE
                                    BUTTON('Receive'),AT(366,74,51),USE(?btnReceive),DISABLE
                                    PROMPT('Output'),AT(10,96),USE(?PROMPT3)
                                    BUTTON,AT(418,96,13,10),USE(?btnClearOutput),ICON('Clear.gif')
                                    TEXT,AT(10,109,420,117),USE(?txtResponse),VSCROLL,FONT('Courier New'),READONLY
                                  END
                                  TAB('Send file'),USE(?TAB2)
                                    PROMPT('File to send:'),AT(10,60),USE(?PROMPT4)
                                    ENTRY(@s255),AT(60,58,294),USE(fileToSend)
                                    PROMPT('File to send:'),AT(10,74),USE(?PROMPT6)
                                    ENTRY(@s255),AT(60,72,294),USE(fileToRecv)
                                    BUTTON('Send'),AT(366,57,51),USE(?btnSendFile),DISABLE
                                    BUTTON('Receive'),AT(366,74,51),USE(?btnReceiveFile),DISABLE
                                    PROMPT('Output'),AT(10,96),USE(?PROMPT5)
                                    BUTTON,AT(418,96,13,10),USE(?btnClearOutput2),ICON('Clear.gif')
                                    TEXT,AT(10,109,420,117),USE(?txtFileResponse),VSCROLL,FONT('Courier New'), |
                                            READONLY
                                  END
                                END
                                BUTTON('Exit'),AT(375,235,56),USE(?BUTTON1),STD(STD:Close)
                              END
  CODE
  SYSTEM{PROP:CharSet} = CHARSET:DEFAULT
  
  !- create websockets client
  ws.Init()
    
  !- Postman’s WebSocket Echo Service
  !- see https://blog.postman.com/introducing-postman-websocket-echo-service/
!  host = 'wss://ws.postman-echo.com/raw'
  
  host = 'wss://echo.websocket.org'
  txtRequest = 'Hello there!'
  fileToSend = 'WebsocketsClient.clw'
  fileToRecv = 'ws_response_WebsocketsClient.clw'
  
  OPEN(Window)
  SELECT(?btnConnect)
  
  ACCEPT
    CASE ACCEPTED()
    OF ?btnConnect
      IF NOT ws.Connected()
        DisplayResponse(?txtResponse, 'Connecting...')
        ws.Connect(host)
        IF ws.Connected()
          DisplayResponse(?txtResponse, 'Connected')
          POST(EVENT:Accepted, ?btnReceive)
        ELSE
          DisplayResponse(?txtResponse, 'Error: Cannot connected')
        END
      ELSE
        ws.Disconnect()
        DisplayResponse(?txtResponse, 'Disconnected')
      END
    OF ?btnSend
      DisplayResponse(?txtResponse, printf('Sending %s', txtRequest), WS_DIRECTION_SEND)
      IF ws.SendText(txtRequest) = CURLE_OK
        DisplayResponse(?txtResponse, printf('Sent %s', txtRequest), WS_DIRECTION_SEND)
        Sleep(500)
        POST(EVENT:Accepted, ?btnReceive)
      ELSE
        !- Send error
        DisplayResponse(?txtResponse, 'Send error')
      END
    OF ?btnReceive
      DisplayResponse(?txtResponse, 'Receiving...', WS_DIRECTION_RECV)
      IF ws.Receive(txtResponse) = CURLE_OK
        DisplayResponse(?txtResponse, printf('Received %s', txtResponse), WS_DIRECTION_RECV)
      ELSE
        !- Receive error
        DisplayResponse(?txtResponse, 'Receive error')
      END
      
    OF ?btnSendFile
      DisplayResponse(?txtFileResponse, printf('Sending file %s', fileToSend), WS_DIRECTION_SEND)
      IF ws.SendFile(fileToSend) = CURLE_OK
        DisplayResponse(?txtFileResponse, printf('Sent file %s', fileToSend), WS_DIRECTION_SEND)
        Sleep(1000)
        POST(EVENT:Accepted, ?btnReceiveFile)
      ELSE
        !- Send error
        DisplayResponse(?txtFileResponse, 'Send file error')
      END
    OF ?btnReceiveFile
      DisplayResponse(?txtFileResponse, 'Receiving...', WS_DIRECTION_RECV)
      IF ws.ReceiveFile(fileToRecv) = CURLE_OK
        DisplayResponse(?txtFileResponse, printf('Received file %s:', fileToRecv), WS_DIRECTION_RECV)
      ELSE
        !- Receive error
        DisplayResponse(?txtFileResponse, 'Receive file error')
      END
    
    OF ?btnClearOutput
      ?txtResponse{PROP:Text} = ''
    OF ?btnClearOutput2
      ?txtFileResponse{PROP:Text} = ''
    END
  END

  
  
DisplayResponse               PROCEDURE(SIGNED pTextbox, STRING pText, <STRING pDirection>)
  CODE
  pTextbox{PROP:Text} = pTextbox{PROP:Text} & printf('%t@t4@: %z@s2@ %s%|', CLOCK(), pDirection, pText)
  DISPLAY(pTextbox)
  SELECT(pTextbox, LEN(pTextbox{PROP:Text}))

  
  
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
  PARENT.Connect(pUrl)
  IF SELF.Connected()
    ?btnConnect{PROP:Text} = 'Disconnect'
    ?btnSend{PROP:Disable} = FALSE
    ?btnReceive{PROP:Disable} = FALSE
    ?btnSendFile{PROP:Disable} = FALSE
    ?btnReceiveFile{PROP:Disable} = FALSE
  ELSE
    !- Connect error
    ?btnSend{PROP:Disable} = TRUE
    ?btnReceive{PROP:Disable} = TRUE
    ?btnSendFile{PROP:Disable} = TRUE
    ?btnReceiveFile{PROP:Disable} = TRUE
  END

  RETURN SELF.connRes
  
ws.Disconnect                 PROCEDURE(<STRING pReason>)
rc                              CURLcode, AUTO
  CODE
  rc = PARENT.Disconnect(pReason)
  ?btnConnect{PROP:Text} = 'Connect'
  ?btnSend{PROP:Disable} = TRUE
  ?btnReceive{PROP:Disable} = TRUE
  ?btnSendFile{PROP:Disable} = TRUE
  ?btnReceiveFile{PROP:Disable} = TRUE
  RETURN rc
