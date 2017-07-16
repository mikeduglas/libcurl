!https://www.dropbox.com/developers/documentation/http/documentation

  PROGRAM

  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')
  INCLUDE('DbxJSON.inc')
  INCLUDE('keycodes.clw')

  MAP
    Authorize(), BOOL, PRIVATE
    GetAccessToken(STRING pAuthCode, STRING pAppKey, STRING pAppSecret, *STRING pAccessToken), BOOL, PROC, PRIVATE
    DbxFileManager(), PRIVATE
  END

eq::AppName                   EQUATE('Dropbox File manager')


TDbxControls                  CLASS, TYPE
!- toolbox group
feqToolbox                      SIGNED
!- buttons
feqCopy                         SIGNED
feqMove                         SIGNED
feqCreateFolder                 SIGNED
feqDelete                       SIGNED
feqDownload                     SIGNED
feqUpload                       SIGNED
feqRefresh                      SIGNED
feqPreview                      SIGNED
                              END


TDbxFolder                    CLASS, TYPE
curl                            &TCurlDropboxClass, PROTECTED
FolderQ                         &TDbxEntries, PROTECTED
CurrentFolder                   STRING(256), PROTECTED
AnotherPanel                    &TDbxFolder, PROTECTED

!- controls
feqListbox                      SIGNED, PROTECTED
feqCurPath                      SIGNED, PROTECTED
Toolbox                         &TDbxControls, PROTECTED
feqPreviewer                    SIGNED, PROTECTED

Construct                       PROCEDURE()
Destruct                        PROCEDURE(), VIRTUAL

GetSelectedItem                 PROCEDURE(), BOOL, PROTECTED

TakeEvent                       PROCEDURE(), BYTE
ShowDbxError                    PROCEDURE(), PROTECTED

Init                            PROCEDURE(*TCurlDropboxClass pCurl, SIGNED pListFeq, SIGNED pCurPathFeq, SIGNED pPreviewerFeq, *TDbxControls pControls, *TDbxFolder pAnotherPanel)
Refresh                         PROCEDURE(), BOOL, PROC
Open                            PROCEDURE(), BOOL, PROC !- opens selected folder or performs default action on file
CreateFolder                    PROCEDURE(), BOOL, PROC
Copy                            PROCEDURE(), BOOL, PROC
Move                            PROCEDURE(), BOOL, PROC
Delete                          PROCEDURE(), BOOL, PROC
IsDownloadable                  PROCEDURE(), BOOL
Download                        PROCEDURE(), BOOL, PROC
Upload                          PROCEDURE(), BOOL, PROC
IsPreviewable                   PROCEDURE(), BOOL
Preview                         PROCEDURE(), BOOL, PROC
IsThumbnailable                 PROCEDURE(), BOOL
Thumbnail                       PROCEDURE(), BOOL, PROC
                              END

curl                          TCurlDropboxClass

  CODE
  curl.Init()
  
  IF Authorize()
    DbxFileManager()
  END
  
Authorize                     PROCEDURE()
appKey                          STRING(32)
appSecret                       STRING(32)

authCode                        STRING(64)
accessToken                     STRING(128)

AuthWindow                      WINDOW('Dropbox File manager'),AT(,,298,146),CENTER,GRAY,SYSTEM, |
                                  FONT('Tahoma',8)
                                  PROMPT('"Authorize" redirects you to Dropbox authorization web page. Copy au' & |
                                    'thorization code found there and press "Continue" to complete OAuth2 fl' & |
                                    'ow and open File Manager.'),AT(13,10,269,39),USE(?lblUserInfo),FONT(,10)
                                  PROMPT('App key:'),AT(13,69),USE(?lblAppKey)
                                  ENTRY(@s32),AT(67,66),USE(appKey)
                                  PROMPT('App secret:'),AT(13,84),USE(?lblAppSecret)
                                  ENTRY(@s32),AT(67,84),USE(appSecret)
                                  BUTTON('Authorize'),AT(219,83,63),USE(?bAuthorize)
                                  BUTTON('Continue'),AT(137,118,69),USE(?bGetToken)
                                  BUTTON('Cancel'),AT(219,118,63),USE(?bCancel)
                                END

