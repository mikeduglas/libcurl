hl职!YLI悍槟񷈭�}鬑nH毟/樃.  �64鈯�M�枻?� �         濑��"       )` �2     )` �2                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                         r   朵漞�.�-鐴)z         圑��"      怞 �2     �m �2                  ChangePath 鯉鰷郃N�!`n鉯5�    F   (STRING pCurrentFolder, STRING pGoToFolder, BOOL pRemotePath), STRING     >   (STRING pCurrentFolder, STRING pGoToFolder, BOOL pRemotePath)        
                                   ABC$Source         s �2 c       �m �2     6$呁娮D厈�窵a"`rL�!.B噐�4t	� _哿�>J�<�4q樞                                                                                                                                        .  �Y鎱A楌凶匴�         Z���"       0` �2     .Ad �2               Pwd �(                                                                        @s40             
   Password:        Pwd                                                                             Q    PROMPT('Password:'),USE(?TAccount:Pwd:Prompt)
 ENTRY(@s40),USE(TAccount:Pwd)
     "    STRING(@s40),USE(TAccount:Pwd)
                                                                                                                                      .  @Mp	�=M�妌X�_          ���"       敃z �2     c硘 �2               KeyPassword �(                                                                        @s40                Key Password:        Key Password                                                                             k    PROMPT('Key Password:'),USE(?SSHSettings:KeyPassword:Prompt)
 ENTRY(@s40),USE(SSHSettings:KeyPassword)
     -    STRING(@s40),USE(SSHSettings:KeyPassword)
                                                                           p   � `萇@擷�脥
`         T���"       `� �2     5譊 �<           $湌澝 J�%                                                  ABC$GENERATED         s �< 5譊       5譊 �<                                                                                              r   �ッ帆θ49N�         帼��"      �5R �2     |腶 �5                  ExtractRemotePath 覕H=wL砊鮭眨編       (STRING pUrl), STRING        (STRING pUrl)        
                                   ABC$Source         s �5 _Qe       |腶 �5     �0栻�#塏氬踀SYhm焤E矋K�3台ザ w筇E嶣b蝶                                                                                                                                                                                                                                 .  �K沬彞5��3�         挈��"       ZI �2     蚘 �2               glo:OverwriteExistingFile �                                     No|Yes|No for All|Yes for All                &   see OEF declarations in Global Embeds                @n3                glo : Overwrite Existing File:        glo : Overwrite Existing File             &   see OEF declarations in Global Embeds     &   see OEF declarations in Global Embeds                                                     �    PROMPT('glo : Overwrite Existing File:'),USE(?glo:OverwriteExistingFile:Prompt)
 ENTRY(@n3),USE(glo:OverwriteExistingFile),MSG('see OEF declarations in Global Embeds'),TIP('see OEF declarations in Global Embeds')
     .    STRING(@n3),USE(glo:OverwriteExistingFile)
                0|1|2|3                                                                                                                                                                                                                                                                      p   �.&鮐MC禈誫蕯蚉         T���"       juo �2     嘝v �2           0拇鋋縀�+E!{�?                                                  ABC$GENERATED         s �2 嘝v       嘝v �2                                                                                              .  公AH鵏贑�
�#q炃�         ���"       !� �2     彴F �2               CurrentLocalPath ��                                                                        @s255                Current Local Path:        Current Local Path                                                                             d    PROMPT('Current Local Path:'),USE(?CurrentLocalPath:Prompt)
 ENTRY(@s255),USE(CurrentLocalPath)
     '    STRING(@s255),USE(CurrentLocalPath)
                                                                      r   �6W释KnI剓蓖?耯         ��"       鎉 �2     �E �=                  Main 腒鍓槯N�?0砩%                UA鹆4┡C俯暬J忧�     朵漞�.�-鐴)z冗坩SF垬泖齿腛懕⑿2�NQ鐽珁閍W`唅劽B瞔�艗U�^ ztPM綽�4C��$湌澝 J�%�0閕\�1H�\?lL潠狧d鷒严I�;{2;励嶌訠橭9 SQ}��摳嗳@咡辷渄鲙7尭⺁慖�3 �IQ%�
兰N�!q�7�2���(PI啺C}lr摢1)[鈁>M泒F�級�                                   ABC$Window         s �= �E       �E �=     垺A踡M侳玻nk3E孶u轅⿱鷒y2"   P〣胊疉�o}槭Bo簨
欻婭衦V帛D众鎄腉骏瀁+3�&�9砏�@疦嵨膼溳�:Dd&塏溳伮氇氳Vb瀦^D盝�}晆ヰ唂鞮9嘒塙e�3�<�	t樒燖巬I询眻F.s�(U犰E筄蹃\錢�-D�r匫欍撜鄞:��徝?M?F蠂坚�5qM督篳秨�1巴d3炰鬕�替P}WQ椶~h汧G�薾洀p4榮	蕑E瓀充櫶饸zV廎iY"G 鳴��lH�!胾:牞�$餶Q蠧�
乽 �?隣甗鹜G�h破赻棯_H犗.奝�)輀�(映eL孒~ht騤啓t#t`G廟丢頥鈔�4l|谦J�NΕql.<B灕举QB�倶棻U�*�&糃潥�<觉Q椅e鷤eHナ.SN嚱q8񬫏掩M噅翎FDq�1臘:;M啔牓(`埙�秗籑瘡樥祽徾z*WI懏汯�0sZ�,杂砱c跧敖蔁P�公AH鵏贑�
�#q炃糺�<笹1餌㈠�!=�)鮜�悢L睟樦�4掕)诛枹N�樘鬷w                                                                                                                                                                                                                                                              p   �"�2
O�5'u�.�         T���"       a �2     糊a �6           励嶌訠橭9 SQ}�                                                  ABC$GENERATED         s �6 糊a       糊a �6                                                                                              j   T蔠R�汢U掊p壃 :      :  て��"       �5y �2     鵻V �>        �          %ClassItem %                            Default             WindowToolbar       %DefaultBaseClassType %                   %ClassItem                 Default             WindowManager             WindowToolbar             ToolbarClass       %ActualDefaultBaseClassType %                   %ClassItem                 Default                             WindowToolbar                       %ClassLines %                  %ClassItem                 Default   4   4       4   Init                   PROCEDURE(),BYTE,PROC,DERIVED4   4       4   Kill                   PROCEDURE(),BYTE,PROC,DERIVED4   4       4   TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       %ReturnValue "             旵Mz8-僉UO"�       %ProcedureOneInstance                                %WindowOperationMode %                          Use WINDOW setting       %INISaveWindow                               %ProcedureDisableEnhanceFocus                             %   %ProcedureUseEnterInsteadTabOverride                                %WindowUseEnterInsteadTab                            -   %ProcedureUseEnterInsteadTabExcludeListCombo                             .   %ProcedureUseEnterInsteadTabEnableNextTabStop                             %   %ProcedureUseEnterInsteadTabExcludeG                            !   %WindowUseEnterInsteadTabExclude %                       %GlobalObject %                   %ClassItem                 Default             NO             WindowToolbar             NO       %ThisObjectName %                   %ClassItem                 Default
   
       
   ThisWindow             WindowToolbar             Toolbar       %UseDefaultABCBaseClass                    %ClassItem                 Default                       WindowToolbar                 %UseABCBaseClass                    %ClassItem                 Default                       WindowToolbar                 %ABCBaseClass %                   %ClassItem                 Default                             WindowToolbar                       %ExtBaseClass %                   %ClassItem            %BaseClassIncludeFile %                   %ClassItem            %DeriveFromBaseClass                    %ClassItem                 Default                        WindowToolbar                  %NewMethods                   %ClassItem            %NewMethodName %                   %NewMethods            %NewMethodPrototype %                   %NewMethods            %NewClassPropertyItems                   %ClassItem            %NewClassProperty %                   %NewClassPropertyItems            %NewClassDataType %                   %NewClassPropertyItems                 WindowToolbar           %NewClassOtherType %                   %NewClassPropertyItems            %NewClassDataIsRef                    %NewClassPropertyItems            %NewClassDataSize %                   %NewClassPropertyItems            %NewClassDataDim1 %                   %NewClassPropertyItems            %NewClassDataDim2 %                   %NewClassPropertyItems            %NewClassDataDim3 %                   %NewClassPropertyItems            %NewClassDataDim4 %                   %NewClassPropertyItems            %ClassMethods                   %ClassItem            %ClassMethodName %                   %ClassMethods            %ClassMethodPrototype %                   %ClassMethods            %ClassPropertyItems                   %ClassItem            %ClassProperty %                   %ClassPropertyItems            %ClassDataType %                   %ClassPropertyItems                 WindowToolbar           %ClassOtherType %                   %ClassPropertyItems            %ClassDataIsRef                    %ClassPropertyItems            %ClassDataSize %                   %ClassPropertyItems            %ClassDataDim1 %                   %ClassPropertyItems            %ClassDataDim2 %                   %ClassPropertyItems            %ClassDataDim3 %                   %ClassPropertyItems            %ClassDataDim4 %                   %ClassPropertyItems            %WindowStyles                        %WindowStyleFontName %                   %WindowStyles            %WindowStyleFontNameVariable %                   %WindowStyles            %WindowStyleFontNameIsVariable                    %WindowStyles            %WindowStyleFontSize %                   %WindowStyles            %WindowStyleFontSizeVariable %                   %WindowStyles            %WindowStyleFontSizeIsVariable                    %WindowStyles            %WindowStyleFontStyle %                   %WindowStyles            %WindowStyleFontStyleVariable %                   %WindowStyles             %WindowStyleFontStyleIsVariable                    %WindowStyles            %WindowStyleFontColor %                   %WindowStyles            %WindowStyleFontCharSet %                   %WindowStyles            %WindowStyleForegroundNormal                    %WindowStyles         %   %WindowStyleForegroundNormalVariable %                   %WindowStyles         '   %WindowStyleForegroundNormalIsVariable                    %WindowStyles            %WindowStyleBackgroundNormal                    %WindowStyles         %   %WindowStyleBackgroundNormalVariable %                   %WindowStyles         '   %WindowStyleBackgroundNormalIsVariable                    %WindowStyles            %WindowStyleForegroundSelected                    %WindowStyles         '   %WindowStyleForegroundSelectedVariable %                   %WindowStyles         )   %WindowStyleForegroundSelectedIsVariable                    %WindowStyles            %WindowStyleBackgroundSelected                    %WindowStyles         '   %WindowStyleBackgroundSelectedVariable %                   %WindowStyles         )   %WindowStyleBackgroundSelectedIsVariable                    %WindowStyles            %WindowStylePicture %                   %WindowStyles            %WindowStylePictureVariable %                   %WindowStyles            %WindowStylePictureIsVariable                    %WindowStyles            %WindowStyleOtherListboxes %                       %ProcedureAutoBindFields                        %ProcedureAutoBindField %                   %ProcedureAutoBindFields            %ProcedureAutoBindFieldTPL %                   %ProcedureAutoBindFields            %ProcedureAutoBindProcedures                        %ProcedureAutoBindProcedure %                   %ProcedureAutoBindProcedures            %ProcedureAutoBindProcedureTPL %                   %ProcedureAutoBindProcedures             %ProcedureAutoBindFieldsIgnored                        %ProcedureAutoBindFieldIgnored %                    %ProcedureAutoBindFieldsIgnored         $   %ProcedureAutoBindProceduresIgnored                     #   %ProcedureAutoBindProcedureIgnored %                $   %ProcedureAutoBindProceduresIgnored         "   %ProcedureAutoBindValidToAddField                                %ProcedureUserBindFields                        %ProcedureUserBindField "                   %ProcedureUserBindFields            %ProcedureAutoBindFieldIgnore                    %ProcedureAutoBindFields            %ProcedureUserBindProcedures                        %ProcedureUserBindProcedure                     %ProcedureUserBindProcedures         "   %ProcedureAutoBindProcedureIgnore                    %ProcedureAutoBindProcedures            %ProcedureUserBindExpressions                     !   %ProcedureUserBindExpressionName %                   %ProcedureUserBindExpressions            %ProcedureUserBindExpression %                   %ProcedureUserBindExpressions            %PreserveVarsLoc                        %PreserveVarLoc %                   %PreserveVarsLoc            %ExtUITabIcon %                	   %Control            %ExtUITabStyleOverrideGlobal                 	   %Control            %ExtUITabStyle %                	   %Control                                 Default       %FieldGradientColorType %                	   %Control                                 Off        %FieldGradientColorTypeVariable %                	   %Control                                        "   %FieldGradientColorTypeIsVariable                 	   %Control                                      %FieldGradientColorFrom                 	   %Control                           ����        %FieldGradientColorFromVariable %                	   %Control         "   %FieldGradientColorFromIsVariable                 	   %Control                                      %FieldGradientColorTo                 	   %Control                           ����       %FieldGradientColorToVariable %                	   %Control             %FieldGradientColorToIsVariable                 	   %Control                                      %ButtonAction %                	   %Control                                 No Special Action             ?bCancel             No Special Action             ?bOK             No Special Action       %ButtonRunName %                	   %Control            %ButtonRunParameters %                	   %Control            %ButtonProcedure                  	   %Control            %ButtonThread                 	   %Control            %ButtonThreadStack %                	   %Control                           ╝               ?bCancel       ╝               ?bOK       ╝         %ButtonParameters %                	   %Control            %ButtonReturnValueAssignment "                	   %Control         "   %ButtonReturnValueReferenceAssign                 	   %Control            %ButtonRequest %                	   %Control                                 None             ?bCancel             None             ?bOK             None       %ButtonThreadParameters %                	   %Control         #   %ButtonThreadReturnValueAssignment "                	   %Control            %PreLookupKey #                	   %Control            %PreLookupField $                	   %Control            %PreLookupProcedure                  	   %Control            %PreLookupProcedureParameters %                	   %Control            %PostLookupKey #                	   %Control            %PostLookupField $                	   %Control            %PostLookupProcedure                  	   %Control            %PostLookupProcedureParameters %                	   %Control            %PostLookupDuringValidate                 	   %Control                                           ?SSHSettings:KeyPassword                       ?SSHSettings:KnownHosts                       ?SSHSettings:PrivateKeyFile                       ?SSHSettings:PublicKeyFile                       ?SSHSettings:PublicKeyMD5                 %LookupAssign                	   %Control            %MoreTarget "                   %LookupAssign            %MoreField %                   %LookupAssign            %ForceWindowRefresh                 	   %Control            %CheckedAssigns                	   %Control            %CheckedAssignVariable "                   %CheckedAssigns            %CheckedAssignValue %                   %CheckedAssigns            %CheckedHides                	   %Control            %CheckedControl %                   %CheckedHides            %CheckedControlAction %                   %CheckedHides                               %CheckedEnables                	   %Control            %CheckedControl1 %                   %CheckedEnables            %CheckedControl1Action %                   %CheckedEnables                               %UncheckedAssigns                	   %Control            %UncheckedAssignVariable "                   %UncheckedAssigns            %UncheckedAssignValue %                   %UncheckedAssigns            %UnCheckedHides                	   %Control            %UnCheckedControl %                   %UnCheckedHides            %UnCheckedControlAction %                   %UnCheckedHides                               %UnCheckedEnables                	   %Control            %UnCheckedControl1 %                   %UnCheckedEnables            %UnCheckedControl1Action %                   %UnCheckedEnables                               %CheckedDisables                	   %Control            %CheckedDisableControl %                   %CheckedDisables            %CheckedDisableControlAction %                   %CheckedDisables                               %UnCheckedDisables                	   %Control            %UnCheckedDisableControl %                   %UnCheckedDisables            %UnCheckedDisableControlAction %                   %UnCheckedDisables                               %ActiveImageEnable                 	   %Control            %AIObjectName %                	   %Control                                 AIBtn0       %AIEnableMimicControl                 	   %Control                                     %AIMimicControl %                	   %Control                                 ?SSHSettings:AuthMethod:Prompt       %AIImgRound                 	   %Control            %AIOverrideImg %                	   %Control            %AIOverrideImgVariable %                	   %Control            %AIOverrideImgIsVariable                 	   %Control                                      %AIDisableImg %                	   %Control            %AIDisableImgVariable %                	   %Control            %AIDisableImgIsVariable                 	   %Control                                   
   %AIHotImg %                	   %Control            %AIHotImgVariable %                	   %Control            %AIHotImgIsVariable                 	   %Control                                      %AIPressedImg %                	   %Control            %AIPressedImgVariable %                	   %Control            %AIPressedImgIsVariable                 	   %Control                                                                                                                                                                                                    �  錆褛�-7B絻嬴糽?q         ����"       �8h �2     �8h �2                                                                                                                                                                                                                            .  \馯课飤B寎儙]�殠         ;���"       疨` �2     襎` �2            	   FileSize �                                                                        @s20                File Size:     
   File Size                                                                             ^    PROMPT('File Size:'),USE(?TFileInfo:FileSize:Prompt)
 ENTRY(@s20),USE(TFileInfo:FileSize)
     (    STRING(@s20),USE(TFileInfo:FileSize)
                                                                                                       r   ���(PI啺C}lr�         铨��"      嬍n �2     �峷 �2     O          
   UploadDir !bj槭%G�*x�4贳Z    r   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem, SIGNED pProgress, SIGNED pLabel), BOOL     l   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem, SIGNED pProgress, SIGNED pLabel)       O懕⑿2�NQ鐽珁槔鴯�訠橭9 SQ}�0拇鋋縀�+E!{�?�1)[鈁>M泒F�級�                                   ABC$Source         s �2 �峷       �峷 �2     B﹛�t匬AC酹��x.(1�*N�#$玠貨 殡�%:rJ廰僦*�U                                                                                                                                                                                                                                               .  i�!镓狥婇洼R抶          ���"       G鮵 �2     c硘 �2               KeyPassword �(                                                                        @s40                Key Password:        Key Password                                                                             k    PROMPT('Key Password:'),USE(?SSHSettings:KeyPassword:Prompt)
 ENTRY(@s40),USE(SSHSettings:KeyPassword)
     -    STRING(@s40),USE(SSHSettings:KeyPassword)
                                                                           .  �:捠M�#.褘R~v         	���"       脌 �2     EX �2               TrailingSlashPos �                                                                     @n-14                Trailing Slash Pos:        Trailing Slash Pos                                                                             m    PROMPT('Trailing Slash Pos:'),USE(?TrailingSlashPos:Prompt)
 ENTRY(@n-14),USE(TrailingSlashPos),RIGHT(1)
     0    STRING(@n-14),USE(TrailingSlashPos),RIGHT(1)
                                                    j   鉠堘襣譊X% 葀-         a���"       �*? �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           �  
}v9�8M俼z閰觃�         ����"       ^� �2     ^� �2                                                                                                                                                                                                                            .  <B灕举QB�倶棻U�         ,���"       E媊 �2     .猙 �2            	   FileMask �
                                                                        @s10                File Mask:     
   File Mask                                                                             h    PROMPT('File Mask:'),USE(?LocalFileInfoQ:FileMask:Prompt)
 ENTRY(@s10),USE(LocalFileInfoQ:FileMask)
     -    STRING(@s10),USE(LocalFileInfoQ:FileMask)
                                                                                       .  -D�r匫欍撜鄞:         濑��"       瘇` �2     2慲 �2                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                        .  � '噑橈@柼澥攰         ���"       N鹼 �2     �	 �2               AuthMethod �                     CURLSSH_AUTH_ENUM                                                    @s20                Auth Method:        Auth Method                                                                             h    PROMPT('Auth Method:'),USE(?SSHSettings:AuthMethod:Prompt)
 ENTRY(@s20),USE(SSHSettings:AuthMethod)
     ,    STRING(@s20),USE(SSHSettings:AuthMethod)
                                                                .  隣甗鹜G�h         濑��"       漽c �2     I坈 �2                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                        .  va4�I1Cj�no�         W���"       鬴c �2      詂 �2               Name ��                                                                        @s255                Name:        Name                                                                             R    PROMPT('Name:'),USE(?TFileInfo:Name:Prompt)
 ENTRY(@s255),USE(TFileInfo:Name)
     %    STRING(@s255),USE(TFileInfo:Name)
                                                                                                                                   �  �+�/峵騁懫>灚稍         V���"       ~廕 �2     曉W �2                    �            d   �
   	   �!6�
          �1   �   �� :   e      �   �	   
    �3K�   ��	 ?   �   J   3   �B   *K�   ��	 G   �   J   5   �N   �   ����    S   FTP manager Segoe UI New folder (directory): ?PROMPT1 s255 OK ?bOK Cancel ?bCancel        Window Dirname 微�:oO��P@xd                                                                                       .  )鮜�悢L睟樦�4掕         ��"       暦 �2     6uH �2               bSSH �                                                               @n3                 SSH        b SSH                                                                                 CHECK(' SSH'),USE(bSSH)
         CHECK(' SSH'),USE(bSSH)
                                                                                                                                                                                                             .  �0w惀M欅泵h\:;         8���"       纑 �2     ,舝 �2            	   SortName ��                                                                        @s255                Sort Name:     
   Sort Name                                                                             _    PROMPT('Sort Name:'),USE(?TFileInfo:SortName:Prompt)
 ENTRY(@s255),USE(TFileInfo:SortName)
     )    STRING(@s255),USE(TFileInfo:SortName)
                                                                                                    j   櫼Dt�M皔�$s(3 <      <  m���"        嶫 �2     鵻V �>        �          %ClassItem %                            Default             WindowToolbar       %DefaultBaseClassType %                   %ClassItem                 Default             WindowManager             WindowToolbar             ToolbarClass       %ActualDefaultBaseClassType %                   %ClassItem                 Default                             WindowToolbar                       %ClassLines %                  %ClassItem                 Default   4   4       4   Init                   PROCEDURE(),BYTE,PROC,DERIVED4   4       4   Kill                   PROCEDURE(),BYTE,PROC,DERIVED4   4       4   TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       %ReturnValue "             in焑H矫E汖茉燆羇       %ProcedureOneInstance                                %WindowOperationMode %                          Use WINDOW setting       %INISaveWindow                               %ProcedureDisableEnhanceFocus                             %   %ProcedureUseEnterInsteadTabOverride                                %WindowUseEnterInsteadTab                            -   %ProcedureUseEnterInsteadTabExcludeListCombo                             .   %ProcedureUseEnterInsteadTabEnableNextTabStop                             %   %ProcedureUseEnterInsteadTabExcludeG                            !   %WindowUseEnterInsteadTabExclude %                       %GlobalObject %                   %ClassItem                 Default             NO             WindowToolbar             NO       %ThisObjectName %                   %ClassItem                 Default
   
       
   ThisWindow             WindowToolbar             Toolbar       %UseDefaultABCBaseClass                    %ClassItem                 Default                       WindowToolbar                 %UseABCBaseClass                    %ClassItem                 Default                       WindowToolbar                 %ABCBaseClass %                   %ClassItem                 Default                             WindowToolbar                       %ExtBaseClass %                   %ClassItem            %BaseClassIncludeFile %                   %ClassItem            %DeriveFromBaseClass                    %ClassItem                 Default                        WindowToolbar                  %NewMethods                   %ClassItem            %NewMethodName %                   %NewMethods            %NewMethodPrototype %                   %NewMethods            %NewClassPropertyItems                   %ClassItem            %NewClassProperty %                   %NewClassPropertyItems            %NewClassDataType %                   %NewClassPropertyItems                 WindowToolbar           %NewClassOtherType %                   %NewClassPropertyItems            %NewClassDataIsRef                    %NewClassPropertyItems            %NewClassDataSize %                   %NewClassPropertyItems            %NewClassDataDim1 %                   %NewClassPropertyItems            %NewClassDataDim2 %                   %NewClassPropertyItems            %NewClassDataDim3 %                   %NewClassPropertyItems            %NewClassDataDim4 %                   %NewClassPropertyItems            %ClassMethods                   %ClassItem            %ClassMethodName %                   %ClassMethods            %ClassMethodPrototype %                   %ClassMethods            %ClassPropertyItems                   %ClassItem            %ClassProperty %                   %ClassPropertyItems            %ClassDataType %                   %ClassPropertyItems                 WindowToolbar           %ClassOtherType %                   %ClassPropertyItems            %ClassDataIsRef                    %ClassPropertyItems            %ClassDataSize %                   %ClassPropertyItems            %ClassDataDim1 %                   %ClassPropertyItems            %ClassDataDim2 %                   %ClassPropertyItems            %ClassDataDim3 %                   %ClassPropertyItems            %ClassDataDim4 %                   %ClassPropertyItems            %WindowStyles                        %WindowStyleFontName %                   %WindowStyles            %WindowStyleFontNameVariable %                   %WindowStyles            %WindowStyleFontNameIsVariable                    %WindowStyles            %WindowStyleFontSize %                   %WindowStyles            %WindowStyleFontSizeVariable %                   %WindowStyles            %WindowStyleFontSizeIsVariable                    %WindowStyles            %WindowStyleFontStyle %                   %WindowStyles            %WindowStyleFontStyleVariable %                   %WindowStyles             %WindowStyleFontStyleIsVariable                    %WindowStyles            %WindowStyleFontColor %                   %WindowStyles            %WindowStyleFontCharSet %                   %WindowStyles            %WindowStyleForegroundNormal                    %WindowStyles         %   %WindowStyleForegroundNormalVariable %                   %WindowStyles         '   %WindowStyleForegroundNormalIsVariable                    %WindowStyles            %WindowStyleBackgroundNormal                    %WindowStyles         %   %WindowStyleBackgroundNormalVariable %                   %WindowStyles         '   %WindowStyleBackgroundNormalIsVariable                    %WindowStyles            %WindowStyleForegroundSelected                    %WindowStyles         '   %WindowStyleForegroundSelectedVariable %                   %WindowStyles         )   %WindowStyleForegroundSelectedIsVariable                    %WindowStyles            %WindowStyleBackgroundSelected                    %WindowStyles         '   %WindowStyleBackgroundSelectedVariable %                   %WindowStyles         )   %WindowStyleBackgroundSelectedIsVariable                    %WindowStyles            %WindowStylePicture %                   %WindowStyles            %WindowStylePictureVariable %                   %WindowStyles            %WindowStylePictureIsVariable                    %WindowStyles            %WindowStyleOtherListboxes %                       %ProcedureAutoBindFields                        %ProcedureAutoBindField %                   %ProcedureAutoBindFields            %ProcedureAutoBindFieldTPL %                   %ProcedureAutoBindFields            %ProcedureAutoBindProcedures                        %ProcedureAutoBindProcedure %                   %ProcedureAutoBindProcedures            %ProcedureAutoBindProcedureTPL %                   %ProcedureAutoBindProcedures             %ProcedureAutoBindFieldsIgnored                        %ProcedureAutoBindFieldIgnored %                    %ProcedureAutoBindFieldsIgnored         $   %ProcedureAutoBindProceduresIgnored                     #   %ProcedureAutoBindProcedureIgnored %                $   %ProcedureAutoBindProceduresIgnored         "   %ProcedureAutoBindValidToAddField                                %ProcedureUserBindFields                        %ProcedureUserBindField "                   %ProcedureUserBindFields            %ProcedureAutoBindFieldIgnore                    %ProcedureAutoBindFields            %ProcedureUserBindProcedures                        %ProcedureUserBindProcedure                     %ProcedureUserBindProcedures         "   %ProcedureAutoBindProcedureIgnore                    %ProcedureAutoBindProcedures            %ProcedureUserBindExpressions                     !   %ProcedureUserBindExpressionName %                   %ProcedureUserBindExpressions            %ProcedureUserBindExpression %                   %ProcedureUserBindExpressions            %PreserveVarsLoc                        %PreserveVarLoc %                   %PreserveVarsLoc            %ExtUITabIcon %                	   %Control            %ExtUITabStyleOverrideGlobal                 	   %Control            %ExtUITabStyle %                	   %Control                                 Default             ?bCancel             Default       %FieldGradientColorType %                	   %Control                                 Off             ?bCancel             Off        %FieldGradientColorTypeVariable %                	   %Control                                                 ?bCancel                    "   %FieldGradientColorTypeIsVariable                 	   %Control                                            ?bCancel                  %FieldGradientColorFrom                 	   %Control                           ����             ?bCancel       ����        %FieldGradientColorFromVariable %                	   %Control         "   %FieldGradientColorFromIsVariable                 	   %Control                                            ?bCancel                  %FieldGradientColorTo                 	   %Control                           ����             ?bCancel       ����       %FieldGradientColorToVariable %                	   %Control             %FieldGradientColorToIsVariable                 	   %Control                                            ?bCancel                  %ButtonAction %                	   %Control                                 No Special Action             ?bCancel             No Special Action             ?bOK             No Special Action       %ButtonRunName %                	   %Control            %ButtonRunParameters %                	   %Control            %ButtonProcedure                  	   %Control            %ButtonThread                 	   %Control            %ButtonThreadStack %                	   %Control                           ╝               ?bCancel       ╝               ?bOK       ╝         %ButtonParameters %                	   %Control            %ButtonReturnValueAssignment "                	   %Control         "   %ButtonReturnValueReferenceAssign                 	   %Control            %ButtonRequest %                	   %Control                                 None             ?bCancel             None             ?bOK             None       %ButtonThreadParameters %                	   %Control         #   %ButtonThreadReturnValueAssignment "                	   %Control            %PreLookupKey #                	   %Control            %PreLookupField $                	   %Control            %PreLookupProcedure                  	   %Control            %PreLookupProcedureParameters %                	   %Control            %PostLookupKey #                	   %Control            %PostLookupField $                	   %Control            %PostLookupProcedure                  	   %Control            %PostLookupProcedureParameters %                	   %Control            %PostLookupDuringValidate                 	   %Control                                           ?Dirname                       ?bCancel                 %LookupAssign                	   %Control            %MoreTarget "                   %LookupAssign            %MoreField %                   %LookupAssign            %ForceWindowRefresh                 	   %Control            %CheckedAssigns                	   %Control            %CheckedAssignVariable "                   %CheckedAssigns            %CheckedAssignValue %                   %CheckedAssigns            %CheckedHides                	   %Control            %CheckedControl %                   %CheckedHides            %CheckedControlAction %                   %CheckedHides                                     ?bCancel           %CheckedEnables                	   %Control            %CheckedControl1 %                   %CheckedEnables            %CheckedControl1Action %                   %CheckedEnables                                     ?bCancel           %UncheckedAssigns                	   %Control            %UncheckedAssignVariable "                   %UncheckedAssigns            %UncheckedAssignValue %                   %UncheckedAssigns            %UnCheckedHides                	   %Control            %UnCheckedControl %                   %UnCheckedHides            %UnCheckedControlAction %                   %UnCheckedHides                                     ?bCancel           %UnCheckedEnables                	   %Control            %UnCheckedControl1 %                   %UnCheckedEnables            %UnCheckedControl1Action %                   %UnCheckedEnables                                     ?bCancel           %CheckedDisables                	   %Control            %CheckedDisableControl %                   %CheckedDisables            %CheckedDisableControlAction %                   %CheckedDisables                                     ?bCancel           %UnCheckedDisables                	   %Control            %UnCheckedDisableControl %                   %UnCheckedDisables            %UnCheckedDisableControlAction %                   %UnCheckedDisables                                     ?bCancel           %ActiveImageEnable                 	   %Control            %AIObjectName %                	   %Control                                 AIBtn0             ?bCancel             AIBtn4       %AIEnableMimicControl                 	   %Control                                           ?bCancel                 %AIMimicControl %                	   %Control                                 ?PROMPT1             ?bCancel             ?PROMPT1       %AIImgRound                 	   %Control            %AIOverrideImg %                	   %Control            %AIOverrideImgVariable %                	   %Control            %AIOverrideImgIsVariable                 	   %Control                                            ?bCancel                  %AIDisableImg %                	   %Control            %AIDisableImgVariable %                	   %Control            %AIDisableImgIsVariable                 	   %Control                                            ?bCancel               
   %AIHotImg %                	   %Control            %AIHotImgVariable %                	   %Control            %AIHotImgIsVariable                 	   %Control                                            ?bCancel                  %AIPressedImg %                	   %Control            %AIPressedImgVariable %                	   %Control            %AIPressedImgIsVariable                 	   %Control                                            ?bCancel                                                                                                                         �  谪r
