!https://www.dropbox.com/developers/documentation/http/documentation

  PROGRAM

  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')
  INCLUDE('JSON.inc')
  INCLUDE('keycodes.clw')

  MAP
    ReadFolder(STRING pPath), BOOL, PROC
    CreateFolder(STRING pPath), BOOL, PROC
    DeleteItem(STRING pPath), BOOL, PROC
    Download(STRING pRemotePath, STRING pFilename), BOOL, PROC
    Upload(STRING pRemotePath), BOOL, PROC
  END

eq::AppName                   EQUATE('Dropbox File manager')

curl                          TCurlDropboxClass

accessToken                   STRING(128)
currentFolder                 STRING(256)

FolderQ                       QUEUE, PRE(FolderQ)
DisplayName                     STRING(256)               ! [FOLDER] | FILE
Tag                             STRING(20), NAME('.tag')  ! 'folder' | 'file'
Name                            STRING(256), NAME('name')
Path                            STRING(256), NAME('path_lower')
Size                            LONG, NAME('size')
                              END

Window                        WINDOW('Dropbox File manager'),AT(,,459,313),CENTER,GRAY,SYSTEM, |
                                FONT('Tahoma',8)
                                PROMPT('Access token:'),AT(14,14),USE(?PROMPT1)
                                ENTRY(@s128),AT(68,13,324),USE(accessToken)
                                BUTTON('Open'),AT(400,12,49),USE(?bOpen)
                                PROMPT('Current folder:'),AT(14,36),USE(?PROMPT2)
                                STRING(@S255),AT(67,36,326),USE(currentFolder)
                                LIST,AT(15,54,378,247),USE(?lstFolder),VSCROLL,FONT(,10),FROM(FolderQ), |
                                  FORMAT('274L(2)|M~Name~@s255@20R(2)|M~Size~@n10b@#5#'),ALRT(MouseLeft2)
                                GROUP,AT(400,54,,204),USE(?grpAPI),DISABLE
                                  BUTTON('New folder'),AT(400,82),USE(?bCreateFolder)
                                  BUTTON('Delete'),AT(400,108,49),USE(?bDelete)
                                  BUTTON('Download'),AT(400,133,49),USE(?bDownload)
                                  BUTTON('Upload'),AT(400,158,49),USE(?bUpload)
                                  BUTTON('Refresh'),AT(400,200,49),USE(?bRefresh)
                                END
                                BUTTON('Close'),AT(400,270,49),USE(?bClose),STD(STD:Close)
                              END
  CODE
  curl.Init()
  
  OPEN(Window)
  SELECT(?lstFolder)
  
  ACCEPT
    CASE ACCEPTED()
    OF ?bOpen
      !- set access token, generated on App Console page
      IF accessToken
        curl.AccessToken(accessToken)
      
        !- read root folder
        IF ReadFolder('')
          ?grpAPI{PROP:Disable} = FALSE
        ELSE
          ?grpAPI{PROP:Disable} = TRUE
        END
        
      ELSE
        ?grpAPI{PROP:Disable} = TRUE
        MESSAGE('Access token required!|Open Dropbox App Console, open Application and press "Generate access token"', 'Dropbox test', ICON:Exclamation)
      END
      
      
    OF ?bCreateFolder
      IF CreateFolder(currentFolder)
        !- re-read current folder
        ReadFolder(currentFolder)
      END
      
    OF ?bDelete
      GET(FolderQ, CHOICE(?lstFolder))
      IF NOT ERRORCODE()
        IF DeleteItem(FolderQ:Path)
          !- re-read current folder
          ReadFolder(currentFolder)
        END
      END
      
    OF ?bDownload
      GET(FolderQ, CHOICE(?lstFolder))
      IF NOT ERRORCODE()
        IF FolderQ:Tag = 'file'
          Download(FolderQ:Path, FolderQ:Name)
        END
      END

    OF ?bUpload
      IF Upload(currentFolder)
        !- re-read current folder
        ReadFolder(currentFolder)
      END
      
    OF ?bRefresh
      !- re-read current folder
      ReadFolder(currentFolder)
    
    END
    
    CASE FIELD()
    OF ?lstFolder
      IF EVENT() = EVENT:AlertKey AND KEYCODE() = MouseLeft2
        IF NOT ?grpAPI{PROP:Disable}
          GET(FolderQ, CHOICE(?lstFolder))
          IF NOT ERRORCODE()
            IF FolderQ:Tag = 'folder'
              !- open folder
              ReadFolder(FolderQ:Path)
            END
          END
        END
      END
    END
  END
  
    