rc                              BOOL(FALSE)
  CODE
  appKey = GETINI('Application', 'Key', '', '.\dropbox.ini')
  appSecret = GETINI('Application', 'Secret', '', '.\dropbox.ini')
  accessToken = GETINI('Application', 'AccessToken', '', '.\dropbox.ini')
  IF accessToken
    curl.AccessToken(accessToken)
    RETURN TRUE
  END
  
  OPEN(AuthWindow)
  
  ACCEPT
    CASE ACCEPTED()
    OF ?bAuthorize
      curl.Authorize(appKey)
      
    OF ?bGetToken
      authCode = CLIPBOARD()
      IF GetAccessToken(authCode, appKey, appSecret, accessToken)
        !- save app settings for future use
        PUTINI('Application', 'Key', appKey, '.\dropbox.ini')
        PUTINI('Application', 'Secret', appSecret, '.\dropbox.ini')
        PUTINI('Application', 'AccessToken', curl.AccessToken(), '.\dropbox.ini')

        !- continue
        rc = TRUE
        POST(EVENT:CloseWindow)
      END
      
    OF ?bCancel
      !- exit
      POST(EVENT:CloseWindow)
    END
  END

  RETURN rc  
  
GetAccessToken                PROCEDURE(STRING pAuthCode, STRING pAppKey, STRING pAppSecret, *STRING pAccessToken)
json                            TDbxJSON
dbxError                        LIKE(TDbxAuthError)
rc                              BOOL, AUTO
res                             CURLcode, AUTO
  CODE
  SETCURSOR(CURSOR:Wait)
  
  rc = curl.AccessToken(pAuthCode, pAppKey, pAppSecret)
  
  SETCURSOR()
  
  IF rc
    pAccessToken = curl.AccessToken()
    RETURN TRUE
  END

  res = curl.CurlResponse()
  IF res <> CURLE_OK
    MESSAGE('AccessToken failed: '& curl.StrError(res), eq::AppName, ICON:Exclamation)
  ELSIF curl.GetResponseCode() <> 200
    json.AuthError(curl.DropboxResponse(), dbxError)
    MESSAGE(CLIP(dbxError.Summary) &'|'& CLIP(dbxError.Description), eq::AppName, ICON:Exclamation)
  ELSE
    MESSAGE('AccessToken json parser failed, json:|'& curl.DropboxResponse(), eq::AppName, ICON:Exclamation)
  END

  RETURN FALSE
  
DbxFileManager                PROCEDURE()
leftPanel                       TDbxFolder
rightPanel                      TDbxFolder
currentPanel                    &TDbxFolder
toolControls                    TDbxControls