�	蠥媦�7漋�         ����"       �5 �2     �5 �2                                                                                                                                                                                                                            r   狧d鷒严I�;{2;         ��"      d �2     Z�	 �6                  LoadLocalDir 眛玀捰b~�i    3   (STRING pRoot, *TFtpFilesInfo dirlist), BOOL, PROC     '   (STRING pRoot, *TFtpFilesInfo dirlist)        
                                   ABC$Source         s �2 ~       Z�	 �6     梒J鎆x鏓汑�/��鞹D賅鮸B淴Ru乛�7 �q莓MF粊菄@d汗                                                                                                                                                                                �  x.(1�*N�#$玠貨         ︷��"       嬍n �2     pnX �>           +       %ProcessedCode     +*    �    ASSERT(pitem.IsFolder, 'Not a directory: '& CLIP(pitem.Name))
  IF NOT pitem.IsFolder
    RETURN FALSE
  END
  
  !xferinfo.Url -- remote path
  !xferinfo.Filename -- local full path
  !pitem -- local dir name
  
  baseUrl = xferinfo.Url[1 : INSTRING('/', xferinfo.Url, 1, 1)]
  
!  curl::DebugInfo('UploadDir: Url '& CLIP(xferinfo.Url))
!  curl::DebugInfo('UploadDir: Filename '& CLIP(xferinfo.Filename))
!  curl::DebugInfo('UploadDir: pitem '& CLIP(pitem.Name))
!  curl::DebugInfo('UploadDir: baseUrl '& CLIP(baseUrl))

  !load current remote dir list
  xf = xferinfo
  IF NOT LoadRemoteDir(xf, acct, pSSH, remoteChildren)
    RETURN FALSE
  END

  !create root remote dir if it does not exist
  CLEAR(remoteChildren)
  remoteChildren.IsFolder = TRUE
  remoteChildren.Name = pitem.Name
  GET(remoteChildren, remoteChildren.IsFolder, remoteChildren.Name)
  IF ERRORCODE()
    xf.Url = baseUrl
    xf.Filename = CLIP(xferinfo.Url) & pitem.Name
!        curl::DebugInfo('UploadDir: Create remote dir '& CLIP(xf.Filename))
    IF NOT CreateRemoteDir(xf, acct, pSSH, pitem)
      RETURN FALSE
    END
  END
  
  !load next level remote dir list
  xf.Url = CLIP(xferinfo.Url) & CLIP(pitem.Name) &'/'
  IF NOT LoadRemoteDir(xf, acct, pSSH, remoteChildren)
    RETURN FALSE
  END

  ReadLocalChildren(xferinfo.Filename, 1, localChildren)

!  !sort by hierarchy
!  SORT(localChildren, localChildren.Level, -localChildren.IsFolder, localChildren.Name)
  !sort
  SORT(localChildren, -localChildren.IsFolder, localChildren.Name)
  
!  curl::DebugInfo('Parent '& CLIP(xferinfo.Filename))
  LOOP qIndex = 1 TO RECORDS(localChildren)
    GET(localChildren, qIndex)
!    curl::DebugInfo(All(' ', localChildren.Level * 2) & CLIP(localChildren.Name) & CHOOSE(localChildren.IsFolder = TRUE, ' -- folder', ' -- file'))
    
    !children.Name -- full path
    
    IF localChildren.IsFolder
      !create remote dir if it does not exist
      CLEAR(remoteChildren)
      remoteChildren.IsFolder = TRUE
      remoteChildren.Name = localChildren.Name
      GET(remoteChildren, remoteChildren.IsFolder, remoteChildren.Name)
      IF ERRORCODE()
        xf.Url = baseUrl
        xf.Filename = CLIP(xferinfo.Url) & CLIP(pitem.Name) & '/'& localChildren.Name
!        curl::DebugInfo('UploadDir: Create remote dir '& CLIP(xf.Filename))
        IF NOT CreateRemoteDir(xf, acct, pSSH, pitem)
          RETURN FALSE
        END
      END
      
      xf.Url = CLIP(xferinfo.Url) & CLIP(pitem.Name) &'/'
      xf.Filename = localChildren.FullName
      iItem :=: localChildren
      IF NOT UploadDir(xf, acct, pSSH, iItem, pProgress, pLabel)
        RETURN FALSE
      END
      
    ELSE
      !url remote path
      !filename local full name
      !pitem local item
      xf.Url = CLIP(xferinfo.Url) & CLIP(pitem.Name) &'/'
      xf.Filename = localChildren.FullName
      iItem :=: localChildren
!      curl::DebugInfo('UploadFile: Url '& CLIP(xf.Url) &' Filename '& CLIP(xf.Filename) &' iItem '& CLIP(iItem.Name))
      curl::DebugInfo('UploadFile:  '& CLIP(xf.Filename) &' size '& CLIP(iItem.FileSize))
      IF NOT UploadFile(xf, acct, pSSH, iItem, pProgress, pLabel)
        RETURN FALSE
      END
    END
  END

  RETURN TRUE
 �  !           +       %LocalDataAfterClasses     +*    �  baseUrl                 STRING(256)
filename                STRING(256)
xf                      LIKE(TXferInfo)
iItem                   LIKE(TFtpFileInfo)

res                     CURLcode, AUTO

localChildren           QUEUE(TFtpFilesInfoEx), PRE(localChildren)  !with fullnames
                        END
remoteChildren          QUEUE(TFtpFilesInfo), PRE(remoteChildren)
                        END

qIndex                  LONG, AUTO
 �                                                                                                                                                                                    j   6$呁娮D厈�窵a"         a���"       釲 �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           .  V�1/:E毶N,衲         ���"       摃z �2     c硘 �2               PublicKeyFile �                                                                        @s255                Public Key File:        Public Key File                                                                             s    PROMPT('Public Key File:'),USE(?SSHSettings:PublicKeyFile:Prompt)
 ENTRY(@s255),USE(SSHSettings:PublicKeyFile)
     0    STRING(@s255),USE(SSHSettings:PublicKeyFile)
                                                       j   垺A踡M侳玻n @      @  F���"       �2^ �2     鵻V �>        �          %ClassItem %                            Default             WindowToolbar       %DefaultBaseClassType %                   %ClassItem                 Default             WindowManager             WindowToolbar             ToolbarClass       %ActualDefaultBaseClassType %                   %ClassItem                 Default                             WindowToolbar                       %ClassLines %                  %ClassItem                 Default   4   4       4   Init                   PROCEDURE(),BYTE,PROC,DERIVED4   4       4   Kill                   PROCEDURE(),BYTE,PROC,DERIVED4   4       4   TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED4   4       4   TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED       %ReturnValue "                     %ProcedureOneInstance                                %WindowOperationMode %                          Use WINDOW setting       %INISaveWindow                               %ProcedureDisableEnhanceFocus                             %   %ProcedureUseEnterInsteadTabOverride                                %WindowUseEnterInsteadTab                            -   %ProcedureUseEnterInsteadTabExcludeListCombo                             .   %ProcedureUseEnterInsteadTabEnableNextTabStop                             %   %ProcedureUseEnterInsteadTabExcludeG                            !   %WindowUseEnterInsteadTabExclude %                       %GlobalObject %                   %ClassItem                 Default             NO             WindowToolbar             NO       %ThisObjectName %                   %ClassItem                 Default
   
       
   ThisWindow             WindowToolbar             Toolbar       %UseDefaultABCBaseClass                    %ClassItem                 Default                       WindowToolbar                 %UseABCBaseClass                    %ClassItem                 Default                       WindowToolbar                 %ABCBaseClass %                   %ClassItem                 Default                             WindowToolbar                       %ExtBaseClass %                   %ClassItem            %BaseClassIncludeFile %                   %ClassItem            %DeriveFromBaseClass                    %ClassItem                 Default                        WindowToolbar                  %NewMethods                   %ClassItem            %NewMethodName %                   %NewMethods            %NewMethodPrototype %                   %NewMethods            %NewClassPropertyItems                   %ClassItem            %NewClassProperty %                   %NewClassPropertyItems            %NewClassDataType %                   %NewClassPropertyItems            %NewClassOtherType %                   %NewClassPropertyItems            %NewClassDataIsRef                    %NewClassPropertyItems            %NewClassDataSize %                   %NewClassPropertyItems            %NewClassDataDim1 %                   %NewClassPropertyItems            %NewClassDataDim2 %                   %NewClassPropertyItems            %NewClassDataDim3 %                   %NewClassPropertyItems            %NewClassDataDim4 %                   %NewClassPropertyItems            %ClassMethods                   %ClassItem            %ClassMethodName %                   %ClassMethods            %ClassMethodPrototype %                   %ClassMethods            %ClassPropertyItems                   %ClassItem            %ClassProperty %                   %ClassPropertyItems            %ClassDataType %                   %ClassPropertyItems            %ClassOtherType %                   %ClassPropertyItems            %ClassDataIsRef                    %ClassPropertyItems            %ClassDataSize %                   %ClassPropertyItems            %ClassDataDim1 %                   %ClassPropertyItems            %ClassDataDim2 %                   %ClassPropertyItems            %ClassDataDim3 %                   %ClassPropertyItems            %ClassDataDim4 %                   %ClassPropertyItems            %WindowStyles                        %WindowStyleFontName %                   %WindowStyles            %WindowStyleFontNameVariable %                   %WindowStyles            %WindowStyleFontNameIsVariable                    %WindowStyles            %WindowStyleFontSize %                   %WindowStyles            %WindowStyleFontSizeVariable %                   %WindowStyles            %WindowStyleFontSizeIsVariable                    %WindowStyles            %WindowStyleFontStyle %                   %WindowStyles            %WindowStyleFontStyleVariable %                   %WindowStyles             %WindowStyleFontStyleIsVariable                    %WindowStyles            %WindowStyleFontColor %                   %WindowStyles            %WindowStyleFontCharSet %                   %WindowStyles            %WindowStyleForegroundNormal                    %WindowStyles         %   %WindowStyleForegroundNormalVariable %                   %WindowStyles         '   %WindowStyleForegroundNormalIsVariable                    %WindowStyles            %WindowStyleBackgroundNormal                    %WindowStyles         %   %WindowStyleBackgroundNormalVariable %                   %WindowStyles         '   %WindowStyleBackgroundNormalIsVariable                    %WindowStyles            %WindowStyleForegroundSelected                    %WindowStyles         '   %WindowStyleForegroundSelectedVariable %                   %WindowStyles         )   %WindowStyleForegroundSelectedIsVariable                    %WindowStyles            %WindowStyleBackgroundSelected                    %WindowStyles         '   %WindowStyleBackgroundSelectedVariable %                   %WindowStyles         )   %WindowStyleBackgroundSelectedIsVariable                    %WindowStyles            %WindowStylePicture %                   %WindowStyles            %WindowStylePictureVariable %                   %WindowStyles            %WindowStylePictureIsVariable                    %WindowStyles            %WindowStyleOtherListboxes %                       %ProcedureAutoBindFields                        %ProcedureAutoBindField %                   %ProcedureAutoBindFields            %ProcedureAutoBindFieldTPL %                   %ProcedureAutoBindFields            %ProcedureAutoBindProcedures                        %ProcedureAutoBindProcedure %                   %ProcedureAutoBindProcedures            %ProcedureAutoBindProcedureTPL %                   %ProcedureAutoBindProcedures             %ProcedureAutoBindFieldsIgnored                        %ProcedureAutoBindFieldIgnored %                    %ProcedureAutoBindFieldsIgnored         $   %ProcedureAutoBindProceduresIgnored                     #   %ProcedureAutoBindProcedureIgnored %                $   %ProcedureAutoBindProceduresIgnored         "   %ProcedureAutoBindValidToAddField                                %ProcedureUserBindFields                        %ProcedureUserBindField "                   %ProcedureUserBindFields            %ProcedureAutoBindFieldIgnore                    %ProcedureAutoBindFields            %ProcedureUserBindProcedures                        %ProcedureUserBindProcedure                     %ProcedureUserBindProcedures         "   %ProcedureAutoBindProcedureIgnore                    %ProcedureAutoBindProcedures            %ProcedureUserBindExpressions                     !   %ProcedureUserBindExpressionName %                   %ProcedureUserBindExpressions            %ProcedureUserBindExpression %                   %ProcedureUserBindExpressions            %PreserveVarsLoc                        %PreserveVarLoc %                   %PreserveVarsLoc            %ExtUITabIcon %                	   %Control            %ExtUITabStyleOverrideGlobal                 	   %Control            %ExtUITabStyle %                	   %Control                                 Default       %FieldGradientColorType %                	   %Control                                 Off        %FieldGradientColorTypeVariable %                	   %Control                                        "   %FieldGradientColorTypeIsVariable                 	   %Control                                      %FieldGradientColorFrom                 	   %Control                           ����        %FieldGradientColorFromVariable %                	   %Control         "   %FieldGradientColorFromIsVariable                 	   %Control                                      %FieldGradientColorTo                 	   %Control                           ����       %FieldGradientColorToVariable %                	   %Control             %FieldGradientColorToIsVariable                 	   %Control                                      %ButtonAction %                	   %Control                                 No Special Action             ?bAbortUpload             No Special Action             ?bClearDebugLog             No Special Action	   	       	   ?bConnect             No Special Action             ?bCopyDebugLog             No Special Action             ?bCreateRemoteDir             No Special Action             ?bDeleteRemoteFile             No Special Action
   
       
   ?bDownload             No Special Action             ?bDownloadAndDeleteRemoteFile             No Special Action	   	       	   ?bRefresh             No Special Action             ?bRenameRemoteFile             No Special Action             ?bSSHSettings             No Special Action             ?bUpload             No Special Action       %ButtonRunName %                	   %Control            %ButtonRunParameters %                	   %Control            %ButtonProcedure                  	   %Control            %ButtonThread                 	   %Control            %ButtonThreadStack %                	   %Control                           ╝               ?bAbortUpload       ╝               ?bClearDebugLog       ╝  	   	       	   ?bConnect       ╝               ?bCopyDebugLog       ╝               ?bCreateRemoteDir       ╝               ?bDeleteRemoteFile       ╝  
   
       
   ?bDownload       ╝               ?bDownloadAndDeleteRemoteFile       ╝  	   	       	   ?bRefresh       ╝               ?bRenameRemoteFile       ╝               ?bSSHSettings       ╝               ?bUpload       ╝         %ButtonParameters %                	   %Control            %ButtonReturnValueAssignment "                	   %Control         "   %ButtonReturnValueReferenceAssign                 	   %Control            %ButtonRequest %                	   %Control                                 None             ?bAbortUpload             None             ?bClearDebugLog             None	   	       	   ?bConnect             None             ?bCopyDebugLog             None             ?bCreateRemoteDir             None             ?bDeleteRemoteFile             None
   
       
   ?bDownload             None             ?bDownloadAndDeleteRemoteFile             None	   	       	   ?bRefresh             None             ?bRenameRemoteFile             None             ?bSSHSettings             None             ?bUpload             None       %ButtonThreadParameters %                	   %Control         #   %ButtonThreadReturnValueAssignment "                	   %Control            %PreLookupKey #                	   %Control            %PreLookupField $                	   %Control            %PreLookupProcedure                  	   %Control            %PreLookupProcedureParameters %                	   %Control            %PostLookupKey #                	   %Control            %PostLookupField $                	   %Control            %PostLookupProcedure                  	   %Control            %PostLookupProcedureParameters %                	   %Control            %PostLookupDuringValidate                 	   %Control                                           ?Account:Pwd                       ?Account:User                       ?BaseUrl                       ?CurrentLocalPath                       ?CurrentRemotePath                       ?XFerInfo:Port                 %LookupAssign                	   %Control            %MoreTarget "                   %LookupAssign            %MoreField %                   %LookupAssign            %ForceWindowRefresh                 	   %Control            %CheckedAssigns                	   %Control            %CheckedAssignVariable "                   %CheckedAssigns            %CheckedAssignValue %                   %CheckedAssigns            %CheckedHides                	   %Control            %CheckedControl %                   %CheckedHides            %CheckedControlAction %                   %CheckedHides                               %CheckedEnables                	   %Control            %CheckedControl1 %                   %CheckedEnables            %CheckedControl1Action %                   %CheckedEnables                               %UncheckedAssigns                	   %Control            %UncheckedAssignVariable "                   %UncheckedAssigns            %UncheckedAssignValue %                   %UncheckedAssigns            %UnCheckedHides                	   %Control            %UnCheckedControl %                   %UnCheckedHides            %UnCheckedControlAction %                   %UnCheckedHides                               %UnCheckedEnables                	   %Control            %UnCheckedControl1 %                   %UnCheckedEnables            %UnCheckedControl1Action %                   %UnCheckedEnables                               %CheckedDisables                	   %Control            %CheckedDisableControl %                   %CheckedDisables            %CheckedDisableControlAction %                   %CheckedDisables                               %UnCheckedDisables                	   %Control            %UnCheckedDisableControl %                   %UnCheckedDisables            %UnCheckedDisableControlAction %                   %UnCheckedDisables                               %ActiveImageEnable                 	   %Control            %AIObjectName %                	   %Control                                 AIBtn0       %AIEnableMimicControl                 	   %Control                                     %AIMimicControl %                	   %Control                                 ?BaseUrl:Prompt       %AIImgRound                 	   %Control            %AIOverrideImg %                	   %Control            %AIOverrideImgVariable %                	   %Control            %AIOverrideImgIsVariable                 	   %Control                                      %AIDisableImg %                	   %Control            %AIDisableImgVariable %                	   %Control            %AIDisableImgIsVariable                 	   %Control                                   
   %AIHotImg %                	   %Control            %AIHotImgVariable %                	   %Control            %AIHotImgIsVariable                 	   %Control                                      %AIPressedImg %                	   %Control            %AIPressedImgVariable %                	   %Control            %AIPressedImgIsVariable                 	   %Control                                                                                                      �  e�/j崞H�猘Q瞃         ����"       婮 �2     婮 �2                                                                                                                                                                                                                            j   B﹛�t匬AC酹��         a���"       屖n �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           .  8񬫏掩M噅翎FDq         /���"       +� �2     EX �2            	   IsFolder �                                                                        @n3                Is Folder:     
   Is Folder                                                                             g    PROMPT('Is Folder:'),USE(?LocalFileInfoQ:IsFolder:Prompt)
 ENTRY(@n3),USE(LocalFileInfoQ:IsFolder)
     ,    STRING(@n3),USE(LocalFileInfoQ:IsFolder)
                                                                                          r   冗坩SF垬泖齿�         ￣��"      婮 �2     櫾W �2                  CreateFolderDialog 麇醻岶彲筩�z       (*STRING pDirname), BOOL        (*STRING pDirname) �+�/峵騁懫>灚稍                                         ABC$Window         s �2 櫾W       櫾W �2     櫼Dt�M皔�$s(3@洷顬1諱悲骄	(�   微�:oO��P@xdin焑H矫E汖茉燆羇e�/j崞H�猘Q瞃                                                                                                                                                                    .  in焑H矫E汖茉燆羇         侢��"       f{K �2     捯M �2               rc �                     BOOL                                                    @s20                rc:        rc                                                                             7    PROMPT('rc:'),USE(?rc:Prompt)
 ENTRY(@s20),USE(rc)
         STRING(@s20),USE(rc)
                                                                                                                                                                            �  �q莓MF粊菄@d汗         ����"       d �2     d �2                                                                                                                                                                                                                            �  湀,qK割J渞>�         ����"       5) �2     5) �2                                                                                                                                                                                                                            .  鬳廬前M�\[�堍         凝��"       騠c �2     呍c �2            
   TFileInfo �0                        
   TFileInfo               @            files and folders info                @s20                TF ile Info:        TF ile Info                files and folders info        files and folders info                                                     �    PROMPT('TF ile Info:'),USE(?TFileInfo:Prompt)
 ENTRY(@s20),USE(TFileInfo),MSG('files and folders info'),TIP('files and folders info')
         STRING(@s20),USE(TFileInfo)
                                                                                                                                                                                                                                                p   �M亾.E角5[緝[^         T���"       淼I �2     曕h }6           O懕⑿2�NQ鐽珁�                                                  ABC$GENERATED         s }6 曕h       曕h }6                                                                                              j   隡D縟%甆�羲椘憱         a���"       8礗 �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           .  >�絾f鶨�m佫|ha         -���"       梴W �2     顪_ �2               glo:DebugText �@B                                                                      @s255                glo : Debug Text:        glo : Debug Text                                                                             \    PROMPT('glo : Debug Text:'),USE(?glo:DebugText:Prompt)
 ENTRY(@s255),USE(glo:DebugText)
     $    STRING(@s255),USE(glo:DebugText)
                                                                                         .  埙�秗籑瘡樥祽徾         7���"       I燗 �6     9褹 �6               SSHSettings �H                   TSSHSettings                                                    @s20                SSHS ettings:        SSHS ettings                                                                             S    PROMPT('SSHS ettings:'),USE(?SSHSettings:Prompt)
 ENTRY(@s20),USE(SSHSettings)
     !    STRING(@s20),USE(SSHSettings)
                                                                                                  p   覕H=wL砊鮭眨編         T���"       �5R �2     |腶 �5           �ッ帆θ49N�                    
                              ABC$GENERATED         s �5 |腶       |腶 �5                                                                                              �  d~9镀HDきh鍈         ����"       倦D �2     倦D �2                                                                                                                                                                                                                            �  猻5哳 0C浲}Xs7�         ����"       )3y �2     )3y �2                                                                                                                                                                                                                            .  .s�(U犰E筄蹃\錢�         ]���"       瘇` �2     Id �2               Pwd �(                                                                        @s40             
   Password:        Pwd                                                                             O    PROMPT('Password:'),USE(?Account:Pwd:Prompt)
 ENTRY(@s40),USE(Account:Pwd)
     !    STRING(@s40),USE(Account:Pwd)
                                                                                                                                        �  赖p瀲]E殶韞wIe         ����"       馰 �2     馰 �2                                                                                                                                                                                                                            .  綑�,[鋋K緌�,M瓋�         濑��"       0` �2     0` �2                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                         .  �5�歎騄�9�"I攭         ���"       E鮵 �2     c硘 �2               PublicKeyFile �                                                                        @s255                Public Key File:        Public Key File                                                                             s    PROMPT('Public Key File:'),USE(?SSHSettings:PublicKeyFile:Prompt)
 ENTRY(@s255),USE(SSHSettings:PublicKeyFile)
     0    STRING(@s255),USE(SSHSettings:PublicKeyFile)
                                                       �  ob跢瞣歊�6`�         ����"       �:h �2     �:h �2                                                                                                                                                                                                                            .  破赻棯_H犗.奝�)�         ��"       8� �2     々A �2               LocalFileInfoQ �0                           LocalFileInfoQ                            like TFtpFilesInfo                @s20                Local File Info Q:        Local File Info Q                like TFtpFilesInfo        like TFtpFilesInfo                                                     �    PROMPT('Local File Info Q:'),USE(?LocalFileInfoQ:Prompt)
 ENTRY(@s20),USE(LocalFileInfoQ),MSG('like TFtpFilesInfo'),TIP('like TFtpFilesInfo')
     $    STRING(@s20),USE(LocalFileInfoQ)
                                                                                                                                                                                                                        p   !bj槭%G�*x�4贳Z         T���"       嵤n �2     �峷 �2           ���(PI啺C}lr�                                                  ABC$GENERATED         s �2 �峷       �峷 �2                                                                                              �  !-妓?�'O巢羗m渤�         引��"       頤W �2     裉X �2                    L           d   �
   	   �!6�
          �#   �   �� ,   C      �   �	   
    �3IQ�   ��
 1      ,   �;   �   �� D   D   ,   �   
   �	#   
+    �K�   ��	 I   �   J   3   �L   *K�   ��	 Q   �   J   5   �X   �   ����    ]   FTP manager Segoe UI Old name: ?PROMPT1 s255 New name: ?PROMPT2 s255 OK ?bOK Cancel ?bCancel     7   Window Oldname 幆辨�廜貉犗/讠Newname �虆戋疧巕9K                                                                                                                                                                                                                   .  坚�5qM督篳秨�1         ���"       嶝z �2      �2               DisplayName ��                                                                        @s255                Display Name:        Display Name                                                                             t    PROMPT('Display Name:'),USE(?RemoteFileInfoQ:DisplayName:Prompt)
 ENTRY(@s255),USE(RemoteFileInfoQ:DisplayName)
     2    STRING(@s255),USE(RemoteFileInfoQ:DisplayName)
                                                            �  �48tQ	BO崵睗  鶵         D���"       a �2     �mX �>           +       %ProcessedCode     +*    �    res = ThisCurl.ResetOptions()
  IF res <> CURLE_OK
    MESSAGE(ThisCurl.StrError(res), 'FTP Manager', ICON:Exclamation)
    RETURN FALSE
  END

  url = ThisCurl.BuildUrl(xferinfo.Url, acct.User, pSSH)
  
  res = ThisCurl.LoadDir(url, dirlist)
  IF res <> CURLE_OK
    MESSAGE(ThisCurl.StrError(res), 'FTP Manager', ICON:Exclamation)
    RETURN FALSE
  END
  
  RETURN TRUE
   �     "        +       %DataSection     +*    N   url                     STRING(256)
res                     CURLcode, AUTO
              +       %LocalProcedures     +*          P  "   #                                                                             .  �4l|谦J�NΕql.         ,���"       we` �2     .猙 �2            	   FileSize �                                                                        @s20                File Size:     
   File Size                                                                             h    PROMPT('File Size:'),USE(?LocalFileInfoQ:FileSize:Prompt)
 ENTRY(@s20),USE(LocalFileInfoQ:FileSize)
     -    STRING(@s20),USE(LocalFileInfoQ:FileSize)
                                                                                       j   槀$骧 領��Ob <      <  5���"       頤W �2     鵻V �>        �          %ClassItem %                            Default             WindowToolbar       %DefaultBaseClassType %                   %ClassItem                 Default             WindowManager             WindowToolbar             ToolbarClass       %ActualDefaultBaseClassType %                   %ClassItem                 Default                             WindowToolbar                       %ClassLines %                  %ClassItem                 Default   4   4       4   Init                   PROCEDURE(),BYTE,PROC,DERIVED4   4       4   Kill                   PROCEDURE(),BYTE,PROC,DERIVED4   4       4   TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       %ReturnValue "             霖專萊G害7l鷄檏       %ProcedureOneInstance                                %WindowOperationMode %                          Use WINDOW setting       %INISaveWindow                               %ProcedureDisableEnhanceFocus                             %   %ProcedureUseEnterInsteadTabOverride                                %WindowUseEnterInsteadTab                            -   %ProcedureUseEnterInsteadTabExcludeListCombo                             .   %ProcedureUseEnterInsteadTabEnableNextTabStop                             %   %ProcedureUseEnterInsteadTabExcludeG                            !   %WindowUseEnterInsteadTabExclude %                       %GlobalObject %                   %ClassItem                 Default             NO             WindowToolbar             NO       %ThisObjectName %                   %ClassItem                 Default
   
       
   ThisWindow             WindowToolbar             Toolbar       %UseDefaultABCBaseClass                    %ClassItem                 Default                       WindowToolbar                 %UseABCBaseClass                    %ClassItem                 Default                       WindowToolbar                 %ABCBaseClass %                   %ClassItem                 Default                             WindowToolbar                       %ExtBaseClass %                   %ClassItem            %BaseClassIncludeFile %                   %ClassItem            %DeriveFromBaseClass                    %ClassItem                 Default                        WindowToolbar                  %NewMethods                   %ClassItem            %NewMethodName %                   %NewMethods            %NewMethodPrototype %                   %NewMethods            %NewClassPropertyItems                   %ClassItem            %NewClassProperty %                   %NewClassPropertyItems            %NewClassDataType %                   %NewClassPropertyItems                 WindowToolbar           %NewClassOtherType %                   %NewClassPropertyItems            %NewClassDataIsRef                    %NewClassPropertyItems            %NewClassDataSize %                   %NewClassPropertyItems            %NewClassDataDim1 %                   %NewClassPropertyItems            %NewClassDataDim2 %                   %NewClassPropertyItems            %NewClassDataDim3 %                   %NewClassPropertyItems            %NewClassDataDim4 %                   %NewClassPropertyItems            %ClassMethods                   %ClassItem            %ClassMethodName %                   %ClassMethods            %ClassMethodPrototype %                   %ClassMethods            %ClassPropertyItems                   %ClassItem            %ClassProperty %                   %ClassPropertyItems            %ClassDataType %                   %ClassPropertyItems                 WindowToolbar           %ClassOtherType %                   %ClassPropertyItems            %ClassDataIsRef                    %ClassPropertyItems            %ClassDataSize %                   %ClassPropertyItems            %ClassDataDim1 %                   %ClassPropertyItems            %ClassDataDim2 %                   %ClassPropertyItems            %ClassDataDim3 %                   %ClassPropertyItems            %ClassDataDim4 %                   %ClassPropertyItems            %WindowStyles                        %WindowStyleFontName %                   %WindowStyles            %WindowStyleFontNameVariable %                   %WindowStyles            %WindowStyleFontNameIsVariable                    %WindowStyles            %WindowStyleFontSize %                   %WindowStyles            %WindowStyleFontSizeVariable %                   %WindowStyles            %WindowStyleFontSizeIsVariable                    %WindowStyles            %WindowStyleFontStyle %                   %WindowStyles            %WindowStyleFontStyleVariable %                   %WindowStyles             %WindowStyleFontStyleIsVariable                    %WindowStyles            %WindowStyleFontColor %                   %WindowStyles            %WindowStyleFontCharSet %                   %WindowStyles            %WindowStyleForegroundNormal                    %WindowStyles         %   %WindowStyleForegroundNormalVariable %                   %WindowStyles         '   %WindowStyleForegroundNormalIsVariable                    %WindowStyles            %WindowStyleBackgroundNormal                    %WindowStyles         %   %WindowStyleBackgroundNormalVariable %                   %WindowStyles         '   %WindowStyleBackgroundNormalIsVariable                    %WindowStyles            %WindowStyleForegroundSelected                    %WindowStyles         '   %WindowStyleForegroundSelectedVariable %                   %WindowStyles         )   %WindowStyleForegroundSelectedIsVariable                    %WindowStyles            %WindowStyleBackgroundSelected                    %WindowStyles         '   %WindowStyleBackgroundSelectedVariable %                   %WindowStyles         )   %WindowStyleBackgroundSelectedIsVariable                    %WindowStyles            %WindowStylePicture %                   %WindowStyles            %WindowStylePictureVariable %                   %WindowStyles            %WindowStylePictureIsVariable                    %WindowStyles            %WindowStyleOtherListboxes %                       %ProcedureAutoBindFields                        %ProcedureAutoBindField %                   %ProcedureAutoBindFields            %ProcedureAutoBindFieldTPL %                   %ProcedureAutoBindFields            %ProcedureAutoBindProcedures                        %ProcedureAutoBindProcedure %                   %ProcedureAutoBindProcedures            %ProcedureAutoBindProcedureTPL %                   %ProcedureAutoBindProcedures             %ProcedureAutoBindFieldsIgnored                        %ProcedureAutoBindFieldIgnored %                    %ProcedureAutoBindFieldsIgnored         $   %ProcedureAutoBindProceduresIgnored                     #   %ProcedureAutoBindProcedureIgnored %                $   %ProcedureAutoBindProceduresIgnored         "   %ProcedureAutoBindValidToAddField                                %ProcedureUserBindFields                        %ProcedureUserBindField "                   %ProcedureUserBindFields            %ProcedureAutoBindFieldIgnore                    %ProcedureAutoBindFields            %ProcedureUserBindProcedures                        %ProcedureUserBindProcedure                     %ProcedureUserBindProcedures         "   %ProcedureAutoBindProcedureIgnore                    %ProcedureAutoBindProcedures            %ProcedureUserBindExpressions                     !   %ProcedureUserBindExpressionName %                   %ProcedureUserBindExpressions            %ProcedureUserBindExpression %                   %ProcedureUserBindExpressions            %PreserveVarsLoc                        %PreserveVarLoc %                   %PreserveVarsLoc            %ExtUITabIcon %                	   %Control            %ExtUITabStyleOverrideGlobal                 	   %Control            %ExtUITabStyle %                	   %Control                                 Default             ?bCancel             Default       %FieldGradientColorType %                	   %Control                                 Off             ?bCancel             Off        %FieldGradientColorTypeVariable %                	   %Control                                                 ?bCancel                    "   %FieldGradientColorTypeIsVariable                 	   %Control                                            ?bCancel                  %FieldGradientColorFrom                 	   %Control                           ����             ?bCancel       ����        %FieldGradientColorFromVariable %                	   %Control         "   %FieldGradientColorFromIsVariable                 	   %Control                                            ?bCancel                  %FieldGradientColorTo                 	   %Control                           ����             ?bCancel       ����       %FieldGradientColorToVariable %                	   %Control             %FieldGradientColorToIsVariable                 	   %Control                                            ?bCancel                  %ButtonAction %                	   %Control                                 No Special Action             ?bCancel             No Special Action             ?bOK             No Special Action       %ButtonRunName %                	   %Control            %ButtonRunParameters %                	   %Control            %ButtonProcedure                  	   %Control            %ButtonThread                 	   %Control            %ButtonThreadStack %                	   %Control                           ╝               ?bCancel             25000             ?bOK             25000       %ButtonParameters %                	   %Control            %ButtonReturnValueAssignment "                	   %Control         "   %ButtonReturnValueReferenceAssign                 	   %Control            %ButtonRequest %                	   %Control                                 None             ?bCancel             None             ?bOK             None       %ButtonThreadParameters %                	   %Control         #   %ButtonThreadReturnValueAssignment "                	   %Control            %PreLookupKey #                	   %Control            %PreLookupField $                	   %Control            %PreLookupProcedure                  	   %Control            %PreLookupProcedureParameters %                	   %Control            %PostLookupKey #                	   %Control            %PostLookupField $                	   %Control            %PostLookupProcedure                  	   %Control            %PostLookupProcedureParameters %                	   %Control            %PostLookupDuringValidate                 	   %Control                                           ?Newname                       ?Oldname                       ?bCancel                 %LookupAssign                	   %Control            %MoreTarget "                   %LookupAssign            %MoreField %                   %LookupAssign            %ForceWindowRefresh                 	   %Control            %CheckedAssigns                	   %Control            %CheckedAssignVariable "                   %CheckedAssigns            %CheckedAssignValue %                   %CheckedAssigns            %CheckedHides                	   %Control            %CheckedControl %                   %CheckedHides            %CheckedControlAction %                   %CheckedHides                                     ?bCancel           %CheckedEnables                	   %Control            %CheckedControl1 %                   %CheckedEnables            %CheckedControl1Action %                   %CheckedEnables                                     ?bCancel           %UncheckedAssigns                	   %Control            %UncheckedAssignVariable "                   %UncheckedAssigns            %UncheckedAssignValue %                   %UncheckedAssigns            %UnCheckedHides                	   %Control            %UnCheckedControl %                   %UnCheckedHides            %UnCheckedControlAction %                   %UnCheckedHides                                     ?bCancel           %UnCheckedEnables                	   %Control            %UnCheckedControl1 %                   %UnCheckedEnables            %UnCheckedControl1Action %                   %UnCheckedEnables                                     ?bCancel           %CheckedDisables                	   %Control            %CheckedDisableControl %                   %CheckedDisables            %CheckedDisableControlAction %                   %CheckedDisables                                     ?bCancel           %UnCheckedDisables                	   %Control            %UnCheckedDisableControl %                   %UnCheckedDisables            %UnCheckedDisableControlAction %                   %UnCheckedDisables                                     ?bCancel           %ActiveImageEnable                 	   %Control            %AIObjectName %                	   %Control                                 AIBtn0             ?bCancel             AIBtn4       %AIEnableMimicControl                 	   %Control                                           ?bCancel                 %AIMimicControl %                	   %Control                                 ?PROMPT1             ?bCancel             ?PROMPT1       %AIImgRound                 	   %Control            %AIOverrideImg %                	   %Control            %AIOverrideImgVariable %                	   %Control            %AIOverrideImgIsVariable                 	   %Control                                            ?bCancel                  %AIDisableImg %                	   %Control            %AIDisableImgVariable %                	   %Control            %AIDisableImgIsVariable                 	   %Control                                            ?bCancel               
   %AIHotImg %                	   %Control            %AIHotImgVariable %                	   %Control            %AIHotImgIsVariable                 	   %Control                                            ?bCancel                  %AIPressedImg %                	   %Control            %AIPressedImgVariable %                	   %Control            %AIPressedImgIsVariable                 	   %Control                                            ?bCancel                                                                 �  D禉�啳I秐嵑繗         ����"       juo �2     juo �2                                                                                                                                                                                                                            .  [�(映eL孒~ht騤�         ���"       ;� �2     EX �2               DisplayName ��                                                                        @s255                Display Name:        Display Name                                                                             r    PROMPT('Display Name:'),USE(?LocalFileInfoQ:DisplayName:Prompt)
 ENTRY(@s255),USE(LocalFileInfoQ:DisplayName)
     1    STRING(@s255),USE(LocalFileInfoQ:DisplayName)
                                                               .  貛漫d俻D桙搠9崡         W���"       蓼` �5     C╜ �5               Root ��                                                                        @s255                Root:        Root                                                                             R    PROMPT('Root:'),USE(?TXFerInfo:Root:Prompt)
 ENTRY(@s255),USE(TXFerInfo:Root)
     %    STRING(@s255),USE(TXFerInfo:Root)
                                                                                                                                   �  I�1u廗��-nM%|         ��"       馰 �2     FnX �>           +       %LocalDataAfterClasses     +*    �   url                     STRING(256)
