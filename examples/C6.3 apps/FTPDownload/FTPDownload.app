      �   �  tOpS      n                                                                                                                     =   =   =   =   =   =   =   =   =   =   =   =   =   =   n   �   �   �   �   �   �   �   �   �                                                                                                             =   =   =   =   =   =   =   =   =   =   =   =   =   =   n   �   �   �   �   �   �   �   �   �   �      Z Z u  n   =               �    �
 
  j       .���      #   �   .   ����������������������������������������������������������������������������������������������������������������������������������������������������������������������   ���  �n
 �   .   emoteFileName), 'ERROR - ReadFile', ICON:Exclamation)
    END
    FREE(RemoteFileInfoQ)

    !-- reset progress
    ?ProgressDownload{PROP:Progress} = 0
    DISPLAY(?ProgressDownload)  

    ! Cleanup
    Curl.Cleanup()
    ?txtLog{PROP:Text} = ?txtLog{PROP:Text} & 'Cleanup: Done - Disconnected'
    SELECT(?txtLog, LEN(?txtLog{PROP:Text}))
    DISPLAY(?txtLog)
�  T:     +%curlXFerInfoBeforeParent   +curl   +*�     ?ProgressDownload{PROP:Progress} = dlnow * 100.0 / Download:FileSize  !-- we know actual file size Download:FileSize
    DISPLAY(?ProgressDownload)
  
��I  UJ         �> �      �      4            :�G u6     4-, �6         ����������������������������������������������������������������   �	A]  �V
 .���   .���   L 	
 W�0 y6 2�; �6 Download:KnownHosts �  �� � ;  ��@s255 �Download : Known Hosts: Download : Known Hosts � m����L  w� ��?Download:KnownHosts:Prompt Download:KnownHosts Download:KnownHosts 