MainWindow                      WINDOW('Dropbox File manager'),AT(,,679,324),CENTER,GRAY,SYSTEM, |
                                  FONT('Tahoma',8)
                                  SHEET,AT(3,2,335,293),USE(?shtLeft)
                                    TAB('File panel'),USE(?tabLeftPanel)
                                      STRING(''),AT(3,23,333,12),USE(?strLeftCurrentFolder),FONT(,9),COLOR(0DEC4B0H)
                                      LIST,AT(3,40,334,254),USE(?lstLeftPanel),FLAT,VSCROLL,FONT(,10), |
                                        FROM(leftPanel.FolderQ),FORMAT('254L(2)|M~Name~@s255@#4#20R(2)|M~Siz' & |
                                        'e~@n10b@#9#'),ALRT(EnterKey), ALRT(MouseLeft2)
                                    END
                                    TAB('Preview'),USE(?tabLeftPreview)
                                      OLE,AT(3,17,332,276),USE(?LeftShellExplorer),COMPATIBILITY(020H), |
                                        CREATE('Shell.Explorer.2')
                                      END
                                    END
                                  END
                                  SHEET,AT(343,2,335,293),USE(?shtRight)
                                    TAB('File panel'),USE(?tabRightPanel)
                                      STRING(''),AT(344,23,331,12),USE(?strRightCurrentFolder),FONT(,9), |
                                        COLOR(0DEC4B0H)
                                      LIST,AT(343,40,334,254),USE(?lstRightPanel),FLAT,VSCROLL,FONT(,10), |
                                        FROM(rightPanel.FolderQ),FORMAT('254L(2)|M~Name~@s255@#4#20R(2)|M~Si' & |
                                        'ze~@n10b@#9#'),ALRT(EnterKey), ALRT(MouseLeft2)
                                    END
                                    TAB('Preview'),USE(?tabRightPreview)
                                      OLE,AT(343,17,332,276),USE(?RightShellExplorer),COMPATIBILITY(020H), |
                                        CREATE('Shell.Explorer.2')
                                      END
                                    END
                                  END
                                  GROUP,AT(3,298,676,24),USE(?grpToolbox),DISABLE
                                    BUTTON('F3  Preview'),AT(3,303,56),USE(?bPreview),KEY(F3Key),FLAT
                                    BUTTON('F5  Copy'),AT(83,303,56),USE(?bCopy),KEY(F5Key),FLAT
                                    BUTTON('F6  Move'),AT(143,303,56),USE(?bMove),KEY(F6Key),FLAT
                                    BUTTON('F7  New folder'),AT(211,303,56),USE(?bCreateFolder),KEY(F7Key),FLAT
                                    BUTTON('F8  Delete'),AT(279,303,56),USE(?bDelete),KEY(F8Key),FLAT
                                    BUTTON('Download'),AT(344,303,56),USE(?bDownload),FLAT
                                    BUTTON('Upload'),AT(404,303,56),USE(?bUpload),FLAT
                                    BUTTON('Refresh'),AT(476,303,56),USE(?bRefresh),FLAT
                                  END
                                  BUTTON('Close'),AT(628,303,49),USE(?bClose),STD(STD:Close),FLAT
                                END

  CODE
  toolControls.feqToolbox = ?grpToolbox
  toolControls.feqCreateFolder = ?bCreateFolder
  toolControls.feqCopy = ?bCopy
  toolControls.feqMove = ?bMove
  toolControls.feqDelete = ?bDelete
  toolControls.feqDownload = ?bDownload
  toolControls.feqUpload = ?bUpload
  toolControls.feqRefresh = ?bRefresh
  toolControls.feqPreview = ?bPreview

  leftPanel.Init(curl, ?lstLeftPanel, ?strLeftCurrentFolder, ?RightShellExplorer, toolControls, rightPanel)
  rightPanel.Init(curl, ?lstRightPanel, ?strRightCurrentFolder, ?LeftShellExplorer, toolControls, leftPanel)
  
  OPEN(MainWindow)
  SELECT(?lstLeftPanel)
  
  ?LeftShellExplorer{'Silent'} = 1 !-- block script error messages 
  ?RightShellExplorer{'Silent'} = 1 !-- block script error messages 

  ACCEPT
    IF EVENT() = EVENT:OpenWindow
      leftPanel.Refresh()
      rightPanel.Refresh()
    END
        
    CASE SELECTED()
    OF ?lstLeftPanel
      ?lstLeftPanel{PROP:SelectedFillColor} = COLOR:NONE
      ?lstRightPanel{PROP:SelectedFillColor} = COLOR:Silver
      
      currentPanel &= leftPanel
      POST(EVENT:NewSelection, ?lstLeftPanel)
    OF ?lstRightPanel
      ?lstLeftPanel{PROP:SelectedFillColor} = COLOR:Silver
      ?lstRightPanel{PROP:SelectedFillColor} = COLOR:NONE

      currentPanel &= rightPanel
      POST(EVENT:NewSelection, ?lstRightPanel)
    END

    CASE currentPanel.TakeEvent()
    OF Level:Notify
      CYCLE
    OF Level:Fatal
      BREAK
    END
  END
  
TDbxFolder.Construct          PROCEDURE()
  CODE
  SELF.FolderQ &= NEW TDbxEntries
  
TDbxFolder.Destruct           PROCEDURE()
  CODE
  FREE(SELF.FolderQ)
  DISPOSE(SELF.FolderQ)
  
TDbxFolder.Init               PROCEDURE(*TCurlDropboxClass pCurl, SIGNED pListFeq, SIGNED pCurPathFeq, SIGNED pPreviewerFeq, *TDbxControls pControls, *TDbxFolder pAnotherPanel)
  CODE
  SELF.curl &= curl
  SELF.feqListbox = pListFeq
  SELF.feqCurPath = pCurPathFeq
  SELF.Toolbox &= pControls
  SELF.feqPreviewer = pPreviewerFeq
  SELF.AnotherPanel &= pAnotherPanel
  
TDbxFolder.GetSelectedItem    PROCEDURE()
  CODE
  GET(SELF.FolderQ, CHOICE(SELF.feqListbox))
  RETURN CHOOSE(ERRORCODE() = 0)