oldname                 STRING(256)
newname                 STRING(256)
res                     CURLcode, AUTO
 �             +       %ProcessedCode     +*    �    res = ThisCurl.ResetOptions()
  IF res <> CURLE_OK
    MESSAGE(ThisCurl.StrError(res), 'FTP Manager', ICON:Exclamation)
    RETURN FALSE
  END

  url = ThisCurl.BuildUrl(xferinfo.Url, acct.User, pSSH)

  !oldname like "/home/slavaz/testfile1.txt"
  oldname = ExtractRemotePath(xferinfo.Filename)
  !newname like "/home/slavaz/testfile2.txt"
  newname = ExtractRemotePath(pNewname)

  IF pitem.IsFolder
    res = ThisCurl.RenameDir(url, CLIP(oldname), CLIP(newname))
  ELSE
    res = ThisCurl.RenameFile(url, CLIP(oldname), CLIP(newname))
  END
  
  IF res <> CURLE_OK
    MESSAGE(ThisCurl.StrError(res), 'FTP Manager', ICON:Exclamation)
    RETURN FALSE
  END
  
  RETURN TRUE
 �     /                                                                                                                                                                                                                                                                 j   �0栻�#塏氬踀SY         a���"       �7R �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           .  微�:oO��P@xd         `���"       躂 �2     捯M �2               Dirname ��                                                                        @s255             	   Dirname:        Dirname                                                                             G    PROMPT('Dirname:'),USE(?Dirname:Prompt)
 ENTRY(@s255),USE(Dirname)
         STRING(@s255),USE(Dirname)
                                                                                                                                           r   7尭⺁慖�3 �I         ���"      馰 �2     骩y �5     O             RenameRemoteItem z哔�77@ゆG!W    b   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem, STRING pNewname), BOOL     \   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem, STRING pNewname)       �ッ帆θ49N�                   Renames file or directory                ABC$Source         s �5 骩y       骩y �5     谘�堿殧亯Xr*gI�1u廗��-nM%| 赖p瀲]E殶韞wIe                              �  '"�	R<篔滯(4NZ�         ��"       )3y �2     enX �>           +        %WindowManagerMethodCodeSection     +       Init     +       (),BYTE     +*    �   SSHSettings = pSSHSettings

IF SSHSettings.AuthMethod = CURLSSH_AUTH_NONE
  SSHSettings.AuthMethod = CURLSSH_AUTH_DEFAULT
END
 A  S   X       +       %ControlEventHandling     +       ?bOK     +    	   Accepted     +*    A   pSSHSettings = SSHSettings
rc = TRUE
POST(EVENT:CloseWindow)
 4!  |          +    	   ?bCancel     +    	   Accepted     +*    &   rc = FALSE
POST(EVENT:CloseWindow)
 4!  �   �                                                                                                                                                                                     j   J :
^�3A�规瓧�/         a���"       fah �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           p   眛玀捰b~�i         T���"       e �2     Z�	 �6           狧d鷒严I�;{2;                                                  ABC$GENERATED         s �6 Z�	       Z�	 �6                                                                                              .  �3匐O珋a�%�         濑��"       褷y �2     褷y �2                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                         .  榮	蕑E瓀充櫶饸         )���"       哷 �2     .猙 �2            	   FileMask �
                                                                        @s10                File Mask:     
   File Mask                                                                             j    PROMPT('File Mask:'),USE(?RemoteFileInfoQ:FileMask:Prompt)
 ENTRY(@s10),USE(RemoteFileInfoQ:FileMask)
     .    STRING(@s10),USE(RemoteFileInfoQ:FileMask)
                                                                                    .  恚侲魵驤� 3�(怦         ���"       懚y �2     i z �2               PrivateKeyFile �                                                                        @s255                Private Key File:        Private Key File                                                                             x    PROMPT('Private Key File:'),USE(?TSSHSettings:PrivateKeyFile:Prompt)
 ENTRY(@s255),USE(TSSHSettings:PrivateKeyFile)
     2    STRING(@s255),USE(TSSHSettings:PrivateKeyFile)
                                              .  众鎄腉骏瀁+3�&         ]���"       曮	 �2     V�	 �2               Port �                                                                        @n13                Port:        Port                                                                             O    PROMPT('Port:'),USE(?XFerInfo:Port:Prompt)
 ENTRY(@n13),USE(XFerInfo:Port)
     #    STRING(@n13),USE(XFerInfo:Port)
                                                                                                                                        j   g鍆辻灒A�5x艘�         a���"       `� �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           p   腒鍓槯N�?0砩%         T���"       鎉 �2     �E �=           �6W释KnI剓蓖?耯                                                  ABC$GENERATED         s �7 唾:       �E �=                                                                                              .  p瘶|E癠礡斠矨         ^���"       )` �2     +蟘 �2               Url ��                                                                        @s255                Url:        Url                                                                             O    PROMPT('Url:'),USE(?TXFerInfo:Url:Prompt)
 ENTRY(@s255),USE(TXFerInfo:Url)
     $    STRING(@s255),USE(TXFerInfo:Url)
                                                                                                                                          �  �&�;�8狤�,緙2�         轩��"       6y �2     +l: �7                    �         B  �   �
   	   �!6�
 &         �=   �   �� k      Z      �	   
"    �/   5\   �   ��
 �      R   ��   �   �� �   J   R   �   
   �	2   
L    �3�   ��
 �      b   ��   �   ��   J   _   �   
   �	\   
w    �3�   ��
      o   �"  �   �� A  J   o   �   
   �	�   
�    �3�   ��
 F        �T  �	   �� t  J      �   
   �	�   
�    �3�
   ��
 x     �   ��  �   �� �  K   �   �   
   �	�   
�    ��   ��	 �  �   �   1   ��  �   ��	 �    �   /   ��  �   ��
 �     ?   ��  

�  ��   ����    �  SSH settings Microsoft Sans Serif Authentication method: ?SSHSettings:AuthMethod:Prompt Any|#-1|None|#0|PublicKey|#1|Password|#2|Host|#4|Keyboard|#8|Agent|#16 Public Key File: ?SSHSettings:PublicKeyFile:Prompt s255 Private Key File: ?SSHSettings:PrivateKeyFile:Prompt s255 Known Hosts: ?SSHSettings:KnownHosts:Prompt s255 Key Password: ?SSHSettings:KeyPassword:Prompt s40 Public Key MD5: ?SSHSettings:PublicKeyMD5:Prompt s32 OK ?bOK Cancel ?bCancel PublicKey authentication settings: ?PROMPT1     �   Window SSHSettings:AuthMethod � '噑橈@柼澥攰SSHSettings:PublicKeyFile �5�歎騄�9�"I攭SSHSettings:PrivateKeyFile 且潻嘾A�o\I維SHSettings:KnownHosts X~�=@hC熦ari	�SSHSettings:KeyPassword i�!镓狥婇洼R抶SSHSettings:PublicKeyMD5 	.fR3荕&讯�                                                                                                                                                                                                                 j   再�|扜I壁臲^--M         氟��"       K鋆 �2     �^ �2                  %SaveCreateLocalMap %                          1       %GenerationCompleted %                  %Module                 FTPManager.clw             1             FTPManager001.clw             1             FTPManager002.clw             1             FTPManager003.clw             1             FTPManager004.clw             1             FTPManager005.clw             1             FTPManager006.clw             1             FTPManager007.clw             1             FTPManager008.clw             1             FTPManager009.clw             1             FTPManager010.clw             1             FTPManager011.clw             1             FTPManager012.clw             1             FTPManager013.clw             1             FTPManager014.clw             1             FTPManager015.clw             1             FTPManager016.clw             1             FTPManager017.clw             1       %LastTarget32 %                          1       %LastProgramExtension %                          EXE       %LastApplicationDebug %                                    %LastApplicationLocalLibrary %                          1                                                                                                                                                                                        .  O鲙�痉N兂湓湜         鳊��"       )` �2     +蟘 �2            	   Filename ��                                                        local file                @s255             
   Filename:     	   Filename                local file        local file                                                     �    PROMPT('Filename:'),USE(?TXFerInfo:Filename:Prompt)
 ENTRY(@s255),USE(TXFerInfo:Filename),MSG('local file'),TIP('local file')
     )    STRING(@s255),USE(TXFerInfo:Filename)
                                                                                                                                                                                                                                                                                                  .  霖專萊G害7l鷄檏         侢��"       頤W �2     騏W �2               rc �                    BOOL                                                    @s20                rc:        rc                                                                             7    PROMPT('rc:'),USE(?rc:Prompt)
 ENTRY(@s20),USE(rc)
         STRING(@s20),USE(rc)
                                                                                                                                                                            r   �0閕\�1H�\?lL潠         觚��"      �8h �2     ВD �=                  DownloadFile P7揻鯧\D�'舮1�    �   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem, SIGNED pProgress, SIGNED pLabel, BOOL pDeleteAfter=FALSE), BOOL     y   (TXferInfo xferinfo,TAccount acct,TSSHSettings pSSH,TFtpFileInfo pitem,SIGNED pProgress,SIGNED pLabel,BOOL pDeleteAfter)       �ッ帆θ49N�                                   ABC$Source         s �= U嶤       ВD �=     朣��g甇�:寷�\.�漰o砈B邯鑆鞬If 錆褛�-7B絻嬴糽?q                                                                                                                                                                                                                                                      .  ��`{I爊P _�         Z���"       �	 �2     掜	 �2               Port �                                                                        @n13                Port:        Port                                                                             Q    PROMPT('Port:'),USE(?TXFerInfo:Port:Prompt)
 ENTRY(@n13),USE(TXFerInfo:Port)
     $    STRING(@n13),USE(TXFerInfo:Port)
                                                                                                                                      �  嗾RIズV�?D�         忴��"       _� �2     �nX �>           +       %LocalDataAfterClasses     +*    �  !url                     STRING(256)
!filename                STRING(256)
!
!res                     CURLcode, AUTO

xf                      LIKE(TXferInfo)

szLocalFolder           CSTRING(256)
secattr                 LIKE(SECURITY_ATTRIBUTES)

remoteChildren          QUEUE(TFtpFilesInfo), PRE(remoteChildren)
                        END
qIndex                  LONG, AUTO
 �             +       %ProcessedCode     +*    =    ASSERT(pitem.IsFolder)
  IF NOT pitem.IsFolder
    RETURN FALSE
  END
    
  szLocalFolder = CLIP(xferinfo.Filename)
  IF NOT winapi::CreateDirectory(szLocalFolder, secattr)
    IF winapi::GetLastError() <> ERROR_ALREADY_EXISTS
      MESSAGE('Unable to create local folder '& szLocalFolder, 'FTP Manager', ICON:Exclamation)
      RETURN FALSE
    END
  END
  
  xf = xferinfo
  xf.Url = CLIP(xferinfo.Url) & CLIP(pitem.Name) &'/'
!  curl::DebugInfo('RemoteDir: '& CLIP(xf.Url) &' --> LocalDir:'& szLocalFolder)

  !load root dir list
  IF NOT LoadRemoteDir(xf, acct, pSSH, remoteChildren)
    RETURN FALSE
  END
  
  SORT(remoteChildren, -remoteChildren:IsFolder, +remoteChildren:SortName)

  LOOP qIndex = 1 TO RECORDS(remoteChildren)
    GET(remoteChildren, qIndex)
    
    IF remoteChildren.IsFolder
      !folder
      IF remoteChildren.Name <> '.' AND remoteChildren.Name <> '..'
        xf.Filename = szLocalFolder &'\'& remoteChildren.Name
        IF NOT DownloadDir(xf, acct, pSSH, remoteChildren, pProgress, pLabel)
          BREAK
        END
      END
    ELSE
      !file
      xf.Filename = szLocalFolder &'\'& remoteChildren.Name
      IF DownloadFile(xf, acct, pSSH, remoteChildren, pProgress, pLabel)
        !BEEP(BEEP:SystemDefault)
      END
    END
  END
  
  RETURN TRUE
 �     L                                                                                                                                                        j   朣��g甇�:寷�\.         a���"       M=h �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           j   穩仜�1禝夀溭奺Y         a���"       S餌 �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           .  畞宊� 荊�宨�         ���"       �> �6     褞A �6               PublicKeyMD5 �                                                                         @s32                Public Key MD 5:        Public Key MD 5                                                                             p    PROMPT('Public Key MD 5:'),USE(?SSHSettings:PublicKeyMD5:Prompt)
 ENTRY(@s32),USE(SSHSettings:PublicKeyMD5)
     .    STRING(@s32),USE(SSHSettings:PublicKeyMD5)
                                                              �  �漰o砈B邯鑆鞬If         ���"       �8h �2     nX �>           +       %LocalDataAfterClasses     +*      url                     STRING(256)
filename                STRING(256)

LocFileItem             QUEUE(FILE:queue), PRE(LocFileItem)
                        END

srcFileInfo             STRING(128)
dstFileInfo             STRING(128)

res                     CURLcode, AUTO
 �             +       %ProcessedCode     +*    �	    ASSERT(NOT pitem.IsFolder)
  IF pitem.IsFolder
    RETURN FALSE
  END
    
  IF EXISTS(xferinfo.Filename)
    IF glo:OverwriteExistingFile = OEF::NoForAll
      RETURN FALSE
    END

    IF glo:OverwriteExistingFile <> OEF::YesForAll
      
      !read local file info
      DIRECTORY(LocFileItem, xferinfo.Filename, ff_:NORMAL)
      GET(LocFileItem, 1)
      ASSERT(NOT ERRORCODE())
      dstFileInfo = 'Local:  Date '& FORMAT(LocFileItem.Date, @d17) &' '& FORMAT(LocFileItem.Time, @t07) &'; Size '& LocFileItem.Size
      srcFileInfo = 'Remote: Date '& CLIP(pitem.LastModified) &'; Size '& CLIP(pitem.FileSize)
      
      CASE MESSAGE('File '& CLIP(xferinfo.Filename) &' exists, overwrite?|'& CLIP(srcFileInfo) &'|'& CLIP(dstFileInfo), 'FTP Manager', ICON:Question, 'No|No for All|Yes|Yes for All', 1)
      OF 1  !No
        glo:OverwriteExistingFile = OEF::No
        RETURN FALSE
      OF 2  !No for All
        glo:OverwriteExistingFile = OEF::NoForAll
        RETURN FALSE
      OF 3  !Yes
        glo:OverwriteExistingFile = OEF::No
      OF 4  !Yes for All
        glo:OverwriteExistingFile = OEF::YesForAll
      END
    END
  END
  
  !setup label
  pLabel{PROP:Text} = CLIP(pitem.Name) &'...'
  
  res = ThisCurl.ResetOptions()
  IF res <> CURLE_OK
    MESSAGE(ThisCurl.StrError(res), 'FTP Manager', ICON:Exclamation)
    RETURN FALSE
  END

  ThisCurl.SetDownloadProgress(pProgress, DEFORMAT(pitem.FileSize))
  
  url = ThisCurl.BuildUrl(xferinfo.Url, acct.User, pSSH)

  url = CLIP(url) & pitem.Name
  filename = xferinfo.Filename
  
  res = ThisCurl.ReadFile(url, filename)
    
  ThisCurl.SetDownloadProgress(0, 0)

  IF res = CURLE_OK
    
    !- Delete file after download
    IF pDeleteAfter
      !url like "ftp://user@127.0.0.1:21"
      url = ThisCurl.BuildUrl(xferinfo.Url, acct.User, pSSH)

      !filename like "/home/var/temp/testfile.txt"
      filename = pitem.Name
      
      curl::DebugInfo('DeleteAfter: url='& CLIP(url) &'; remotefile='& CLIP(filename))

      res = ThisCurl.DeleteFile(url, CLIP(filename))
      IF res <> CURLE_OK
        MESSAGE(ThisCurl.StrError(res), 'FTP Manager', ICON:Exclamation)
      END
    END
    
    RETURN TRUE
  ELSIF res = -1 
    MESSAGE('Cannot create local file', 'libcurl', ICON:Exclamation)
    RETURN FALSE
  ELSE
    MESSAGE('Download failed: '& ThisCurl.StrError(res), 'libcurl', ICON:Exclamation)
    RETURN FALSE
  END
 �     k                                                                                                                                        .  堃蝒鷤eHナ.SN嚱q         )���"       綉 �2     EX �2            	   SortName ��                                                                        @s255                Sort Name:     
   Sort Name                                                                             i    PROMPT('Sort Name:'),USE(?LocalFileInfoQ:SortName:Prompt)
 ENTRY(@s255),USE(LocalFileInfoQ:SortName)
     .    STRING(@s255),USE(LocalFileInfoQ:SortName)
                                                                                    �  hm焤E矋K�3台ザ         ��"       �5R �2     ?nX �>           +       %DataSection     +*    %   slashpos                LONG, AUTO
              +       %ProcessedCode     +*    �     slashpos = INSTRING('/', pUrl, 1, 1)
  IF NOT slashpos
    RETURN CLIP(pUrl)
  ELSE
    RETURN pUrl[slashpos : LEN(CLIP(pUrl))]
  END
 �                                                                                                                                                                                     .  �:Dd&塏溳伮氇�         Z���"       陋` �5     墸c �5               Root ��                                                                        @s255                Root:        Root                                                                             P    PROMPT('Root:'),USE(?XFerInfo:Root:Prompt)
 ENTRY(@s255),USE(XFerInfo:Root)
     $    STRING(@s255),USE(XFerInfo:Root)
                                                                                                                                     .  �Vb瀦^D盝�}晆�         濑��"       ws` �2     2慲 �2                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                        r   �摳嗳@咡辷渄鲙         w���"      霼W �2     @鷆 �2                  RenameDialog 骷鵘�%'L巟酀ZL|*    *   (STRING pOldname, *STRING pNewname), BOOL     $   (STRING pOldname, *STRING pNewname) !-妓?�'O巢羗m渤�                                         ABC$Window         s �2 溾X       @鷆 �2     槀$骧 領��Ob"N詯逨堵�ゲ?d   幆辨�廜貉犗/讠�虆戋疧巕9K霖專萊G害7l鷄檏誈鳆b敄H▊箌熏�                                                                                                                        r   0拇鋋縀�+E!{�?         f���"      juo �2     嘝v �2                  ReadLocalChildren �.&鮐MC禈誫蕯蚉    :   (STRING pCurDir, LONG pLevel, *TFtpFilesInfoEx pChildren)     :   (STRING pCurDir, LONG pLevel, *TFtpFilesInfoEx pChildren)        
                *   Recursively reads local subdirs and files                ABC$Source         s �2 c6v       嘝v �2     2~D馍C⒑嵳�:�嗽最m�,K猚$�?B� D禉�啳I秐嵑繗                                                                                                       �  @洷顬1諱悲骄	(�         淊��"       婮 �2     6nX �>           +       %ControlEventHandling     +       ?bOK     +    	   Accepted     +*    P   IF Dirname
  pDirname = Dirname
  rc = TRUE
  POST(EVENT:CloseWindow)
END
 4!  d   i       +    	   ?bCancel     +    	   Accepted     +*    &   rc = FALSE
POST(EVENT:CloseWindow)
 4!  k   m                                                                                                                                                                   .  dx@U溉D�K 韋p         濑��"       E鮵 �2     c硘 �2                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                        �  鞹D賅鮸B淴Ru乛�7         鉴��"       M: �2     nX �>           +       %DataSection     +*    �   FilesQ                  QUEUE(FILE:Queue), PRE(FilesQ)
                        END

qIndex                  LONG, AUTO
drive                   LONG, AUTO
              +       %ProcessedCode     +*    �    FREE(dirlist)
  
  DIRECTORY(FilesQ, CLIP(pRoot) &'*.*', ff_:DIRECTORY)
  LOOP qIndex = 1 TO RECORDS(FilesQ)
    GET(FilesQ, qIndex)
    
    IF BAND(FilesQ.Attrib, ff_:DIRECTORY) AND FilesQ.Name = '.'
      CYCLE
    END
    
    CLEAR(dirlist)
    dirlist.IsFolder = CHOOSE(BAND(FilesQ.Attrib, ff_:DIRECTORY) <> 0)
    dirlist.Name = FilesQ.Name
    dirlist.DisplayName = CHOOSE(dirlist.IsFolder = TRUE, '['& CLIP(FilesQ.Name) &']', FilesQ.Name)
    dirlist.SortName = CHOOSE(dirlist.Name <> '..', UPPER(FilesQ.Name), '<2>'& UPPER(FilesQ.Name))  ! force sort before names starting with # etc
    dirlist.LastModified = FORMAT(FilesQ.Date, @d17) &' '& FORMAT(FilesQ.Time, @t07)
    
    IF NOT dirlist.IsFolder
      dirlist.FileSize = FilesQ.Size
    END
    
    dirlist.fileMask = FilesQ.Attrib
    ADD(dirlist)
  END
  
  ! add disk drives
  DO Routine::GetDrives

  RETURN TRUE
  
 �     3        +       %LocalProcedures     +*    *  Routine::GetDrives            ROUTINE
  DATA
drivemask                     LONG, AUTO
bitcounter                    LONG, AUTO
  CODE
  drivemask = curl::GetLogicalDrives()
  LOOP bitcounter = 1 TO 26 !A-Z
    IF BAND(drivemask, BSHIFT(1, bitcounter - 1)) <> 0
      CLEAR(dirlist)
      dirlist.IsFolder = TRUE
      dirlist.Name = CHR(VAL('A') + bitcounter - 1) &':'
      dirlist.DisplayName = '['& CLIP(dirlist.Name) & ']'
      dirlist.SortName = '<1>'& drive &':' ! force to sort before [..]
      ADD(dirlist)
    END
  END
  
   �  3   E                                                                                                                                                                                                     .  �1臘:;M啔牓(`         濑��"       8� �2     EX �2                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                        .  �$餶Q蠧�
乽 �?         ,���"       漽c �2      �2            	   IsFolder �                                                                        @n3                Is Folder:     
   Is Folder                                                                             i    PROMPT('Is Folder:'),USE(?RemoteFileInfoQ:IsFolder:Prompt)
 ENTRY(@n3),USE(RemoteFileInfoQ:IsFolder)
     -    STRING(@n3),USE(RemoteFileInfoQ:IsFolder)
                                                                                       p   7?F俽J濋qg�         T���"       )3y �2     榏 -;           Q%�
兰N�!q�7�2                                                  ABC$GENERATED         s -; 榏       榏 -;                                                                                              �  州芈J泊O好�镄	�         啉��"       �*? �2     噉X �>           +       %LocalDataAfterClasses     +*    $  url                     STRING(256)
filename                STRING(256)
res                     CURLcode, AUTO

xf                      LIKE(TXferInfo)

remoteChildren          QUEUE(TFtpFilesInfo), PRE(remoteChildren)
                        END
qIndex                  LONG, AUTO
 �             +       %ProcessedCode     +*    N    ASSERT(pitem.IsFolder)
  IF NOT pitem.IsFolder
    RETURN FALSE
  END
  
  curl::DebugInfo('DeleteRemoteDir: '& CLIP(xferinfo.Filename))

  xf = xferinfo
  !xferinfo.Url is base url, xferinfo.Filename is file path
  xf.Url = CLIP(xferinfo.Filename) &'/'
!  curl::DebugInfo('LoadRemoteDir: '& CLIP(xf.Url))

  !load root dir list
  IF NOT LoadRemoteDir(xf, acct, pSSH, remoteChildren)
    RETURN FALSE
  END
  
  SORT(remoteChildren, -remoteChildren:IsFolder, +remoteChildren:SortName)

  xf.Url = xferinfo.Url
  LOOP qIndex = 1 TO RECORDS(remoteChildren)
    GET(remoteChildren, qIndex)
    
    IF remoteChildren.IsFolder
      !folder
      IF remoteChildren.Name <> '.' AND remoteChildren.Name <> '..'
        xf.Filename = CLIP(xferinfo.Filename) &'/'& remoteChildren.Name
        IF NOT DeleteRemoteDir(xf, acct, pSSH, remoteChildren)
          BREAK
        END
      END
    ELSE
      !file
      xf.Filename = CLIP(xferinfo.Filename) &'/'& remoteChildren.Name
!      curl::DebugInfo('DeleteRemoteFile: '& CLIP(xf.Filename))
      IF DeleteRemoteFile(xf, acct, pSSH, remoteChildren)
        !BEEP(BEEP:SystemDefault)
      END
    END
  END

  !on this step dir must be empty, delete it
  xf = xferinfo
  IF NOT DeleteRemoteFile(xf, acct, pSSH, remoteChildren)
    RETURN FALSE
  END

  RETURN TRUE
 �     L                                                                                                                                                                                                                                        �  `rL�!.B噐�4t	�         消��"       怞 �2     nX �>           +       %LocalDataAfterClasses     +*    H   TrailingSlashPos        LONG, AUTO
SlashChar               STRING(1)
 �             +       %ProcessedCode     +*    :    SlashChar = CHOOSE(pRemotePath = TRUE, '/', '\')

  IF LEN(CLIP(pGoToFolder)) = 2 AND pGoToFolder[2] = ':'  !disk drive
    RETURN CLIP(pGoToFolder) & SlashChar
  END

  IF pGoToFolder <> '..'    
    IF pCurrentFolder AND pCurrentFolder[LEN(CLIP(pCurrentFolder))] <> SlashChar
      pCurrentFolder = CLIP(pCurrentFolder) & SlashChar
    END
    pCurrentFolder = CLIP(pCurrentFolder) & CLIP(pGoToFolder) & SlashChar
  ELSE
    !go up to parent folder
    TrailingSlashPos = INSTRING(SlashChar, pCurrentFolder[1 : LEN(CLIP(pCurrentFolder)) - 1], -1, LEN(CLIP(pCurrentFolder)) - 1)
    IF TrailingSlashPos > 1 AND pCurrentFolder[TrailingSlashPos - 1] <> SlashChar  ! avoid to double slash like in ftp://
      pCurrentFolder = pCurrentFolder[1 : TrailingSlashPos]
    END
  END
  
  RETURN pCurrentFolder
 �     &                                                                                                                                                                                                                        .  饐f鞮9嘒塙e�3�<         [���"       瘇` �2     �梎 �2               Account �P                            Account                                            @s20             	   Account:        Account                                                                             F    PROMPT('Account:'),USE(?Account:Prompt)
 ENTRY(@s20),USE(Account)
         STRING(@s20),USE(Account)
                                                                                                                                      .  �Ms衩褺増R�:c41         濑��"       摃z �2     c硘 �2                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                        p   骵�;R柈K瀊襤$[Q         T���"       �:h �2     �G 56           �1)[鈁>M泒F�級�                                                  ABC$GENERATED         s 56 �G       �G 56                                                                                              .  zV廎iY"G �         E���"       
de �2      �2               Name ��                                                                        @s255                Name:        Name                                                                             ^    PROMPT('Name:'),USE(?RemoteFileInfoQ:Name:Prompt)
 ENTRY(@s255),USE(RemoteFileInfoQ:Name)
     +    STRING(@s255),USE(RemoteFileInfoQ:Name)
                                                                                                                .  WTI硟B祵dǐ菵�         &���"       M陓 �2     烋| �2            
   EnableSSH �                     BOOL                                                    @s20                Enable SSH:        Enable SSH                                                                             g    PROMPT('Enable SSH:'),USE(?TSSHSettings:EnableSSH:Prompt)
 ENTRY(@s20),USE(TSSHSettings:EnableSSH)
     ,    STRING(@s20),USE(TSSHSettings:EnableSSH)
                                                                                  .  �9砏�@疦嵨膼溳         ��"       v` �2     2慲 �2            	   Filename ��                                                        local file                @s255             
   Filename:     	   Filename                local file        local file                                                     �    PROMPT('Filename:'),USE(?XFerInfo:Filename:Prompt)
 ENTRY(@s255),USE(XFerInfo:Filename),MSG('local file'),TIP('local file')
     (    STRING(@s255),USE(XFerInfo:Filename)
                                                                                                                                                                                                                                                                                                    �  �F�)娘O爖&h弭3�           B���"       M鋆 �2     搉X �>           +       %BeforeGlobalIncludes     +*    �   !  ! libcurl stuff
! obsolete, use libcurl global extension instead
!  PRAGMA('project(#pragma link(libcurl.lib))')
!  INCLUDE('libcurl.inc'), ONCE
 �             +       %ProgramSetup     +*    &   curl::GlobalInit()
ThisCurl.Init()
 �  t   v       +       %ProgramEnd     +*    ,   ThisCurl.Cleanup()
curl::GlobalCleanup()
 �  x   z       +       %ProgramProcedures     +*    �  !-- TCurlFtpClassEx implementation

TCurlFtpClassEx.ConnectInfo   PROCEDURE(TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH)
url                             STRING(256)
res                             CURLcode, AUTO
  CODE
  ! set SSH authentication
  res = SELF.SSHAuth(pSSH)
  IF res <> CURLE_OK
    RETURN res
  END
  
  SELF.ssh = pSSH
  
  ! set port 
  IF xferinfo.Port
    res = SELF.SetOpt(CURLOPT_PORT, xferinfo.Port)
  ELSIF NOT INSTRING(':', xferinfo.Url, 1, 1)
    IF SELF.ssh.AuthMethod = CURLSSH_AUTH_NONE
      res = SELF.SetOpt(CURLOPT_PORT, 21)
    ELSE
      res = SELF.SetOpt(CURLOPT_PORT, 22)
    END
  END
  IF res <> CURLE_OK
    RETURN res
  END

  SELF.xferinfo = xferinfo

  ! set user:password
  res = SELF.SetUserPwd(acct.User, acct.Pwd)
  IF res <> CURLE_OK
    RETURN res
  END
  
  SELF.acct = acct
  
  ! set connection timeout
  res = SELF.SetOpt(CURLOPT_CONNECTTIMEOUT, 60)
  IF res <> CURLE_OK
    RETURN res
  END
  
  RETURN CURLE_OK
  
TCurlFtpClassEx.ResetOptions  PROCEDURE()
slist                           TCurlSList
res                             CURLcode, AUTO
  CODE
  ! reset options
  SELF.Reset()
  SELF.ConnectInfo(SELF.xferinfo, SELF.acct, SELF.ssh)
  SELF.abortXfer = FALSE
  
  RETURN CURLE_OK

TCurlFtpClassEx.SetUploadProgress PROCEDURE(SIGNED pFeq, UNSIGNED pTotal)
  CODE
  SELF.UploadProgress.Feq = pFeq
  SELF.UploadProgress.Total = pTotal
  SELF.UploadProgress.Current = 0
  
  SELF.UploadProgress.Feq{PROP:RangeLow} = 0
  SELF.UploadProgress.Feq{PROP:RangeHigh} = 100
  SELF.UploadProgress.Feq{PROP:Progress} = 0
  DISPLAY(SELF.UploadProgress.Feq)

TCurlFtpClassEx.SetDownloadProgress   PROCEDURE(SIGNED pFeq, UNSIGNED pTotal)
  CODE
  SELF.DownloadProgress.Feq = pFeq
  SELF.DownloadProgress.Total = pTotal
  SELF.DownloadProgress.Current = 0
    
  SELF.DownloadProgress.Feq{PROP:RangeLow} = 0
  SELF.DownloadProgress.Feq{PROP:RangeHigh} = 100
  SELF.DownloadProgress.Feq{PROP:Progress} = 0
  DISPLAY(SELF.UploadProgress.Feq)
  
TCurlFtpClassEx.BuildUrl      PROCEDURE(STRING pUrl, STRING pUser, TSSHSettings pSSH)
url                             STRING(256)
sprotocol                       CSTRING(5)
  CODE
  sprotocol = CHOOSE(pSSH.AuthMethod = CURLSSH_AUTH_NONE, 'ftp', 'sftp')
  SELF.SetDefaultProtocol(sprotocol)
  
  IF pUser AND NOT INSTRING('@', pUser, 1, 1)
    url = sprotocol &'://' & CLIP(pUser) &'@'& CLIP(pUrl)
  ELSE
    url = sprotocol &'://' & CLIP(pUrl)
  END

  IF url AND url[LEN(CLIP(url))] <> '/'
    url = CLIP(url) & '/'
  END
  
  RETURN CLIP(url)

TCurlFtpClassEx.DebugCallback PROCEDURE(CURL_INFOTYPE ptype, STRING ptypetxt, STRING ptext)
sMsg                            CSTRING(32768)
nTextLen                        LONG, AUTO
EM_SETSEL                       LONG(00B1h)
EM_REPLACESEL                   LONG(00C2h)

root_start                      LONG, AUTO
root_end                        LONG, AUTO
  CODE
  ! skip file contents on upload/download
  CASE ptype
  OF CURLINFO_DATA_IN
  OROF CURLINFO_DATA_OUT
  OROF CURLINFO_SSL_DATA_IN
  OROF CURLINFO_SSL_DATA_OUT
    RETURN
  END
  
  sMsg = CLIP(ptypetxt) &': '& CLIP(ptext)
  
  IF NOT SELF.hwndLog
    curl::DebugInfo(sMsg)
  ELSE
    ! get length of log text
    nTextLen = curl::SendMessage(SELF.hwndLog, WM_GETTEXTLENGTH, 0, 0)
    !textbox limit 30,000 characters
    IF nTextLen + LEN(sMsg) <= 30000
      ! position to the end of text
      curl::SendMessage(SELF.hwndLog, EM_SETSEL, nTextLen, nTextLen)
      ! append text
      curl::SendMessage(SELF.hwndLog, EM_REPLACESEL, TRUE, ADDRESS(sMsg))
    ELSE
      ! clear textbox
      curl::SendMessage(SELF.hwndLog, EM_SETSEL, 1, nTextLen)
      curl::SendMessage(SELF.hwndLog, EM_REPLACESEL, TRUE, ADDRESS(sMsg))
    END
  END
  
  !- root directory
  IF ptype = CURLINFO_HEADER_IN AND INSTRING('257 "', ptext, 1, 1) = 1
    root_start = INSTRING('"', ptext, 1, 1)
    root_end = INSTRING('"', ptext, 1, root_start + 1)
!    curl::DebugInfo('ROOT DIRECTORY IS: '& pText[root_start + 1 : root_end - 1])
    SELF.xferinfo.Root = SUB(ptext, root_start + 1, root_end - root_start - 1)
    curl::DebugInfo('ROOT DIRECTORY IS: '& CLIP(SELF.xferinfo.Root))
  END
  
TCurlFtpClassEx.XFerInfo      PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
  CODE
  IF SELF.abortXfer
    SELF.abortXfer = FALSE
    RETURN 1
  END
  
  PARENT.XFerInfo(dltotal, dlnow, ultotal, ulnow)
  
  IF SELF.DownloadProgress.Feq
    IF dlnow
      IF SELF.DownloadProgress.Current <> dlnow
        SELF.DownloadProgress.Current = dlnow
      
        SELF.DownloadProgress.Feq{PROP:Progress} = SELF.DownloadProgress.Current * 100 / SELF.DownloadProgress.Total
        DISPLAY(SELF.DownloadProgress.Feq)
      END
    END
  END

  IF SELF.UploadProgress.Feq
    IF ulnow
      IF SELF.UploadProgress.Current <> ulnow
        SELF.UploadProgress.Current = ulnow
      
        SELF.UploadProgress.Feq{PROP:Progress} = SELF.UploadProgress.Current * 100 / SELF.UploadProgress.Total
        DISPLAY(SELF.UploadProgress.Feq)
      END
    END
  END
  
  YIELD()

  RETURN 0

TCurlFtpClassEx.GetRoot       PROCEDURE()
  CODE
  RETURN CLIP(SELF.xferinfo.Root) �  }   4       +       %GlobalMap     +*    �   MODULE('Win API')
  curl::SendMessage(HWND hWnd, LONG nMsg, LONG wParam, LONG lParam), LONG, PASCAL, PROC, NAME('SendMessageA')
  curl::GetLogicalDrives(), LONG, PASCAL, NAME('GetLogicalDrives')
END
 �            +       %AfterGlobalDataUser     +*    �  !-- TCurlFtpClassEx declaration

TProgressInfo                 GROUP, TYPE
Feq                             SIGNED
Total                           UNSIGNED
Current                         UNSIGNED
                              END

! holds local folder hierarchy
TFtpFilesInfoEx               QUEUE(TFtpFilesInfo), PRE(TFtpFilesInfoEx), TYPE
FullName                        STRING(256)
!Level                           LONG
                              END


TCurlFtpClassEx               CLASS(TCurlFtpClass), TYPE
hwndLog                         LONG

xferinfo                        LIKE(TXferInfo), PRIVATE
acct                            LIKE(TAccount), PRIVATE
ssh                             LIKE(TSSHSettings), PRIVATE

DownloadProgress                LIKE(TProgressInfo), PRIVATE
UploadProgress                  LIKE(TProgressInfo), PRIVATE

abortXfer                       BOOL

ConnectInfo                     PROCEDURE(TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH), CURLcode, PROC
ResetOptions                    PROCEDURE(), CURLcode, PROC

SetUploadProgress               PROCEDURE(SIGNED pFeq, UNSIGNED pTotal)
SetDownloadProgress             PROCEDURE(SIGNED pFeq, UNSIGNED pTotal)

BuildUrl                        PROCEDURE(STRING pUrl, STRING pUser, TSSHSettings pSSH), STRING
DebugCallback                   PROCEDURE(CURL_INFOTYPE ptype, STRING ptypetxt, STRING ptext), DERIVED
XFerInfo                        PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, PROC, DERIVED
GetRoot                         PROCEDURE(), STRING
                              END

ThisCurl                      TCurlFtpClassEx
 �  0   X        +*    �   ! define available options for glo:OverwriteExistingFile
OEF::No                       EQUATE(0)
OEF::Yes                      EQUATE(1)
OEF::NoForAll                 EQUATE(2)
OEF::YesForAll                EQUATE(3)
 �  X   ]                                                                           �  _哿�>J�<�4q樞         ����"       怞 �2     怞 �2                                                                                                                                                                                                                            p   麇醻岶彲筩�z         T���"       婮 �2     -輘 �2           冗坩SF垬泖齿�                    	                              ABC$GENERATED         s �2 -輘       -輘 �2                                                                                              .  U饇艳�6F竳陨汣�         E���"       杕W �2     tW �2               sDebugInfo � �                                                                       @s255                s Debug Info:        s Debug Info                                                                             R    PROMPT('s Debug Info:'),USE(?sDebugInfo:Prompt)
 ENTRY(@s255),USE(sDebugInfo)
     !    STRING(@s255),USE(sDebugInfo)
                                                                                                                 p   銅眪=.M櫯颏L 4�         T���"       #+? �2     X躠 �5           aW`唅劽B瞔�艗U                                                  ABC$GENERATED         s �5 X躠       X躠 �5                                                                                              .  巴d3炰鬕�替P}WQ         ���"       鏪` �2     .猙 �2               LastModified �                                                                        @s20                Last Modified:        Last Modified                                                                             v    PROMPT('Last Modified:'),USE(?RemoteFileInfoQ:LastModified:Prompt)
 ENTRY(@s20),USE(RemoteFileInfoQ:LastModified)
     2    STRING(@s20),USE(RemoteFileInfoQ:LastModified)
                                                        .  璵2寰B鯡房!驮�         W���"       漽c �2     !郼 �2               Name ��                                                                        @s255                Name:        Name                                                                             R    PROMPT('Name:'),USE(?FileInfoQ:Name:Prompt)
 ENTRY(@s255),USE(FileInfoQ:Name)
     %    STRING(@s255),USE(FileInfoQ:Name)
                                                                                                                                  j   2~D馍C⒑嵳�:�         a���"        xo �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           .  椶~h汧G�薾洀p4         )���"       腲` �2     .猙 �2            	   FileSize �                                                                        @s20                File Size:     
   File Size                                                                             j    PROMPT('File Size:'),USE(?RemoteFileInfoQ:FileSize:Prompt)
 ENTRY(@s20),USE(RemoteFileInfoQ:FileSize)
     .    STRING(@s20),USE(RemoteFileInfoQ:FileSize)
                                                                                    �  �	未-0cN�梀b遌�         =���"       侩D �2     #nX �>           +       %LocalDataAfterClasses     +*    s   url                     STRING(256)
filename                STRING(256)
res                     CURLcode, AUTO
 �             +       %ProcessedCode     +*    �    res = ThisCurl.ResetOptions()
  IF res <> CURLE_OK
    MESSAGE(ThisCurl.StrError(res), 'FTP Manager', ICON:Exclamation)
    RETURN FALSE
  END

  !url like "ftp://user@127.0.0.1:21"
  url = ThisCurl.BuildUrl(xferinfo.Url, acct.User, pSSH)

  !filename like "/home/var/temp/testfile.txt"
  filename = ExtractRemotePath(xferinfo.Filename)
!  filename = ThisCurl.GetRoot() & ExtractRemotePath(xferinfo.Filename)

  res = ThisCurl.DeleteFile(url, CLIP(filename))
!  res = ThisCurl.DeleteFile(url, '"'& CLIP(filename) &'"')
  IF res <> CURLE_OK
    MESSAGE(ThisCurl.StrError(res), 'FTP Manager', ICON:Exclamation)
    RETURN FALSE
  END
  
  RETURN TRUE
 �     *                                                                      �  �絘!鮈嚸�垡�;         e���"       �:h �2     nX �>           +       %ProcessedCode     +*    w    ASSERT(NOT pitem.IsFolder, 'Not a file: '& CLIP(pitem.Name))
  IF pitem.IsFolder
    RETURN FALSE
  END
    
  !setup label
  pLabel{PROP:Text} = CLIP(pitem.Name) &'...'

  res = ThisCurl.ResetOptions()
  IF res <> CURLE_OK
    MESSAGE(ThisCurl.StrError(res), 'FTP Manager', ICON:Exclamation)
    RETURN FALSE
  END

  url = ThisCurl.BuildUrl(xferinfo.Url, acct.User, pSSH)

  url = CLIP(url) & pitem.Name
  filename = xferinfo.Filename
  
  ThisCurl.SetUploadProgress(pProgress, DEFORMAT(pitem.FileSize))

  res = ThisCurl.WriteFile(url, filename)
  
  ThisCurl.SetUploadProgress(pProgress, 0)

  IF res = CURLE_OK
    RETURN TRUE
  ELSIF res = -1 
    MESSAGE('Cannot open local file', 'libcurl', ICON:Exclamation)
    RETURN FALSE
  ELSE
    MESSAGE('Upload failed: '& ThisCurl.StrError(res), 'libcurl', ICON:Exclamation)
    RETURN FALSE
  END
   �     7        +       %LocalDataAfterClasses     +*    u   url                     STRING(256)
filename                STRING(256)

res                     CURLcode, AUTO
 �                                                                                                                   .  簨
欻婭衦V帛D         a���"       gu` �2     2慲 �2               Url ��                                                                        @s255                Url:        Url                                                                             M    PROMPT('Url:'),USE(?XFerInfo:Url:Prompt)
 ENTRY(@s255),USE(XFerInfo:Url)
     #    STRING(@s255),USE(XFerInfo:Url)
                                                                                                                                            .  t甾輆椐G蟬I鯪         K���"       �, �2     B�. �2               hwndLog �                                                                      @n-14             
   hwnd Log:     	   hwnd Log                                                                             Q    PROMPT('hwnd Log:'),USE(?hwndLog:Prompt)
 ENTRY(@n-14),USE(hwndLog),RIGHT(1)
     '    STRING(@n-14),USE(hwndLog),RIGHT(1)
                                                                                                                       .  且潻嘾A�o\I�         ���"       E鮵 �2     c硘 �2               PrivateKeyFile �                                                                        @s255                Private Key File:        Private Key File                                                                             v    PROMPT('Private Key File:'),USE(?SSHSettings:PrivateKeyFile:Prompt)
 ENTRY(@s255),USE(SSHSettings:PrivateKeyFile)
     1    STRING(@s255),USE(SSHSettings:PrivateKeyFile)
                                                .  檛#t`G廟丢頥鈔         ���"       閎` �2     .猙 �2               LastModified �                                                                        @s20                Last Modified:        Last Modified                                                                             t    PROMPT('Last Modified:'),USE(?LocalFileInfoQ:LastModified:Prompt)
 ENTRY(@s20),USE(LocalFileInfoQ:LastModified)
     1    STRING(@s20),USE(LocalFileInfoQ:LastModified)
                                                           .  RiF騇払��4捖啜         3���"       >穋 �2     v譪 �2               TFilesInfo �                  
   TFileInfo        TFilesInfo               @                            @s20                TF iles Info:        TF iles Info                                                                             Q    PROMPT('TF iles Info:'),USE(?TFilesInfo:Prompt)
 ENTRY(@s20),USE(TFilesInfo)
          STRING(@s20),USE(TFilesInfo)
                                                                                               .  廌k愕覗B忹O@婚,         	���"       諣y �2     i z �2               PublicKeyFile �                                                                        @s255                Public Key File:        Public Key File                                                                             u    PROMPT('Public Key File:'),USE(?TSSHSettings:PublicKeyFile:Prompt)
 ENTRY(@s255),USE(TSSHSettings:PublicKeyFile)
     1    STRING(@s255),USE(TSSHSettings:PublicKeyFile)
                                                     .  X~�=@hC熦ari	�         $���"       F鮵 �2     c硘 �2               KnownHosts �                                                                        @s255                Known Hosts:        Known Hosts                                                                             i    PROMPT('Known Hosts:'),USE(?SSHSettings:KnownHosts:Prompt)
 ENTRY(@s255),USE(SSHSettings:KnownHosts)
     -    STRING(@s255),USE(SSHSettings:KnownHosts)
                                                                               .  鮀� �%N堾N坏0竿         $���"       摃z �2     c硘 �2               KnownHosts �                                                                        @s255                Known Hosts:        Known Hosts                                                                             i    PROMPT('Known Hosts:'),USE(?SSHSettings:KnownHosts:Prompt)
 ENTRY(@s255),USE(SSHSettings:KnownHosts)
     -    STRING(@s255),USE(SSHSettings:KnownHosts)
                                                                               .  ,杂砱c跧敖蔁P�         ���"       儾F �2     亄X �2               CurrentRemotePath ��                                                                        @s255                Current Remote Path:        Current Remote Path                                                                             g    PROMPT('Current Remote Path:'),USE(?CurrentRemotePath:Prompt)
 ENTRY(@s255),USE(CurrentRemotePath)
     (    STRING(@s255),USE(CurrentRemotePath)
                                                               r   �^ ztPM綽�4C��         @���"      茧D �2     I朌 �=     O             DeleteRemoteFile 傶�)匇稤綧莓訉�    Q   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem), BOOL     K   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem)       �ッ帆θ49N�                   Delete file or empty dir                ABC$Source         s �5 s乧       I朌 �=     穩仜�1禝夀溭奺Y�	未-0cN�梀b遌� d~9镀HDきh鍈                                                                 �  嗽最m�,K猚$�?B�         淃��"       juo �2     wnX �>           +       %ProcessedCode     +*    <    DIRECTORY(FilesQ, CLIP(pCurDir) &'\*.*', ff_:NORMAL + ff_:DIRECTORY)
  LOOP qIndex = 1 TO RECORDS(FilesQ)
    GET(FilesQ, qIndex)
    IF BAND(FilesQ:Attrib,ff_:DIRECTORY)
      IF FilesQ:ShortName <> '..' AND FilesQ:ShortName <> '.' 
        !subdirectory
        CLEAR(pChildren)
        pChildren.IsFolder = TRUE
        pChildren.Name = FilesQ:Name
        pChildren.FullName = CLIP(pCurDir) &'\'& FilesQ:Name
        pChildren.FileSize = FilesQ:Size
!        pChildren.Level = pLevel
        ADD(pChildren)
      END
    ELSE
      !file
      CLEAR(pChildren)
      pChildren.IsFolder = FALSE
      pChildren.Name = FilesQ:Name
      pChildren.FullName = CLIP(pCurDir) &'\'& FilesQ:Name
      pChildren.FileSize = FilesQ:Size
!      pChildren.Level = pLevel
      ADD(pChildren)
    END
  END
   �     .        +       %LocalDataAfterClasses     +*    z   FilesQ                  QUEUE(FILE:Queue), PRE(FilesQ)
                        END
qIndex                  LONG, AUTO
 �                                                                                                                                                                         .  幨虛�+F糣Sy靴�         ���"       摃z �2     c硘 �2               PrivateKeyFile �                                                                        @s255                Private Key File:        Private Key File                                                                             v    PROMPT('Private Key File:'),USE(?SSHSettings:PrivateKeyFile:Prompt)
 ENTRY(@s255),USE(SSHSettings:PrivateKeyFile)
     1    STRING(@s255),USE(SSHSettings:PrivateKeyFile)
                                                .  C萪逆N�&鴳V         ]���"       0` �2     z=d �2               User �(                                                                        @s40                User:        User                                                                             O    PROMPT('User:'),USE(?TAccount:User:Prompt)
 ENTRY(@s40),USE(TAccount:User)
     #    STRING(@s40),USE(TAccount:User)
                                                                                                                                         .  yp渠鶌揓翂�袚         ���"       gC` �2     甈` �2               LastModified �                                                                        @s20                Last Modified:        Last Modified                                                                             j    PROMPT('Last Modified:'),USE(?TFileInfo:LastModified:Prompt)
 ENTRY(@s20),USE(TFileInfo:LastModified)
     ,    STRING(@s20),USE(TFileInfo:LastModified)
                                                                           �  縒?
r+B瑱F結h�$         ����"       a �2     a �2                                                                                                                                                                                                                            p   P7揻鯧\D�'舮1�         T���"       �8h �2     ВD �=           �0閕\�1H�\?lL潠                                                  ABC$GENERATED         s 57 O縌       ВD �=                                                                                              r   O懕⑿2�NQ鐽珁�         Z���"      6礗 �2     曕h }6     O             CreateRemoteDir �M亾.E角5[緝[^    Q   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem), BOOL     K   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem)       �ッ帆θ49N�                                   ABC$Source         s �5 * y       曕h }6     隡D縟%甆�羲椘憱|c显盓/J獚�#溴;� !fl鼬G兲,�                                                                                           �  !fl鼬G兲,�         ����"       6礗 �2     6礗 �2                                                                                                                                                                                                                            �  "N詯逨堵�ゲ?d         ��"       霼W �2     TnX �>           +       %ControlEventHandling     +       ?bOK     +    	   Accepted     +*    P   IF Newname
  pNewname = Newname
  rc = TRUE
  POST(EVENT:CloseWindow)
END
 4!  i   n       +    	   ?bCancel     +    	   Accepted     +*    &   rc = FALSE
POST(EVENT:CloseWindow)
 4!  p   r       +        %WindowManagerMethodCodeSection     +       Init     +       (),BYTE     +*    )   Oldname = pOldname
Newname = pOldname
 E  C   E                                                                                                                                                                                                                                                                 p   z哔�77@ゆG!W         T���"       馰 �2     骩y �5           7尭⺁慖�3 �I                                                  ABC$GENERATED         s �5 骩y       骩y �5                                                                                              .  I<�8�K痋剐嗖d�         濑��"       >穋 �2     >穋 �2                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                         j   D�餂EB⒑w怢�� \      \  趣��"       O鋆 �2     鵻V �>        2         %ClassItem %                            ErrorManager             ErrorStatusManager             FileManager:             FuzzyMatcher
   
       
   INIManager             RelationManager:
   
       
   Translator       %DefaultBaseClassType %                   %ClassItem                 ErrorManager
   
       
   ErrorClass             ErrorStatusManager             ErrorStatusClass             FuzzyMatcher
   
       
   FuzzyClass
   
       
   INIManager             INIClass
   
       
   Translator             TranslatorClass       %ActualDefaultBaseClassType %                   %ClassItem                 ErrorManager                             ErrorStatusManager                             FuzzyMatcher                
   
       
   INIManager                
   
       
   Translator                       %ClassLines %                  %ClassItem            %ProgramAuthor %                                    %ProgramIcon %                          ftp.ico       %MessageDescription                               %GlobalExternal                                %ExternalSource %                          Dynamic Link Library (DLL)       %GenerateEmbedComments                             	   %INIType %                          NVD_INI    	   %INIFile %                          Program Name.INI    	   %ININame %                                    %INIProgramIniLocation %                          APPDIR       %INICSIDLDirectory %                          SV:CSIDL_PERSONAL       %CSIDLCompanyDir %                                    %CSIDLProductDir %                                    %CSIDLCreate                                %INIInAppDirectory                            	   %REGRoot %                          REG_CLASSES_ROOT       %DisableINISaveWindow                                %PreserveVars                        %PreserveVar %                   %PreserveVars            %EnableRunTimeTranslator                                %FuzzyMatchingEnabled                               %IgnoreCase                            
   %WordOnly                                %ButtonMarginsCompatibility                                %UseDefaultXPManifest                                %GenerateXPManifest                                %LinkGenerateXPManifest                                %AddVistaXPManifest                                %VistaManifestExecutionLevel %             	   	       	   asInvoker       %VistaManifestUIAccess                                %NoThemedControlsDependency                                 %VistaManifestDependentAssembly                     $   %VistaManifestDependentAssemblyName %                    %VistaManifestDependentAssembly         '   %VistaManifestDependentAssemblyVersion %                    %VistaManifestDependentAssembly         $   %VistaManifestDependentAssemblyType %                    %VistaManifestDependentAssembly         .   %VistaManifestDependentAssemblyPublicKeyToken %                    %VistaManifestDependentAssembly         (   %VistaManifestDependentAssemblyLanguage %                    %VistaManifestDependentAssembly         5   %VistaManifestDependentAssemblyProcessorArchitecture                     %VistaManifestDependentAssembly            %W7ManifestVista                               %W7ManifestW7                               %W7ManifestW8                               %W7ManifestW81                               %W7ManifestW10                                %ForceMakeTransparentXPManifest                                %ForceMakeColorXPManifest                                %ForceSHEETNoTheme                                %ExtUIXPMenuEnableGlobal                                %ExtUIXPMenuColorTypeGlobal %                          OFF       %ExtUIXPMenuDisableImageBar                               %ExtUIXPMenuEnableRuntime                                %ExtUIXPMenuRuntimeVar %                                    %ExtUIXPMenuColorLeftGlobal                     祆�        %ExtUIXPMenuColorRightGlobal                     Е�     (   %ExtUIXPMenuColorSelectionBarLeftGlobal                     祆�     )   %ExtUIXPMenuColorSelectionBarRightGlobal                     祆�        %ExtUIXPMenuSelVertical                            '   %ExtUIXPMenuColorSelectionBorderGlobal                     祆�        %ExtUIXPMenuColorHotLeftGlobal                     祆�         %ExtUIXPMenuColorHotRightGlobal                     祆�     $   %ExtUIXPMenuColorSelectedLeftGlobal                     祆�     %   %ExtUIXPMenuColorSelectedRightGlobal                     祆�     %   %ExtUIXPMenuColorNormalBarLeftGlobal                     祆�     &   %ExtUIXPMenuColorNormalBarRightGlobal                     祆�     &   %ExtUIXPMenuColorItemBackgroundGlobal                       �       %ExtUIXPMenuColorNormalText                                %ExtUIXPMenuColorSelectedText                                %ExtUIXPMenuColorHotText                                %ExtUIXPMenuFlat                               %ExtUIXPMenuShowImageBar                                %ExtUIXPMenuSeparator3D                               %ExtUIXPMenuSeparatorFull                                %ExtUIXPMenuVerticalLine                               %ExtUIMDITabGlobal %                          DISABLE       %ExtUIMDITabStyleGlobal %                          Default       %ExtUITabStyleGlobal %                          Default       %WindowEnableEnhanceFocus                                %SelectedText                               %SelectedRadio                               %SelectedSpin                               %SelectedCheck                               %SelectedDropList                               %SelectedList                               %SelectedDisplayChangeColor                               %SelectedColor                     ��         %SelectedStyle                               %SelectedRequired                                %SelectedRequiredColor                     ��         %SelectedDisplayBox                               %SelectedDisplayBoxFillColor                     ��         %SelectedDisplayBoxBorderColor                                %SelectedDisplayBoxBorderSize %                              %SelectedRequiredBox                             %   %SelectedRequiredDisplayBoxFillColor                     �       '   %SelectedRequiredDisplayBoxBorderColor                                %SelectedCaret                               %SelectedCaretColor                     ���        %SelectedCaretCharacter %                          �    "   %SelectedCaretCharacterSeparation %                          8       %ExcludeSelectedDropList                                %EnableOSK %                          OFF       %GlobalUseEnterInsteadTab                             !   %GlobalUseEnterInsteadTabExclude %                        %GlobalUseEnterInsteadTabEnable %                          Enable    %   %GlobalUseEnterInsteadTabEnableValue %                          True       %GlobalInterLine %                               %GlobalEnableAutoSizeColumn                                %GlobalEnableListFormatManager                             "   %GlobalUserFieldListFormatManager %                          1       %TableOrigin %                          Application       %FileEquate %             	   	       	   LFM_CFile       %ConfigFilePRE %                          CFG       %ConfigFileOEM                                %ConfigFileTHREAD                               %ConfigFileENCRYPT                                %ConfigFilePASSWORD %                                    %FormatNameSize %                              %FormatBufferSize %                              %VariableBufferSize %                              %ConfigFilePath %                                    %UseConfigFileName %                          Default       %ConfigFileNAME %                          Formats.FDB       %ColonCounter %                                    %WrongSymbol %                                    %DictionaryTableOrigin !                     %GlobalLFMSortOrderMenuText %             	   	       	   SortOrder       %GlobalEnableRebase                                %RBDMethod %                          Specify manually       %RBDImageBase %                          10000000       %DefaultGenerate                                %DefaultRILogout                               %LockRecoverTime %                    
          %DefaultThreaded %                          Use File Setting       %DefaultCreate %                          Use File Setting       %DefaultExternal %                          None External       %DefaultLocalExternal                                %DefaultExternalSource %                                    %DefaultExternalAPP                                %DefaultExport                                %DefaultOpenMode %                          Share       %DefaultUserAccess %             
   
       
   Read/Write       %DefaultOtherAccess %             	   	       	   Deny None       %DefaultLazyOpen                               %GeneratePropDataPath                                %PropDataPathLocation %                          CSIDLLIKEINI       %DataPathCSIDLDirectory %                          SV:CSIDL_PERSONAL       %DataPathCSIDLCompanyDir %                                    %DataPathCSIDLProductDir %                                    %DataPathCSIDLCreate                                %DataPathOtherDirectory %                                    %DataPathOtherDirectoryCreate                                %OverrideGenerate                    %File            %OverrideRILogout %                   %File                                 Use Default       %GlobalObject %                   %ClassItem                 ErrorManager             YES             ErrorStatusManager             YES             FuzzyMatcher             YES
   
       
   INIManager             YES
   
       
   Translator             YES       %ThisObjectName %                   %ClassItem                 ErrorManager             GlobalErrors             ErrorStatusManager             GlobalErrorsStatus             FuzzyMatcher             FuzzyMatcher
   
       
   INIManager             INIMgr
   
       
   Translator
   
       
   Translator       %UseDefaultABCBaseClass                    %ClassItem                 ErrorManager                       ErrorStatusManager                       FuzzyMatcher          
   
       
   INIManager          
   
       
   Translator                 %UseABCBaseClass                    %ClassItem                 ErrorManager                       ErrorStatusManager                       FuzzyMatcher          
   
       
   INIManager          
   
       
   Translator                 %ABCBaseClass %                   %ClassItem                 ErrorManager                             ErrorStatusManager                             FuzzyMatcher                
   
       
   INIManager                
   
       
   Translator                       %ExtBaseClass %                   %ClassItem            %BaseClassIncludeFile %                   %ClassItem            %DeriveFromBaseClass                    %ClassItem                 ErrorManager                        ErrorStatusManager                        FuzzyMatcher           
   
       
   INIManager           
   
       
   Translator                  %NewMethods                   %ClassItem            %NewMethodName %                   %NewMethods            %NewMethodPrototype %                   %NewMethods            %NewClassPropertyItems                   %ClassItem            %NewClassProperty %                   %NewClassPropertyItems            %NewClassDataType %                   %NewClassPropertyItems    
   
       
   INIManager           %NewClassOtherType %                   %NewClassPropertyItems            %NewClassDataIsRef                    %NewClassPropertyItems            %NewClassDataSize %                   %NewClassPropertyItems            %NewClassDataDim1 %                   %NewClassPropertyItems            %NewClassDataDim2 %                   %NewClassPropertyItems            %NewClassDataDim3 %                   %NewClassPropertyItems            %NewClassDataDim4 %                   %NewClassPropertyItems            %ClassMethods                   %ClassItem            %ClassMethodName %                   %ClassMethods            %ClassMethodPrototype %                   %ClassMethods            %ClassPropertyItems                   %ClassItem            %ClassProperty %                   %ClassPropertyItems            %ClassDataType %                   %ClassPropertyItems    
   
       
   INIManager           %ClassOtherType %                   %ClassPropertyItems            %ClassDataIsRef                    %ClassPropertyItems            %ClassDataSize %                   %ClassPropertyItems            %ClassDataDim1 %                   %ClassPropertyItems            %ClassDataDim2 %                   %ClassPropertyItems            %ClassDataDim3 %                   %ClassPropertyItems            %ClassDataDim4 %                   %ClassPropertyItems            %OverrideThreaded %                   %File                                 Use Default       %OverrideCreate %                   %File                                 Use Default       %OverrideExternal %                   %File                                 Use Default       %OverrideLocalExternal                    %File            %OverrideExternalSource %                   %File            %OverrideExternalAPP                    %File            %OverrideExport                    %File            %FileDeclarationMode %                   %File                                 Use User Options       %FileDeclarationType                    %File                                      %FileDeclarationThread                    %File                                      %FileDeclarationBindable                    %File                                     %FileDeclarationName %                   %File            %FileDeclarationOver %                   %File            %OverrideOpenMode %                   %File                                 Use Default       %OverrideUserAccess %                   %File                                 Use Default       %OverrideOtherAccess %                   %File                                 Use Default       %OverrideLazyOpen %                   %File                                 Use Default       %StandardExternalModule                    %Module                                           FTPManager.clw                       FTPManager001.clw                       FTPManager002.clw                       FTPManager003.clw                       FTPManager004.clw                       FTPManager005.clw                       FTPManager006.clw                       FTPManager007.clw                       FTPManager008.clw                       FTPManager009.clw                       FTPManager010.clw                       FTPManager011.clw                       FTPManager012.clw                       FTPManager013.clw                       FTPManager014.clw                       FTPManager015.clw                       FTPManager016.clw                       FTPManager017.clw                 %NoGenerateGlobals                                %WindowManagerType %                          WindowManager       %ResetOnGainFocus                                %AutoToolbar                               %AutoRefresh                               %ImageClass %                          ImageManager       %ErrorStatusManagerType %                          ErrorStatusClass       %ErrorManagerType %             
   
       
   ErrorClass       %DefaultErrorCategory %                          ABC       %AllowSelectCopy                                %StoreErrorHistory                                %LimitStoredHistory                                %ErrorHistoryThreshold %                    ,         %HistoryViewTrigger %                          Level:Fatal       %PopupClass %             
   
       
   PopupClass       %SelectFileClass %                          SelectFileClass       %ResizerType %                          WindowResizeClass       %ResizerDeFaultFindParents                               %ResizerDefaultOptimizeMoves                               %ResizerDefaultOptimizeRedraws                            
   %INIClass %                          INIClass       %RunTimeTranslatorType %                          TranslatorClass       %ExtractionFilename %                                    %TranslationGroups                        %TranslationFile %                   %TranslationGroups            %TranslationGroup %                   %TranslationGroups            %CalendarManagerType %                          CalendarClass       %GlobalChangeColor                                %GlobalColorSunday                     �          %GlobalColorSaturday                     �          %GlobalColorHoliday                      �         %GlobalColorOther                                %GlobalSelectOnClose %                          Select       %GlobalUseABCClasess                               %FileManagerType %                          FileManager       %ViewManagerType %                          ViewManager       %RelationManagerType %                          RelationManager       %BrowserType %                          BrowseClass       %ActiveInvisible                                %AllowUnfilled                                %RetainRow                               %FileDropManagerType %                          FileDropClass       %FileDropComboManagerType %                          FileDropComboClass       %FormVCRManagerType %                          FormVCRClass       %BrowseEIPManagerType %                          BrowseEIPManager       %EditInPlaceInterface %                          Detailed       %EditInPlaceType %                          EditEntryClass       %EditInPlaceEntryType %                          EditEntryClass       %EditInPlaceTextType %                          EditTextClass       %EditInPlaceCheckType %                          EditCheckClass       %EditInPlaceSpinType %                          EditSpinClass       %EditInPlaceDropListType %                          EditDropListClass       %EditInPlaceDropComboType %                          EditDropComboClass       %EditInPlaceColorType %                          EditColorClass       %EditInPlaceFileType %                          EditFileClass       %EditInPlaceFontType %                          EditFontClass       %EditInPlaceMultiSelectType %                          EditMultiSelectClass       %EditInPlaceCalendarType %                          EditCalendarClass       %EditInPlaceLookupType %                          EditLookupClass       %EditInPlaceOtherType %                          EditEntryClass       %QBEFormType %                          QueryFormClass       %QBEFormVisualType %                          QueryFormVisual       %QBEListType %                          QueryListClass       %QBEListVisualType %                          QueryListVisual       %StepManagerType %             	   	       	   StepClass       %StepManagerLongType %                          StepLongClass       %StepManagerRealType %                          StepRealClass       %StepManagerStringType %                          StepStringClass       %StepManagerCustomType %                          StepCustomClass       %StepLocatorType %                          StepLocatorClass       %EntryLocatorType %                          EntryLocatorClass       %IncrementalLocatorType %                          IncrementalLocatorClass       %FilteredLocatorType %                          FilterLocatorClass       %FuzzyMatcherClass %             
   
       
   FuzzyClass       %GridClass %             	   	       	   GridClass       %SidebarClass %                          SidebarClass       %ProcessType %                          ProcessClass       %PrintPreviewType %                          PrintPreviewClass       %ReportManagerType %                          ReportManager    !   %ReportTargetSelectorManagerType %                          ReportTargetSelectorClass       %BreakManagerType %                          BreakManagerClass       %AsciiViewerClass %                          AsciiViewerClass       %AsciiSearchClass %                          AsciiSearchClass       %AsciiPrintClass %                          AsciiPrintClass       %AsciiFileManagerType %                          AsciiFileClass       %ToolbarClass %                          ToolbarClass       %ToolbarListBoxType %                          ToolbarListboxClass       %ToolbarRelTreeType %                          ToolbarReltreeClass       %ToolbarUpdateClassType %                          ToolbarUpdateClass       %ToolbarFormVCRType %                          ToolbarFormVCRClass       %OverrideAbcSettings                                %AbcSourceLocation %                          LINK       %AbcLibraryName %                                    %AppTemplateFamily %                          ABC       %CWTemplateVersion %                          v11.1       %ABCVersion %                          11100       %VistaManifestdpiAware                            "   %OverrideDoNotAssertOnCloseMisuse                    %File                                                                                                                                                                                                                                        .  *�&糃潥�<觉Q�         H���"       迬 �2     EX �2               Name ��                                                                        @s255                Name:        Name                                                                             \    PROMPT('Name:'),USE(?LocalFileInfoQ:Name:Prompt)
 ENTRY(@s255),USE(LocalFileInfoQ:Name)
     *    STRING(@s255),USE(LocalFileInfoQ:Name)
                                                                                                                   �  k3E孶u轅⿱鷒y2 K      K  壍��"       嘾 �2     頼X �>           +       %ControlEventHandling     +    
   ?bConnect     +    	   Accepted     +*    n  SETCURSOR(CURSOR:Wait)

FREE(RemoteFileInfoQ)
DISPLAY(?lstRemoteDir)

CurrentRemotePath = BaseUrl
IF CurrentRemotePath AND CurrentRemotePath[LEN(CLIP(CurrentRemotePath))] <> '/'
  CurrentRemotePath = CLIP(CurrentRemotePath) & '/'
END

DISPLAY(?CurrentRemotePath)

!pass new connection info to curl
XFerInfo:Url = CurrentRemotePath
XFerInfo:Filename = ''

ThisCurl.ConnectInfo(XFerInfo, Account, SSHSettings)

!load remote dir
IF LoadRemoteDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
  SORT(RemoteFileInfoQ, -RemoteFileInfoQ:IsFolder, +RemoteFileInfoQ:SortName)
  DISPLAY(?lstRemoteDir)
  
  !save last success connection info
  PUTINI('FTP', 'FTP', BaseUrl, '.\FTPManager.INI')
  PUTINI('FTP', 'Port', XFerInfo:Port, '.\FTPManager.INI')
  PUTINI('FTP', 'User', Account:User, '.\FTPManager.INI')
  PUTINI('FTP', 'Pwd', Account:Pwd, '.\FTPManager.INI')
  
  !SSH
  PUTINI('FTP', 'EnableSSH', SSHSettings:AuthMethod, '.\FTPManager.INI')
  PUTINI('FTP', 'PublicKeyFile', SSHSettings:PublicKeyFile, '.\FTPManager.INI')
  PUTINI('FTP', 'PrivateKeyFile', SSHSettings:PrivateKeyFile, '.\FTPManager.INI')
  PUTINI('FTP', 'KnownHosts', SSHSettings:KnownHosts, '.\FTPManager.INI')
  PUTINI('FTP', 'KeyPassword', SSHSettings:KeyPassword, '.\FTPManager.INI')
  PUTINI('FTP', 'PublicKeyMD5', SSHSettings:PublicKeyMD5, '.\FTPManager.INI')
END

SETCURSOR()
 4!  �  �      +       ?lstRemoteDir     +    	   AlertKey     +*      CASE KEYCODE()
OF MouseLeft2 OROF EnterKey
  GET(RemoteFileInfoQ, CHOICE(?lstRemoteDir))
  IF NOT ERRORCODE()
    IF RemoteFileInfoQ:IsFolder
      SETCURSOR(CURSOR:Wait)

      DO Routine::ChangeRemoteDir

      SETCURSOR()
    END
  END
  
OF MouseRightUp
OROF AppsKey
  IF RECORDS(RemoteFileInfoQ)
!          EXECUTE(POPUP('Download|-|Create directory|Refresh|-|Rename|Delete'))
!            POST(EVENT:Accepted, ?bDownload)
!            POST(EVENT:Accepted, ?bCreateRemoteDir)
!            DO Routine::RefreshRemoteDir
!            POST(EVENT:Accepted, ?bRenameRemoteFile)
!            POST(EVENT:Accepted, ?bDeleteRemoteFile)
!          END
    EXECUTE(POPUP('Download|Download and Delete|-|Create directory|Refresh|-|Rename|Delete'))
      POST(EVENT:Accepted, ?bDownload)
      POST(EVENT:Accepted, ?bDownloadAndDeleteRemoteFile)
      POST(EVENT:Accepted, ?bCreateRemoteDir)
      DO Routine::RefreshRemoteDir
      POST(EVENT:Accepted, ?bRenameRemoteFile)
      POST(EVENT:Accepted, ?bDeleteRemoteFile)
    END
  ELSE
    IF POPUP('~Download|-|~Create directory|~Refresh|-|~Rename|~Delete') END
  END
END 
 �  �         +       ?lstLocalDir     +    	   AlertKey     +*    P  CASE KEYCODE()
OF MouseLeft2 OROF EnterKey
  GET(LocalFileInfoQ, CHOICE(?lstLocalDir))
  IF NOT ERRORCODE()
    IF LocalFileInfoQ:IsFolder
      SETCURSOR(CURSOR:Wait)
      
      DO Routine::ChangeLocalDir
      
      SETCURSOR()
    END
  END
  
OF MouseRightUp
OROF AppsKey
  IF RECORDS(RemoteFileInfoQ)
    EXECUTE(POPUP('Upload|-|Refresh'))
      POST(EVENT:Accepted, ?bUpload)
      DO Routine::RefreshLocalDir
    END
  ELSE
    EXECUTE(POPUP('~Upload|-|Refresh'))
      POST(EVENT:Accepted, ?bUpload)
      DO Routine::RefreshLocalDir
    END
  END
END 
 �  �  �      +    	   ?bUpload     +    	   Accepted     +*      IF RECORDS(RemoteFileInfoQ) > 0
  GET(LocalFileInfoQ, CHOICE(?lstLocalDir))
  IF NOT ERRORCODE()
    IF NOT LocalFileInfoQ:IsFolder
      !upload file
      SETCURSOR(CURSOR:Wait)
    
      ?progressUpload{PROP:Hide} = FALSE
      ?lblUploadingItem{PROP:Hide} = FALSE
!            ?bAbortUpload{PROP:Hide} = FALSE
    
      XFerInfo.Url = CurrentRemotePath
      XFerInfo.Filename = CLIP(CurrentLocalPath) & LocalFileInfoQ:Name
      IF UploadFile(XFerInfo, Account, SSHSettings, LocalFileInfoQ, ?progressUpload, ?lblUploadingItem)
        BEEP(BEEP:SystemDefault)
      END

      ?lblUploadingItem{PROP:Hide} = TRUE
      ?progressUpload{PROP:Hide} = TRUE
!            ?bAbortUpload{PROP:Hide} = TRUE

      !reload remote folder
      XFerInfo:Url = CurrentRemotePath
      XFerInfo:Filename = ''
      IF LoadRemoteDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
        SORT(RemoteFileInfoQ, -RemoteFileInfoQ:IsFolder, +RemoteFileInfoQ:SortName)
        DISPLAY(?lstRemoteDir)
      END
    
      SETCURSOR()
    ELSE
      !upload directory
      IF LocalFileInfoQ:Name <> '..' AND SUB(LocalFileInfoQ:Name, 2, 1) <> ':'  !restrict [..] and disk drives
        SETCURSOR(CURSOR:Wait)
    
        ?progressUpload{PROP:Hide} = FALSE
        ?lblUploadingItem{PROP:Hide} = FALSE
    
        XFerInfo.Url = CurrentRemotePath
        XFerInfo.Filename = CLIP(CurrentLocalPath) & LocalFileInfoQ:Name
        IF UploadDir(XFerInfo, Account, SSHSettings, LocalFileInfoQ, ?progressUpload, ?lblUploadingItem)
          BEEP(BEEP:SystemDefault)
        END

        ?lblUploadingItem{PROP:Hide} = TRUE
        ?progressUpload{PROP:Hide} = TRUE

        !reload remote folder
        XFerInfo:Url = CurrentRemotePath
        XFerInfo:Filename = ''
        IF LoadRemoteDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
          SORT(RemoteFileInfoQ, -RemoteFileInfoQ:IsFolder, +RemoteFileInfoQ:SortName)
          DISPLAY(?lstRemoteDir)
        END
    
        SETCURSOR()
      END
    END
  END
END
 4!  �  �      +       ?bDownload     +    	   Accepted     +*    �  GET(RemoteFileInfoQ, CHOICE(?lstRemoteDir))
IF NOT ERRORCODE()
  IF NOT RemoteFileInfoQ:IsFolder
    SETCURSOR(CURSOR:Wait)
    
    ?progressDownload{PROP:Hide} = FALSE
    ?lblDownloadingItem{PROP:Hide} = FALSE
    
    glo:OverwriteExistingFile = OEF::No

    XFerInfo.Url = CurrentRemotePath
    XFerInfo.Filename = CLIP(CurrentLocalPath) & RemoteFileInfoQ:Name
    IF DownloadFile(XFerInfo, Account, SSHSettings, RemoteFileInfoQ, ?progressDownload, ?lblDownloadingItem)
      BEEP(BEEP:SystemDefault)
    END

    ?progressDownload{PROP:Hide} = TRUE
    ?lblDownloadingItem{PROP:Hide} = TRUE

    !reload current folder
    LoadLocalDir(CurrentLocalPath, LocalFileInfoQ)
    SORT(LocalFileInfoQ, -LocalFileInfoQ:IsFolder, +LocalFileInfoQ:SortName)
    DISPLAY(?lstLocalDir)
    
    SETCURSOR()
  ELSE
    IF RemoteFileInfoQ:Name <> '..' !restrict [..]
      SETCURSOR(CURSOR:Wait)
    
      ?progressDownload{PROP:Hide} = FALSE
      ?lblDownloadingItem{PROP:Hide} = FALSE

      XFerInfo.Url = CurrentRemotePath
      XFerInfo.Filename = CLIP(CurrentLocalPath) & CLIP(RemoteFileInfoQ:Name)
      IF DownloadDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ, ?progressDownload, ?lblDownloadingItem)
        BEEP(BEEP:SystemDefault)
      END

      ?progressDownload{PROP:Hide} = TRUE
      ?lblDownloadingItem{PROP:Hide} = TRUE

      glo:OverwriteExistingFile = OEF::No

      !reload current folder
      LoadLocalDir(CurrentLocalPath, LocalFileInfoQ)
      SORT(LocalFileInfoQ, -LocalFileInfoQ:IsFolder, +LocalFileInfoQ:SortName)
      DISPLAY(?lstLocalDir)
    
      SETCURSOR()
    END
  END
