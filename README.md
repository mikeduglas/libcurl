# libcurl
libcurl for Clarion

## Required C6.3 and newer.

[libcurl home page](https://curl.haxx.se/libcurl/)  
[FAQ](https://clarionhub.com/t/libcurl-faq-https-github-com-mikeduglas-libcurl/1965)  
[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)  
[Clarion 6.3 examples](https://github.com/mikeduglas/libcurl/tree/master/examples/C6.3%20apps)  


## How to install
Hit the 'Clone or Download' button and select 'Download Zip'.
Now unzip libcurl-master.zip into a temporary folder somewhere.

Copy the contents of...

Bin into %ClarionRoot%\Accessory\bin  
Lib into %ClarionRoot%\Accessory\lib  
Libsrc into %ClarionRoot%\Accessory\libsrc\win  
Template into %ClarionRoot%\Accessory\template\win  

Where %ClarionRoot% is the folder into which you installed Clarion 10.

Now, with no APPs or DCTs loaded in the Clarion IDE, register the libcurl template by selecting...
Clarion main menu - Tools - 'Edit Template Registry' - click on 'Register' and use the dialog to navigate to %ClarionRoot%\Accessory\template\win and double-click on libcurl.tpl and click 'Open'.

You should see 'Class LibcurlTpl - Libcurl template' and the LibcurlGloExt and LibcurlLocExt templates are now in the list.
Click on the Save icon 'floppy disk' and the Green arrow to close.


## Recent changes
v1.33
- NEW: Added an option to specify which HTTP version to use, and constants for use with the CURLOPT_HTTP_VERSION option:
```
CURLOPT_HTTP_VERSION          EQUATE(84 + CURLOPTTYPE_LONG)             !Specify which HTTP version to use! This must be set to one of the CURL_HTTP_VERSION* enums set below.
!  /* These enums are for use with the CURLOPT_HTTP_VERSION option. */ 
CURL_HTTP_VERSION_NONE              EQUATE(0)                           !setting this means we don't care, and that we'd like the library to choose the best possible for us!
CURL_HTTP_VERSION_1_0               EQUATE(1)                           !please use HTTP 1.0 in the request
CURL_HTTP_VERSION_1_1               EQUATE(2)                           !please use HTTP 1.1 in the request
CURL_HTTP_VERSION_2_0               EQUATE(3)                           !please use HTTP 2 in the request
CURL_HTTP_VERSION_2TLS              EQUATE(4)                           !use version 2 for HTTPS, version 1.1 for HTTP
CURL_HTTP_VERSION_2_PRIOR_KNOWLEDGE EQUATE(5)                           !please use HTTP 2 without HTTP/1.1 Upgrade
CURL_HTTP_VERSION_LAST              EQUATE(6)                           !*ILLEGAL* http version
```
- NEW: TCurlClass.SetPostFields(*IDynStr pPostFields)

v1.32
- CHG: TCurlMailClass now adds Date header field (ex.: "Date: Wed, 22 Aug 2018 12:32:25 +0300").

v1.31
- FIX: TCurlMailClass failed if encoded body size was exceeded 16K (original body size of ~12885 bytes or larger).

v1.30
- FIX: new TCurlClass.SetPostFields method could affect the behavior of other stuff, now it is changed and sets post fields only if passed argument is not empty. To clear post fields use SetOpt calls.
- Updated [Clarion 6.3 examples](https://github.com/mikeduglas/libcurl/tree/master/examples/C6.3%20apps).

v1.29
- NEW: TCurlClass.SetPostFields(STRING pPostFields)
- NEW: TCurlMailClass now allows to send html emails with embedded (inline) images:
```
curl.Body('<html><body><p>HTML content</p><img src="cid:myLogo"/><p>with embedded images.</p></body></html>')
curl.AddEmbeddedImage('d:\Images\logo.jpg', 'myLogo')  !- 'myLogo' is an image id and appears in html "src" attribute: <img src="cid:myLogo"/>
curl.ContentType('text/html')  !- not required in this case (embedded images force to use text/html)
curl.AltBody('This is an alternative plain text. Embedded images will appear as attachments.')  !- for those email clients not supporting html.
```

new TCurlMailClass methods:
```
AddEmbeddedImage(STRING pFilename, STRING pCid, <STRING pName>)  !forces to use 'text/html' content-type
AltBody(STRING pBody)    !forces to use 'text/html' content-type
```

**Thank to Guillermo who has provided these changes in TCurlMailClass**


[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)
