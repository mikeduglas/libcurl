!** libcurl for Clarion v1.34
!** 01.09.2018
!** mikeduglas66@gmail.com

  MEMBER

  INCLUDE('libcurl.inc')

  MAP
    MODULE('libcurl API')
      !/*
      ! * NAME curl_mime_init()
      ! *
      ! * DESCRIPTION
      ! *
      ! * Create a mime context and return its handle. The easy parameter is the
      ! * target handle.
      ! */
      !CURL_EXTERN curl_mime *curl_mime_init(CURL *easy);
      curl_mime_init(CURL easy), curl_mime, C, RAW, NAME('curl_mime_init')

      !/*
      ! * NAME curl_mime_free()
      ! *
      ! * DESCRIPTION
      ! *
      ! * release a mime handle and its substructures.
      ! */
      !CURL_EXTERN void curl_mime_free(curl_mime *mime);
      curl_mime_free(curl_mime mime), C, RAW, NAME('curl_mime_free')

      !/*
      ! * NAME curl_mime_addpart()
      ! *
      ! * DESCRIPTION
      ! *
      ! * Append a new empty part to the given mime context and return a handle to
      ! * the created part.
      ! */
      !CURL_EXTERN curl_mimepart *curl_mime_addpart(curl_mime *mime);
      curl_mime_addpart(curl_mime mime), curl_mimepart, C, RAW, NAME('curl_mime_addpart')

      !/*
      ! * NAME curl_mime_name()
      ! *
      ! * DESCRIPTION
      ! *
      ! * Set mime/form part name.
      ! */
      !CURL_EXTERN CURLcode curl_mime_name(curl_mimepart *part, const char *name);
      curl_mime_name(curl_mimepart part, *CSTRING name), CURLcode, C, RAW, NAME('curl_mime_name')

      !/*
      ! * NAME curl_mime_filename()
      ! *
      ! * DESCRIPTION
      ! *
      ! * Set mime part remote file name.
      ! */
      !CURL_EXTERN CURLcode curl_mime_filename(curl_mimepart *part,
      !                                        const char *filename);
      curl_mime_filename(curl_mimepart part, *CSTRING filename), CURLcode, C, RAW, NAME('curl_mime_filename')

      !/*
      ! * NAME curl_mime_type()
      ! *
      ! * DESCRIPTION
      ! *
      ! * Set mime part type.
      ! */
      !CURL_EXTERN CURLcode curl_mime_type(curl_mimepart *part, const char *mimetype);
      curl_mime_type(curl_mimepart part, *CSTRING mimetype), CURLcode, C, RAW, NAME('curl_mime_type')

      !/*
      ! * NAME curl_mime_encoder()
      ! *
      ! * DESCRIPTION
      ! *
      ! * Set mime data transfer encoder.
      ! */
      !CURL_EXTERN CURLcode curl_mime_encoder(curl_mimepart *part,
      !                                       const char *encoding);
      curl_mime_encoder(curl_mimepart part, *CSTRING encoding), CURLcode, C, RAW, NAME('curl_mime_encoder')

      !/*
      ! * NAME curl_mime_data()
      ! *
      ! * DESCRIPTION
      ! *
      ! * Set mime part data source from memory data,
      ! */
      !CURL_EXTERN CURLcode curl_mime_data(curl_mimepart *part,
      !                                    const char *data, size_t datasize);
!      curl_mime_data(curl_mimepart part, *CSTRING data, size_t datasize), CURLcode, C, RAW, NAME('curl_mime_data')
      curl_mime_data(curl_mimepart part, *STRING data, size_t datasize), CURLcode, C, RAW, NAME('curl_mime_data')

      !/*
      ! * NAME curl_mime_filedata()
      ! *
      ! * DESCRIPTION
      ! *
      ! * Set mime part data source from named file.
      ! */
      !CURL_EXTERN CURLcode curl_mime_filedata(curl_mimepart *part,
      !                                        const char *filename);
      curl_mime_filedata(curl_mimepart part, *CSTRING filename), CURLcode, C, RAW, NAME('curl_mime_filedata')

      !/*
      ! * NAME curl_mime_data_cb()
      ! *
      ! * DESCRIPTION
      ! *
      ! * Set mime part data source from callback function.
      ! */
      !CURL_EXTERN CURLcode curl_mime_data_cb(curl_mimepart *part,
      !                                       curl_off_t datasize,
      !                                       curl_read_callback readfunc,
      !                                       curl_seek_callback seekfunc,
      !                                       curl_free_callback freefunc,
      !                                       void *arg);
      curl_mime_data_cb(curl_mimepart part, curl_off_t datasize, curl::ReadWriteProcType readfunc, curl::SeekProcType seekfunc, curl::FreeProcType freefunc, LONG arg), CURLcode, C, RAW, NAME('curl_mime_data_cb')

      !/*
      ! * NAME curl_mime_subparts()
      ! *
      ! * DESCRIPTION
      ! *
      ! * Set mime part data source from subparts.
      ! */
      !CURL_EXTERN CURLcode curl_mime_subparts(curl_mimepart *part,
      !                                        curl_mime *subparts);
      curl_mime_subparts(curl_mimepart part, curl_mime subparts), CURLcode, C, RAW, NAME('curl_mime_subparts')

      !/*
      ! * NAME curl_mime_headers()
      ! *
      ! * DESCRIPTION
      ! *
      ! * Set mime part headers.
      ! */
      !CURL_EXTERN CURLcode curl_mime_headers(curl_mimepart *part,
      !                                       struct curl_slist *headers,
      !                                       int take_ownership); 
      curl_mime_headers(curl_mimepart part, LONG headers, LONG take_ownership), CURLcode, C, RAW, NAME('curl_mime_headers')
    END
  END