END
 4!  �  3      +       ?bShowPassword     +    	   Accepted     +*    2   ?Account:Pwd{PROP:Password} = bShowPassword - 1
 4!  x  y      +    
   ?bRefresh     +    	   Accepted     +*    W   !refresh both lists      
DO Routine::RefreshRemoteDir
DO Routine::RefreshLocalDir
 4!  �  �      +       ?bDeleteRemoteFile     +    	   Accepted     +*    �  GET(RemoteFileInfoQ, CHOICE(?lstRemoteDir))
IF NOT ERRORCODE()
  IF NOT RemoteFileInfoQ:IsFolder !only empty folders could be deleted
    IF MESSAGE('FIle "'& CLIP(RemoteFileInfoQ:Name) &'" will be deleted', 'FTP Manager', ICON:Exclamation, BUTTON:OK + BUTTON:CANCEL, BUTTON:CANCEL) = BUTTON:OK
      SETCURSOR(CURSOR:Wait)

      XFerInfo.Url = BaseUrl
      XFerInfo.Filename = CLIP(CurrentRemotePath) & RemoteFileInfoQ:Name
      IF DeleteRemoteFile(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
        BEEP(BEEP:SystemDefault)
 
        !reload remote folder
        XFerInfo:Url = CurrentRemotePath
        XFerInfo:Filename = ''
        IF LoadRemoteDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
          SORT(RemoteFileInfoQ, -RemoteFileInfoQ:IsFolder, +RemoteFileInfoQ:SortName)
          DISPLAY(?lstRemoteDir)
        END
      END

      SETCURSOR()
    END
  ELSE
    IF RemoteFileInfoQ:Name <> '..' !restrict [..]
      IF MESSAGE('Directory "'& CLIP(RemoteFileInfoQ:Name) &'" will be deleted', 'FTP Manager', ICON:Exclamation, BUTTON:OK + BUTTON:CANCEL, BUTTON:CANCEL) = BUTTON:OK
        SETCURSOR(CURSOR:Wait)

        XFerInfo.Url = BaseUrl
        XFerInfo.Filename = CLIP(CurrentRemotePath) & RemoteFileInfoQ:Name
        IF DeleteRemoteDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
          BEEP(BEEP:SystemDefault)
 
          !reload remote folder
          XFerInfo:Url = CurrentRemotePath
          XFerInfo:Filename = ''
          IF LoadRemoteDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
            SORT(RemoteFileInfoQ, -RemoteFileInfoQ:IsFolder, +RemoteFileInfoQ:SortName)
            DISPLAY(?lstRemoteDir)
          END
        END

        SETCURSOR()
      END
    END
  END
END
 4!  5  c      +       ?bCreateRemoteDir     +    	   Accepted     +*       DO Routine::CreateRemoteDir
 4!  e  f      +       ?bRenameRemoteFile     +    	   Accepted     +*       DO Routine::RenameRemoteItem
 4!  h  i      +       ?bClearDebugLog     +    	   Accepted     +*    ,   ?txtLog{PROP:Text} = ''
DISPLAY(?txtLog)
 �  �  �      +       ?bCopyDebugLog     +    	   Accepted     +*    #   SETCLIPBOARD(?txtLog{PROP:Text})
 �  �  �      +       ?bSSHSettings     +    	   Accepted     +*    �   IF SSHSettingsDialog(SSHSettings)
  IF SSHSettings.AuthMethod = CURLSSH_AUTH_NONE
    CHANGE(?bSSH, FALSE)
    DISABLE(?bSSHSettings)
  END
END
       4!  �  �      +       ?bSSH     +    	   Accepted     +*    �   ?bSSHSettings{PROP:Disable} = 1 - bSSH

IF NOT bSSH
  SSHSettings:AuthMethod = CURLSSH_AUTH_NONE
ELSE
  SSHSettings:AuthMethod = CURLSSH_AUTH_ANY
END
 4!  z  �      +       ?bAbortUpload     +    	   Accepted     +*       ThisCurl.abortXfer = TRUE
 4!  k  l      +       ?bDownloadAndDeleteRemoteFile     +    	   Accepted     +*    �  !- Download and delete
GET(RemoteFileInfoQ, CHOICE(?lstRemoteDir))
IF NOT ERRORCODE()
  IF NOT RemoteFileInfoQ:IsFolder
    SETCURSOR(CURSOR:Wait)
    
    ?progressDownload{PROP:Hide} = FALSE
    ?lblDownloadingItem{PROP:Hide} = FALSE
    
    glo:OverwriteExistingFile = OEF::No

    XFerInfo.Url = CurrentRemotePath
    XFerInfo.Filename = CLIP(CurrentLocalPath) & RemoteFileInfoQ:Name
    IF DownloadFile(XFerInfo, Account, SSHSettings, RemoteFileInfoQ, ?progressDownload, ?lblDownloadingItem, TRUE)
      BEEP(BEEP:SystemDefault)
    END

    ?progressDownload{PROP:Hide} = TRUE
    ?lblDownloadingItem{PROP:Hide} = TRUE

    !reload current folder
    LoadLocalDir(CurrentLocalPath, LocalFileInfoQ)
    SORT(LocalFileInfoQ, -LocalFileInfoQ:IsFolder, +LocalFileInfoQ:SortName)
    DISPLAY(?lstLocalDir)
    
    !reload remote dir
    DO Routine::RefreshRemoteDir
    
    SETCURSOR()
  ELSE
    IF RemoteFileInfoQ:Name <> '..' !restrict [..]
      SETCURSOR(CURSOR:Wait)
    
      ?progressDownload{PROP:Hide} = FALSE
      ?lblDownloadingItem{PROP:Hide} = FALSE

      XFerInfo.Url = CurrentRemotePath
      XFerInfo.Filename = CLIP(CurrentLocalPath) & CLIP(RemoteFileInfoQ:Name)
      IF DownloadDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ, ?progressDownload, ?lblDownloadingItem)
        BEEP(BEEP:SystemDefault)
      END

      ?progressDownload{PROP:Hide} = TRUE
      ?lblDownloadingItem{PROP:Hide} = TRUE

      glo:OverwriteExistingFile = OEF::No

      !reload current folder
      LoadLocalDir(CurrentLocalPath, LocalFileInfoQ)
      SORT(LocalFileInfoQ, -LocalFileInfoQ:IsFolder, +LocalFileInfoQ:SortName)
      DISPLAY(?lstLocalDir)
    
      SETCURSOR()
    END
  END