�   p �   � � � �   $ � H � � � �  Download : Known Hosts:  d
\  �  � � � �  � %@s50 Download:KnownHosts  ($ � � � � @   @s255   Download:KnownHosts  �8 � � � �  � 6?Download:KnownHosts:Prompt Download : Known Hosts:  L� � � � � 2P4   wn formal entityType descriptor not staticUnknow�� ����h   .���   ^ 	
 W�0 y6 b�; �6 Download:PrivateKeyFile �  �� � E  ��@s255 �Download : Private Key File: Download : Private Key File � j����X L w�� ��?Download:PrivateKeyFile:Prompt Download:PrivateKeyFile Download:PrivateKeyFile 
�  | � � � � �  , <@s255    � IDownload : Private Key File:  P?Download:PrivateKeyFile:Prompt 
l  �  � � � �  � %"@s50  �Download:PrivateKeyFile  4( � � � � L   1
 �ile  �@ � � � �  �  � T � � � �  Download : Private Key File:  �| � � � � <Download:PrivateKeyFile    n cl�� ����a   .���   W 	
 W�0 y6 ��; �6 Download:PublicKeyFile �  �� � C  ��@s255 �Download : Public Key File: Download : Public Key File � j����X D w�� ��?Download:PublicKeyFile:Prompt �Download:PublicKeyFile  Download:PublicKeyFile  
�  | � � � � �  ( <@s255    � EDownload : Public Key File: ?Download:PublicKeyFile:Prompt 
h  �  � � � �  � %"@s50 AutDownload:PublicKeyFile   0( � � � � H   1
 �le � �@ � � � �  �  � P � � � �  Download : Public Key File:  �t � � � � @Download:PublicKeyFile e   ile    �� �����   .���   � 	
 W�0 y6 ��1 y6 Download:AuthMethod � �� � 9  ��@s2 �Download : Auth Method: Download : Auth Method � Y���� wL ��?Download:AuthMethod:Prompt Download:AuthMethod Download:AuthMethod l � :� � � � � "=Download : Auth Method:  Dnload:AuthMethod:Prompt 
X  �  � � � �  � %@s2  �load:AuthMethod  ($ � � � � @   @s2  �load:AuthMethod  �8 � � � �  � $  
�� ����X   .���   N 	
 W�0 y6 ��1 y6 Download:UseSSH � �� � 1  ��@n3 �Download : Use SSH: Download : Use SSH � 5����� T w�( ��Download:UseSSH Download:UseSSH � � ^� � � � � "&Download : Use SSH   Dload:UseSSH  �  � � � � � %@n3  �load:UseSSH  ( � � � �  @ (  �� �������������������������������������   �	3  ��
 .���   .���   � 	
 W�0 y6 ��1 y6 Download:Port �
 �� � 1  ��@N4. �Download : Port: Download : Port ���21 M���� � w@ ��?Download:Port:Prompt   Download:Port   Download:Port   x � F� � � � � "5Download : Port: wd  @nload:Port:Prompt   
P  �  � � � �  � %@N4.  �load:Port ow    � � � � 8   �? @N4.  �  �load:Port    �0 � � � �  � $ (      Dir:�� ����_   .���   U 	
 W�0 y6 ��1 y6 bShowDownloadPwd � �� � 3  ��@n3 �b Show Download Pwd: b Show Download Pwd � "����� \ w�0 ��bShowDownloadPwd bShowDownloadPwd � � V� � � � � "*b Show Download Pwd  HwDownloadPwd omp �  � � � � � %@n3  �wDownloadPwd  �  , � � � �  D $  #Use   �� �����   .���   � 	
 W�0 y6 ��1 y6 Download:Pwd �2 �� � *  ��@s50 �Download : Pwd: Download : Pwd � &����� � w�@ ��?Download:Pwd:Prompt Download:Pwd Download:Pwd x � F� � � � � "1Download : Pwd:  <nload:Pwd:Prompt omp
L  �  � � � �  � %@s50 s50 �load:Pwd Use   � � � � 4   @s50 s50 �load:Pwd Use x0 � � � �  � (     
�� �����   .���   � 	
 W�0 y6 ��1 y6 Download:User �2 �� � ,  ��@s50 �Download : User: Download : User � M����� � w�@ ��?Download:User:Prompt   Download:User   Download:User   x � F� � � � � "5Download : User: ize @nload:User:Prompt :P
P  �  � � � �  � %@s50  �load:User ad    � � � � 8   @s50  �load:User � |0 � � � �  � $  
�� �����    . ���   � 	
 W�0 y6 ��1 y6 Download:FileSize � �� � 6  ��@n13 �Download : File Size: Download : File Size � Y���� wL ��?Download:FileSize:Prompt   Download:FileSize   Download:FileSize   l � :� � � � � "=Download : File Size:  N Hnload:FileSize:Prompt le
\  �  � � � �  � %@n13  �load:FileSize ad ($ � � � � @   @n13  �load:FileSize � �8 � � � �  � 0      �� �����!   .!���   � 	
 W�0 y6 ��1 y6 Download:RemoteFileName �� �� � E  ��@s255 �Download : Remote File Name: Download : Remote File Name � e���� wX ��?Download:RemoteFileName:Prompt Download:RemoteFileName Download:RemoteFileName ` � .� � � � � "IDownload : Remote File Name:  P  Tnload:RemoteFileName:Prompt 
l  �  � � � �  � %"@s255 � �load:RemoteFileName  4( � � � � L   "@s255 � �load:RemoteFileName  �@ � � � �  �   $   Dir:�� �����"   ."���   � 	
 W�0 y6 ��1 y6 Download:LocalFilename �� �� � A  ��@s255 �Download : Local Filename: Download : Local Filename � e���� wX ��?Download:LocalFilename:Prompt �Download:LocalFilename  Download:LocalFilename  ` � .� � � � � "EDownload : Local Filename:   Pnload:LocalFilename:Prompt 
h  �  � � � �  � %"@s255 ad �load:LocalFilename   0( � � � � H   "@s255 em �load:LocalFilename   �@ � � � �  �      ote �� ������������������������������������������������������������������������   �"�,�,  ��
 .���#   .#���   � 	
 W�0 y6 ��1 y6 Download:RemoteDir �� �� � 9  ��@s255 �Download : Remote Dir: Download : Remote Dir � Y���� wL ��?Download:RemoteDir:Prompt  Download:RemoteDir  Download:RemoteDir  l � :� � � � � "=Download : Remote Dir: a Hnload:RemoteDir:Prompt  
\  �  � � � �  � %@s255 rl �load:RemoteDir   ($ � � � � @   @s255 @s �load:RemoteDir   �8 � � � �  � 0 4   PT('Upload : Remote �� �����$   .$���   � 	
 W�0 y6 ��1 y6 Download:Url �� �� � +  ��@s255 �Download : Url: Download : Url � &����� � w�@ ��?Download:Url:Prompt Download:Url Download:Url x � F� � � � � "1Download : Url:  <nload:Url:Prompt plo
L  �  � � � �  � %@s255 mo �load:Url (?U   � � � � 4   @s255 RO �load:Url (@s x0 � � � �  � ( '   ENT(42949670�� ����H�   0   �0  > 	
 v�0 y6 fD, �6 %   w8��   H  � ���� | `   +!Download File via FTP/SFTP &� 
�? �  Segoe UI ttoWindow  Start!  Use SSH 
�  � �  
 w  � �  � H e� Public Key MD5: @s50  MD $���  #��� @N4. N4.@s255 25@s255 25@s255 25@s255 25 P "���   � -Download File via FTP/SFTP ,?String1 (Up  ���  ?String1  PR�  Dx s   � �  \� � ?Sheet1 ?Sheet1 %T  ��   �t  &( !��� ?bDownload  	  (H   � 2  � � � ?ProgressDownload   ?Progress1 p  &General ?GeneralTab ?Tab1 il&\  �� �   T SSH ?SSHTab ?Tab2   & 0L  H  � HAuthentication method:  ?Download:AuthMethod:Prompt Download:AuthMethod  "Download:Url oad ��� h  �� 	> ( a � 0 ,Url: ('L?PROMPT3 :')
�  <\   )  � �  T � t� Remote Dir: ?Download:RemoteDir:Prompt 0?Download:RemoteDir:Prompt rDownload:RemoteDir  
�  ��   =  � �  � T ^  �  Download:LocalFilename D �Download:RemoteDir  Download:RemoteFileName  ��   � > < a ( < *Download:User adDownload:Pwd e R�  �8 > O �    ` �0 Remote File Name: Up?Download:RemoteFileName:Prompt ?Download:RemoteFileName:Prompt bShowDownloadPwd ile ��� 
0  @  � P  � �  , � j@  �  Download:Port adDownload:UseSSH Download:RemoteFileName Download:PublicKeyFile e ��� �  �h O �   0Local file: ?PROMPT4 T(1
�  \�   P  � �  t $,User: Ke?PROMPT7 wor
0  ��   e  � �  �  $ @s20 ey  ���  ��� �   � 	> d  � �  0Password: US?PROMPT8 Pub
�  \�  � e  � �  t � $ @s20 ),U ���  ��� H	  �� 	� d  � � �  @ ( . Show password lDownload:KnownHosts �	  	� 	>e  � � $	 �	 dX
 Port: @s?Download:Port:Prompt US?Download:Port:Prompt LA ���  ��� 
X
  |	�	   w  � �  �	 0
 R   �	  Download:PrivateKeyFile Download:Port ,2Download:KeyPassword  as�
   
� > w  �
  
�? ���@ 	�? �
 ( � �  �   Download:UseSSH  �
� 	n w  � � � 
#|�� v � / Y@ 5Downloading File:   ?DownloadingFileString  ?String2 
� �X v �  � �  D   8?Download:PublicKeyMD5:Prompt g 
P  ��  �I� � �  � � V'Any|#-1|None|#0|PublicKey|#1|Password|#2|Host|#4|Keyboard|#8|Agent|#16' STD�  �� 	� (  � �   � LPublic Key File: ICO?Download:PublicKeyFile:Prompt  
8  ��  
 B  � �  � � , @s255   Download:PublicKeyMD5  T� @  B B � 
  LPrivate Key File: MB?Download:PrivateKeyFile:Prompt 
  d�  
 P  � �  | �	 , @s255  EDownload:PublicKeyMD5 e | @�
 B P � 
 � DKnown Hosts:  ED?Download:KnownHosts:Prompt 
�  8`  
 ]  � �  P �	 ( @s255    ���  ���  �H @�4	 B ] � 
 � -Key Password:   ?Download:KeyPassword:Prompt 
�   (  
 i  � �   �  @s40 " hload:KeyPassword U �  @l@
 B i � 
 � 5PublicKey authentication settings: _?PROMPT1 c   ���  
 �  
 *  � �  � 
%?Download:PublicKeyMD5:Prompt     � Close   ?bClose STD:Close   	 x�  x� /  � � � 
$ @�
  B v � 
 ,�     �   t &Block... ?M_ID_EXPORTFILE Z     � � � � � � � � � &Close ?M_ID_EXIT2  ���  � � � � � &Edit ?M_EDIT_MENU '  �  � � � � � %���      �  � 	
 :�G u6 <�; �6 G +%WindowManagerMethodCodeSection   +Init   +(),BYTE   +*< Download:Url = 'ftp.yoururl.com'
 Download:LocalFilename  = ''
 5Download:RemoteFilename = 'FileNameToDownload.Txt'
 Download:User 
= 'username'
 Download:Pwd = 'password'
 Download:Port 
= 21
 Download:AuthMethod = CURLSSH_AUTH_NONE

 Download:UseSSH = 0

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
M6*  �.    +%LocalDataAfterClasses   +*   MAP
 ReadFile()
  END
��   B+%ControlEventHandling   +?bDownload   +Accepted   +*  FReadFile()
�O4  e4    +?bShowDownloadPwd   +Accepted   +*9  i?Download:Pwd{PROP:Password} = 1 - bShowDownloadPwd
�s2  �2    +%ProcedureRoutines   +*ReadFile PROCEDURE()
slist TCurlSList
sprotocol CSTRING(20), AUTO
ssh LIKE(TSSHSettings), AUTO
url STRING(2048), AUTO
res CURLcode, AUTO
  CODE
 ! Reset Curl
 Curl.Reset()

 ! set SSH
 IF Download:UseSSH
 ! SSH settings
 ssh:AuthMethod = CLIP(Download:AuthMethod)
 4ssh:PublicKeyFile  = CLIP(Download:PublicKeyFile)
 5ssh:PrivateKeyFile = CLIP(Download:PrivateKeyFile)
 ssh:KnownHosts = CLIP(Download:KnownHosts)
 ssh:KeyPassword = CLIP(Download:KeyPassword)
 5ssh:PublicKeyMD5   = CLIP(Download:PublicKeyMD5)

 res = Curl.SSHAuth(ssh)
 IF res <> CURLE_OK
 EMESSAGE(Curl.StrError(res), 'Set SSHAuth Error', ICON:Exclamation)
 	RETURN
 END
 END

 ! set port
 IF Download:Port
 1res = Curl.SetOpt(CURLOPT_PORT, Download:Port)
 .ELSIF NOT INSTRING(':', Download:Url, 1, 1)
 -IF Download:AuthMethod = CURLSSH_AUTH_NONE
 &res = Curl.SetOpt(CURLOPT_PORT, 21)
 ELSE
 1res = Curl.SetOpt(CURLOPT_PORT, Download:Port)
 END
 END
 IF res <> CURLE_OK
 NMESSAGE(Curl.StrError(res), 'SetOpt(CURLOPT_PORT) Error', ICON:Exclamation)
 	RETURN
 END

 ! set user:password
 $IF Download:User AND Download:Pwd
 5res = Curl.SetUserPwd(Download:User, Download:Pwd)
 IF res <> CURLE_OK
 DMESSAGE(Curl.StrError(res), 'SetUserPwd Error', ICON:Exclamation)
 	RETURN
 END
 END

 ! set connection timeout
 0res = Curl.SetOpt(CURLOPT_CONNECTTIMEOUT, 60)
 IF res <> CURLE_OK
 XMESSAGE(Curl.StrError(res), 'SetOpt(CURLOPT_CONNECTTIMEOUT) Error', ICON:Exclamation)
 	RETURN
 END

 ! Build url
 Ssprotocol = CHOOSE(Download:AuthMethod = CURLSSH_AUTH_NONE, 'ftp://', 'sftp://')
 >IF Download:User AND NOT INSTRING('@', Download:User, 1, 1)
 Uurl = sprotocol & CLIP(Download:User) &'@'& CLIP(Download:Url) !ftp://username@url
 ELSE
 3url = sprotocol & CLIP(Download:Url) !sftp://url
 END

 !-- trailing slash
 (IF url AND url[LEN(CLIP(url))] <> '/'
 url = CLIP(url) & '/'
 END

 !-- append remote dir
  IF url AND Download:RemoteDir
 -url = CLIP(url) & CLIP(Download:RemoteDir)
 !-- trailing slash
 (IF url AND url[LEN(CLIP(url))] <> '/'
 url = CLIP(url) & '/'
 END
 END

 ,?DownloadingFileString{Prop:Hide} = FALSE
 Y?DownloadingFileString{PROP:Text} = 'Downloading File: '&CLIP(Download:RemoteFileName)
 ?ProgressDownload{Prop:Hide} = FALSE
  
 !-- build remote file name
 4url = CLIP(url) & CLIP(Download:RemoteFileName)

 ! Start Download
 IF Download:LocalFileName
 3res = Curl.ReadFile(url, Download:LocalFileName)
 ELSE
 4res = Curl.ReadFile(url, Download:RemoteFileName)
 END
 IF res = CURLE_OK
 }MESSAGE('File Downloaded||URL: '&CLIP(url)&'||File Name: '&CLIP(Download:RemoteFileName), 'SUCCESS - ReadFile', ICON:Tick)
 ELSIF res = -1
 vMESSAGE('Cannot open remote file||File Name: '&CLIP(Download:RemoteFileName), 'ERROR - ReadFile', ICON:Exclamation)
 ELSE
 �MESSAGE('Download failed: '& Curl.StrError(res)&'||URL: '&CLIP(url)&'||File Name: '&CLIP(Download:RemoteFileName), 'ERROR - ReadFile', ICON:Exclamation)
 END

 !-- reset progress
 '?ProgressDownload{PROP:Progress} = 0
 'DISPLAY(?ProgressDownload)  
��  �' 1+%curlXFerInfoBeforeParent   +curl   +*�  m?ProgressDownload{PROP:Progress} = dlnow * 100.0 / dltotal  !-- we know actual file size Download:FileSize
 DISPLAY(?ProgressDownload)
 YIELD
�e8   9  ����������������������� ?  0�1+2	  �; 
  j      j   1 

 �SG r6 �SG r6 
   j   1 

 STG r6 STG r6 �'   j   ���� 
 @�G u6 ��; �6 ��%ClassItem %�  �  Default�  WindowToolbar%DefaultBaseClassType %� %ClassItem  �  Default�  WindowManager�  WindowToolbar�  ToolbarClass%ActualDefaultBaseClassType %� %ClassItem  �  Default� �  WindowToolbar� �%ClassLines %�%ClassItem   %ProcedureParameters �   %ProcedureParameterName %� %ProcedureParameters   %ProcedureParameterType %� %ProcedureParameters   %ProcedureParameterDefault %� %ProcedureParameters   %ProcedureParameterOmitted � %ProcedureParameters   %ProcedureParameterByReference � %ProcedureParameters   %Parameters %�  � Y%ReturnValue "�   %WindowOperationMode %�  �  Use WINDOW setting%INISaveWindow �  � %%ProcedureDisableEnhanceFocus �  � ,%ProcedureUseEnterInsteadTabOverride �  � X%WindowUseEnterInsteadTab �  �   %ProcedureUseEnterInsteadTabExcludeListCombo �  � 5%ProcedureUseEnterInsteadTabEnableNextTabStop �  � �%ProcedureUseEnterInsteadTabExcludeG �  �   %WindowUseEnterInsteadTabExclude %�   %GlobalObject %� %ClassItem  �  Default�  NO�  WindowToolbar�  NO%ThisObjectName %� %ClassItem  �  Default�
 
 ThisWindow�  WindowToolbar�  Toolbar%UseDefaultABCBaseClass � %ClassItem  �  Default�   �  WindowToolbar�   %UseABCBaseClass � %ClassItem  �  Default�   �  WindowToolbar�   %ABCBaseClass %� %ClassItem  �  Default�  ADOBlob�  WindowToolbar�  ADOBlob%ExtBaseClass %� %ClassItem   %BaseClassIncludeFile %� %ClassItem   %DeriveFromBaseClass � %ClassItem  �  Default� �  WindowToolbar� �%NewMethods �%ClassItem   %NewMethodName %� %NewMethods   %NewMethodPrototype %� %NewMethods   %NewClassPropertyItems �%ClassItem   %NewClassProperty %� %NewClassPropertyItems   %NewClassDataType %� %NewClassPropertyItems  �  WindowToolbar  %NewClassOtherType %� %NewClassPropertyItems   %NewClassDataIsRef � %NewClassPropertyItems   %NewClassDataSize %� %NewClassPropertyItems   %NewClassDataDim1 %� %NewClassPropertyItems   %NewClassDataDim2 %� %NewClassPropertyItems   %NewClassDataDim3 %� %NewClassPropertyItems   %NewClassDataDim4 %� %NewClassPropertyItems   %ClassMethods �%ClassItem   %ClassMethodName %� %ClassMethods   %ClassMethodPrototype %� %ClassMethods   %ClassPropertyItems �%ClassItem   %ClassProperty %� %ClassPropertyItems   %ClassDataType %� %ClassPropertyItems  �  WindowToolbar  %ClassOtherType %� %ClassPropertyItems   %ClassDataIsRef � %ClassPropertyItems   %ClassDataSize %� %ClassPropertyItems   %ClassDataDim1 %� %ClassPropertyItems   %ClassDataDim2 %� %ClassPropertyItems   %ClassDataDim3 %� %ClassPropertyItems   %ClassDataDim4 %� %ClassPropertyItems   %WindowStyles �   %WindowStyleFontName %� %WindowStyles   %WindowStyleFontNameVariable %� %WindowStyles   %WindowStyleFontNameIsVariable � %WindowStyles   %WindowStyleFontSize %� %WindowStyles   %WindowStyleFontSizeVariable %� %WindowStyles   %WindowStyleFontSizeIsVariable � %WindowStyles   %WindowStyleFontStyle %� %WindowStyles   %WindowStyleFontStyleVariable %� %WindowStyles   %WindowStyleFontStyleIsVariable � %WindowStyles   %WindowStyleFontColor %� %WindowStyles   %WindowStyleFontCharSet %� %WindowStyles   %WindowStyleForegroundNormal � %WindowStyles   %WindowStyleForegroundNormalVariable %� %WindowStyles   %WindowStyleForegroundNormalIsVariable � %WindowStyles   %WindowStyleBackgroundNormal � %WindowStyles   %WindowStyleBackgroundNormalVariable %� %WindowStyles   %WindowStyleBackgroundNormalIsVariable � %WindowStyles   %WindowStyleForegroundSelected � %WindowStyles   %WindowStyleForegroundSelectedVariable %� %WindowStyles   %WindowStyleForegroundSelectedIsVariable � %WindowStyles   %WindowStyleBackgroundSelected � %WindowStyles   %WindowStyleBackgroundSelectedVariable %� %WindowStyles   %WindowStyleBackgroundSelectedIsVariable � %WindowStyles   %WindowStylePicture %� %WindowStyles   %WindowStylePictureVariable %� %WindowStyles   %WindowStylePictureIsVariable � %WindowStyles   %WindowStyleOtherListboxes %�   %ProcedureAutoBindFields �   %ProcedureAutoBindField %� %ProcedureAutoBindFields   %ProcedureAutoBindFieldTPL %� %ProcedureAutoBindFields   %ProcedureAutoBindProcedures �   %ProcedureAutoBindProcedure %� %ProcedureAutoBindProcedures   %ProcedureAutoBindProcedureTPL %� %ProcedureAutoBindProcedures   %ProcedureAutoBindFieldsIgnored �   %ProcedureAutoBindFieldIgnored %� %ProcedureAutoBindFieldsIgnored   %ProcedureAutoBindProceduresIgnored �   %ProcedureAutoBindProcedureIgnored %� %ProcedureAutoBindProceduresIgnored   %ProcedureAutoBindValidToAddField �  � �
%ProcedureUserBindFields �   %ProcedureUserBindField "� %ProcedureUserBindFields   %ProcedureAutoBindFieldIgnore � %ProcedureAutoBindFields   %ProcedureUserBindProcedures �   %ProcedureUserBindProcedure  � %ProcedureUserBindProcedures   %ProcedureAutoBindProcedureIgnore � %ProcedureAutoBindProcedures   %ProcedureUserBindExpressions �   %ProcedureUserBindExpressionName %� %ProcedureUserBindExpressions   %ProcedureUserBindExpression %� %ProcedureUserBindExpressions   %ExtUITabIcon %� %Control   %ExtUITabStyleOverrideGlobal � %Control   %ExtUITabStyle %� %Control 	 �  ?Download:KeyPassword�  Default�  ?Download:PublicKeyMD5�  Default�  ?Download:UseSSH�  Default�  ?DownloadingFileString�  Default�  ?PROMPT1�  Default�  ?ProgressDownload�  Default�  ?Sheet1�  Default�  ?bClose�  Default�
 
 ?bDownload�  Default%ButtonAction %� %Control  �  ?Download:KeyPassword�  No Special Action�  ?Download:PublicKeyMD5�  No Special Action�  ?Download:UseSSH�  No Special Action�  ?DownloadingFileString�  No Special Action�  ?PROMPT1�  No Special Action�  ?ProgressDownload�  No Special Action�  ?bClose�  No Special Action�
 
 ?bDownload�  No Special Action%ButtonRunName %� %Control  �
 
 ?bDownload� 7%ButtonRunParameters %� %Control  �
 
 ?bDownload� 1%ButtonProcedure  � %Control  �
 
 ?bDownload 0%ButtonThread � %Control  �
 
 ?bDownload� �%ButtonThreadStack %� %Control  �  ?Download:KeyPassword��a  �  ?Download:PublicKeyMD5��a  �  ?Download:UseSSH��a  �  ?DownloadingFileString��a  �  ?PROMPT1��a  �  ?ProgressDownload��a  �  ?bClose�  25000�
 
 ?bDownload��a  %ButtonParameters %� %Control  �
 
 ?bDownload� �%ButtonReturnValueAssignment "� %Control  �
 
 ?bDownload %ButtonReturnValueReferenceAssign � %Control  �
 
 ?bDownload� �%ButtonRequest %� %Control  �  ?Download:KeyPassword�  None�  ?Download:PublicKeyMD5�  None�  ?Download:UseSSH�  None�  ?DownloadingFileString�  None�  ?PROMPT1�  None�  ?ProgressDownload�  None�  ?bClose�  None�
 
 ?bDownload�  None%ButtonThreadParameters %� %Control  �
 
 ?bDownload� �%ButtonThreadReturnValueAssignment "� %Control  �
 
 ?bDownload %PreLookupKey #� %Control   %PreLookupField $� %Control  �  ?Download:PublicKeyMD5 %PreLookupProcedure  � %Control  �  ?Download:PublicKeyMD5 L%PreLookupProcedureParameters %� %Control  �  ?Download:PublicKeyMD5� �%PostLookupKey #� %Control   %PostLookupField $� %Control  �  ?Download:PublicKeyMD5 %PostLookupProcedure  � %Control  �  ?Download:PublicKeyMD5 M%PostLookupProcedureParameters %� %Control  �  ?Download:PublicKeyMD5� �%PostLookupDuringValidate � %Control  �  ?Download:KeyPassword�   �  ?Download:KnownHosts�   �  ?Download:LocalFilename�   �  ?Download:Port�   �  ?Download:PrivateKeyFile�   �  ?Download:PublicKeyFile�   �  ?Download:PublicKeyMD5�   �  ?Download:Pwd�   �  ?Download:RemoteDir�   �  ?Download:RemoteFileName�   �  ?Download:Url�   �  ?Download:UseSSH�   �  ?Download:User�   �  ?DownloadingFileString�   �  ?PROMPT1�   �  ?ProgressDownload�   �  ?bClose�   �
 
 ?bDownload�   %LookupAssign �%Control   %MoreTarget "� %LookupAssign   %MoreField %� %LookupAssign   %ForceWindowRefresh � %Control   %CheckedAssigns �%Control  �  ?Download:UseSSH �   �   %CheckedAssignVariable "� %CheckedAssigns  �  ?Download:UseSSH �   ��   ���%CheckedAssignValue %� %CheckedAssigns  �  ?Download:UseSSH �   �  CURLSSH_AUTH_ANY�   �  22%CheckedHides �%Control  �  ?Download:UseSSH �   %CheckedControl %� %CheckedHides  �  ?Download:UseSSH �   �  ?SSHTab%CheckedControlAction %� %CheckedHides  �  ?Download:KeyPassword  �  ?Download:PublicKeyMD5  �  ?Download:UseSSH �   �  Unhide�  ?DownloadingFileString  �  ?PROMPT1  �  ?ProgressDownload  �  ?bClose  �
 
 ?bDownload  %CheckedEnables �%Control   %CheckedControl1 %� %CheckedEnables   %CheckedControl1Action %� %CheckedEnables  �  ?Download:KeyPassword  �  ?Download:PublicKeyMD5  �  ?Download:UseSSH  �  ?DownloadingFileString  �  ?PROMPT1  �  ?ProgressDownload  �  ?bClose  �
 
 ?bDownload  %UncheckedAssigns �%Control  �  ?Download:UseSSH �   �   %UncheckedAssignVariable "� %UncheckedAssigns  �  ?Download:UseSSH �   ��   ���%UncheckedAssignValue %� %UncheckedAssigns  �  ?Download:UseSSH �   �  CURLSSH_AUTH_NONE�   �  21%UnCheckedHides �%Control  �  ?Download:UseSSH �   %UnCheckedControl %� %UnCheckedHides  �  ?Download:UseSSH �   �  ?SSHTab%UnCheckedControlAction %� %UnCheckedHides  �  ?Download:KeyPassword  �  ?Download:PublicKeyMD5  �  ?Download:UseSSH �   �  Hide�  ?DownloadingFileString  �  ?PROMPT1  �  ?ProgressDownload  �  ?bClose  �
 
 ?bDownload  %UnCheckedEnables �%Control   %UnCheckedControl1 %� %UnCheckedEnables   %UnCheckedControl1Action %� %UnCheckedEnables  �  ?Download:KeyPassword  �    �a      ?Download:PublicKeyMD5  �  ?Download:UseSSH  �  ?DownloadingFileString  �  ?PROMPT1  �  ?ProgressDownload  �  ?bClose  �
 
 ?bDownload  %CheckedDisables �%Control   %CheckedDisableControl %� %CheckedDisables   %CheckedDisableControlAction %� %CheckedDisables  �  ?Download:KeyPassword  �  ?Download:PublicKeyMD5  �  ?Download:UseSSH  �  ?DownloadingFileString  �  ?PROMPT1  �  ?ProgressDownload  �  ?bClose  �
 
 ?bDownload  %UnCheckedDisables �%Control   %UnCheckedDisableControl %� %UnCheckedDisables   %UnCheckedDisableControlAction %� %UnCheckedDisables  �  ?Download:KeyPassword  �  ?Download:PublicKeyMD5  �  ?Download:UseSSH  �  ?DownloadingFileString  �  ?PROMPT1  �  ?ProgressDownload  �  ?bClose  �
 
 ?bDownload  %ITHasDllTemplate %�  � %FatherExists %�  � �c p      p   Y 

 ZG r6 6U9 y6 �� ���ABC$ABC �  6U9 y6   �m    p   c 

 #G r6 ��; �6 .    ��    ���ABC$GENERATED �  ��; �6   �/r      r   %   
 :�G u6 ��; �6 � Main    �0 IA   ���ABC$Window �s �6 ��;   ��; �6 LibcurlTpl$LibcurlLocExt �� �%curlBaseClass %�  �  TCurlFtpClass%curlVar %�  �  curl        $���#���"���!��� ������������������������������������   �).���   .���    	
 �, �6 ��; �6 Download:PublicKeyMD5 �  �� � @  ��@s32 �Download : Public Key MD5: Download : Public Key MD5 � ���d �  wdH  
D   , � � � � �  , $ p � � � � � �    @s32 pt @s32  b  �  � � � �  � +�?Download:PublicKeyMD5:Prompt tsDownload:PublicKeyMD5 blDownload:PublicKeyMD5 D5Download : Public Key MD5:        :KnownHosts  ($�� �����   .���   � 	
 W�0 y6 ��; �6 Download:KeyPassword �( �� � <  ��@s40 �Download : Key Password: Download : Key Password � F���� wh ��?Download:KeyPassword:Prompt   �Download:KeyPassword Download:KeyPassword @s40 @s40 P � � � � � � "EDownload : Key Password:  H  Hnload:KeyPassword:Prompt � 
h  �  � � � �  � %  � oad �load:KeyPassword  0( � � � � X    "  � Kno �load:KeyPassword  �  �@ � � � �  `         �� ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������� p  �1�1	2  �    �!
  d       d                   ZG r6     ��; �6                 ��             1            ���/         !                                          �) �6 �) �6 , : �E �ABC$ToDo ���ABC �s y6 �U9   ��; �6 LibcurlTpl$LibcurlGloExt ��              ��f       f        �           ZG r6     ��; �6     �-- Generator
#noedit
#system win32
#model clarion lib
#set RELEASE = on
#pragma debug(vid=>off)
#pragma optimize(cpu=>386)
#pragma define(_ABCDllMode_=>0)
#pragma define(_ABCLinkMode_=>1)
#compile "FTPDownload_BC0.CLW" -- GENERATED
#compile "FTPDOWNLOAD_BC.CLW" -- GENERATED
#compile "FTPDownload.clw" -- GENERATED
#compile "FTPDownload001.clw" -- GENERATED
#pragma link("libcurl.lib") -- GENERATED
#link "FTPDownload.EXE"
 ��j      j       �           ZG r6     �SG r6     %SaveCreateLocalMap %�  �  1%GenerationCompleted %�%Module  �  FTPDownload.clw�  1�  FTPDownload001.clw�  1�  FTPDownloadDebug.clw�  1�  FTPDownloadDebug001.clw�  1�  FTPUpload.clw�  1�  FTPUpload001.clw�  1�  FTPUploadDebug.clw�  1�  FTPUploadDebug001.clw�  1�  HTTPUploadProgress.clw�  1�  HTTPUploadProgress001.clw�  1�  TestHTTP.clw�  1�  TestHTTP001.clw�  1�  TestHTTP002.clw�  1�  TestHTTP003.clw�  1�  TestHTTP004.clw�  1%LastTarget32 %�  �  1%LastProgramExtension %�  �  EXE%LastApplicationDebug %�  �    %LastApplicationLocalLibrary %�  �  1�'   j       ����         `G r6     �+ �6     �%ClassItem %�  �  ErrorManager�  ErrorStatusManager�  FuzzyMatcher�
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
 Translator�  TranslatorClass%ActualDefaultBaseClassType %� %ClassItem  �  ErrorManager�    �  ErrorStatusManager�    �  FuzzyMatcher�    �
 
 INIManager�    �
 
 Translator�    %ClassLines %�%ClassItem   %ProgramAuthor %�  �    %ProgramIcon %�  �    %MessageDescription �  �   %GlobalExternal �  �    %ExternalSource %�  �  Dynamic Link Library (DLL)%GenerateEmbedComments �  �    %INIType %�  �  NVD_INI%INIFile %�  �  Program Name.INI%ININame %�  �    %INIInAppDirectory �  �   %REGRoot %�  �  REG_CLASSES_ROOT%DisableINISaveWindow �  �   %PreserveVars �   %PreserveVar %� %PreserveVars   %EnableRunTimeTranslator �  �    %FuzzyMatchingEnabled �  �   %IgnoreCase �  �   %WordOnly �  �    %WindowFrameDragging �  �   %UseDefaultXPManifest �  �    %GenerateXPManifest �  �    %LinkGenerateXPManifest �  �    %AddVistaXPManifest �  �    %VistaManifestExecutionLevel %�  �	 	 asInvoker%VistaManifestUIAccess �  �    %ExtUIXPMenuEnableGlobal �  �    %ExtUIXPMenuColorTypeGlobal %�  �  XPLunaSilver%ExtUIXPMenuColorLeftGlobal �  ���� %ExtUIXPMenuColorRightGlobal �  ���� %ExtUIXPMenuColorSelectionBarLeftGlobal �  ���� %ExtUIXPMenuColorSelectionBarRightGlobal �  ���� %ExtUIXPMenuColorSelectionBorderGlobal �  ���� %ExtUIXPMenuColorHotLeftGlobal �  ���� %ExtUIXPMenuColorHotRightGlobal �  ���� %ExtUIXPMenuColorSelectedLeftGlobal �  ���� %ExtUIXPMenuColorSelectedRightGlobal �  ���� %ExtUIXPMenuFlat �  �   %ExtUIMDITabGlobal %�  �  DISABLE%ExtUIMDITabStyleGlobal %�  �  Default%ExtUITabStyleGlobal %�  �  Default%WindowEnableEnhanceFocus �  �    %SelectedText �  �   %SelectedRadio �  �   %SelectedSpin �  �   %SelectedCheck �  �   %SelectedDropList �  �   %SelectedList �  �   %SelectedDisplayChangeColor �  �   %SelectedColor �  ���  %SelectedStyle �  �   %SelectedRequired �  �    %SelectedRequiredColor �  ���  %SelectedDisplayBox �  �   %SelectedDisplayBoxFillColor �  ���  %SelectedDisplayBoxBorderColor �  �    %SelectedDisplayBoxBorderSize %�  �   %SelectedRequiredBox �  �    %SelectedRequiredDisplayBoxFillColor �  ��   %SelectedRequiredDisplayBoxBorderColor �  �    %SelectedCaret �  �   %SelectedCaretColor �  ���� %SelectedCaretCharacter %�  �  �%SelectedCaretCharacterSeparation %�  �  8%ExcludeSelectedDropList �  �    %GlobalUseEnterInsteadTab �  �    %GlobalUseEnterInsteadTabExclude %�   %GlobalUseEnterInsteadTabEnable %�  �  Enable%GlobalUseEnterInsteadTabEnableValue %�  �  True%GlobalEnableAutoSizeColumn �  �    %GlobalEnableListFormatManager �  �    %GlobalUserFieldListFormatManager %�  �  1%TableOrigin %�  �  Application%FileEquate %�  �	 	 LFM_CFile%ConfigFilePRE %�  �  CFG%ConfigFileOEM �  �    %ConfigFileTHREAD �  �   %ConfigFileENCRYPT �  �    %ConfigFilePASSWORD %�  �    %FormatNameSize %�  �   %FormatBufferSize %�  �   %VariableBufferSize %�  �   %UseConfigFileName %�  �  Default%ConfigFileVariable %�  �    %ConfigFilePath %�  �    %ConfigFileNAME %�  �  Formats.FDB%ColonCounter %�  �    %WrongSymbol %�  �    %DictionaryTableOrigin !�   %GlobalLFMSortOrderMenuText %�  �	 	 SortOrder%GlobalEnableRebase �  �    %RBDMethod %�  �  Specify manually%RBDImageBase %�  �  10000000%DefaultGenerate �  �    %DefaultRILogout �  �   %LockRecoverTime %�  �
   %DefaultThreaded %�  �  Use File Setting%DefaultCreate %�  �  Use File Setting%DefaultExternal %�  �  None External%DefaultLocalExternal �  �    %DefaultExternalSource %�  �    %DefaultExternalAPP �  �    %DefaultExport �  �    %DefaultOpenMode %�  �  Share%DefaultUserAccess %�  �
 
 Read/Write%DefaultOtherAccess %�  �	 	 Deny None%DefaultLazyOpen �  �   %OverrideGenerate � %File   %OverrideRILogout %� %File  �    �  Use Default%GlobalObject %� %ClassItem  �  ErrorManager�  YES�  ErrorStatusManager�  YES�  FuzzyMatcher�  YES�
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
 Translator�   %ABCBaseClass %� %ClassItem  �  ErrorManager�    �  ErrorStatusManager�    �  FuzzyMatcher�    �
 
 INIManager�    �
 
 Translator�    %ExtBaseClass %� %ClassItem   %BaseClassIncludeFile %� %ClassItem   %DeriveFromBaseClass � %ClassItem  �  ErrorManager�    �  ErrorStatusManager�    �  FuzzyMatcher�    �
 
 INIManager�    �
 
 Translator�    %NewMethods �%ClassItem   %NewMethodName %� %NewMethods   %NewMethodPrototype %� %NewMethods   %NewClassPropertyItems �%ClassItem   %NewClassProperty %� %NewClassPropertyItems   %NewClassDataType %� %NewClassPropertyItems  �  FuzzyMatcher  �
 
 INIManager  %NewClassOtherType %� %NewClassPropertyItems   %NewClassDataIsRef � %NewClassPropertyItems   %NewClassDataSize %� %NewClassPropertyItems   %NewClassDataDim1 %� %NewClassPropertyItems   %NewClassDataDim2 %� %NewClassPropertyItems   %NewClassDataDim3 %� %NewClassPropertyItems   %NewClassDataDim4 %� %NewClassPropertyItems   %ClassMethods �%ClassItem   %ClassMethodName %� %ClassMethods   %ClassMethodPrototype %� %ClassMethods   %ClassPropertyItems �%ClassItem   %ClassProperty %� %ClassPropertyItems   %ClassDataType %� %ClassPropertyItems  �  FuzzyMatcher  �
 
 INIManager  %ClassOtherType %� %ClassPropertyItems   %ClassDataIsRef � %ClassPropertyItems   %ClassDataSize %� %ClassPropertyItems   %ClassDataDim1 %� %ClassPropertyItems   %ClassDataDim2 %� %ClassPropertyItems   %ClassDataDim3 %� %ClassPropertyItems   %ClassDataDim4 %� %ClassPropertyItems   %OverrideThreaded %� %File  �    �  Use Default%OverrideCreate %� %File  �    �  Use Default%OverrideExternal %� %File  �    �  Use Default%OverrideLocalExternal � %File   %OverrideExternalSource %� %File   %OverrideExternalAPP � %File   %OverrideExport � %File   %FileDeclarationMode %� %File  �    �  Use User Options%FileDeclarationType � %File  �    �    %FileDeclarationThread � %File  �    �    %FileDeclarationBindable � %File  �    �   %FileDeclarationName %� %File   %FileDeclarationOver %� %File   %OverrideOpenMode %� %File  �    �  Use Default%OverrideUserAccess %� %File  �    �  Use Default%OverrideOtherAccess %� %File  �    �  Use Default%OverrideLazyOpen %� %File  �    �  Use Default%StandardExternalModule � %Module  �    �   �  FTPDownload.clw�   �  FTPDownload001.clw�   %NoGenerateGlobals �  �    %WindowManagerType %�  �  WindowManager%ResetOnGainFocus �  �    %AutoToolbar �  �   %AutoRefresh �  �   %ImageClass %�  �  ImageManager%ErrorStatusManagerType %�  �  ErrorStatusClass%ErrorManagerType %�  �
 
 ErrorClass%DefaultErrorCategory %�  �  ABC%AllowSelectCopy �  �    %StoreErrorHistory �  �    %LimitStoredHistory �  �    %ErrorHistoryThreshold %�  �,  %HistoryViewTrigger %�  �  Level:Fatal%PopupClass %�  �
 
 PopupClass%SelectFileClass %�  �  SelectFileClass%ResizerType %�  �  WindowResizeClass%ResizerDeFaultFindParents �  �   %ResizerDefaultOptimizeMoves �  �   %ResizerDefaultOptimizeRedraws �  �   %INIClass %�  �  INIClass%RunTimeTranslatorType %�  �  TranslatorClass%ExtractionFilename %�  �    %TranslationGroups �   %TranslationFile %� %TranslationGroups   %TranslationGroup %� %TranslationGroups   %CalendarManagerType %�  �  CalendarClass%GlobalChangeColor �  �    %GlobalColorSunday �  ��   %GlobalColorSaturday �  ��   %GlobalColorHoliday �  � �  %GlobalColorOther �  �    %GlobalSelectOnClose %�  �  Select%GlobalUseABCClasess �  �   %FileManagerType %�  �  FileManager%ViewManagerType %�  �  ViewManager%RelationManagerType %�  �  RelationManager%BrowserType %�  �  BrowseClass%ActiveInvisible �  �    %AllowUnfilled �  �    %RetainRow �  �   %FileDropManagerType %�  �  FileDropClass%FileDropComboManagerType %�  �  FileDropComboClass%FormVCRManagerType %�  �  FormVCRClass%BrowseEIPManagerType %�  �  BrowseEIPManager%EditInPlaceInterface %�  �  Original%EditInPlaceType %�  �  EditEntryClass%EditInPlaceEntryType %�  �  EditEntryClass%EditInPlaceTextType %�  �  EditTextClass%EditInPlaceCheckType %�  �  EditCheckClass%EditInPlaceSpinType %�  �  EditSpinClass%EditInPlaceDropListType %�  �  EditDropListClass%EditInPlaceDropComboType %�  �  EditDropComboClass%EditInPlaceColorType %�  �  EditColorClass%EditInPlaceFileType %�  �  EditFileClass%EditInPlaceFontType %�  �  EditFontClass%EditInPlaceMultiSelectType %�  �  EditMultiSelectClass%EditInPlaceCalendarType %�  �  EditCalendarClass%EditInPlaceLookupType %�  �  EditLookupClass%EditInPlaceOtherType %�  �  EditEntryClass%QBEFormType %�  �  QueryFormClass%QBEFormVisualType %�  �  QueryFormVisual%QBEListType %�  �  QueryListClass%QBEListVisualType %�  �  QueryListVisual%StepManagerType %�  �	 	 StepClass%StepManagerLongType %�  �  StepLongClass%StepManagerRealType %�  �  StepRealClass%StepManagerStringType %�  �  StepStringClass%StepManagerCus   ��   tomType %�  �  StepCustomClass%StepLocatorType %�  �  StepLocatorClass%EntryLocatorType %�  �  EntryLocatorClass%IncrementalLocatorType %�  �  IncrementalLocatorClass%FilteredLocatorType %�  �  FilterLocatorClass%FuzzyMatcherClass %�  �
 
 FuzzyClass%GridClass %�  �	 	 GridClass%SidebarClass %�  �  SidebarClass%ProcessType %�  �  ProcessClass%PrintPreviewType %�  �  PrintPreviewClass%ReportManagerType %�  �  ReportManager%ReportTargetSelectorManagerType %�  �  ReportTargetSelectorClass%BreakManagerType %�  �  BreakManagerClass%AsciiViewerClass %�  �  AsciiViewerClass%AsciiSearchClass %�  �  AsciiSearchClass%AsciiPrintClass %�  �  AsciiPrintClass%AsciiFileManagerType %�  �  AsciiFileClass%ToolbarClass %�  �  ToolbarClass%ToolbarListBoxType %�  �  ToolbarListboxClass%ToolbarRelTreeType %�  �  ToolbarReltreeClass%ToolbarUpdateClassType %�  �  ToolbarUpdateClass%ToolbarFormVCRType %�  �  ToolbarFormVCRClass%OverrideAbcSettings �  �    %AbcSourceLocation %�  �  LINK%AbcLibraryName %�  �    %AppTemplateFamily %�  �  ABC%CWTemplateVersion %�  �  v6.3%ABCVersion %�  �  6300%CWPlusFirstActive � %Procedure  �  Main�   %ITHasExeTemplate %�  �        �����������