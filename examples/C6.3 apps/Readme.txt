All App's in this folder was done in Clarion 6.3.
You should be able to open and compile them in any newer Clarion version.
All App's uses the LibCurl Global Template.

1) FTPManager
Simple example client using libcurl as a FTP client.
Well not that simple, it is a full fledged working app that can be used to do all your work.
Handles both FTP and SFTP.

2) TestHTTP
It demonstrates:
a) File Upload via HTTP.
b) File Download via HTTP.
c) Web Services.

3) HTTPDownload (File Download via HTTP)
Contains two App's.
a) HTTPDownloadNoProgress app is very basic with No Progress indicators.
b) HTTPDownloadProgress app is more advanced and have a Progress indicator.

4) HTTPUpload (File Upload via HTTP)
Contains two App's.
a) HTTPUploadNoProgress app is very basic with No Progress indicators.
b) HTTPUploadProgress app is more advanced and have a Progress indicator.

5) WebServices
Demonstrates using Web Services.
PUT, GET, DELETE and POST
Can use both NON Secure and Secure (SSL/TLS) Connections.
Secure Connections supported - TLSv1, SSLv2, SSLv3, TLSv1.0, TLSv1.1, TLSv1.2, TLSv1.3(Not Yet Implemented).
If selected to use Secure connections and no secure version is selected libcurl will automatically use the version supported by the server.
Shows the use of the dynamic IDynStr to allow you to capture the response without knowing the size of the response.
Shows how to save a response to a file.

6) FTPUpload (File Upload via FTP/SFTP)
For SSH connections can handle: Any, PublicKey, Password, Host, Keyboard, Agent.
Contains two App's.
a) FTPUpload app is very basic with No Debug Information, uses local libcurl control template.
b) FTPUploadDebug app is more advanced and Debug Information also displayed on the screen, uses local libcurl control template, require some Global Embed Code.

7) FTPDownload (File Download via FTP/SFTP)
For SSH connections can handle: Any, PublicKey, Password, Host, Keyboard, Agent.
Contains two App's.
a) FTPDownload app is very basic with No Debug Information, uses local libcurl control template.
b) FTPDownloadDebug app is more advanced and Debug Information also displayed on the screen, uses local libcurl control template, require some Global Embed Code.

8) FTPUpload (File Upload via FTP/SFTP with Creation of Remote Directories/Folders)
For SSH connections can handle: Any, PublicKey, Password, Host, Keyboard, Agent.
Contains two App's.
a) FTPUploadDirs app is very basic with No Debug Information, uses local libcurl control template.
b) FTPUploadDirsDebug app is more advanced and Debug Information also displayed on the screen, uses local libcurl control template, require some Global Embed Code.
You can have as many or as little Directories/Folders to create as you need.
This example was made with 5 Directories/Folders but you can leave any of them empty except the first one and the Directories/Folders will be created from 1 to 5.
If the Directory/Folder already exists libcurl will just return a error and continue creating the rest of the Directories/Folders.

All App's have been made as simple as possible and easy to follow to allow quick and easy implementation into your own app.
I hope it will help others.

PS: I need to say that it is not me that is this clever.
I have the idea, I do the basic, I add the libcurl stuff/code, I usually mess it up.
Mike then guides me and fix my mistakes.
Thanks Mike.
Regards
Johan de Klerk