END
 4!  n  �      +        %WindowManagerMethodCodeSection     +       Init     +       (),BYTE     +*    K   ! pass log control handle to curl
ThisCurl.hwndLog = ?txtLog{PROP:Handle} A  7  9      +*    �   !init local path

CurrentLocalPath = PATH() &'\'
LoadLocalDir(CurrentLocalPath, LocalFileInfoQ)
SORT(LocalFileInfoQ, -LocalFileInfoQ:IsFolder, +LocalFileInfoQ:SortName)
 )#  <  A      +*    M  !initialize controls

! url and account
BaseUrl = GETINI('FTP', 'FTP', '99.45.203.227', '.\FTPManager.INI')
XFerInfo:Port = GETINI('FTP', 'Port', 0, '.\FTPManager.INI')
Account:User = GETINI('FTP', 'User', 'User', '.\FTPManager.INI')
Account:Pwd = GETINI('FTP', 'Pwd', 'Password', '.\FTPManager.INI')

! SSH settings
SSHSettings:AuthMethod = GETINI('FTP', 'EnableSSH', CURLSSH_AUTH_NONE, '.\FTPManager.INI')
SSHSettings:PublicKeyFile = GETINI('FTP', 'PublicKeyFile', '', '.\FTPManager.INI')
SSHSettings:PrivateKeyFile = GETINI('FTP', 'PrivateKeyFile', '', '.\FTPManager.INI')
SSHSettings:KnownHosts = GETINI('FTP', 'KnownHosts', '', '.\FTPManager.INI')
SSHSettings:KeyPassword = GETINI('FTP', 'KeyPassword', '', '.\FTPManager.INI')
SSHSettings:PublicKeyMD5 = GETINI('FTP', 'PublicKeyMD5', '', '.\FTPManager.INI')