TDbxFolder.TakeEvent          PROCEDURE()
rc                              BYTE(Level:Notify)
  CODE
  CASE EVENT()
  OF EVENT:Accepted
    CASE FIELD()
    OF SELF.Toolbox.feqCreateFolder
      SELF.CreateFolder()

    OF SELF.Toolbox.feqCopy
      SELF.Copy()

    OF SELF.Toolbox.feqMove
      SELF.Move()

    OF SELF.Toolbox.feqDelete
      SELF.Delete()

    OF SELF.Toolbox.feqDownload
      SELF.Download()
      
    OF SELF.Toolbox.feqUpload
      SELF.Upload()
      
    OF SELF.Toolbox.feqRefresh
      SELF.Refresh()
      
    OF SELF.Toolbox.feqPreview
      IF SELF.IsPreviewable()
        SELF.Preview()
      ELSIF SELF.IsThumbnailable()
        SELF.Thumbnail()
      END
      
    ELSE
      rc = Level:Benign
    END
  
  OF EVENT:NewSelection
    CASE FIELD()
    OF SELF.feqListbox
      IF SELF.IsPreviewable() OR SELF.IsThumbnailable()
        SELF.Toolbox.feqPreview{PROP:Disable} = FALSE        
      ELSE
        SELF.Toolbox.feqPreview{PROP:Disable} = TRUE
      END

      IF SELF.IsDownloadable()
        SELF.Toolbox.feqDownload{PROP:Disable} = FALSE
      ELSE
        SELF.Toolbox.feqDownload{PROP:Disable} = TRUE
      END

    ELSE
      rc = Level:Benign
    END
    
  OF EVENT:AlertKey
    CASE FIELD()
    OF SELF.feqListbox
      CASE KEYCODE() 
      OF MouseLeft2 OROF EnterKey
        SELF.Open()
      END
      
    ELSE
      rc = Level:Benign
    END
  
  ELSE
    rc = Level:Benign
  END
  
  RETURN rc
  
TDbxFolder.ShowDbxError       PROCEDURE()
json                            TDbxJSON
dbxError                        LIKE(TDbxApiError)
  CODE
  IF SELF.curl.CurlResponse() <> CURLE_OK
    MESSAGE('Curl failed: '& SELF.curl.StrError(SELF.curl.CurlResponse()), eq::AppName, ICON:Exclamation)
  ELSIF SELF.curl.GetResponseCode() <> 200
    json.ApiError(SELF.curl.DropboxResponse(), dbxError)
    MESSAGE(CLIP(dbxError.ErrGrp.Description), eq::AppName, ICON:Exclamation)
  ELSE
    MESSAGE('Operation failed', eq::AppName, ICON:Exclamation)
  END

TDbxFolder.Refresh            PROCEDURE()
json                            TDbxJSON
trailingSlashPos                LONG, AUTO
qIndex                          LONG, AUTO
rc                              BOOL, AUTO
  CODE
  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    SELF.Toolbox.feqToolbox{PROP:Disable} = FALSE
    RETURN FALSE
  END
  
  SETCURSOR(CURSOR:Wait)
  
  FREE(SELF.FolderQ)
  !- read dropbox folder
  IF SELF.curl.ListFolder(SELF.CurrentFolder)
    !- fill FoldersQ from json
    json.GetEntries(curl.DropboxResponse(), SELF.FolderQ)
    !- set folder's DisplayName as "[FOLDER]", file's DisplayName as "file"
    LOOP qIndex = 1 TO RECORDS(SELF.FolderQ)
      GET(SELF.FolderQ, qIndex)
      SELF.FolderQ.DisplayName = CHOOSE(SELF.FolderQ.Tag = 'file', LOWER(SELF.FolderQ.Name), '['& UPPER(CLIP(SELF.FolderQ.Name)) &']')
      PUT(SELF.FolderQ)
    END
    
    !- if not in root folder, add [.] as parent link
    IF SELF.CurrentFolder
      trailingSlashPos = INSTRING('/', SELF.CurrentFolder, -1, LEN(CLIP(SELF.CurrentFolder)))
      CLEAR(SELF.FolderQ)
      SELF.FolderQ.Tag = 'folder'
      SELF.FolderQ.DisplayName = '[.]'
      SELF.FolderQ.Path = SUB(SELF.CurrentFolder, 1, trailingSlashPos - 1)
      ADD(SELF.FolderQ)
    END
    
    !- sort by folders, then files
    SORT(SELF.FolderQ, SELF.FolderQ.DisplayName)  ! folders first
    rc = TRUE
  ELSE
    SELF.ShowDbxError()    
    SELF.CurrentFolder = ''
    rc = FALSE
  END
  
  SELF.Toolbox.feqToolbox{PROP:Disable} = CHOOSE(rc = FALSE)
  
  IF SELF.CurrentFolder
    SELF.feqCurPath{PROP:Text} = SELF.CurrentFolder
  ELSE
    SELF.feqCurPath{PROP:Text} = '/'
  END
  
  DISPLAY()
  SETCURSOR()

  RETURN rc
  
