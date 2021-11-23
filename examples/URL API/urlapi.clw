  PROGRAM

  INCLUDE('libcurl.inc')

  MAP
    GetUrlPart(CURLUPart what, UNSIGNED flags = 0), STRING
    PrintUrlParts()
  END


uapi                          TCurlUrlApiClass
url                           STRING('https://example.com:449/foo/bar?name=moo')
rc                            CURLUcode, AUTO



  CODE
  !Create a handle that holds URL info and resources.
  uapi.Init() !- comment this line to test new curl::url:StrError() function.

  !If successful, this stores the URL in its individual parts within the handle.
  rc = uapi.SetPart(CURLUPART_URL, url, 0)
  IF rc = CURLUE_OK
    PrintUrlParts()
    
    !Redirect to a relative URL.
    !When the handle already has parsed a URL, setting a relative URL will make it "redirect" to adapt to it.
    uapi.SetPart(CURLUPART_URL, '../test?another', 0)
    curl::DebugInfo('Redirected URL: '& GetUrlPart(CURLUPART_URL))

    !Set individual URL parts.
    !A user can opt to set individual parts, either after having parsed a full URL or instead of parsing such.
    uapi.SetPart(CURLUPART_USER, 'john', 0)
    uapi.SetPart(CURLUPART_PASSWORD, 'doe', 0)
    uapi.SetPart(CURLUPART_PATH, '/index.html', 0)
    uapi.SetPart(CURLUPART_FRAGMENT, 'anchor', 0)
    curl::DebugInfo('Modified URL: '& GetUrlPart(CURLUPART_URL))

    !Append to the query.
    !An application can append a string to the right end of the query part with the CURLU_APPENDQUERY flag.
    uapi.SetPart(CURLUPART_QUERY, 'hat=1', CURLU_APPENDQUERY)
    uapi.SetPart(CURLUPART_QUERY, 'shoes=2', CURLU_APPENDQUERY)
    curl::DebugInfo('Appended URL: '& GetUrlPart(CURLUPART_URL))

    !The appended string can of course also get URL encoded on add, and if asked, the encoding will skip the '=' character. 
    !For example, append candy=M&M to what we already have, and URL encode it to deal with the ampersand in the data:
    uapi.SetPart(CURLUPART_QUERY, 'candy=M&M', CURLU_APPENDQUERY+CURLU_URLENCODE)
    curl::DebugInfo('Encoded URL: '& GetUrlPart(CURLUPART_URL))
  ELSE
    MESSAGE('Parse failed: '& curl::url:StrError(rc))
  END
  
  !When done with it, clean it up
  uapi.Cleanup()  !-- not required, automatically called by destructor
  
  MESSAGE('Done!')
    
GetUrlPart                    PROCEDURE(CURLUPart what, UNSIGNED flags = 0)
part                            STRING(256)
  CODE
  uapi.GetPart(what, part, flags)
  RETURN CLIP(part)
  
PrintUrlParts                 PROCEDURE()
  CODE
  !Get individual URL parts.
  !When a URL has been parsed or parts have been set, you can extract those pieces from the handle at any time.
  !Extracted parts are not URL decoded unless the user asks for it with the CURLU_URLDECODE flag.
  
  curl::DebugInfo('URL: '& GetUrlPart(CURLUPART_URL))
  curl::DebugInfo('Scheme: '& GetUrlPart(CURLUPART_SCHEME))
  curl::DebugInfo('User: '& GetUrlPart(CURLUPART_USER))
  curl::DebugInfo('Password: '& GetUrlPart(CURLUPART_PASSWORD))
  curl::DebugInfo('Options: '& GetUrlPart(CURLUPART_OPTIONS))
  curl::DebugInfo('Host: '& GetUrlPart(CURLUPART_HOST))
  curl::DebugInfo('Port: '& GetUrlPart(CURLUPART_PORT))
  curl::DebugInfo('Path: '& GetUrlPart(CURLUPART_PATH))
  curl::DebugInfo('Query: '& GetUrlPart(CURLUPART_QUERY))
  curl::DebugInfo('Fragment: '& GetUrlPart(CURLUPART_FRAGMENT))