!region static functions
!endregion

!region TCurlMimeClass
TCurlMimeClass.Construct      PROCEDURE()
  CODE
  
TCurlMimeClass.Destruct       PROCEDURE()
  CODE
  SELF.Kill()
  
TCurlMimeClass.Init           PROCEDURE(*TCurlClass curl)
easy                            CURL, AUTO
  CODE
  IF NOT curl &= NULL
    easy = curl.GetHandle()
    ASSERT(easy)
    IF easy
      SELF.Kill()
      SELF.mime = curl_mime_init(easy)
    ELSE
      curl::DebugInfo('TCurlMimeClass.Init: easy handle was not initialized.')
    END
  ELSE
    curl::DebugInfo('TCurlMimeClass.Init: null reference.')
  END
  
TCurlMimeClass.Kill           PROCEDURE()
  CODE
  IF SELF.mime
    curl_mime_free(SELF.mime)
    SELF.mime = 0
  END

TCurlMimeClass.GetMime        PROCEDURE()
  CODE
  RETURN SELF.mime
  
TCurlMimeClass.AddPart        PROCEDURE()
  CODE
  ASSERT(SELF.mime)
  RETURN curl_mime_addpart(SELF.mime)

TCurlMimeClass.SetData        PROCEDURE(curl_mimepart part, STRING pData)
  CODE
  ASSERT(part)
  RETURN curl_mime_data(part, pData, LEN(CLIP(pData)))
  
TCurlMimeClass.SetFileData    PROCEDURE(curl_mimepart part, STRING pFileName)
szFile                          CSTRING(MAX_PATH + 1)
  CODE
  ASSERT(part)
  szFile = LONGPATH(pFileName)
  RETURN curl_mime_filedata(part, szFile)
  
TCurlMimeClass.SetName        PROCEDURE(curl_mimepart part, STRING pName)
szName                          CSTRING(LEN(CLIP(pName)) + 1)
  CODE
  ASSERT(part)
  szName = CLIP(pName)
  RETURN curl_mime_name(part, szName)

TCurlMimeClass.SetEncoder     PROCEDURE(curl_mimepart part, STRING pEncoding)
szEncoding                      CSTRING(LEN(CLIP(pEncoding)) + 1)
  CODE
  ASSERT(part)
  szEncoding = CLIP(pEncoding)
  RETURN curl_mime_encoder(part, szEncoding)
  
TCurlMimeClass.SetType        PROCEDURE(curl_mimepart part, STRING pType)
szType                          CSTRING(LEN(CLIP(pType)) + 1)
  CODE
  ASSERT(part)
  szType = CLIP(pType)
  RETURN curl_mime_type(part, szType)

TCurlMimeClass.SetFileName    PROCEDURE(curl_mimepart part, STRING pRemoteFileName)
szFileName                      CSTRING(LEN(CLIP(pRemoteFileName)) + 1)
  CODE
  ASSERT(part)
  szFileName = CLIP(pRemoteFileName)
  RETURN curl_mime_filename(part, szFileName)

TCurlMimeClass.SetHeaders     PROCEDURE(curl_mimepart part, TCurlSList headers, BOOL take_ownership = FALSE)
  CODE
  RETURN curl_mime_headers(part, headers.GetList(), take_ownership)

TCurlMimeClass.SetSubparts    PROCEDURE(curl_mimepart part, TCurlMimeClass subparts)
  CODE
  RETURN curl_mime_subparts(part, subparts.GetMime())
  
!endregion