TDbxFolder.Open               PROCEDURE()
  CODE
  IF NOT SELF.GetSelectedItem()
    RETURN FALSE
  END
  
  CASE SELF.FolderQ.Tag 
  OF 'folder'
    !- open selected folder
    SELF.CurrentFolder = SELF.FolderQ.Path
    RETURN SELF.Refresh()
    
  OF 'file'
    RETURN SELF.Download()    
  END
  
TDbxFolder.CreateFolder       PROCEDURE()
folderName                      STRING(256)
NewFolderDialog                 WINDOW('New folder'),AT(,,260,100),CENTER,GRAY,FONT('Tahoma',8)
                                  PROMPT('Folder name:'),AT(17,25),USE(?lblNewFolder)
                                  ENTRY(@s255),AT(69,25,176),USE(folderName),REQ
                                  BUTTON('OK'),AT(117,62,50),USE(?bOK_NewFolder),DEFAULT,REQ
                                  BUTTON('Cancel'),AT(198,62,48),USE(?bCancel_NewFolder)
                                END
rc                              BOOL, AUTO
  CODE
  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    RETURN FALSE
  END
  
  OPEN(NewFolderDialog)
  rc = FALSE
  ACCEPT
    CASE ACCEPTED()
    OF ?bOK_NewFolder
      rc = TRUE
      POST(EVENT:CloseWindow)
    OF ?bCancel_NewFolder
      POST(EVENT:CloseWindow)
    END
  END
  
  IF rc = FALSE
    !- cancel
    RETURN FALSE
  END
    
  SETCURSOR(CURSOR:Wait)

  IF SELF.curl.CreateFolder(CLIP(SELF.CurrentFolder) &'/'& CLIP(folderName))
    SELF.Refresh()
    rc = TRUE
    
    !- refresh 2nd panel if its current path is the same
    IF SELF.CurrentFolder = SELF.AnotherPanel.CurrentFolder
      SELF.AnotherPanel.Refresh()
    END
  ELSE
    SELF.ShowDbxError()    
    rc = FALSE
  END
  
  SETCURSOR()

  RETURN rc

TDbxFolder.Copy               PROCEDURE()
fromPath                        STRING(256), AUTO
toPath                          STRING(256), AUTO
rc                              BOOL, AUTO
  CODE
  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    RETURN FALSE
  END
  
  IF NOT SELF.GetSelectedItem()
    RETURN FALSE
  END
  
  SETCURSOR(CURSOR:Wait)
  
  !- find source item to copy
  fromPath = SELF.FolderQ.Path
  
  !- find target item to get
  toPath = CLIP(SELF.AnotherPanel.CurrentFolder) & '/'& SELF.FolderQ.Name
  
  IF SELF.curl.Copy(fromPath, toPath)
    rc = TRUE
    SELF.Refresh()
    SELF.AnotherPanel.Refresh()
  ELSE
    SELF.ShowDbxError()    
    rc = FALSE
  END

  SETCURSOR()

  RETURN rc

TDbxFolder.Move               PROCEDURE()
fromPath                        STRING(256), AUTO
toPath                          STRING(256), AUTO
rc                              BOOL, AUTO
  CODE
  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    RETURN FALSE
  END
  
  IF NOT SELF.GetSelectedItem()
    RETURN FALSE
  END

  SETCURSOR(CURSOR:Wait)
  
  !- find source item to copy
  fromPath = SELF.FolderQ.Path
  
  !- find target item to get
  toPath = CLIP(SELF.AnotherPanel.CurrentFolder) & '/'& SELF.FolderQ.Name
  
  IF SELF.curl.Move(fromPath, toPath)
    rc = TRUE
    SELF.Refresh()
    SELF.AnotherPanel.Refresh()
  ELSE
    SELF.ShowDbxError()    
    rc = FALSE
  END

  SETCURSOR()

  RETURN rc

