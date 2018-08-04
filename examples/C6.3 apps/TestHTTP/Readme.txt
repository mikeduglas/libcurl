This TestHTTP.App is a Clarion 6.3 app.
Demonstrate some of the LibCurl HTTP functionality

It has been made as simple as possible and easy to follow to allow quick and easy implementation into your own app.

It demonstrates:
1) File Upload via HTTP.
2) File Download via HTTP.
3) Using PUT, GET, DELETE and POST via HTTP.

Can use both NON Secure and Secure (SSL/TLS) Connections.
Secure Connections supported - TLSv1, SSLv2, SSLv3, TLSv1.0, TLSv1.1, TLSv1.2, TLSv1.3(Not Yet Implemented).
If selected to use Secure connections and no secure version is selected libcurl will automatically use the version supported by the server.
Shows the use of the dynamic IDynStr to allow you to capture the response without knowing the size of the response.
Shows how to save a response to a file.

There are much more functionality in libcurl.
Please take a look at the other examples.