bSSH = CHOOSE(SSHSettings:AuthMethod <> CURLSSH_AUTH_NONE)
?bSSHSettings{PROP:Disable} = 1 - bSSH

CurrentRemotePath = BaseUrl
IF CurrentRemotePath AND CurrentRemotePath[LEN(CLIP(CurrentRemotePath))] <> '/'
  CurrentRemotePath = CLIP(CurrentRemotePath) & '/'
END
 �#  A  X      +       %ProcedureRoutines     +*    �  Routine::ChangeLocalDir       ROUTINE
  DATA
tmpPath                       LIKE(CurrentLocalPath)
  CODE
  tmpPath = ChangePath(CurrentLocalPath, LocalFileInfoQ:Name, FALSE)
            
!reload dir list
  IF LoadLocalDir(tmpPath, LocalFileInfoQ)
    SORT(LocalFileInfoQ, -LocalFileInfoQ:IsFolder, +LocalFileInfoQ:SortName)
    
    IF LEN(CLIP(tmpPath)) < LEN(CLIP(CurrentLocalPath))
      !jump up, position on current folder
      LocalFileInfoQ.Name = CurrentLocalPath[LEN(CLIP(tmpPath)) + 1 : LEN(CLIP(CurrentLocalPath)) - 1]
      LocalFileInfoQ.IsFolder = TRUE
      GET(LocalFileInfoQ, LocalFileInfoQ.IsFolder, LocalFileInfoQ.Name)
      IF NOT ERRORCODE()
        ?lstLocalDir{PROP:Selected} = POINTER(LocalFileInfoQ)
      END
    ELSE