ReadFolder                    PROCEDURE(STRING pPath)
json                            JSONDataClass
entries:StartPos                LONG, AUTO
entries:EndPos                  LONG, AUTO
trailingSlashPos                LONG, AUTO
qIndex                          LONG, AUTO
rc                              BOOL, AUTO
  CODE
  SETCURSOR(CURSOR:Wait)
  
  FREE(FolderQ)
  !- read dropbox folder
  IF curl.ListFolder(pPath)
    !- find start and end of "entries" json
    entries:StartPos = INSTRING('[', curl.DropboxResponse(), 1, 1)
    entries:EndPos = INSTRING('}],', curl.DropboxResponse(), 1, 1)
    !- fill FoldersQ from json
    json.FromJSON(SUB(curl.DropboxResponse(), entries:StartPos, entries:EndPos + 1 - entries:StartPos + 1), FolderQ)
    !- set folder's DisplayName as [name]
    LOOP qIndex = 1 TO RECORDS(FolderQ)
      GET(FolderQ, qIndex)
      CASE FolderQ:Tag
      OF 'file'
        FolderQ:DisplayName = LOWER(FolderQ:Name)
        PUT(FolderQ)
      OF 'folder'
        FolderQ:DisplayName = '['& UPPER(CLIP(FolderQ:Name)) &']'
        PUT(FolderQ)
      END
    END
    !- if not in root folder, add [.] as parent link
    IF pPath
      trailingSlashPos = INSTRING('/', pPath, -1, LEN(CLIP(pPath)))
      CLEAR(FolderQ)
      FolderQ:Tag = 'folder'
      FolderQ:DisplayName = '[.]'
      FolderQ:Path = SUB(pPath, 1, trailingSlashPos - 1)
      ADD(FolderQ)
    END
    !- sort by folders, then files
    SORT(FolderQ, FolderQ:DisplayName)  ! folders first
        
    currentFolder = pPath
    DISPLAY(?currentFolder)
 
    rc = TRUE
  ELSE
    IF curl.CurlResponse() <> CURLE_OK
      MESSAGE('ListFolder failed: '& curl.StrError(curl.CurlResponse()), eq::AppName, ICON:Exclamation)
    ELSE
      MESSAGE('ListFolder failed: '& curl.DropboxResponse(), eq::AppName, ICON:Exclamation)
    END
    
    currentFolder = ''
    DISPLAY(?currentFolder)

    rc = FALSE
  END

  DISPLAY(?lstFolder)
  SETCURSOR()
  
  RETURN rc
  
CreateFolder                  PROCEDURE(STRING pPath)
folderName                      STRING(256)
NewFolderDialog                 WINDOW('New folder'),AT(,,260,100),CENTER,GRAY,FONT('Tahoma',8)
                                  PROMPT('Folder name:'),AT(17,25),USE(?lblNewFolder)
                                  ENTRY(@s255),AT(69,25,176),USE(folderName),REQ
                                  BUTTON('OK'),AT(117,62,50),USE(?bOK_NewFolder),DEFAULT,REQ
                                  BUTTON('Cancel'),AT(198,62,48),USE(?bCancel_NewFolder)
                                END
rc                              BOOL, AUTO
  CODE
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
  
  IF NOT curl.CreateFolder(CLIP(pPath) &'/'& CLIP(folderName))
    IF curl.CurlResponse() <> CURLE_OK
      MESSAGE('CreateFolder failed: '& curl.StrError(curl.CurlResponse()), eq::AppName, ICON:Exclamation)
    ELSE
      MESSAGE('CreateFolder failed: '& curl.DropboxResponse(), eq::AppName, ICON:Exclamation)
    END

    rc = FALSE
  END
  
  RETURN rc

DeleteItem                    PROCEDURE(STRING pPath)
rc                              BOOL, AUTO
  CODE
  IF NOT curl.Delete(pPath)
    IF curl.CurlResponse() <> CURLE_OK
      MESSAGE('Delete failed: '& curl.StrError(curl.CurlResponse()), eq::AppName, ICON:Exclamation)
    ELSE
      MESSAGE('Delete failed: '& curl.DropboxResponse(), eq::AppName, ICON:Exclamation)
    END

    rc = FALSE
  END

  RETURN rc

Download                      PROCEDURE(STRING pRemotePath, STRING pFilename)
localPath                       STRING(256)
rc                              BOOL, AUTO
  CODE
  localPath = pFilename
  IF NOT FILEDIALOG(, localPath, , FILE:Save + FILE:LongName + FILE:AddExtension)
    RETURN FALSE
  END
  
  IF curl.Download(pRemotePath, localPath)
    MESSAGE('Download completed.|File '& CLIP(localPath), eq::AppName, ICON:Asterisk)

    rc = TRUE
  ELSE
    IF curl.CurlResponse() <> CURLE_OK
      MESSAGE('Download failed: '& curl.StrError(curl.CurlResponse()), eq::AppName, ICON:Exclamation)
    ELSE
      MESSAGE('Download failed: '& curl.DropboxResponse(), eq::AppName, ICON:Exclamation)
    END

    rc = FALSE
  END
   
  RETURN rc

Upload                        PROCEDURE(STRING pRemotePath)
localPath                       STRING(256)
localFilename                   STRING(256)
rc                              BOOL, AUTO
  CODE
  IF NOT FILEDIALOG(, localPath, , FILE:LongName + FILE:AddExtension)
    RETURN FALSE
  END
  
  !- extract file name from path
  localFilename = SUB(localPath, INSTRING('\', localPath, -1, LEN(CLIP(localPath))) + 1, LEN(localPath))
  
  IF NOT curl.Upload(localPath, CLIP(pRemotePath) &'/'& localFilename)
    IF curl.CurlResponse() <> CURLE_OK
      MESSAGE('Upload failed: '& curl.StrError(curl.CurlResponse()), eq::AppName, ICON:Exclamation)
    ELSE
      MESSAGE('Upload failed: '& curl.DropboxResponse(), eq::AppName, ICON:Exclamation)
    END

    rc = FALSE
  END
  
  RETURN rc
