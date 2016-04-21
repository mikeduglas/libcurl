  MEMBER

  INCLUDE('DbxJSON.inc')
  INCLUDE('JSON.inc')

  MAP
  END

TDbxJSON.GetMetadata          PROCEDURE(STRING pJson, *TDbxMetadata pMetadata)
json                            JSONDataClass
  CODE
  json.FromJSON(pJson, pMetadata)
  
TDbxJSON.GetEntries           PROCEDURE(STRING pJson, *TDbxEntries pEntries)
json                            JSONDataClass
  CODE
  json.FromJSON(pJson, pEntries)
  
TDbxJSON.AuthError            PROCEDURE(STRING pJson, *TDbxAuthError pError)
json                            JSONDataClass
  CODE
  json.FromJSON(pJson, pError)

TDbxJSON.ApiError             PROCEDURE(STRING pJson, *TDbxApiError pError)
json                            JSONDataClass
  CODE
  json.FromJSON(pJson, pError)
