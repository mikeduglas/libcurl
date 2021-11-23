!** libcurl for Clarion v1.50
!** 23.11.2021
!** mikeduglas@yandex.com
!** mikeduglas66@gmail.com

  MEMBER

  INCLUDE('libcurl.inc')

  MAP
    MODULE('URL API')
      !/*
      ! * curl_url() creates a new CURLU handle and returns a pointer to it.
      ! * Must be freed with curl_url_cleanup().
      ! */
      !CURL_EXTERN CURLU *curl_url(void);
      curl_url(), CURLU, C, NAME('curl_url')

      !/*
      ! * curl_url_cleanup() frees the CURLU handle and related resources used for
      ! * the URL parsing. It will not free strings previously returned with the URL
      ! * API.
      ! */
      !CURL_EXTERN void curl_url_cleanup(CURLU *handle);
      curl_url_cleanup(CURLU handle), C, NAME('curl_url_cleanup')
  
      !/*
      ! * curl_url_dup() duplicates a CURLU handle and returns a new copy. The new
      ! * handle must also be freed with curl_url_cleanup().
      ! */
      !CURL_EXTERN CURLU *curl_url_dup(CURLU *in);
      curl_url_dup(CURLU in), CURLU, C, NAME('curl_url_dup')
  
      !/*
      ! * curl_url_get() extracts a specific part of the URL from a CURLU
      ! * handle. Returns error code. The returned pointer MUST be freed with
      ! * curl_free() afterwards.
      ! */
      !CURL_EXTERN CURLUcode curl_url_get(CURLU *handle, CURLUPart what,
      !                                   char **part, unsigned int flags);
      curl_url_get(CURLU handle, CURLUPart what, LONG part, UNSIGNED flags), CURLUcode, C, NAME('curl_url_get')
  
      !/*
      ! * curl_url_set() sets a specific part of the URL in a CURLU handle. Returns
      ! * error code. The passed in string will be copied. Passing a NULL instead of
      ! * a part string, clears that part.
      ! */
      !CURL_EXTERN CURLUcode curl_url_set(CURLU *handle, CURLUPart what,
      !    const char *part, unsigned int flags);
      curl_url_set(CURLU handle, CURLUPart what, *CSTRING part, UNSIGNED flags), CURLUcode, C, RAW, NAME('curl_url_set')

      !/*
      ! * curl_url_strerror() turns a CURLUcode value into the equivalent human
      ! * readable error string.  This is useful for printing meaningful error
      ! * messages.
      ! */
      !CURL_EXTERN const char *curl_url_strerror(CURLUcode); 
      curl_url_strerror(CURLUcode pErrCode), *CSTRING, C, RAW, NAME('curl_url_strerror')
    END
  END

!!!region static functions
curl::url:StrError            PROCEDURE(CURLUcode errcode)
  CODE
  RETURN curl_url_strerror(errcode)
!!!endregion

!!!region TCurlUrlApiClass
TCurlUrlApiClass.Construct    PROCEDURE()
  CODE
  SELF.urlp = 0
  
TCurlUrlApiClass.Destruct     PROCEDURE()
  CODE
  SELF.Cleanup()
  
TCurlUrlApiClass.Init         PROCEDURE()
  CODE
  SELF.Cleanup()
  SELF.urlp = curl_url()
  
TCurlUrlApiClass.Cleanup      PROCEDURE()
  CODE
  IF SELF.urlp <> 0
    curl_url_cleanup(SELF.urlp)
    SELF.urlp = 0
  END

TCurlUrlApiClass.Clone        PROCEDURE(TCurlUrlApiClass src)
  CODE
  SELF.Cleanup()
  SELF.urlp = curl_url_dup(src.urlp)

TCurlUrlApiClass.GetPart      PROCEDURE(CURLUPart what, *STRING part, UNSIGNED flags = 0)
rc                              CURLUcode, AUTO
lppart                          LONG, AUTO
szpart                          &CSTRING
  CODE
  rc = curl_url_get(SELF.urlp, what, ADDRESS(lppart), flags)
  IF rc = CURLUE_OK
    szpart &= (lppart)
    part = szpart
    curl::free(lppart)
  END
  
  RETURN rc
  
TCurlUrlApiClass.SetPart      PROCEDURE(CURLUPart what, STRING part, UNSIGNED flags = 0)
szpart                          CSTRING(LEN(CLIP(part)) + 1)
  CODE
  szpart = CLIP(part)
  RETURN curl_url_set(SELF.urlp, what, szpart, flags)
!!!endregion