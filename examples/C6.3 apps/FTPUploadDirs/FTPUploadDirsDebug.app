      �   �  tOpS                                                           '   '   '   8   8   8   8   M   M   M   M   M   M   h   h   h   h   h   h   h   h   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                              '   '   '   8   8   8   8   M   M   M   M   M   M   h   h   h   h   h   h   h   h   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      � � �  �   �   M   8         '   h            �    �
 
  j          .���#   w   {   �   4   �      +   /   �      ������������������������������������������������������������������������������������������������������������   � � �   �> 
 �      �      4            �YB v6     �YB v6            �      4            �ZB v6     �ZB v6         ����������������������������������������������������������������������������������������������������������������������   ���  ��
 .���{   .{���   � 	
 ��N u6 ��P u6 Upload:Url �� �� � '  ��@s255 �Upload : Url: Upload : Url � A����� � w�4 ��?Upload:Url:Prompt  Upload:Url �Upload:Url  � � R� � � � � "-Upload : Url: d  8oad:Url:Prompt d
D  �  � � � �  � %@s255    �ad:Url    � � � � 0   @s255    �ad:Url   p( � � � �  � 0  
    �� ��������������������������������������������������������������������������������������������������������������������������   Q
f
  �U
 .���w   .w���   K 	
 ��N u6 ��P u6 bShowUploadPwd � �� � /  ��@n3 �b Show Upload Pwd: b Show Upload Pwd � 5����� T w�( ��bShowUploadPwd  bShowUploadPwd �� � ^� � � � � "&b Show Upload Pwd 8 DwUploadPwd   �  � � � � � %@n3  �wUploadPwd   ( � � � �  @ (     p( �� �����x   .x���   � 	
 ��N u6 ��P u6 Upload:Pwd �2 �� � &  ��@s50 �Upload : Pwd: Upload : Pwd � A����� � w�4 ��?Upload:Pwd:Prompt  Upload:Pwd �Upload:Pwd  � � R� � � � � "-Upload : Pwd:  m 8oad:Pwd:Prompt  
D  �  � � � �  � %@s50  �ad:Pwd    � � � � 0   @s50  �ad:Pwd   p( � � � �  � 0   �� �����y   .y���   � 	
 ��N u6 ��P u6 Upload:User �2 �� � (  ��@s50 �Upload : User: Upload : User � A����� � w�4 ��?Upload:User:Prompt Upload:User Upload:User � � R� � � � � "-Upload : User: m 8oad:User:Prompt 
D  �  � � � �  � %@s50  �ad:User   � � � � 0   @s50  �ad:User  p( � � � �  � 0   �� �����z   .z���   � 	
 ��N u6 �- y6 Upload:LocalFilename �� �� � =  ��@s255 �Upload : Local Filename: Upload : Local Filename � f����� � w�8 ��Upload:LocalFilename pt Upload:LocalFilename d:F | ame ?Upload:LocalFilename:Prompt Upload : Local Filename: < � 
� � � � � "5, @ad : Filename:  @oad:Filename:Prompt 
P  � @ � � � �  ` %@s255 :U �ad:Filename    � � � � 8   @s255    �ad:Filename  |  � � � �  � $  
�� �����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������   ���  >��
 �   /     dirStruct = CLIP(dirStruct) & dirs[dirNdx]
 
 .res = Curl.CreateDir(Upload:Url, dirStruct)
 IF res = CURLE_OK
 P?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Create Dir '& dirNdx &' OK<13,10>'
 ELSE
 �?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Create Dir '& dirNdx &' ERROR '&CLIP(res)&' ('&CLIP(Curl.StrError(res))&')<13,10>'
 END
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 >DISPLAY(?txtLog)
  END
  
  RETURN dirStruct
  
�J`  ld +*
ResetCurl PROCEDURE()
sprotocol CSTRING(20), AUTO
ssh LIKE(TSSHSettings), AUTO
res �CURLcode, AUTO
  CODE
  ! Reset Curl
  Curl.Reset()
  ?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Reset: Curl Reset<13,10>'
  SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
  DISPLAY(?txtLog)

  ! set SSH
  IF Upload:UseSSH
 ! SSH settings
 ssh:AuthMethod = CLIP(Upload:AuthMethod)
 2ssh:PublicKeyFile  = CLIP(Upload:PublicKeyFile)
 3ssh:PrivateKeyFile = CLIP(Upload:PrivateKeyFile)
 ssh:KnownHosts = CLIP(Upload:KnownHosts)
 ssh:KeyPassword = CLIP(Upload:KeyPassword)

 res = Curl.SSHAuth(ssh)
 IF res <> CURLE_OK
 EMESSAGE(Curl.StrError(res), 'Set SSHAuth Error', ICON:Exclamation)
 L?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SSHAuth: ERROR Setting<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 	RETURN
 ELSE
 B?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SSHAuth: Set<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 /END
  END

  ! set port
  IF Upload:Port
 \res = Curl.SetOpt(CURLOPT_PORT, Upload:Port)
  ELSIF NOT INSTRING(':', Upload:Url, 1, 1)
 +IF Upload:AuthMethod = CURLSSH_AUTH_NONE
 &res = Curl.SetOpt(CURLOPT_PORT, 21)
 ELSE
 /res = Curl.SetOpt(CURLOPT_PORT, Upload:Port)
 #END
  END
  IF res <> CURLE_OK
 NMESSAGE(Curl.StrError(res), 'SetOpt(CURLOPT_PORT) Error', ICON:Exclamation)
 R?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SetOpt (Port): ERROR Setting<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 RETURN
  ELSE
 Z?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SetOpt (Port): '&CLIP(Upload:Port)&'<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 TDISPLAY(?txtLog)
  END

  ! set user:password
  IF Upload:User AND Upload:Pwd
 1res = Curl.SetUserPwd(Upload:User, Upload:Pwd)
 IF res <> CURLE_OK
 DMESSAGE(Curl.StrError(res), 'SetUserPwd Error', ICON:Exclamation)
 U?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SetOpt (Usr/Pwd): ERROR Setting<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 	RETURN
 ELSE
 K?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SetOpt (Usr/Pwd): Set<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 �END
  END

  ! set protocol
  sprotocol = CHOOSE(Upload:AuthMethod = CURLSSH_AUTH_NONE, 'ftp', 'sftp')
  curl.SetDefaultProtocol(sprotocol)
�ld  �n 1+%curlXFerInfoBeforeParent   +curl   +*�  q?ProgressUpload{PROP:Progress} = ulnow * 100.0 / Upload:FileSize  !-- we know actual file size Upload:FileSize
 'DISPLAY(?ProgressUpload)
  
�N�  � �+%curlDebugCallbackBeforeParent   +curl   +*X  ! skip file contents on upload/download
  CASE ptype
  OF CURLINFO_DATA_IN
  OROF CURLINFO_DATA_OUT
  OROF CURLINFO_SSL_DATA_IN
  OROF CURLINFO_SSL_DATA_OUT
 �RETURN
  END
 
  ?txtLog{PROP:Text} = ?txtLog{PROP:Text} & CLIP(ptypetxt) &': '& CLIP(ptext)&'<13,10>'
  SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
  DISPLAY(?txtLog)
���  �� �> �      �  4 

 :�G u6 \-- �6  ��   AYg  ���

 �   +   OP:RangeLow} = 0
  SELF.DownloadProgress.Feq{PROP:RangeHigh} = 100
  SELF.DownloadProgress.Feq{PROP:Progress} = 0
  DISPLAY(SELF.UploadProgress.Feq)
  
� 
+*TCurlFtpClassEx.BuildUrl =PROCEDURE(STRING pUrl, STRING pUser, TSSHSettings pSSH)
url STRING(256)
sprotocol �CSTRING(20)
  CODE
  sprotocol = CHOOSE(pSSH.AuthMethod = CURLSSH_AUTH_NONE, 'ftp://', 'sftp://')
  
  IF pUser AND NOT INSTRING('@', pUser, 1, 1)
 9url = sprotocol & CLIP(pUser) &'@'& CLIP(pUrl)
  ELSE
 Qurl = sprotocol & CLIP(pUrl)
  END

  IF url AND url[LEN(CLIP(url))] <> '/'
 ;url = CLIP(url) & '/'
  END
  
  RETURN CLIP(url)

� 
g+*}TCurlFtpClassEx.DebugCallback PROCEDURE(CURL_INFOTYPE ptype, STRING ptypetxt, STRING ptext)
sMsg CSTRING(32768)
nTextLen LONG, AUTO
EM_SETSEL LONG(00B1h)
EM_REPLACESEL �LONG(00C2h)
  CODE
  ! skip file contents on upload/download
  CASE ptype
  OF CURLINFO_DATA_IN
  OROF CURLINFO_DATA_OUT
  OROF CURLINFO_SSL_DATA_IN
  OROF CURLINFO_SSL_DATA_OUT
 [RETURN
  END
  
  sMsg = CLIP(ptypetxt) &': '& CLIP(ptext)
  
  IF NOT SELF.hwndLog
  curl::DebugInfo(sMsg)
  ELSE
 ! get length of log text
 EnTextLen = curl::SendMessage(SELF.hwndLog, WM_GETTEXTLENGTH, 0, 0)
 #!textbox limit 30,000 characters
 IF nTextLen + LEN(sMsg) <= 30
  ! position to the end of text
 Acurl::SendMessage(SELF.hwndLog, EM_SETSEL, nTextLen, nTextLen)
 ! append text
 Fcurl::SendMessage(SELF.hwndLog, EM_REPLACESEL, TRUE, ADDRESS(sMsg))
 ELSE
 ! clear textbox
 :curl::SendMessage(SELF.hwndLog, EM_SETSEL, 1, nTextLen)
 Fcurl::SendMessage(SELF.hwndLog, EM_REPLACESEL, TRUE, ADDRESS(sMsg))
 END
  END
  
� 
+*DTCurlFtpClassEx.XFerInfo �PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
  CODE
  PARENT.XFerInfo(dltotal, dlnow, ultotal, ulnow)
  
  IF SELF.DownloadProgress.Feq
 IF dlnow
 ,IF SELF.DownloadProgress.Current <> dlnow
 (SELF.DownloadProgress.Current = dlnow
 
 oSELF.DownloadProgress.Feq{PROP:Progress} = SELF.DownloadProgress.Current * 100 / SELF.DownloadProgress.Total
 %DISPLAY(SELF.DownloadProgress.Feq)
 END
 -END
  END

  IF SELF.UploadProgress.Feq
 IF ulnow
 *IF SELF.UploadProgress.Current <> ulnow
 &SELF.UploadProgress.Current = ulnow
 
 iSELF.UploadProgress.Feq{PROP:Progress} = SELF.UploadProgress.Current * 100 / SELF.UploadProgress.Total
 #DISPLAY(SELF.UploadProgress.Feq)
 END
 END
  END

  RETURN 0
� �� -   �-  � 

 9\ w6 3< �6 � +%GlobalMap   +*� MODULE('Win API')
  curl::SendMessage(HWND hWnd, LONG nMsg, LONG wParam, LONG lParam), LONG, PASCAL, PROC, NAME('SendMessageA')
END
�]  �    ��.   Text}))
 DISPLAY(?txtLog)
�@3  F? 1+%curlXFerInfoBeforeParent   +curl   +*�  q?ProgressUpload{PROP:Progress} = ulnow * 100.0 / Upload:FileSize  !-- we know actual file size Upload:FileSize
 DISPLAY(?ProgressUpload)
 YIELD
��R  ,S �+%curlDebugCallbackBeforeParent   +curl   +*X  ! skip file contents on upload/download
  CASE ptype
  OF CURLINFO_DATA_IN
  OROF CURLINFO_DATA_OUT
  OROF CURLINFO_SSL_DATA_IN
  OROF CURLINFO_SSL_DATA_OUT
 �RETURN
  END
 
  ?txtLog{PROP:Text} = ?txtLog{PROP:Text} & CLIP(ptypetxt) &': '& CLIP(ptext)&'<13,10>'
  SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
  DISPLAY(?txtLog)
��S  (U  ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������� )  �ZZ  �H
 �   4   �4  > 	
 ��U |6 �8- �6 '   w� ��   H  � ���� | ` �   +!Upload File via FTP/SFTP n &� 
�6 �  Segoe UI ttoWindow  ?Upload:AuthMethod:Prompt �. T qp  �General Url: �� @s255 � Remote Dir 1: � @s255 � Remote Dir 2: � @s255 � @N4. N4.@s255 25@s255 25SSH   � / Remote Dir 3: a @s255 TP@n4 ?String1 EOP  ���  ?String1 � ��  Dx    � �  �� � ?Sheet1 ?Sheet1 %T  ��   ��  &Start! 0?bUpload 	�  (H   � 2  � @ � ?ProgressUpload ?Progress1  	 H   &@s255 l ?GeneralTab ?Tab1  �&\  �� �    T  �?SSHTab ?Tab2   & 0L  @  d � Upload:AuthMethod Public Key File: @s255 3@s255 IN?Upload:Url:Prompt  
d  �   
 (  � �  � � User: �?Upload:Url    8X 	B ' a � � � I� Remote Dir 4: se?Upload:RemoteDir1:Prompt ��?Upload:RemoteDir:Prompt +Remote File Name: @
�  ��  
 7  � �  � \ �	    @s20 %Upload:RemoteDir1   Upload:RemoteDir Remote Dir 5: Di   ���  ,  (H B 6 a  � x� Password:  2 (?Upload:RemoteDir2:Prompt &?Upload:RemoteDir2:Prompt ��@s20 �� Port: �  �
�  ��  
 F  � �   � ^p
  ,  Use SSH Upload:RemoteDir2 oaUpload:RemoteDir2 CT Show password i@s255 mp �T  Pp B E a   $ � Known Hosts: d?Upload:RemoteDir3:Prompt � ?Upload:RemoteDir3:Prompt 	CPrivate Key File:   
�  �  
 U  � �  \ � ^|  T  @s255  �Upload:RemoteDir3   Upload:RemoteDir3 akKey Password: Di@s40 omp (
|  x� B T a l L x	 Uploading File: ?Upload:RemoteDir4:Prompt   ?Upload:RemoteDir4:Prompt CTClose d:STD:Close  L
	  0  
 d  � �  � � ^�  |  @s50 �� Upload:RemoteDir4  bUpload:RemoteDir4 OSLocal File Name:  H	 {��� �	  �� B c a � t	 x,
 Public Key MD5: ?Upload:RemoteDir5:Prompt na?Upload:RemoteDir5:Prompt   Upload:PublicKeyMD5 
,
  0	X	  
 s  � �  p �	 =�  �	   (��� Upload:RemoteDir5 �	Upload:RemoteDir5 �   h �  ��
  �	�	 B r a � 0 * $��� Upload:LocalFilename ERT@  X
x
 B � �  8  ]� Upload:PublicKeyMD5 ?Upload:RemoteFileName:Prompt   ?Upload:RemoteFileName:Prompt AS  �  �    
�  �
�
  � �  � �  � � j�  @   #��� Upload:RemoteFileName   Upload:RemoteFileName  ? "��� Upload:User Upload:Pwd  D  d� � �  0 DUpload:Port ?Upload:LocalFilename:Prompt Hel
�   $  
 �  � �  � $4 !��� ?Upload:User:Prompt 
�  h�  
 �  � �  P P   bShowUploadPwd U 8P  �� 	B �  � � @ 8 z���  �?Upload:Pwd:Prompt  
�  <  � �  � �  � �   Upload:UseSSH :P �  t� 	� �  � �   @ � *Upload:PublicKeyFile Upl &��� �  �� 	>�  � � � l [  y��� ?Upload:Port:Prompt ?Upload:Port:Prompt  x���  w��� 
   8X  
 �  � �    � F�  �  Upload:KnownHosts t Upload:Port Upload:KeyPassword  �  � B �  �
 ( 
�? ���@ 	�? | � 2Upload:PrivateKeyFile UNUpload:UseSSH ke   L� 	� �  � � h 
# �� B � / Y@ % 5���  4��� ?UploadingFileString 	?String2 
� �� B 
 � �   � 'b?txtLog 'Any|#-1|None|#0|PublicKey|#1|Password|#2|Host|#4|Keyboard|#8|Agent|#16' 16' �  �� 	� (  � �  l � ?Upload:PublicKeyFile:Prompt 
p  ��   C  � �  � �    �
 <  0  � @@� 	E B ^ � � L ���  2���  @?Upload:PrivateKeyFile:Prompt   
D  ��   Q  � �  @ � , Upload:ConnectionTimeout ec  D� @d E P ^ � D 1���  0��� ?Upload:KnownHosts:Prompt   
  p�   _  � �  � P ( ?Upload:PublicKeyMD5:Prompt | @�� E ^ ^ � D .���  ,��� ?Upload:KeyPassword:Prompt  
�  8`   m  � �  � X ( Upload:ConnectionTimeout d l0 @�� E l ^ � @PublicKey authentication settings: a ���  �lic Key MD5: :2 ���  
�   �    *  � �  X 

�" Ld  � �E �  �e   ?bClose  �Close   	 ��  }� /  � h p 
�  
D  � �  � �  � E?Upload:ConnectionTimeout:Prompt c C?Upload:ConnectionTimeout:Prompt  ($ !�  �
 t   �? p�@ 	�? pConnection Timeout (Seconds):   Upload File via FTP/SFTP and Create Directories/Folders 
p  � �   |  � �  H	 &?Upload:PublicKeyMD5:Prompt    @X�	 E { ^ �    l   `� � � � � "Guide W ?xTTGuide W 	 0   � �<  (      WOW WOW WOW WOW WOW  ,� X  ������������� :  |�*  ��
 .���#   .#���   � 	
 \�= |6 x�= |6 Upload:RemoteDir3 �� �� � 9  ��@s255 �Upload : Remote Dir 3: Upload : Remote Dir 3 � ���D �  wD�   
D   , � � � � �    $ p  � � � � �    @s255 t @s255 EE � , � � � �  � +�?Upload:RemoteDir3:Prompt :P @t  :Upload : Remote Dir 3: RUpload:RemoteDir3 :RUpload:RemoteDir3 
    �� ���$   .$���   � 	
 V�= |6 \�= |6 Upload:RemoteDir2 �� �� � 9  ��@s255 �Upload : Remote Dir 2: Upload : Remote Dir 2 � ���D �  wD�   
D   , � � � � �    $ p  � � � � �    @s255 t @s255 EE � , � � � �  � +�?Upload:RemoteDir2:Prompt :P @t  :Upload : Remote Dir 2: RUpload:RemoteDir2 :RUpload:RemoteDir2 
    �� ����*&   .&���     	
 p�- y6 ��- y6 Upload:RemoteFileName �� �� � A  ��@s255 �Upload : Remote File Name: Upload : Remote File Name � ���d �  wd�   
D   , � � � � �   $ p   � � � � �    @s255 t @s255    � 8 � � � �  � +v?Upload:RemoteFileName:Prompt :P Pt  @Upload : Remote File Name:  Upload:RemoteFileName   Upload:RemoteFileName e    "� � � �� �����(   .(���   � 	
 �fU x6 Ӯ= |6 Upload:RemoteDir1 �� �� � 9  ��@s255 �Upload : Remote Dir 1: Upload : Remote Dir 1 � ���D �  wD8  
D   , � � � � �  � % p  � � � � �    @s255 t @s255 EE � $ � � � �  � +^?Upload:RemoteDir1:Prompt PrUpload : Remote Dir 1:  Upload:RemoteDir1 otUpload:RemoteDir1 ot #
    �� �����*   .*���   � 	
 US x6 �ZS x6 Upload:FileSize � �� � 2  ��@n13 �Upload : File Size: Upload : File Size � ���D �  wD�   
D   , � � � � �  � % p  � � � � �    @n13 pt @n13 HEE �   � � � �  � +� 0 ERT?Upload:FileSize:Prompt Upload : File Size: Upload:FileSize Upload:FileSize    NFOI DDI_CON�� �����,   .,���   � 	
 �"Q w6 �0< �6 Upload:KeyPassword �( �� � 8  ��@s40 �Upload : Key Password: Upload : Key Password � ���D �  wD�   
D   , � � � � �    $ p  � � � � �    @s40 pt @s40 HEE � , � � � �  � +�?Upload:KeyPassword:Prompt : @pt  Upload : Key Password:  Upload:KeyPassword  Upload:KeyPassword     �� ����D.   ..���   : 	
 /Q w6 /< �6 Upload:KnownHosts �  �� � 7  ��@s255 �Upload : Known Hosts: Upload : Known Hosts � ����@ w��   
D   , � � � � �    $ p  � � � � �    @s50 pt @s255 EE � , � � � �  � +|?Upload:KnownHosts:Prompt :P ht   Upload : Known Hosts:   Upload:KnownHosts P Upload:KnownHosts 
 
|  d�   � � � �  � $ �� � � � �  J?Upload:KnownHosts:Prompt ivUpload : Known Hosts: loUpload:KnownHosts il <T � � � � 2Upload:KnownHosts   $ 8Upload:PrivateKeyFile �|   �� �����0   .0���   � 	
 �Q w6 �-< �6 Upload:PrivateKeyFile �  �� � A  ��@s255 �Upload : Private Key File: Upload : Private Key File � ���P( w�   
D   , � � � � �   $ p   � � � � �    @s50 pt @s255 EE � 8 � � � �  � +�?Upload:PrivateKeyFile:Prompt :P �t � Upload : Private Key File: ?Upload:PrivateKeyFile   Upload:PrivateKeyFile   
�  t�   � � � �  � $ � � � � �  V?Upload:PrivateKeyFile:Prompt   Upload : Private Key File: eUpload:PrivateKeyFile EX Xp � � � � 2Upload:PrivateKeyFile �| * l  W � � � � /Export &Project File... ?ID_FILE_EXPORTPRJ  , �  � � � � � �� �����1   .1���   � 	
 ��P w6 ,< �6 Upload:PublicKeyFile �  �� � ?  ��@s255 �Upload : Public Key File: Upload : Public Key File � ���P( w�   
D   , � � � � �   $ p   � � � � �    @s50 pt @s255 ff � 8 � � � �  � +�?Upload:PublicKeyFile:Prompt :Pr �   Upload : Public Key File: �Upload:PublicKeyFile ��Upload:PublicKeyFile   
�  t�   � � � �  � $ � � � � �  ?Upload:PublicKeyFile:Prompt 6Upload : Public Key File: TeUpload:PublicKeyFile TEX Xp � � � � 2Upload:PublicKeyFile  �| * l  W � � � � /Export &Project File... ?ID_FILE_EXPORTPRJ  , �  � � � � � �� �����2   .2���   � 	
 ��P w6 COQ w6 Upload:AuthMethod � �� � 5  ��@s2 �Upload : Auth Method: Upload : Auth Method � ���D �  wD�   
D   , � � � � �    $ p  � � � � �    @s2 @s2  �  fff � , � � � �  � +�?Upload:AuthMethod:Prompt :P @t   Upload : Auth Method: ��Upload:AuthMethod ��Upload:AuthMethod �   �� ����N4   .4���   D 	
 [pN w6 �wN w6 Upload:UseSSH � �� � -  ��@n3 �Upload : Use SSH: Upload : Use SSH � ����0�  w��   
D   , � � � � �  � % p  � � � � �    @n3 @n3  �  HEE �   � � � �  � +V � ERT?Upload:UseSSH:Prompt WUpload : Use SSH:   Upload:UseSSH  ?Upload:UseSSH    d| � � � � � $DUpload:UseSSH   Upload : Use SSH 18    �� �����5   .5���   � 	
 �
N w6 �mN w6 Upload:Port �
 �� � -  ��@N4. �Upload : Port: Upload : Port ���21 ��� �  w�  
D   , � � � � �  � % p  � � � � �   @N4. 0  @N4. 0 : �  � � � �  � +\?Uploa:dPort:Prompt @N4. pt Uploa : d Port: Uploa:dPort Upload:Port 
\  D�   � � � �  � $ �� � � � � �    �? 2?Upload:Port:Prompt Upload : Port:  Upload:Port  �� ��������������������������������������������������������������������������������������������������������������������������������������� O  37�  �; 
  j      j   1 

 1�G u6 1�G u6 
   j   1 

 G�G u6 G�G u6 
   j   1 

 m�G u6 m�G u6 ��   String1  �  ?Upload:AuthMethod  �  ?Upload:AuthMethod:Prompt  �    ?Upload:ConnectionTimeout:Prompt  �  ?Upload:Port  �  ?Upload:PublicKeyFile  �  ?Upload:PublicKeyMD5  �  ?Upload:RemoteDir1  �  ?Upload:Url  �  ?Upload:UseSSH �   �  Unhide�  ?UploadingFileString  �  ?bClose  �  ?txtLog  %CheckedEnables �%Control   %CheckedControl1 %� %CheckedEnables   %CheckedControl1Action %� %CheckedEnables  �  ?ProgressUpload  �  ?String1  �  ?Upload:AuthMethod  �  ?Upload:AuthMethod:Prompt  �    ?Upload:ConnectionTimeout:Prompt  �  ?Upload:Port  �  ?Upload:PublicKeyFile  �  ?Upload:PublicKeyMD5  �  ?Upload:RemoteDir1  �  ?Upload:Url  �  ?Upload:UseSSH  �  ?UploadingFileString  �  ?bClose  �  ?txtLog  %UncheckedAssigns �%Control  �  ?Upload:UseSSH �   �   %UncheckedAssignVariable "� %UncheckedAssigns  �  ?Upload:UseSSH �   5��   2���%UncheckedAssignValue %� %UncheckedAssigns  �  ?Upload:UseSSH �   �  21�   �  CURLSSH_AUTH_NONE%UnCheckedHides �%Control  �  ?Upload:UseSSH �   %UnCheckedControl %� %UnCheckedHides  �  ?Upload:UseSSH �   �  ?SSHTab%UnCheckedControlAction %� %UnCheckedHides  �  ?ProgressUpload  �  ?String1  �  ?Upload:AuthMethod  �  ?Upload:AuthMethod:Prompt  �    ?Upload:ConnectionTimeout:Prompt  �  ?Upload:Port  �  ?Upload:PublicKeyFile  �  ?Upload:PublicKeyMD5  �  ?Upload:RemoteDir1  �  ?Upload:Url  �  ?Upload:UseSSH �   �  Hide�  ?UploadingFileString  �  ?bClose  �  ?txtLog  %UnCheckedEnables �%Control   %UnCheckedControl1 %� %UnCheckedEnables   %UnCheckedControl1Action %� %UnCheckedEnables  �  ?ProgressUpload  �  ?String1  �  ?Upload:AuthMethod  �  ?Upload:AuthMethod:Prompt  �    ?Upload:ConnectionTimeout:Prompt  �  ?Upload:Port  �  ?Upload:PublicKeyFile  �  ?Upload:PublicKeyMD5  �  ?Upload:RemoteDir1  �  ?Upload:Url  �  ?Upload:UseSSH  �  ?UploadingFileString  �  ?bClose  �  ?txtLog  %CheckedDisables �%Control   %CheckedDisableControl %� %CheckedDisables   %CheckedDisableControlAction %� %CheckedDisables  �  ?ProgressUpload  �  ?String1  �  ?Upload:AuthMethod  �  ?Upload:AuthMethod:Prompt  �    ?Upload:ConnectionTimeout:Prompt  �  ?Upload:Port  �  ?Upload:PublicKeyFile  �  ?Upload:PublicKeyMD5  �  ?Upload:RemoteDir1  �  ?Upload:Url  �  ?Upload:UseSSH  �  ?UploadingFileString  �  ?bClose  �  ?txtLog  %UnCheckedDisables �%Control   %UnCheckedDisableControl %� %UnCheckedDisables   %UnCheckedDisableControlAction %� %UnCheckedDisables  �  ?ProgressUpload  �  ?String1  �  ?Upload:AuthMethod  �  ?Upload:AuthMethod:Prompt  �    ?Upload:ConnectionTimeout:Prompt  �  ?Upload:Port  �  ?Upload:PublicKeyFile  �  ?Upload:PublicKeyMD5  �  ?Upload:RemoteDir1  �  ?Upload:Url  �  ?Upload:UseSSH  �  ?UploadingFileString  �  ?bClose  �  ?txtLog  %ITHasDllTemplate %�  � %FatherExists %�  � �g p      p   ] 

 ZG r6 ��V x6 ��  ���ABC$ABC �  ��V x6     - �m    p   c 

 #G r6 �1< �6 .    ��    ���ABC$GENERATED �  �1< �6   �Gr      r   =   
 :�G u6 �1< �6 � Main    �4 IH   ���ABC$Window �s �6 �1<   �1< �6 LibcurlTpl$LibcurlLocExt �� �%curlBaseClass %�  �  TCurlFtpClass%curlVar %�  �  curl        {���(���$���#���"���!������z���&���*���y���x���w���5������4���2���1���0���.���,������   �.���   .���   � 	
 �%- �6 �1< �6 Upload:PublicKeyMD5 �  �� � <  ��@s32 �Upload : Public Key MD5: Upload : Public Key MD5 � ���D �  wD<  
D   , � � � � �  � % p  � � � � �    @s32 pt @s32 HEE � ( � � � �  � +�?Upload:PublicKeyMD5:Prompt Upload : Public Key MD5: ey Upload:PublicKeyMD5 Upload:PublicKeyMD5    MD5 �� ����U   .���   K 	
 �Sb }6 B�b }6 Upload:ConnectionTimeout � �� � E  ��@n-14 �Upload : Connection Timeout: Upload : Connection Timeout � ����`�  w�`  
D   , � � � � �   $ p ( � � � � �   @n-14 t @n-14 EE � D � � � �  � +�@n-14 RT?Upload:ConnectionTimeout:Prompt    Upload : Connection Timeout: ��Upload:ConnectionTimeout @�Upload:ConnectionTimeout ec 
�  �    � � � �  @ $ �$ � � � � �    �? ]?Upload:ConnectionTimeout:Prompt pt Upload:ConnectionTimeout ec Upload : Connection Timeout: !(   ad : Connection Timeout Sec:     �� �����   .���   � 	
 =0` }6 �3` }6 Loc:HowManyDirs � �� � 3  ��@n3 �Loc : How Many Dirs: Loc : How Many Dirs � ���D �  wD�   
D   , � � � � �  � % p  � � � � �    @n3 @n3  �  HEE � $ � � � �  � +� 4 ERT?Loc:HowManyDirs:Prompt Loc : How Many Dirs: ���Loc:HowManyDirs Loc:HowManyDirs    �  ��  ��  �� ����F   .���   < 	
 ;(< }6 �1< }6 !Upload:BuildRemoteDirStruct �� �� � O  ��@s255 �Upload : Build Remote Dir Struct: Upload : Build Remote Dir Struct � ���l �  wl   
D   , � � � � �   $ p , � � � � �    @s255 t @s255 EE � H � � � �  � +�?Upload:BuildRemoteDirStruct:Prompt  dmpt Upload : Build Remote Dir Struct: ldUpload:BuildRemoteDirStruct Upload:BuildRemoteDirStruct    uild�� �����   .���   � 	
 �\ |6 �6\ |6  Upload:AutomaticCreateDirs � �� � I  ��@n3 �Upload : Automatic Create Dirs: Upload : Automatic Create Dirs � ���0�  w�   
D   , � � � � �  � % p  � � � � �    @n3 @n3  �  HEE � | � � � �  � +V   ERT?AutoCreateDirs:Prompt Auto Create Dirs:   AutoCreateDirs ? �CreateDirs   d� � � � � � $vUpload:AutomaticCreateDirs  Upload:AutomaticCreateDirs r �Upload:AutoCreateDirs   Upload : Automatic Create Dirs   ) ��d 2  �
�� �����!   .!���   � 	
 ,�= |6 �= |6 Upload:RemoteDir5 �� �� � 9  ��@s255 �Upload : Remote Dir 5: Upload : Remote Dir 5 � ���D �  wD�   
D   , � � � � �    $ p  � � � � �    @s255 t @s255 EE � , � � � �  � +�?Upload:RemoteDir5:Prompt :P @t  :Upload : Remote Dir 5: RUpload:RemoteDir5 :RUpload:RemoteDir5 
    �� ���"   ."���   � 	
 x�= |6 ,�= |6 Upload:RemoteDir4 �� �� � 9  ��@s255 �Upload : Remote Dir 4: Upload : Remote Dir 4 � ���D �  wD�   
D   , � � � � �    $ p  � � � � �    @s255 t @s255 EE � , � � � �  � +o?Upload:RemoteDir4:Prompt :P @t  :Upload : Remote Dir 4: RUpload:RemoteDir4 :RUpload:RemoteDir4 
    �� ���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������� j  J",','  �'
 �      �  ���� 
 :�G u6 �2< �6 G +%WindowManagerMethodCodeSection   +Init   +(),BYTE   +*K Upload:Url = 'ftp.yoururl.com'
 Upload:LocalFilename = 'FileNameToUpload.Txt'
 Upload:RemoteFilename = 'FileNameToUpload.Txt'
 Upload:User = 'username'
 Upload:Pwd = 'password'
 Upload:Port = 21
  Upload:ConnectionTimeout = 60
 Upload:AuthMethod = CURLSSH_AUTH_NONE
 Upload:UseSSH = 0

 Upload:RemoteDir1 = 'subfol1'
 Upload:RemoteDir2 = 'subfol2'
 Upload:RemoteDir3 = 'subfol3'
 Upload:RemoteDir4 = 'subfol4'
 Upload:RemoteDir5 = 'subfol5'

 !CURLSSH_AUTH_ANY EQUATE(-1) 	!~0 +!/* all types supported by the server */
 !CURLSSH_AUTH_NONE 
EQUATE(0) *!/* none allowed, silly but complete */
 !CURLSSH_AUTH_PUBLICKEY 	EQUATE(01b) *!(1<<0) !/* public/private key files */
 !CURLSSH_AUTH_PASSWORD 
EQUATE(00010b) !(1<<1) !/* password */
 !CURLSSH_AUTH_HOST EQUATE(00100b)  !(1<<2) !/* host key files */
 !CURLSSH_AUTH_KEYBOARD 
EQUATE(01000b) &!(1<<3) !/* keyboard interactive */
 !CURLSSH_AUTH_AGENT 	EQUATE(10b) /!(1<<4) !/* agent (ssh-agent, pageant...) */
 !CURLSSH_AUTH_DEFAULT QEQUATE(CURLSSH_AUTH_ANY)
M�A  5G    +%LocalDataAfterClasses   +*T   MAP
 WriteFile()
 !BuildRemoteDirStruct(), STRING
 ResetCurl()
  END
��  � @+%ControlEventHandling   +?bUpload   +Accepted   +*  MWriteFile()
�yL  �L    +%ControlHandling   +?bShowUploadPwd   +*5  f?Upload:Pwd{PROP:Password} = 1 - bShowUploadPwd
�XN  �N    +%ProcedureRoutines   +*BWriteFile PROCEDURE()
url STRING(2048), AUTO
res CCURLcode, AUTO
!- to get file size and file name w/o path
FilesQ !QUEUE(FILE:Queue), PRE(FilesQ)
 !END
  CODE
 ! create dir struct
 IF Upload:RemoteDir1
 7Upload:BuildRemoteDirStruct = BuildRemoteDirStruct()
 L!Upload:BuildRemoteDirStruct = '/subfol1/subfol2/subfol3/subfol4/subfol5'
 ELSE
 $Upload:BuildRemoteDirStruct = '/'
 
END
  
 ! Reset to do preparation
 ResetCurl()

 ! set connection timeout
 Fres = Curl.SetOpt(CURLOPT_CONNECTTIMEOUT, Upload:ConnectionTimeout)
 IF res <> CURLE_OK
 XMESSAGE(Curl.StrError(res), 'SetOpt(CURLOPT_CONNECTTIMEOUT) Error', ICON:Exclamation)
 U?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SetOpt (Timeout): ERROR Setting<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 	RETURN
 ELSE
 r?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SetOpt (Timeout): '&CLIP(Upload:ConnectionTimeout)&' Seconds<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 END

 url = Upload:Url
 !-- append remote dir
 )IF url AND Upload:BuildRemoteDirStruct
 6url = CLIP(url) & CLIP(Upload:BuildRemoteDirStruct)
 V?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Append Remote Dir: '&CLIP(url)&'<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 !-- trailing slash
 (IF url AND url[LEN(CLIP(url))] <> '/'
 url = CLIP(url) & '/'
 END
 O?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Trailing /: '&CLIP(url)&'<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 END

 FREE(FilesQ)
 <DIRECTORY(FilesQ, CLIP(Upload:LocalFileName), ff_:NORMAL)
 GET(FilesQ, 1)

 *?UploadingFileString{Prop:Hide} = FALSE
 R?UploadingFileString{PROP:Text} = 'Uploading File: '&CLIP(Upload:LocalFileName)
 Upload:FileSize = FilesQ:Size
 ?ProgressUpload{Prop:Hide} = FALSE
  
 !-- build remote file name
 IF Upload:RemoteFileName
 0url = CLIP(url) & CLIP(Upload:RemoteFileName)
 ELSE
 /url = CLIP(url) & CLIP(Upload:LocalFileName)
 END

 ! File Size to Debug Text
 P?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'File Size: '&FilesQ:Size&'<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)

 ! Start Upload
 ]?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Upload Started: '&FORMAT(CLOCK(),@T4)&'<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)

 2res = Curl.WriteFile(url, Upload:LocalFileName)
 IF res = CURLE_OK
 ^?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Upload Finished: '&FORMAT(CLOCK(),@T4)&'<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 yMESSAGE('File uploaded||URL: '&CLIP(url)&'||File Name: '&CLIP(Upload:LocalFileName), 'SUCCESS - WriteFile', ICON:Tick)
 ELSIF res = -1
 Y?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'File Upload: Cannot open local file<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 sMESSAGE('Cannot open local file||File Name: '&CLIP(Upload:LocalFileName), 'ERROR - WriteFile', ICON:Exclamation)
 ELSE
 P?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'File Upload: Upload failed<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 �MESSAGE('Upload failed: '& Curl.StrError(res)&'||URL: '&CLIP(url)&'||File Name: '&CLIP(Upload:LocalFileName), 'ERROR - WriteFile', ICON:Exclamation)
 END
 FREE(FilesQ)

 !-- reset progress
 %?ProgressUpload{PROP:Progress} = 0
 %DISPLAY(?ProgressUpload)  
�  �. +*BuildRemoteDirStruct 	PROCEDURE()
dirs "STRING(255), DIM(5), AUTO
dirNdx LONG, AUTO
dirStruct STRING(1024)
res CURLcode, AUTO
  CODE
 dirs[1] = Upload:RemoteDir1
 dirs[2] = Upload:RemoteDir2
 dirs[3] = Upload:RemoteDir3
 dirs[4] = Upload:RemoteDir4
 dirs[5] = Upload:RemoteDir5
 
 ResetCurl()

 LOOP dirNdx = 1 TO 5
 IF NOT dirs[dirNdx]
 BREAK
 END

 $IF SUB(dirs[dirNdx], 1, 1) <> '/'
 #dirStruct = CLIP(dirStruct) &'/'
 END
 
 -dirStruct = CLIP(dirStruct) & dirs[dirNdx]
 
 .res = Curl.CreateDir(Upload:Url, dirStruct)
 IF res = CURLE_OK
 P?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Create Dir '& dirNdx &' OK<13,10>'
 ELSE
 �?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Create Dir '& dirNdx &' ERROR '&CLIP(res)&' ('&CLIP(Curl.StrError(res))&')<13,10>'
 END
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 END
 
 RETURN dirStruct
  
��.  @3 +*ResetCurl PROCEDURE()
sprotocol CSTRING(20), AUTO
ssh LIKE(TSSHSettings), AUTO
res CURLcode, AUTO
  CODE
 ! Reset Curl
 Curl.Reset()
 G?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Reset: Curl Reset<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)

 ! set SSH
 IF Upload:UseSSH
 ! SSH settings
 ssh:AuthMethod = CLIP(Upload:AuthMethod)
 2ssh:PublicKeyFile  = CLIP(Upload:PublicKeyFile)
 3ssh:PrivateKeyFile = CLIP(Upload:PrivateKeyFile)
 ssh:KnownHosts = CLIP(Upload:KnownHosts)
 ssh:KeyPassword = CLIP(Upload:KeyPassword)
 3ssh:PublicKeyMD5   = CLIP(Upload:PublicKeyMD5)

 res = Curl.SSHAuth(ssh)
 IF res <> CURLE_OK
 EMESSAGE(Curl.StrError(res), 'Set SSHAuth Error', ICON:Exclamation)
 L?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SSHAuth: ERROR Setting<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 	RETURN
 ELSE
 B?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SSHAuth: Set<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 END
 END

 ! set port
 IF Upload:Port
 /res = Curl.SetOpt(CURLOPT_PORT, Upload:Port)
 ,ELSIF NOT INSTRING(':', Upload:Url, 1, 1)
 +IF Upload:AuthMethod = CURLSSH_AUTH_NONE
 &res = Curl.SetOpt(CURLOPT_PORT, 21)
 ELSE
 /res = Curl.SetOpt(CURLOPT_PORT, Upload:Port)
 END
 END
 IF res <> CURLE_OK
 NMESSAGE(Curl.StrError(res), 'SetOpt(CURLOPT_PORT) Error', ICON:Exclamation)
 R?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SetOpt (Port): ERROR Setting<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 	RETURN
 ELSE
 Z?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SetOpt (Port): '&CLIP(Upload:Port)&'<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 END

 ! set user:password
  IF Upload:User AND Upload:Pwd
 1res = Curl.SetUserPwd(Upload:User, Upload:Pwd)
 IF res <> CURLE_OK
 DMESSAGE(Curl.StrError(res), 'SetUserPwd Error', ICON:Exclamation)
 U?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SetOpt (Usr/Pwd): ERROR Setting<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 	RETURN
 ELSE
 K?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'SetOpt (Usr/Pwd): Set<13,10>'
 +SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
 DISPLAY(?txtLog)
 END
 END

 ! set protocol
 Ksprotocol = CHOOSE(Upload:AuthMethod = CURLSSH_AUTH_NONE, 'ftp', 'sftp')
 %curl.SetDefaultProtocol(sprotocol)
 l?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Set Protocol (SetDefaultProtocol): '&CLIP(sprotocol)&'<13,10>'
 %SELECT(?txtLog, LEN(?txtLog{PROP:.   �������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������� �  �'�'�'  �; 
  j      j       1            �SG r6     �SG r6         j       1            STG r6     STG r6      �'   j       ����         @�G u6     �1< �6     �%ClassItem %�  �  Default�  WindowToolbar%DefaultBaseClassType %� %ClassItem  �  Default�  WindowManager�  WindowToolbar�  ToolbarClass%ActualDefaultBaseClassType %� %ClassItem  �  Default�    �  WindowToolbar�    %ClassLines %�%ClassItem   %ProcedureParameters �   %ProcedureParameterName %� %ProcedureParameters   %ProcedureParameterType %� %ProcedureParameters   %ProcedureParameterDefault %� %ProcedureParameters   %ProcedureParameterOmitted � %ProcedureParameters   %ProcedureParameterByReference � %ProcedureParameters   %Parameters %�  �    %ReturnValue "�   %WindowOperationMode %�  �  Use WINDOW setting%INISaveWindow �  �    %ProcedureDisableEnhanceFocus �  �    %ProcedureUseEnterInsteadTabOverride �  �    %WindowUseEnterInsteadTab �  �   %ProcedureUseEnterInsteadTabExcludeListCombo �  �    %ProcedureUseEnterInsteadTabEnableNextTabStop �  �    %ProcedureUseEnterInsteadTabExcludeG �  �   %WindowUseEnterInsteadTabExclude %�   %GlobalObject %� %ClassItem  �  Default�  NO�  WindowToolbar�  NO%ThisObjectName %� %ClassItem  �  Default�
 
 ThisWindow�  WindowToolbar�  Toolbar%UseDefaultABCBaseClass � %ClassItem  �  Default�   �  WindowToolbar�   %UseABCBaseClass � %ClassItem  �  Default�   �  WindowToolbar�   %ABCBaseClass %� %ClassItem  �  Default�  ADOBlob�  WindowToolbar�  ADOBlob%ExtBaseClass %� %ClassItem   %BaseClassIncludeFile %� %ClassItem   %DeriveFromBaseClass � %ClassItem  �  Default�    �  WindowToolbar�    %NewMethods �%ClassItem   %NewMethodName %� %NewMethods   %NewMethodPrototype %� %NewMethods   %NewClassPropertyItems �%ClassItem   %NewClassProperty %� %NewClassPropertyItems   %NewClassDataType %� %NewClassPropertyItems  �  WindowToolbar  %NewClassOtherType %� %NewClassPropertyItems   %NewClassDataIsRef � %NewClassPropertyItems   %NewClassDataSize %� %NewClassPropertyItems   %NewClassDataDim1 %� %NewClassPropertyItems   %NewClassDataDim2 %� %NewClassPropertyItems   %NewClassDataDim3 %� %NewClassPropertyItems   %NewClassDataDim4 %� %NewClassPropertyItems   %ClassMethods �%ClassItem   %ClassMethodName %� %ClassMethods   %ClassMethodPrototype %� %ClassMethods   %ClassPropertyItems �%ClassItem   %ClassProperty %� %ClassPropertyItems   %ClassDataType %� %ClassPropertyItems  �  WindowToolbar  %ClassOtherType %� %ClassPropertyItems   %ClassDataIsRef � %ClassPropertyItems   %ClassDataSize %� %ClassPropertyItems   %ClassDataDim1 %� %ClassPropertyItems   %ClassDataDim2 %� %ClassPropertyItems   %ClassDataDim3 %� %ClassPropertyItems   %ClassDataDim4 %� %ClassPropertyItems   %WindowStyles �   %WindowStyleFontName %� %WindowStyles   %WindowStyleFontNameVariable %� %WindowStyles   %WindowStyleFontNameIsVariable � %WindowStyles   %WindowStyleFontSize %� %WindowStyles   %WindowStyleFontSizeVariable %� %WindowStyles   %WindowStyleFontSizeIsVariable � %WindowStyles   %WindowStyleFontStyle %� %WindowStyles   %WindowStyleFontStyleVariable %� %WindowStyles   %WindowStyleFontStyleIsVariable � %WindowStyles   %WindowStyleFontColor %� %WindowStyles   %WindowStyleFontCharSet %� %WindowStyles   %WindowStyleForegroundNormal � %WindowStyles   %WindowStyleForegroundNormalVariable %� %WindowStyles   %WindowStyleForegroundNormalIsVariable � %WindowStyles   %WindowStyleBackgroundNormal � %WindowStyles   %WindowStyleBackgroundNormalVariable %� %WindowStyles   %WindowStyleBackgroundNormalIsVariable � %WindowStyles   %WindowStyleForegroundSelected � %WindowStyles   %WindowStyleForegroundSelectedVariable %� %WindowStyles   %WindowStyleForegroundSelectedIsVariable � %WindowStyles   %WindowStyleBackgroundSelected � %WindowStyles   %WindowStyleBackgroundSelectedVariable %� %WindowStyles   %WindowStyleBackgroundSelectedIsVariable � %WindowStyles   %WindowStylePicture %� %WindowStyles   %WindowStylePictureVariable %� %WindowStyles   %WindowStylePictureIsVariable � %WindowStyles   %WindowStyleOtherListboxes %�   %ProcedureAutoBindFields �   %ProcedureAutoBindField %� %ProcedureAutoBindFields   %ProcedureAutoBindFieldTPL %� %ProcedureAutoBindFields   %ProcedureAutoBindProcedures �   %ProcedureAutoBindProcedure %� %ProcedureAutoBindProcedures   %ProcedureAutoBindProcedureTPL %� %ProcedureAutoBindProcedures   %ProcedureAutoBindFieldsIgnored �   %ProcedureAutoBindFieldIgnored %� %ProcedureAutoBindFieldsIgnored   %ProcedureAutoBindProceduresIgnored �   %ProcedureAutoBindProcedureIgnored %� %ProcedureAutoBindProceduresIgnored   %ProcedureAutoBindValidToAddField �  �    %ProcedureUserBindFields �   %ProcedureUserBindField "� %ProcedureUserBindFields   %ProcedureAutoBindFieldIgnore � %ProcedureAutoBindFields   %ProcedureUserBindProcedures �   %ProcedureUserBindProcedure  � %ProcedureUserBindProcedures   %ProcedureAutoBindProcedureIgnore � %ProcedureAutoBindProcedures   %ProcedureUserBindExpressions �   %ProcedureUserBindExpressionName %� %ProcedureUserBindExpressions   %ProcedureUserBindExpression %� %ProcedureUserBindExpressions   %ExtUITabIcon %� %Control   %ExtUITabStyleOverrideGlobal � %Control   %ExtUITabStyle %� %Control  �  ?ProgressUpload�  Default�  ?Sheet1�  Default�  ?String1�  Default�  ?Upload:AuthMethod�  Default�  ?Upload:AuthMethod:Prompt�  Default�    ?Upload:ConnectionTimeout:Prompt�  Default�  ?Upload:Port�  Default�  ?Upload:PublicKeyFile�  Default�  ?Upload:PublicKeyMD5�  Default�  ?Upload:RemoteDir1�  Default�  ?Upload:Url�  Default�  ?Upload:UseSSH�  Default�  ?UploadingFileString�  Default�  ?bClose�  Default�  ?txtLog�  Default%ButtonAction %� %Control  �  ?ProgressUpload�  No Special Action�  ?String1�  No Special Action�  ?Upload:AuthMethod�  No Special Action�  ?Upload:AuthMethod:Prompt�  No Special Action�    ?Upload:ConnectionTimeout:Prompt�  No Special Action�  ?Upload:Port�  No Special Action�  ?Upload:PublicKeyFile�  No Special Action�  ?Upload:PublicKeyMD5�  No Special Action�  ?Upload:RemoteDir1�  No Special Action�  ?Upload:Url�  No Special Action�  ?Upload:UseSSH�  No Special Action�  ?UploadingFileString�  No Special Action�  ?bClose�  No Special Action�  ?bUpload�  No Special Action�  ?txtLog�  No Special Action%ButtonRunName %� %Control   %ButtonRunParameters %� %Control   %ButtonProcedure  � %Control   %ButtonThread � %Control   %ButtonThreadStack %� %Control  �  ?ProgressUpload��a  �  ?String1��a  �  ?Upload:AuthMethod��a  �  ?Upload:AuthMethod:Prompt��a  �    ?Upload:ConnectionTimeout:Prompt��a  �  ?Upload:Port��a  �  ?Upload:PublicKeyFile��a  �  ?Upload:PublicKeyMD5��a  �  ?Upload:RemoteDir1��a  �  ?Upload:Url��a  �  ?Upload:UseSSH��a  �  ?UploadingFileString��a  �  ?bClose�  25000�  ?bUpload�  25000�  ?txtLog��a  %ButtonParameters %� %Control   %ButtonReturnValueAssignment "� %Control   %ButtonReturnValueReferenceAssign � %Control   %ButtonRequest %� %Control  �  ?ProgressUpload�  None�  ?String1�  None�  ?Upload:AuthMethod�  None�  ?Upload:AuthMethod:Prompt�  None�    ?Upload:ConnectionTimeout:Prompt�  None�  ?Upload:Port�  None�  ?Upload:PublicKeyFile�  None�  ?Upload:PublicKeyMD5�  None�  ?Upload:RemoteDir1�  None�  ?Upload:Url�  None�  ?Upload:UseSSH�  None�  ?UploadingFileString�  None�  ?bClose�  None�  ?bUpload�  None�  ?txtLog�  None%ButtonThreadParameters %� %Control   %ButtonThreadReturnValueAssignment "� %Control   %PreLookupKey #� %Control   %PreLookupField $� %Control  �  ?Upload:Port �  ?Upload:PublicKeyFile �  ?Upload:PublicKeyMD5 %PreLookupProcedure  � %Control  �  ?Upload:Port    �  ?Upload:PublicKeyFile    �  ?Upload:PublicKeyMD5    %PreLookupProcedureParameters %� %Control  �  ?Upload:Port�    �  ?Upload:PublicKeyFile�    �  ?Upload:PublicKeyMD5�    %PostLookupKey #� %Control   %PostLookupField $� %Control  �  ?Upload:Port �  ?Upload:PublicKeyFile �  ?Upload:PublicKeyMD5 %PostLookupProcedure  � %Control  �  ?Upload:Port    �  ?Upload:PublicKeyFile    �  ?Upload:PublicKeyMD5    %PostLookupProcedureParameters %� %Control  �  ?Upload:Port�    �  ?Upload:PublicKeyFile�    �  ?Upload:PublicKeyMD5�    %PostLookupDuringValidate � %Control  �  ?ProgressUpload�   �  ?String1�   �  ?Upload:AuthMethod�   �  ?Upload:AuthMethod:Prompt�   �  ?Upload:ConnectionTimeout�   �    ?Upload:ConnectionTimeout:Prompt�   �  ?Upload:KeyPassword�   �  ?Upload:KnownHosts�   �  ?Upload:LocalFilename�   �  ?Upload:Port�   �  ?Upload:PrivateKeyFile�   �  ?Upload:PublicKeyFile�   �  ?Upload:PublicKeyMD5�   �  ?Upload:Pwd�   �  ?Upload:RemoteDir1�   �  ?Upload:RemoteDir2�   �  ?Upload:RemoteDir3�   �  ?Upload:RemoteDir4�   �  ?Upload:RemoteDir5�   �  ?Upload:RemoteFileName�   �  ?Upload:Url�   �  ?Upload:UseSSH�   �  ?Upload:User�   �  ?UploadingFileString�   �  ?bClose�   �  ?txtLog�   %LookupAssign �%Control   %MoreTarget "� %LookupAssign   %MoreField %� %LookupAssign   %ForceWindowRefresh � %Control   %CheckedAssigns �%Control  �  ?Upload:UseSSH �   �   %CheckedAssignVariable "� %CheckedAssigns  �  ?Upload:UseSSH �   5����   2���%CheckedAssignValue %� %CheckedAssigns  �  ?Upload:UseSSH �   �  22�   �  CURLSSH_AUTH_ANY%CheckedHides �%Control  �  ?Upload:UseSSH �   %CheckedControl %� %CheckedHides  �  ?Upload:UseSSH �   �  ?SSHTab%CheckedControlAction %� %CheckedHides  �  ?ProgressUpload  �  ?   ���������������������������������������������������������������������������������������������������� �  �1c2w2  � �!
  d   d   	
 ZG r6 �1< �6 d            ��             5            ���0                                `�) �6 �) �6 , : �E �ABC$ToDo ���ABC �s x6 ��V   �1< �6 LibcurlTpl$LibcurlGloExt ��  �f   f   	
 ZG r6 73< �6 ��-- Generator
#noedit
#system win32
#model clarion lib
#set RELEASE = on
#pragma debug(vid=>off)
#pragma optimize(cpu=>386)
#pragma define(_ABCDllMode_=>0)
#pragma define(_ABCLinkMode_=>1)
#compile "FTPUploadDirsDebug_BC0.CLW" -- GENERATED
#compile "FTPUPLOADDIRSDEBUG_BC.CLW" -- GENERATED
#compile "FTPUploadDirsDebug.clw" -- GENERATED
#compile "FTPUploadDirsDebug001.clw" -- GENERATED
#pragma link("libcurl.lib") -- GENERATED
#link "FTPUploadDirsDebug.exe"
 ��j      j   � 	
 ZG r6 �SG r6 �%SaveCreateLocalMap %�  �  1%GenerationCompleted %�%Module  �  FTPUpload.clw�  1�  FTPUpload001.clw�  1�  FTPUploadDebug.clw�  1�  FTPUploadDebug001.clw�  1�  FTPUploadDirsDebug.clw�  1�  FTPUploadDirsDebug001.clw�  1�  HTTPUploadProgress.clw�  1�  HTTPUploadProgress001.clw�  1�  TestHTTP.clw�  1�  TestHTTP001.clw�  1�  TestHTTP002.clw�  1�  TestHTTP003.clw�  1�  TestHTTP004.clw�  1%LastTarget32 %�  �  1%LastProgramExtension %�  �  EXE%LastApplicationDebug %�  � 4%LastApplicationLocalLibrary %�  �  1�'   j   ���� 
 `G r6 �#- �6 ��%ClassItem %�  �  ErrorManager�  ErrorStatusManager�  FuzzyMatcher�
 
 INIManager�
 
 Translator%DefaultBaseClassType %� %ClassItem  �  ErrorManager�
 
 ErrorClass�  ErrorStatusManager�  ErrorStatusClass�  FuzzyMatcher�
 
 FuzzyClass�
 
 INIManager�  INIClass�
 
 Translator�  TranslatorClass%ActualDefaultBaseClassType %� %ClassItem  �  ErrorManager� �  ErrorStatusManager� �  FuzzyMatcher� �
 
 INIManager� �
 
 Translator� 3%ClassLines %�%ClassItem   %ProgramAuthor %�  � %ProgramIcon %�  � 5%MessageDescription �  �   %GlobalExternal �  � R%ExternalSource %�  �  Dynamic Link Library (DLL)%GenerateEmbedComments �  � M%INIType %�  �  NVD_INI%INIFile %�  �  Program Name.INI%ININame %�  � �%INIInAppDirectory �  �   %REGRoot %�  �  REG_CLASSES_ROOT%DisableINISaveWindow �  �   %PreserveVars �   %PreserveVar %� %PreserveVars   %EnableRunTimeTranslator �  � G%FuzzyMatchingEnabled �  �   %IgnoreCase �  �   %WordOnly �  � <%WindowFrameDragging �  �   %UseDefaultXPManifest �  � %GenerateXPManifest �  � %LinkGenerateXPManifest �  � %AddVistaXPManifest �  � N%VistaManifestExecutionLevel %�  �	 	 asInvoker%VistaManifestUIAccess �  �  %ExtUIXPMenuEnableGlobal �  � �%ExtUIXPMenuColorTypeGlobal %�  �  XPLunaSilver%ExtUIXPMenuColorLeftGlobal �  ���� %ExtUIXPMenuColorRightGlobal �  ���� %ExtUIXPMenuColorSelectionBarLeftGlobal �  ���� %ExtUIXPMenuColorSelectionBarRightGlobal �  ���� %ExtUIXPMenuColorSelectionBorderGlobal �  ���� %ExtUIXPMenuColorHotLeftGlobal �  ���� %ExtUIXPMenuColorHotRightGlobal �  ���� %ExtUIXPMenuColorSelectedLeftGlobal �  ���� %ExtUIXPMenuColorSelectedRightGlobal �  ���� %ExtUIXPMenuFlat �  �   %ExtUIMDITabGlobal %�  �  DISABLE%ExtUIMDITabStyleGlobal %�  �  Default%ExtUITabStyleGlobal %�  �  Default%WindowEnableEnhanceFocus �  � �%SelectedText �  �   %SelectedRadio �  �   %SelectedSpin �  �   %SelectedCheck �  �   %SelectedDropList �  �   %SelectedList �  �   %SelectedDisplayChangeColor �  �   %SelectedColor �  ���  %SelectedStyle �  �   %SelectedRequired �  � �%SelectedRequiredColor �  ���  %SelectedDisplayBox �  �   %SelectedDisplayBoxFillColor �  ���  %SelectedDisplayBoxBorderColor �  � D%SelectedDisplayBoxBorderSize %�  �   %SelectedRequiredBox �  � ]%SelectedRequiredDisplayBoxFillColor �  ��   %SelectedRequiredDisplayBoxBorderColor �  � �%SelectedCaret �  �   %SelectedCaretColor �  ���� %SelectedCaretCharacter %�  �  �%SelectedCaretCharacterSeparation %�  �  8%ExcludeSelectedDropList �  � !%GlobalUseEnterInsteadTab �  � �%GlobalUseEnterInsteadTabExclude %�   %GlobalUseEnterInsteadTabEnable %�  �  Enable%GlobalUseEnterInsteadTabEnableValue %�  �  True%GlobalEnableAutoSizeColumn �  � &%GlobalEnableListFormatManager �  � �%GlobalUserFieldListFormatManager %�  �  1%TableOrigin %�  �  Application%FileEquate %�  �	 	 LFM_CFile%ConfigFilePRE %�  �  CFG%ConfigFileOEM �  � 6%ConfigFileTHREAD �  �   %ConfigFileENCRYPT �  � %ConfigFilePASSWORD %�  � �%FormatNameSize %�  �   %FormatBufferSize %�  �   %VariableBufferSize %�  �   %UseConfigFileName %�  �  Default%ConfigFileVariable %�  � %ConfigFilePath %�  � :%ConfigFileNAME %�  �  Formats.FDB%ColonCounter %�  � %WrongSymbol %�  � f%DictionaryTableOrigin !�   %GlobalLFMSortOrderMenuText %�  �	 	 SortOrder%GlobalEnableRebase �  � ?%RBDMethod %�  �  Specify manually%RBDImageBase %�  �  10%DefaultGenerate �  � �%DefaultRILogout �  �   %LockRecoverTime %�  �
   %DefaultThreaded %�  �  Use File Setting%DefaultCreate %�  �  Use File Setting%DefaultExternal %�  �  None External%DefaultLocalExternal �  � %DefaultExternalSource %�  � %DefaultExternalAPP �  � %DefaultExport �  � �%DefaultOpenMode %�  �  Share%DefaultUserAccess %�  �
 
 Read/Write%DefaultOtherAccess %�  �	 	 Deny None%DefaultLazyOpen �  �   %OverrideGenerate � %File   %OverrideRILogout %� %File  � ��  Use Default%GlobalObject %� %ClassItem  �  ErrorManager�  YES�  ErrorStatusManager�  YES�  FuzzyMatcher�  YES�
 
 INIManager�  YES�
 
 Translator�  YES%ThisObjectName %� %ClassItem  �  ErrorManager�  GlobalErrors�  ErrorStatusManager�  GlobalErrorsStatus�  FuzzyMatcher�  FuzzyMatcher�
 
 INIManager�  INIMgr�
 
 Translator�
 
 Translator%UseDefaultABCBaseClass � %ClassItem  �  ErrorManager�   �  ErrorStatusManager�   �  FuzzyMatcher�   �
 
 INIManager�   �
 
 Translator�   %UseABCBaseClass � %ClassItem  �  ErrorManager�   �  ErrorStatusManager�   �  FuzzyMatcher�   �
 
 INIManager�   �
 
 Translator�   %ABCBaseClass %� %ClassItem  �  ErrorManager� �  ErrorStatusManager� �  FuzzyMatcher� �
 
 INIManager� �
 
 Translator� �%ExtBaseClass %� %ClassItem   %BaseClassIncludeFile %� %ClassItem   %DeriveFromBaseClass � %ClassItem  �  ErrorManager� �  ErrorStatusManager� �  FuzzyMatcher� �
 
 INIManager� �
 
 Translator� �	%NewMethods �%ClassItem   %NewMethodName %� %NewMethods   %NewMethodPrototype %� %NewMethods   %NewClassPropertyItems �%ClassItem   %NewClassProperty %� %NewClassPropertyItems   %NewClassDataType %� %NewClassPropertyItems  �  FuzzyMatcher  �
 
 INIManager  %NewClassOtherType %� %NewClassPropertyItems   %NewClassDataIsRef � %NewClassPropertyItems   %NewClassDataSize %� %NewClassPropertyItems   %NewClassDataDim1 %� %NewClassPropertyItems   %NewClassDataDim2 %� %NewClassPropertyItems   %NewClassDataDim3 %� %NewClassPropertyItems   %NewClassDataDim4 %� %NewClassPropertyItems   %ClassMethods �%ClassItem   %ClassMethodName %� %ClassMethods   %ClassMethodPrototype %� %ClassMethods   %ClassPropertyItems �%ClassItem   %ClassProperty %� %ClassPropertyItems   %ClassDataType %� %ClassPropertyItems  �  FuzzyMatcher  �
 
 INIManager  %ClassOtherType %� %ClassPropertyItems   %ClassDataIsRef � %ClassPropertyItems   %ClassDataSize %� %ClassPropertyItems   %ClassDataDim1 %� %ClassPropertyItems   %ClassDataDim2 %� %ClassPropertyItems   %ClassDataDim3 %� %ClassPropertyItems   %ClassDataDim4 %� %ClassPropertyItems   %OverrideThreaded %� %File  � 0�  Use Default%OverrideCreate %� %File  � 2�  Use Default%OverrideExternal %� %File  � ��  Use Default%OverrideLocalExternal � %File   %OverrideExternalSource %� %File   %OverrideExternalAPP � %File   %OverrideExport � %File   %FileDeclarationMode %� %File  � :�  Use User Options%FileDeclarationType � %File  � � &%FileDeclarationThread � %File  � � (%FileDeclarationBindable � %File  � i�   %FileDeclarationName %� %File   %FileDeclarationOver %� %File   %OverrideOpenMode %� %File  � 4�  Use Default%OverrideUserAccess %� %File  � 5�  Use Default%OverrideOtherAccess %� %File  � 2�  Use Default%OverrideLazyOpen %� %File  � :�  Use Default%StandardExternalModule � %Module  � ��   �  FTPUpload.clw�   �  FTPUpload001.clw�   �  FTPUploadDebug.clw�   �  FTPUploadDebug001.clw�   �  FTPUploadDirsDebug.clw�   �  FTPUploadDirsDebug001.clw�   %NoGenerateGlobals �  � C%WindowManagerType %�  �  WindowManager%ResetOnGainFocus �  � �%AutoToolbar �  �   %AutoRefresh �  �   %ImageClass %�  �  ImageManager%ErrorStatusManagerType %�  �  ErrorStatusClass%ErrorManagerType %�  �
 
 ErrorClass%DefaultErrorCategory %�  �  ABC%AllowSelectCopy �  � %StoreErrorHistory �  � %LimitStoredHistory �  � �%ErrorHistoryThreshold %�  �,  %HistoryViewTrigger %�  �  Level:Fatal%PopupClass %�  �
 
 PopupClass%SelectFileClass %�  �  SelectFileClass%ResizerType %�  �  WindowResizeClass%ResizerDeFaultFindParents �  �   %ResizerDefaultOptimizeMoves �  �   %ResizerDefaultOptimizeRedraws �  �   %INIClass %�  �  INIClass%RunTimeTranslatorType %�  �  TranslatorClass%ExtractionFilename %�  � �%TranslationGroups �   %TranslationFile %� %TranslationGroups   %TranslationGroup %� %TranslationGroups   %CalendarManagerType %�  �  CalendarClass%GlobalChangeColor �  � s%GlobalColorSunday �  ��   %GlobalColorSaturday �  ��   %GlobalColorHoliday �  � �  %GlobalColorOther �  � �%GlobalSelectOnClose %�  �  Select%GlobalUseABCClasess �  �   %FileManagerType %�  �  FileManager%ViewManagerType %�  �  ViewManager%RelationManagerType %�  �  RelationManager%BrowserType %�  �  BrowseClass%ActiveInvisible �  � %AllowUnfilled �  � �%RetainRow �  �   %FileDropManagerType %�  �  FileDropClass%FileDropComboManagerType %�  �  FileDropComboClass%FormVCRManagerType %�  �  FormVCRClass%BrowseEIPManagerType %�  �  BrowseEIPManager%EditInPlaceInterface %�  �  Original%EditInPlaceType %�  �  EditEntryClass%EditInPlaceEntryType %�  �  EditEntryClass%EditInPlaceTextType %�  �  EditTextClass%EditInPlaceCheckType %�  �  EditCheckClass%EditInPlaceSpinType %�  �  EditSpinClass%EditInPlaceDropListType %�  �  EditDropListClass%EditInPlaceDropComboType %�  �  EditDropComboClass%EditInPlaceColorType %�  �  EditColorClass%EditInPlaceFileType %�  �  EditFileClass%EditInPlaceFontType %�  �  EditFontClass%EditInPlaceMultiSelectType %�  �  EditMultiSelectClass%EditInPlaceCalendarType %�  �  EditCalendarClass%EditInPlaceLookupType %�  �  EditLookupClass%EditInPlaceOtherType %�  �  EditEntryClass%QBEFormType %�  �  QueryFormClass%QBEFormVisualType %�  �  QueryFormVisual%QBEListType %�  �  QueryListClass%QBEListVisualType %�  �  QueryListVisual%StepManagerType %�  �	 	 StepClass%StepManagerLongType    �g   %�  �  StepLongClass%StepManagerRealType %�  �  StepRealClass%StepManagerStringType %�  �  StepStringClass%StepManagerCustomType %�  �  StepCustomClass%StepLocatorType %�  �  StepLocatorClass%EntryLocatorType %�  �  EntryLocatorClass%IncrementalLocatorType %�  �  IncrementalLocatorClass%FilteredLocatorType %�  �  FilterLocatorClass%FuzzyMatcherClass %�  �
 
 FuzzyClass%GridClass %�  �	 	 GridClass%SidebarClass %�  �  SidebarClass%ProcessType %�  �  ProcessClass%PrintPreviewType %�  �  PrintPreviewClass%ReportManagerType %�  �  ReportManager%ReportTargetSelectorManagerType %�  �  ReportTargetSelectorClass%BreakManagerType %�  �  BreakManagerClass%AsciiViewerClass %�  �  AsciiViewerClass%AsciiSearchClass %�  �  AsciiSearchClass%AsciiPrintClass %�  �  AsciiPrintClass%AsciiFileManagerType %�  �  AsciiFileClass%ToolbarClass %�  �  ToolbarClass%ToolbarListBoxType %�  �  ToolbarListboxClass%ToolbarRelTreeType %�  �  ToolbarReltreeClass%ToolbarUpdateClassType %�  �  ToolbarUpdateClass%ToolbarFormVCRType %�  �  ToolbarFormVCRClass%OverrideAbcSettings �  � 8%AbcSourceLocation %�  �  LINK%AbcLibraryName %�  � �%AppTemplateFamily %�  �  ABC%CWTemplateVersion %�  �  v6.3%ABCVersion %�  �  6300%CWPlusFirstActive � %Procedure  �  Main�   %ITHasExeTemplate %�  �  ������������������������������������������������