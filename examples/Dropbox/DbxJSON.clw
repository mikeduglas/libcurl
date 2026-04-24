  MEMBER

  INCLUDE('DbxJSON.inc'), ONCE
  INCLUDE('cJSON.inc'), ONCE

  MAP
    INCLUDE('printf.inc'), ONCE
  END

TDbxJSON.GetMetadata          PROCEDURE(STRING pJson, *TDbxMetadata pMetadata)
factory                         cJSONFactory
  CODE
  factory.ToGroup(pJson, pMetadata) 
  
TDbxJSON.GetEntries           PROCEDURE(STRING pJson, *TDbxEntries pEntries)
factory                         cJSONFactory
jRoot                           &cJSON, AUTO
  CODE
  jRoot &= factory.Parse(pJson, CP_ACP)
  jRoot.ToQueue('entries', pEntries)
  jRoot.Delete()
  
TDbxJSON.AuthError            PROCEDURE(STRING pJson, *TDbxAuthError pError)
factory                         cJSONFactory
  CODE
  factory.ToGroup(pJson, pError) 

TDbxJSON.ApiError             PROCEDURE(STRING pJson, *TDbxApiError pError)
factory                         cJSONFactory
  CODE
  factory.ToGroup(pJson, pError) 
