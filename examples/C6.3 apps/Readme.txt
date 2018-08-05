All App's in this folder was done in Clarion 6.3.
You should be able to open and compile them in any newer Clarion version.
All App's uses the LibCurl Global Template.

1) FTPManager
Simple example client using libcurl as a FTP client.
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


All App's have been made as simple as possible and easy to follow to allow quick and easy implementation into your own app.