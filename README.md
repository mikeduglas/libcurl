# libcurl
libcurl for Clarion

## Required C6.3 and newer.

[libcurl home page](https://curl.haxx.se/libcurl/)  
[FAQ](https://clarionhub.com/t/libcurl-faq-https-github-com-mikeduglas-libcurl/1965)  
[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)  
[Clarion 6.3 examples](https://github.com/mikeduglas/libcurl/tree/master/examples/C6.3%20apps). Last update 2018-10-22.  


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
v1.39

- CHG: Now uses libcurl v7.61.1, see [changelog](https://curl.haxx.se/changes.html) for details.
> curl 7.61.1_8 was built and statically linked with
> 
> OpenSSL 1.1.1
> brotli 1.0.7
> libssh2 1.8.0
> nghttp2 1.34.0
> zlib 1.2.11

v1.38
- CHG: TCurlFtpClass uses 'ftp' default protocol; TCurlMailClass uses 'smtp' default protocol.
- FIX: possible memory leak in TCurlFtpClass and TCurlDropboxClass.

v1.37

- CHG: TCurlFtpClass: PublicKeyMD5 field was added to TSSHSettings group  
```
TSSHSettings                  GROUP, TYPE, PRE(TSSHSettings)
AuthMethod                      CURLSSH_AUTH_ENUM     !allowed SSH authentication methods
PublicKeyFile                   STRING(256)           !Used by scp/sftp to do public/private key authentication
PrivateKeyFile                  STRING(256)           !Used by scp/sftp to do public/private key authentication
KnownHosts                      STRING(256)           !set the SSH knownhost file name to use
KeyPassword                     STRING(40)            !password for the SSL or SSH private key
PublicKeyMD5                    STRING(32)            !used by scp/sftp to verify the host's public key
                              END
```

v1.36

- NEW: curl::StrError(CURLcode errcode) static function returns  meaningful error message.  
- FIX: TCurlMimeClass.SetDataCB(part,hugedata,TRUE) did not dispose allocated memory for hugedata.  
- CHG: TCurlMailClass now internally uses curl mime api.  
- CHG: TCurlMailClass allows both '\\' and '/' in attached file names.  

v1.35

- NEW: TCurlMimeClass.SetDataCB method sets a callback-based data source for a mime part's body.  
- CHG: MimePost example now demonstrates both SetData and SetDataCB approaches.


[Full version history](https://github.com/mikeduglas/libcurl/blob/master/history/changes.md)
