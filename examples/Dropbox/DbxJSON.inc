TDbxMetadata                  GROUP, TYPE
Tag                             STRING(6), NAME('.tag') !- 'file' or 'folder'
Name                            STRING(256), NAME('name') !- The last component of the path (including extension). This never contains a slash. 
Path                            STRING(256), NAME('path_lower') !- The lowercased full path in the user's Dropbox. This always starts with a slash. 
DisplayName                     STRING(256), NAME('path_display')
Id                              STRING(32), NAME('id')  !- A unique identifier for the file or folder.
!- files only
Client_Modified                 STRING(20), NAME('client_modified') !- "2015-05-12T15:50:38Z" 
Server_Modified                 STRING(20), NAME('server_modified') !- "2015-05-12T15:50:38Z" The last time the file was modified on Dropbox. 
Rev                             STRING(16), NAME('rev') !- A unique identifier for the current revision of a file.
Size                            STRING(20), NAME('size')  !- UInt64 The file size in bytes.
                              END

TDbxEntries                   QUEUE(TDbxMetadata), TYPE
                              END


TDbxAuthError                 GROUP, TYPE
Summary                         STRING(64), NAME('error')
Description                     STRING(256), NAME('error_description')
                              END

TDbxApiError                  GROUP, TYPE
Summary                         STRING(64), NAME('error_summary')
ErrGrp                          GROUP, NAME('error')
Description                       STRING(256), NAME('.tag')
                                END
                              END

TDbxJSON                      CLASS, TYPE, MODULE('DbxJSON.clw'), LINK('DbxJSON.clw')
GetMetadata                     PROCEDURE(STRING pJson, *TDbxMetadata pMetadata)
GetEntries                      PROCEDURE(STRING pJson, *TDbxEntries pEntries)
AuthError                       PROCEDURE(STRING pJson, *TDbxAuthError pError)
ApiError                        PROCEDURE(STRING pJson, *TDbxApiError pError)
                              END