!      GET(LocalFileInfoQ, 1)
!      IF NOT ERRORCODE()
!        ?lstLocalDir{PROP:Selected} = POINTER(LocalFileInfoQ)
!      END
      
      !jump down, position on [..]
      LocalFileInfoQ.DisplayName = '[..]'
      GET(LocalFileInfoQ, LocalFileInfoQ.DisplayName)
      IF NOT ERRORCODE()
        ?lstLocalDir{PROP:Selected} = POINTER(LocalFileInfoQ)
      END
    END
    
    DISPLAY(?lstLocalDir)
    
    CurrentLocalPath = tmpPath
    DISPLAY(?CurrentLocalPath)
  END
 �  y   �        +*    �  Routine::ChangeRemoteDir      ROUTINE
  DATA
tmpPath                       LIKE(CurrentRemotePath)
  CODE
  IF RemoteFileInfoQ:FileMask AND RemoteFileInfoQ:FileMask[2] = '-'
    ! read access denied
    EXIT
  END
  
  tmpPath = ChangePath(CurrentRemotePath, RemoteFileInfoQ:Name, TRUE)
      
  !reload dir list
  XFerInfo:Url = tmpPath
  XFerInfo:Filename = ''
  IF LoadRemoteDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
    SORT(RemoteFileInfoQ, -RemoteFileInfoQ:IsFolder, +RemoteFileInfoQ:SortName)

    IF LEN(CLIP(tmpPath)) < LEN(CLIP(CurrentRemotePath))
      !jump up, position on current folder
      RemoteFileInfoQ.Name = CurrentRemotePath[LEN(CLIP(tmpPath)) + 1 : LEN(CLIP(CurrentRemotePath)) - 1]
      RemoteFileInfoQ.IsFolder = TRUE
      GET(RemoteFileInfoQ, RemoteFileInfoQ.IsFolder, RemoteFileInfoQ.Name)
      IF NOT ERRORCODE()
        ?lstRemoteDir{PROP:Selected} = POINTER(RemoteFileInfoQ)
      END
    ELSE
      GET(RemoteFileInfoQ, 1)
      IF NOT ERRORCODE()
        ?lstRemoteDir{PROP:Selected} = POINTER(RemoteFileInfoQ)
      END
    END

    DISPLAY(?lstRemoteDir)

    CurrentRemotePath = tmpPath
    DISPLAY(?CurrentRemotePath)
  END
 �  �   �        +*    �  Routine::CreateRemoteDir      ROUTINE
  DATA
newFolderName   STRING(256)
  CODE
  IF NOT RECORDS(RemoteFileInfoQ)
    EXIT
  END
  
  IF NOT CreateFolderDialog(newFolderName)
    EXIT
  END
  
  SETCURSOR(CURSOR:Wait)
    
  XFerInfo.Url = BaseUrl
  XFerInfo.Filename = CLIP(CurrentRemotePath) & newFolderName
  IF CreateRemoteDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
    BEEP(BEEP:SystemDefault)
     
    !reload remote folder
    XFerInfo:Url = CurrentRemotePath
    XFerInfo:Filename = ''
    IF LoadRemoteDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
      SORT(RemoteFileInfoQ, -RemoteFileInfoQ:IsFolder, +RemoteFileInfoQ:SortName)
      DISPLAY(?lstRemoteDir)
    END
  END
    
  SETCURSOR()
 X  �   �        +*      Routine::RenameRemoteItem     ROUTINE
  DATA
oldName   STRING(256)
newName   STRING(256)
  CODE
  IF NOT RECORDS(RemoteFileInfoQ)
    EXIT
  END
  
  GET(RemoteFileInfoQ, CHOICE(?lstRemoteDir))
  IF ERRORCODE()
    EXIT
  END
  
  IF INLIST(RemoteFileInfoQ:Name, '..', '.')
    EXIT
  END
  
  oldName = RemoteFileInfoQ:Name
  
  IF NOT RenameDialog(oldName, newName)
    EXIT
  END
  
  IF oldName = newName
    EXIT
  END

  SETCURSOR(CURSOR:Wait)
    
  XFerInfo.Url = BaseUrl
  XFerInfo.Filename = CLIP(CurrentRemotePath) & oldName
  IF RenameRemoteItem(XFerInfo, Account, SSHSettings, RemoteFileInfoQ, CLIP(CurrentRemotePath) & newName)
    BEEP(BEEP:SystemDefault)
     
    !reload remote folder
    XFerInfo:Url = CurrentRemotePath
    XFerInfo:Filename = ''
    IF LoadRemoteDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
      SORT(RemoteFileInfoQ, -RemoteFileInfoQ:IsFolder, +RemoteFileInfoQ:SortName)
      DISPLAY(?lstRemoteDir)
    END
  END
    
  SETCURSOR()
 �  �          +*    �  Routine::RefreshRemoteDir     ROUTINE
  SETCURSOR(CURSOR:Wait)
  XFerInfo:Url = CurrentRemotePath
  XFerInfo:Filename = ''
  
  ThisCurl.ConnectInfo(XFerInfo, Account, SSHSettings)
  
  IF LoadRemoteDir(XFerInfo, Account, SSHSettings, RemoteFileInfoQ)
    SORT(RemoteFileInfoQ, -RemoteFileInfoQ:IsFolder, +RemoteFileInfoQ:SortName)
    DISPLAY(?lstRemoteDir)
  END
  SETCURSOR()
             +*    �   Routine::RefreshLocalDir      ROUTINE
  SETCURSOR(CURSOR:Wait)
  LoadLocalDir(CurrentLocalPath, LocalFileInfoQ)
  SORT(LocalFileInfoQ, -LocalFileInfoQ:IsFolder, +LocalFileInfoQ:SortName)
  DISPLAY(?lstLocalDir)
  SETCURSOR()
 �                                                                                                                                                     .  t茧^g僆╓窉V裢�         8���"       E鮵 �2     c硘 �2               SSHSettings �H                           SSHSettings                                            @s20                SSHS ettings:        SSHS ettings                                                                             S    PROMPT('SSHS ettings:'),USE(?SSHSettings:Prompt)
 ENTRY(@s20),USE(SSHSettings)
     !    STRING(@s20),USE(SSHSettings)
                                                                                                   r   Q%�
