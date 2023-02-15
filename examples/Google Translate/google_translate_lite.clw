!- Google Translate API Lite example.
!- It depends on these projects:
!- cJSON (https://github.com/mikeduglas/cJSON)
!- printf (https://github.com/mikeduglas/printf)

  PROGRAM

  PRAGMA('project(#pragma link(libcurl.lib))')

  INCLUDE('libcurl.inc')
  INCLUDE('cjson.inc')

  MAP
    INCLUDE('printf.inc')

    GTranslateLite(STRING pText, STRING pSourceLang, STRING pTargetLang), STRING
  END

SourceText                    STRING(255)
SourceLang                    STRING(2)
TranslatedText                STRING(255)
TargetLang                    STRING(2)

Window                        WINDOW('Google Translate API Lite'),AT(,,362,196),CENTER,GRAY, |
                                FONT('Segoe UI',9)
                                PROMPT('Source text:'),AT(13,14),USE(?PROMPT1)
                                ENTRY(@s255),AT(79,15,269),USE(SourceText)
                                PROMPT('Source language:'),AT(13,42),USE(?PROMPT3)
                                ENTRY(@s2),AT(79,43),USE(SourceLang)
                                PROMPT('Target language:'),AT(13,66),USE(?PROMPT4)
                                ENTRY(@s2),AT(79,63),USE(TargetLang)
                                BUTTON('Translate!'),AT(78,95,51),USE(?bTranslate),DEFAULT
                                PROMPT('Translated text:'),AT(13,130),USE(?PROMPT2)
                                ENTRY(@s255),AT(79,131,269),USE(TranslatedText)
                                BUTTON('Close'),AT(309,173,39),USE(?BUTTON1),STD(STD:Close)
                              END
  CODE
  IF 1
    SourceText = 'How to add translation features to your program.'
    SourceLang = 'en' !- english
    TargetLang = 'ru' !- russian
  ELSE
    SourceText = 'Привет! Как дела?'
    SourceLang = 'ru'
    TargetLang = 'en'
  END
  
  OPEN(Window)
  ACCEPT 
    CASE ACCEPTED()
    OF ?bTranslate
      SETCURSOR(CURSOR:Wait)
      !- clear TranslatedText first
      TranslatedText = ''
      DISPLAY(?TranslatedText)
      !- get translated text
      TranslatedText = GTranslateLite(SourceText, SourceLang, TargetLang)
      DISPLAY(?TranslatedText)
      SETCURSOR()
    END
  END
  
GTranslateLite                PROCEDURE(STRING pText, STRING pSourceLang, STRING pTargetLang)
api_url                         STRING('https://translate.googleapis.com/translate_a/single')
curl                            TCurlHttpClass
curlrc                          CURLE, AUTO
hresp                           &IDynStr
jf                              cJSONFactory
jroot                           &cJSON
jsentences                      &cJSON    !sentences array
jsentence                       &cJSON    !sentence item
i                               LONG, AUTO
aresp                           ANY
  CODE
  hresp &= NewDynStr()
  
  curl.Init()
  curl.SetSSLVerifyHost(FALSE)
  curl.SetSSLVerifyPeer(FALSE)
  
  !- url parameters:
  ! sl=en: source language or 'auto'
  ! tl=ru: target language
  ! dt=t: translate
  ! dj=1: return json with item names
  ! q=text: text to be translated
  ! ie=UTF-8: input encoding
  ! oe=UTF-8: output encoding
  
  curlrc = curl.SendRequest( |
    api_url, | 
    printf('client=gtx&sl=%s&tl=%s&dt=t&dj=1&q=%u&ie=UTF-8&oe=UTF-8', pSourceLang, pTargetLang, json::ToUtf8(SourceText)), | 
    hresp)
  IF curlrc <> CURLE_OK
    !- connection error
    
    MESSAGE(curl.StrError(curlrc))
    aresp = pText
  ELSIF curl.GetResponseCode() <> 200
    !- http error (for example, error 429 (Too many requests)))
    
    MESSAGE(hresp.Str())
    aresp = pText
  ELSE
    !- success, parse json response
    
    jroot &= jf.Parse(hresp.Str())
    IF NOT jroot &= NULL
      !- json response in this form:
      !- {"sentences":[{"trans":"Text 1 ","orig":"Text 1","backend":1},{"trans":"Text 2","orig":"Text 2","backend":1}],"src":"ru"}
      
      jsentences &= jroot.GetObjectItem('sentences')
      IF NOT jsentences &= NULL
        !- concatenate all sentences
        LOOP i = 1 TO jsentences.GetArraySize()
          jsentence &= jsentences.GetArrayItem(i)
          !- convert from utf-8 to current code page
          aresp = aresp & json::FromUtf8(jsentence.GetValue('trans'))
        END
      END
      
      jroot.Delete()
    ELSE
      !- not a json response
      
      MESSAGE('json parsing error')
      aresp = pText
    END
  END

  !- cleanup
  hresp.Kill()
  DisposeDynStr(hresp)

  !- return translated text
  RETURN CLIP(aresp)