TDbxFolder.Delete             PROCEDURE()
rc                              BOOL, AUTO
  CODE
  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    RETURN FALSE
  END
  
  IF NOT SELF.GetSelectedItem()
    RETURN FALSE
  END

  IF MESSAGE('Do you really want to delete the selected '& CLIP(SELF.FolderQ.Name) &'?', eq::AppName, ICON:Question, BUTTON:YES + BUTTON:NO, BUTTON:NO) = BUTTON:NO
    RETURN FALSE
  END
  
  SETCURSOR(CURSOR:Wait)
  
  IF SELF.curl.Delete(SELF.FolderQ.Path)
    SELF.Refresh()
    
    !- refresh 2nd panel if its current folder is same or deeper
    IF SELF.CurrentFolder = '' OR INSTRING(CLIP(SELF.CurrentFolder), SELF.AnotherPanel.CurrentFolder, 1, 1) > 0
      SELF.AnotherPanel.CurrentFolder = SELF.CurrentFolder
      SELF.AnotherPanel.Refresh()
    END
    
    rc = TRUE
  ELSE
    SELF.ShowDbxError()    
    rc = FALSE
  END

  SETCURSOR()

  RETURN rc

TDbxFolder.IsDownloadable     PROCEDURE()
  CODE
  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    RETURN FALSE
  END
    
  IF NOT SELF.GetSelectedItem()
    RETURN FALSE
  END

  IF SELF.FolderQ.Tag = 'folder'
    !- can't download a folder
    RETURN FALSE
  END
  
  RETURN TRUE

TDbxFolder.Download           PROCEDURE()
localPath                       STRING(256)
rc                              BOOL, AUTO
  CODE
  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    RETURN FALSE
  END

  IF NOT SELF.GetSelectedItem()
    RETURN FALSE
  END
  
  IF SELF.FolderQ.Tag = 'folder'
    RETURN FALSE
  END

  localPath = SELF.FolderQ.Name
  IF NOT FILEDIALOGA(, localPath, , FILE:Save + FILE:LongName + FILE:AddExtension)
    RETURN FALSE
  END

  SETCURSOR(CURSOR:Wait)

  IF SELF.curl.Download(SELF.FolderQ.Path, localPath)
    SELF.Refresh()
    rc = TRUE
    MESSAGE('Download completed.|File '& CLIP(localPath), eq::AppName, ICON:Asterisk)
  ELSE
    SELF.ShowDbxError()    
    rc = FALSE
  END
   
  SETCURSOR()

  RETURN rc