兰N�!q�7�2         ���"      )3y �2     榏 -;                  SSHSettingsDialog 7?F俽J濋qg�    )   (*TSSHSettings pSSHSettings), BOOL, PROC        (*TSSHSettings pSSHSettings) �&�;�8狤�,緙2�                                         ABC$Window         s �7 杤:       榏 -;     T蔠R�汢U掊p壃'"�	R<篔滯(4NZ�	   t茧^g僆╓窉V裢 '噑橈@柼澥攰�5�歎騄�9�"I攭且潻嘾A�o\I綳~�=@hC熦ari	�i�!镓狥婇洼R抶	.fR3荕&讯榙x@U溉D�K 韋p旵Mz8-僉UO"�猻5哳 0C浲}Xs7�                           .  旵Mz8-僉UO"�         侢��"       鑩 �2     c硘 �2               rc �                     BOOL                                                    @s20                rc:        rc                                                                             7    PROMPT('rc:'),USE(?rc:Prompt)
 ENTRY(@s20),USE(rc)
         STRING(@s20),USE(rc)
                                                                                                                                                                            p   鯉鰷郃N�!`n鉯5�         T���"       慗 �2     -輘 �2           朵漞�.�-鐴)z                                                  ABC$GENERATED         s �2 -輘       -輘 �2                                                                                              j   梒J鎆x鏓汑�/��         a���"       �! �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           p   傶�)匇稤綧莓訉�         T���"       侩D �2     I朌 �=           �^ ztPM綽�4C��                                                  ABC$GENERATED         s �5 s乧       I朌 �=                                                                                              .  �虆戋疧巕9K         `���"       LbW �2     @鷆 �2               Newname ��                                                                        @s255             	   Newname:        Newname                                                                             G    PROMPT('Newname:'),USE(?Newname:Prompt)
 ENTRY(@s255),USE(Newname)
         STRING(@s255),USE(Newname)
                                                                                                                                           .  颙�*琌FM欐p$1蒖�         >���"       鴎c �2      詂 �2            	   IsFolder �                                                                        @n3                Is Folder:     
   Is Folder                                                                             ]    PROMPT('Is Folder:'),USE(?TFileInfo:IsFolder:Prompt)
 ENTRY(@n3),USE(TFileInfo:IsFolder)
     '    STRING(@n3),USE(TFileInfo:IsFolder)
                                                                                                          �  w筇E嶣b蝶         ����"       �5R �2     �5R �2                                                                                                                                                                                                                            r   励嶌訠橭9 SQ}�         d���"      a �2     糊a �6                  LoadRemoteDir �"�2
O�5'u�.�    U   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, *TFtpFilesInfo dirlist), BOOL     O   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, *TFtpFilesInfo dirlist)        
                                   ABC$Source         s �2 ,       糊a �6     t)醖hH�鼞`('�48tQ	BO崵睗  鶵 縒?
r+B瑱F結h�$                                                                                                     .  ��徝?M?F蠂         (���"       渮c �2     盯A �2               RemoteFileInfoQ �0                           RemoteFileInfoQ                         ,   files and folders info (like TFtpFilesInfo)                @s20                Remote File Info Q:        Remote File Info Q             ,   files and folders info (like TFtpFilesInfo)     ,   files and folders info (like TFtpFilesInfo)                                                     �    PROMPT('Remote File Info Q:'),USE(?RemoteFileInfoQ:Prompt)
 ENTRY(@s20),USE(RemoteFileInfoQ),MSG('files and folders info (like TFtpFilesInfo)'),TIP('files and folders info (like TFtpFilesInfo)')
     %    STRING(@s20),USE(RemoteFileInfoQ)
                                                                                   .  lMi`WL芁��巏々         #���"       -觶 �2     q誾 �2               DisplayName ��                                                                        @s255                Display Name:        Display Name                                                                             h    PROMPT('Display Name:'),USE(?TFileInfo:DisplayName:Prompt)
 ENTRY(@s255),USE(TFileInfo:DisplayName)
     ,    STRING(@s255),USE(TFileInfo:DisplayName)
                                                                               f   ej9�,E淪卷cM遞         !���"       G鋆 �2     痭X �>            �  -- NAMESPACE FTPManager
-- OUTPUTPATH C:\development\apps\libcurl\clarion
#system win32 exe
#model clarion lib
#pragma link_option(icon=>ftp.ico)
#pragma debug(vid=>off)
#pragma define(_ABCDllMode_=>0) -- GENERATED
#pragma define(_ABCLinkMode_=>1) -- GENERATED
#compile "FTPManager.clw" -- GENERATED
#compile "FTPManager001.clw" -- GENERATED
#compile "FTPManager002.clw" -- GENERATED
#compile "FTPManager003.clw" -- GENERATED
#compile "FTPManager004.clw" -- GENERATED
#compile "FTPManager005.clw" -- GENERATED
#compile "FTPManager006.clw" -- GENERATED
#compile "FTPManager007.clw" -- GENERATED
#compile "FTPManager008.clw" -- GENERATED
#compile "FTPManager009.clw" -- GENERATED
#compile "FTPManager010.clw" -- GENERATED
#compile "FTPManager011.clw" -- GENERATED
#compile "FTPManager012.clw" -- GENERATED
#compile "FTPManager013.clw" -- GENERATED
#compile "FTPManager014.clw" -- GENERATED
#compile "FTPManager015.clw" -- GENERATED
#compile "FTPManager016.clw" -- GENERATED
#compile "FTPManager017.clw" -- GENERATED
#compile "FTPManager_BC0.CLW" -- GENERATED
#compile "FTPMANAGER_BC.CLW" -- GENERATED
#pragma link("libcurl.lib") -- GENERATED
#link "FTPManager.EXE"
                                   r   $湌澝 J�%         ���"      ^� �2     5譊 �<     O             DownloadDir � `萇@擷�脥
`    r   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem, SIGNED pProgress, SIGNED pLabel), BOOL     l   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem, SIGNED pProgress, SIGNED pLabel)       �0閕\�1H�\?lL潠励嶌訠橭9 SQ}�                                   ABC$Source         s �2 �5       5譊 �<     g鍆辻灒A�5x艘�嗾RIズV�?D� 
}v9�8M俼z閰觃�             r   �1)[鈁>M泒F�級�         -���"      �:h �2     �G 56                  UploadFile 骵�;R柈K瀊襤$[Q    r   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem, SIGNED pProgress, SIGNED pLabel), BOOL     l   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem, SIGNED pProgress, SIGNED pLabel)        
                                   ABC$Source         s �2 骰o       �G 56     J :
^�3A�规瓧�/�絘!鮈嚸�垡�; ob跢瞣歊�6`�                                              .  Q��lH�!胾:牞         &���"       萺 �2      �2            	   SortName ��                                                                        @s255                Sort Name:     
   Sort Name                                                                             k    PROMPT('Sort Name:'),USE(?RemoteFileInfoQ:SortName:Prompt)
 ENTRY(@s255),USE(RemoteFileInfoQ:SortName)
     /    STRING(@s255),USE(RemoteFileInfoQ:SortName)
                                                                                 �  UA鹆4┡C俯暬J忧�         燆��"       �3^ �2     魼 �=                    K         �  �  �
   	   
�  �!(   6Z�
 !         �(   �   �� 8   $      �   
   �	   
    �3�   ��
 =        �C   �   �� Y   !     +   
   �	#   
1    ��   ��
 ]         �c   �   �� x   $      S   
   �	A   
N    �3�   ��
 |   �      ��   �   �� �   �      ?   
   �	^   
j    �3F�   �� �   �      �	z   
�    ��	   �� �        �	�   
�    ��
   ��	 �   @           ��   ,^�   �   ��	 �   Z     L      ��   (��   ��	 �   �     L      ��   (�   �   ��
 �      d   �  �   ��   9   c     
   �	�   
�    �3I�   ��    -   q  2   �  I�   ��	  �  ,         �'  (�^7  �   ��	  �  F         �G  (�	^V  �   ��
 h  Z  d   �u  �   ��    q   A  �   ��  
	
   ��      �   �#  � 览� �34�  5	�   
�    ��	�   
   �	  
4   �	D  
\   ���   �� �  �  c     
   �	l  
~   �3I�   �� Z  q   A  �   ��  
	
   ��      �   �#  � 览� �34�  5	�  
�   ��	�  
�   �	�  
�   �	  
    �	0  
I   ���   ��	 Z     |  �m  �   ��	 v  Y  |  ��  �   ��# i   ~  �   ��  7G     !d   ��   ��
 �  i   �  ��  7�   ��# �  ~  �   ��  7G     !d   ��   ��
 �  �  �  ��  7�   ��	 �       ��  7�   ��	   )     �  7�   ��	 #  L     �'  7�   ��	 :     �  N   �A  7�    ��	 O  q     *      �Y  7�'  ����    s  FTP manager Segoe UI ftp.ico ftp:// ?BaseUrl:Prompt s255 Port: ?XFerInfo:Port:Prompt n7b User: ?Account:User:Prompt s40 Password: ?Account:Pwd:Prompt s40  Show  SSH ... ?bSSHSettings SSH settings Connect ?bConnect Refresh ?bRefresh refresh.ico Local Path: ?BaseLocalPath:Prompt s255 ?txtLog ?bClearDebugLog Clear debug log ?bCopyDebugLog Copy to clipboard Remote Path: ?CurrentRemotePath:Prompt ?lstLocalDir 172L(2)|FM~Name~@s255@72R(2)|FM~Last Modified~@s20@53R(2)|FM~Size~@s20@ s255 ?lstRemoteDir 132L(2)|FM~Name~@s255@72L(2)|FM~Last Modified~@s20@53R(2)|FM~Size~@s20@40L(2)|FM~Permissions~@s10@ Upload selected >> ?bUpload << Download selected ?bDownload ?progressUpload set in code ?lblUploadingItem ?progressDownload set in code ?lblDownloadingItem DEL ?bDeleteRemoteFile MKD ?bCreateRemoteDir REN ?bRenameRemoteFile Cancel ?bAbortUpload DL && DEL ?bDownloadAndDeleteRemoteFile     U  Window BaseUrl z*WI懏汯�0sZ朮FerInfo:Port 众鎄腉骏瀁+3�&Account:User �	t樒燖巬I询眻FAccount:Pwd .s�(U犰E筄蹃\錢峛ShowPassword j�<笹1餌㈠�!=�bSSH )鮜�悢L睟樦�4掕CurrentLocalPath 公AH鵏贑�
�#q炃糒ocalFileInfoQ 破赻棯_H犗.奝�)軱ocalFileInfoQ:DisplayName [�(映eL孒~ht騤哃ocalFileInfoQ:LastModified 檛#t`G廟丢頥鈔LocalFileInfoQ:FileSize �4l|谦J�NΕql.CurrentRemotePath ,杂砱c跧敖蔁P�RemoteFileInfoQ ��徝?M?F蠂RemoteFileInfoQ:DisplayName 坚�5qM督篳秨�1RemoteFileInfoQ:LastModified 巴d3炰鬕�替P}WQRemoteFileInfoQ:FileSize 椶~h汧G�薾洀p4RemoteFileInfoQ:FileMask 榮	蕑E瓀充櫶饸                                                                                                                                                                r   aW`唅劽B瞔�艗U         %���"      �*? �2     X躠 �5     O             DeleteRemoteDir 銅眪=.M櫯颏L 4�    Q   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem), BOOL     K   (TXferInfo xferinfo, TAccount acct, TSSHSettings pSSH, TFtpFileInfo pitem)       �^ ztPM綽�4C�衫鴯�訠橭9 SQ}�                %   Recursively delete files and subdirs                ABC$Source         s �2 使C       X躠 �5     鉠堘襣譊X% 葀-州芈J泊O好�镄	� Y憅蒩礎�)y,摇                                      .  �脼�4虲燗埫?F蜑         E���"       )` �2     4蟘 �2            
   TXFerInfo �                        
   TXFerInfo               @                            @s20                TXF er Info:        TXF er Info                                                                             N    PROMPT('TXF er Info:'),USE(?TXFerInfo:Prompt)
 ENTRY(@s20),USE(TXFerInfo)
         STRING(@s20),USE(TXFerInfo)
                                                                                                                 �  殡�%:rJ廰僦*�U         ����"       嬍n �2     嬍n �2                                                                                                                                                                                                                            .  艬R鶫挐WS脔}         d���"       eeJ �2     亄X �2               FtpUrl ��                                                                        @s255             	   Ftp Url:        Ftp Url                                                                             E    PROMPT('Ftp Url:'),USE(?FtpUrl:Prompt)
 ENTRY(@s255),USE(FtpUrl)
         STRING(@s255),USE(FtpUrl)
                                                                                                                                               d   �}鬑nH毟/樃         ��"       G鋆 �2     簆X �>        "   ej9�,E淪卷cM遞再�|扜I壁臲^--M   孰i
eJ剤W�$�)c腒鍓槯N�?0砩%�"�2
O�5'u�.潜t玀捰b~�i鯉鰷郃N�!`n鉯5婸7揻鯧\D�'舮1e�;R柈K瀊襤$[Q傶�)匇稤綧莓訉睾M亾.E角5[緝[^麇醻岶彲筩�z覕H=wL砊鮭眨編z哔�77@ゆG!W骷鵘�%'L巟酀ZL|*7?F俽J濋qg�!bj槭%G�*x�4贳Z�.&鮐MC禈誫蕯蚉� `萇@擷�脥
`銅眪=.M櫯颏L 4�                �6W释KnI剓蓖?耯                  en �> en �>      	   ABC$ToDo                        ABC         s �2 臜�       jHX �>           LibcurlTpl$LibcurlGloExt    ����                    D�餂EB⒑w怢��                                                                                                                                                                        p   骷鵘�%'L巟酀ZL|*         T���"       頤W �2     -輘 �2           �摳嗳@咡辷渄鲙                                                  ABC$GENERATED         s �2 -輘       -輘 �2                                                                                              j   谘�堿殧亯Xr*g         a���"       l鱒 �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           .  蚷霐�隌痋�7儏         /���"       ['u �2      � �2               Level �                                                                      @n-14                Level:        Level                                                                             h    PROMPT('Level:'),USE(?LocalFileInfoQ:Level:Prompt)
 ENTRY(@n-14),USE(LocalFileInfoQ:Level),RIGHT(1)
     4    STRING(@n-14),USE(LocalFileInfoQ:Level),RIGHT(1)
                                                                                          �  誈鳆b敄H▊箌熏�         ����"       霼W �2     霼W �2                                                                                                                                                                                                                            j   t)醖hH�鼞`('         a���"       ╠ �2     鵻V �>                  %GenerateOpenClose                                %GenerateSaveRestore                                                                                                                           .  	.fR3荕&讯�         ���"       �:: �7     榏 -;               PublicKeyMD5 �                                                                         @s32                Public Key MD5:        Public Key MD 5                                                                             o    PROMPT('Public Key MD5:'),USE(?SSHSettings:PublicKeyMD5:Prompt)
 ENTRY(@s32),USE(SSHSettings:PublicKeyMD5)
     .    STRING(@s32),USE(SSHSettings:PublicKeyMD5)
                                                                �  |c显盓/J獚�#溴;�         辄��"       7礗 �2     *nX �>           +       %LocalDataAfterClasses     +*    s   url                     STRING(256)
dirname                 STRING(256)
res                     CURLcode, AUTO
 �             +       %ProcessedCode     +*    �    res = ThisCurl.ResetOptions()
  IF res <> CURLE_OK
    MESSAGE(ThisCurl.StrError(res), 'FTP Manager', ICON:Exclamation)
    RETURN FALSE
  END

  ! build full url
  url = ThisCurl.BuildUrl(xferinfo.Url, acct.User, pSSH)

  !dirname like "/home/var/temp"
  dirname = ExtractRemotePath(xferinfo.Filename)
  res = ThisCurl.CreateDir(url, CLIP(dirname))
  IF res <> CURLE_OK
    MESSAGE(ThisCurl.StrError(res), 'FTP Manager', ICON:Exclamation)
    RETURN FALSE
  END
  
  RETURN TRUE
 �     &                                                                                                                                                                                                                                                  .  諘n&肅�Q 0C�         q���"       狰| �2     �	 �2               AuthMethod �                     CURLSSH_AUTH_ENUM              0   Any|None|PublicKey|Password|Host|Keyboard|Agent                                   @s20                Authentication method:        Auth Method                                                                             �    PROMPT('Authentication method:'),USE(?SSHSettings:AuthMethod:Prompt)
 LIST,USE(SSHSettings:AuthMethod),DROP(7),FROM('Any|#-1|None|#0|PublicKey|#1|Password|#2|Host|#4|Keyboard|#8|Agent|#16')
     ,    STRING(@s20),USE(SSHSettings:AuthMethod)
                -1|0|1|2|4|8|16                                                                                                                                            .  �泏裔WO絭�>潵骃         ���"       该y �2     i z �2               KeyPassword �(                                                                        @s40                Key Password:        Key Password                                                                             m    PROMPT('Key Password:'),USE(?TSSHSettings:KeyPassword:Prompt)
 ENTRY(@s40),USE(TSSHSettings:KeyPassword)
     .    STRING(@s40),USE(TSSHSettings:KeyPassword)
                                                                         .  �禡孈I浫b^�17         0���"       褷y �2     匉y �2               TSSHSettings �(                           TSSHSettings               @                            @s20                TSSHS ettings:        TSSHS ettings                                                                             V    PROMPT('TSSHS ettings:'),USE(?TSSHSettings:Prompt)
 ENTRY(@s20),USE(TSSHSettings)
     "    STRING(@s20),USE(TSSHSettings)
                                                                                            .  P〣胊疉�o}槭Bo         M���"       ws` �2     2慲 �2            	   XFerInfo �                        	   XFerInfo                                            @s20                XF er Info:        XF er Info                                                                             K    PROMPT('XF er Info:'),USE(?XFerInfo:Prompt)
 ENTRY(@s20),USE(XFerInfo)
         STRING(@s20),USE(XFerInfo)
                                                                                                                        .  幆辨�廜貉犗/讠         `���"       鞺W �2     踐W �2               Oldname ��                                                                        @s255             	   Oldname:        Oldname                                                                             G    PROMPT('Oldname:'),USE(?Oldname:Prompt)
 ENTRY(@s255),USE(Oldname)
         STRING(@s255),USE(Oldname)
                                                                                                                                           .  Q�崪豪E�1�<�翢         ;���"       As` �2     粅` �2            	   fileMask �
                                                                        @s10                file Mask:     
   file Mask                                                                             ^    PROMPT('file Mask:'),USE(?TFileInfo:fileMask:Prompt)
 ENTRY(@s10),USE(TFileInfo:fileMask)
     (    STRING(@s10),USE(TFileInfo:fileMask)
                                                                                                       p   孰i
eJ剤W�$�)c         桛��"       M鋆 �2     簆X �>                                                               ABC$ABC         s �> 酩W       jHX �>      �F�)娘O爖&h弭3�   �脼�4虲燗埫?F蜑p瘶|E癠礡斠矨��`{I爊P _誒鲙�痉N兂湓湜貛漫d俻D桙搠9崡�64鈯�M�枻?� 麉枚騫俋D�"�槑kC萪逆N�&鴳V�Y鎱A楌凶匴欘,[鋋K緌�,M瓋磘甾輆椐G蟬I鯪�K沬彞5��3�                                                                                                                                                        .  �	t樒燖巬I询眻F         `���"       瘇` �2     2Fd �2               User �(                                                                        @s40                User:        User                                                                             M    PROMPT('User:'),USE(?Account:User:Prompt)
 ENTRY(@s40),USE(Account:User)
     "    STRING(@s40),USE(Account:User)
                                                                                                                                           .  z*WI懏汯�0sZ�         ]���"       歹c �2     畟d �2               BaseUrl ��                                                                        @s255             
   Base Url:     	   Base Url                                                                             H    PROMPT('Base Url:'),USE(?BaseUrl:Prompt)
 ENTRY(@s255),USE(BaseUrl)
         STRING(@s255),USE(BaseUrl)
                                                                                                                                        .  认�-燣�攄,K損         濑��"       騠c �2     騠c �2                �                                                                                                                                                                                                                                                                                                                                                                                                                                                                         �  Y憅蒩礎�)y,摇         ����"       �*? �2     �*? �2                                                                                                                                                                                                                            .  吤厄q俋D�"�槑k         P���"       0` �2     L襝 �2            	   TAccount �P                         	   TAccount               @                            @s20                TA ccount:     
   TA ccount                                                                             J    PROMPT('TA ccount:'),USE(?TAccount:Prompt)
 ENTRY(@s20),USE(TAccount)
         STRING(@s20),USE(TAccount)
                                                                                                                            �  )诛枹N�樘鬷w         ����"       鎉 �2     鎉 �2                                                                                                                                                                                                                            .  j�<笹1餌㈠�!=�         6���"       | �2     !O� �2               bShowPassword �                                                                        @n3                b Show Password:        b Show Password                                                                             Y    PROMPT('b Show Password:'),USE(?bShowPassword:Prompt)
 ENTRY(@n3),USE(bShowPassword)
     "    STRING(@n3),USE(bShowPassword)
                                                                                                 .  �吷w軭楆�=I�?t         ,���"       �u �2      � �2               Level �                                                                      @n-14                Level:        Level                                                                             j    PROMPT('Level:'),USE(?RemoteFileInfoQ:Level:Prompt)
 ENTRY(@n-14),USE(RemoteFileInfoQ:Level),RIGHT(1)
     5    STRING(@n-14),USE(RemoteFileInfoQ:Level),RIGHT(1)
                                                                                       .  嫃藀�癆磝�7x�#�         !���"       考y �2     i z �2               KnownHosts �                                                                        @s255                Known Hosts:        Known Hosts                                                                             k    PROMPT('Known Hosts:'),USE(?TSSHSettings:KnownHosts:Prompt)
 ENTRY(@s255),USE(TSSHSettings:KnownHosts)
     .    STRING(@s255),USE(TSSHSettings:KnownHosts)
                                                                                                         