TDbxFolder.Upload             PROCEDURE()
localPath                       STRING(256)
localFilename                   STRING(256)
rc                              BOOL, AUTO
  CODE
  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    RETURN FALSE
  END
  
  IF NOT FILEDIALOGA(, localPath, , FILE:LongName + FILE:AddExtension)
    RETURN FALSE
  END
  
  SETCURSOR(CURSOR:Wait)

  !- extract file name from path
  localFilename = SUB(localPath, INSTRING('\', localPath, -1, LEN(CLIP(localPath))) + 1, LEN(localPath))
  
  IF SELF.curl.Upload(localPath, CLIP(SELF.CurrentFolder) &'/'& localFilename)
    SELF.Refresh()
    rc = TRUE
     
    !- refresh 2nd panel if its current path is the same
    IF SELF.CurrentFolder = SELF.AnotherPanel.CurrentFolder
      SELF.AnotherPanel.Refresh()
    END
  ELSE
    SELF.ShowDbxError()    
    rc = FALSE
  END
  
  SETCURSOR()

  RETURN rc

TDbxFolder.IsPreviewable      PROCEDURE()
dotpos                          LONG, AUTO
fileext                         STRING(256), AUTO
availExtensions                 STRING('|doc|docx|docm|ppt|pps|ppsx|ppsm|pptx|pptm|xls|xlsx|xlsm|rtf|')
  CODE
  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    RETURN FALSE
  END
    
  IF NOT SELF.GetSelectedItem()
    RETURN FALSE
  END

  IF SELF.FolderQ.Tag = 'folder'
    !- can't preview a folder
    RETURN FALSE
  END

  dotpos = INSTRING('.', SELF.FolderQ.Name, -1, LEN(CLIP(SELF.FolderQ.Name)))
  IF dotpos = 0
    !- no extension (?)
    RETURN FALSE
  END
  
  !- is file extension supported?
  fileext = SUB(SELF.FolderQ.Name, dotpos + 1, LEN(CLIP(SELF.FolderQ.Name)))
  IF INSTRING('|'& CLIP(fileext) &'|', availExtensions, 1, 1)
    RETURN TRUE
  END
  
  RETURN FALSE

TDbxFolder.Preview            PROCEDURE()
previewfile                     STRING(256)
shtFeq                          SIGNED, AUTO
tabFeq                          SIGNED, AUTO
rc                              BOOL, AUTO
  CODE
  !- reset previewer
  SELF.feqPreviewer{'Navigate("about:blank")'}
  DISPLAY(SELF.feqPreviewer)

  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    RETURN FALSE
  END

  IF NOT SELF.GetSelectedItem()
    RETURN FALSE
  END

  SETCURSOR(CURSOR:Wait)
  
  previewfile = LONGPATH('.\preview')
  IF SELF.curl.Preview(SELF.FolderQ.Path, previewfile)
    SELF.feqPreviewer{'Navigate("'& 'file://'& LONGPATH(previewfile) &'")'}
    
    !- select Previewer tab
    tabFeq = SELF.feqPreviewer{PROP:Parent}
    shtFeq = tabFeq{PROP:Parent}
    SELECT(shtFeq, 2)
    
    DISPLAY(SELF.feqPreviewer)
    
    rc = TRUE
  ELSE
    SELF.ShowDbxError()    
    rc = FALSE
  END
  
  SETCURSOR()

  RETURN rc

TDbxFolder.IsThumbnailable    PROCEDURE()
dotpos                          LONG, AUTO
fileext                         STRING(256), AUTO
availExtensions                 STRING('|jpg|jpeg|png|tiff|tif|gif|bmp|')
  CODE
  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    RETURN FALSE
  END
    
  IF NOT SELF.GetSelectedItem()
    RETURN FALSE
  END

  IF SELF.FolderQ.Tag = 'folder'
    !- can't thumbnail a folder
    RETURN FALSE
  END

  dotpos = INSTRING('.', SELF.FolderQ.Name, -1, LEN(CLIP(SELF.FolderQ.Name)))
  IF dotpos = 0
    !- no extension (?)
    RETURN FALSE
  END
  
  !- is file extension supported?
  fileext = SUB(SELF.FolderQ.Name, dotpos + 1, LEN(CLIP(SELF.FolderQ.Name)))
  IF INSTRING('|'& CLIP(fileext) &'|', availExtensions, 1, 1)
    RETURN TRUE
  END
  
  RETURN FALSE

TDbxFolder.Thumbnail          PROCEDURE()
previewfile                     STRING(256)
shtFeq                          SIGNED, AUTO
tabFeq                          SIGNED, AUTO
rc                              BOOL, AUTO
  CODE
  !- reset previewer
  SELF.feqPreviewer{'Navigate("about:blank")'}
  DISPLAY(SELF.feqPreviewer)

  ASSERT(NOT SELF.curl &= NULL, 'Call Init(curl) first')
  IF SELF.curl &= NULL
    RETURN FALSE
  END

  IF NOT SELF.GetSelectedItem()
    RETURN FALSE
  END

  SETCURSOR(CURSOR:Wait)
  
  previewfile = LONGPATH('.\thumbnail.jpg')
  IF SELF.curl.Thumbnail(SELF.FolderQ.Path, TDbxThumbnailFormat:JPEG, TDbxThumbnailSize:w640h480, previewfile)
    SELF.feqPreviewer{'Navigate("'& 'file://'& LONGPATH(previewfile) &'")'}
    
    !- select Previewer tab
    tabFeq = SELF.feqPreviewer{PROP:Parent}
    shtFeq = tabFeq{PROP:Parent}
    SELECT(shtFeq, 2)
    
    DISPLAY(SELF.feqPreviewer)
    
    rc = TRUE
  ELSE
    SELF.ShowDbxError()    
    rc = FALSE
  END
  
  SETCURSOR()

  RETURN rc
