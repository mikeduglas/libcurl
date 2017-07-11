#TEMPLATE(LibcurlTpl, 'Libcurl template'), FAMILY('ABC'), FAMILY('CW20')
#! --------------------------------------------------------------------------
#EXTENSION(LibcurlGloExt, 'Activate Libcurl'), APPLICATION
#SHEET
  #TAB('About')
    #DISPLAY('Libcurl support')
    #DISPLAY('(c) 2015-2017 by Mike Duglas')
    #DISPLAY('home page: https://github.com/mikeduglas/libcurl')
    #DISPLAY('email: mikeduglas66@gmail.com')
    #DISPLAY('')
    #BUTTON('Check for Updates'), WHENACCEPTED(%curlOpenHomePageGrp())
    #ENDBUTTON
    #BUTTON('Report a bug'), WHENACCEPTED(%curlEmailMeGrp())
    #ENDBUTTON
  #ENDTAB
#ENDSHEET
#! --------------------------------------------------------------------------
#AT(%AfterGlobalIncludes)
  #IF(%AppTemplateFamily='ABC')
    #ADD(%GlobalIncludeList,'libcurl.inc')
  #ELSE
    #ADD(%CustomGlobalDeclarationIncludes,'libcurl.inc')
  #ENDIF
#ENDAT
#! --------------------------------------------------------------------------
#AT(%CustomGlobalDeclarations)
  #PROJECT('libcurl.lib')
  #IF(%CWVersion >= 8000)
    #PROJECT('None(libcurl.dll), CopyToOutputDirectory=PreserveNewest')
    #PROJECT('None(libcrypto-1_1.dll), CopyToOutputDirectory=PreserveNewest')
    #PROJECT('None(libssl-1_1.dll), CopyToOutputDirectory=PreserveNewest')
  #ENDIF
#ENDAT
#! --------------------------------------------------------------------------
#EXTENSION(LibcurlLocExt, 'Local libcurl instance'), PROCEDURE, REQ(LibcurlGloExt(LibcurlTpl))
#SHEET
  #TAB('General')
    #PROMPT('Select base class:', DROP('TCurlClass|TCurlFtpClass|TCurlMailClass|TCurlHttpClass')), %curlBaseClass, DEFAULT('TCurlClass')
    #PROMPT('Instance name:', @s32), %curlVar, DEFAULT('curl'), REQ
  #ENDTAB
#ENDSHEET
#! --------------------------------------------------------------------------
#AT(%DataSection)
  #CALL(%curlObjDeclGrp)
#ENDAT
#! --------------------------------------------------------------------------
#AT(%LocalProcedures)
  #CALL(%curlObjDefGrp)
#ENDAT
#! --------------------------------------------------------------------------
#AT(%ProcessedCode), FIRST, WHERE(%ProcedureTemplate = 'SOURCE'), DESCRIPTION('-- '& %curlVar &' initialization --')
  %curlVar.Init()
#ENDAT
#! --------------------------------------------------------------------------
#AT(%WindowManagerMethodCodeSection,'Init','(),BYTE'), FIRST, WHERE(UPPER(%ModuleTemplate)='GENERATED(ABC)' AND %ProcedureTemplate <> 'SOURCE'), DESCRIPTION('-- '& %curlVar &' initialization --')
%curlVar.Init()
#ENDAT
#! --------------------------------------------------------------------------
#AT(%AfterWindowOpening), FIRST,  WHERE(UPPER(%ModuleTemplate)='GENERATED(CLARION)' AND %ProcedureTemplate <> 'SOURCE'), DESCRIPTION('-- '& %curlVar &' initialization --')
  %curlVar.Init()
#ENDAT
#! --------------------------------------------------------------------------
#! --------------------------------------------------------------------------
#GROUP(%curlOpenHomePageGrp)
  #RUN('libcurlhomepage.cmd')
#! --------------------------------------------------------------------------
#GROUP(%curlEmailMeGrp)
  #RUN('libcurlreportabug.cmd libcurl bug report')
#! --------------------------------------------------------------------------
#GROUP(%curlObjDeclGrp)
%[20]curlVar CLASS(%curlBaseClass)
Construct              PROCEDURE()
Destruct               PROCEDURE(), DERIVED
Init                   PROCEDURE(), DERIVED
Cleanup                PROCEDURE(), DERIVED
Reset                  PROCEDURE(), DERIVED
AddError               PROCEDURE(CURLE Id, *STRING Message), DERIVED
AddErrors              PROCEDURE(curl::ErrorBlock ErrsIn), DERIVED
StrError               PROCEDURE(CURLcode errcode), STRING, DERIVED
ReadFile               PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>), CURLcode, DERIVED, PROC
XFerInfo               PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow), LONG, PROC, DERIVED
DebugCallback          PROCEDURE(CURL_INFOTYPE ptype, STRING ptypetxt, STRING ptext), DERIVED
  #IF(%curlBaseClass = 'TCurlMailClass')
SetOptions             PROCEDURE(), CURLcode, PROC, DERIVED, PROTECTED
  #ENDIF
%[20]Null END
#! --------------------------------------------------------------------------
#GROUP(%curlObjDefGrp)
#! Construct  
#?%curlVar.Construct  PROCEDURE()
#EMBED(%curlConstructData, 'Construct DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|Construct()|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlConstructCode, 'Construct CODE'), %curlVar, TREE('libcurl|'& %curlVar &'|Construct()|CODE' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
#! Destruct  
#?%curlVar.Destruct   PROCEDURE()
#EMBED(%curlDestructData, 'Destruct DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|Destruct()|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlDestructCode, 'Destruct CODE'), %curlVar, TREE('libcurl|'& %curlVar &'|Destruct()|CODE' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
#! Init  
#?%curlVar.Init       PROCEDURE()
#EMBED(%curlInitData, 'Init DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|Init()|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlInitBeforeParent, 'Init Before Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|Init()|Before Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
  PARENT.Init()
#EMBED(%curlInitAfterParent, 'Init After Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|Init()|After Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(9000)}')
#! Cleanup  
#?%curlVar.Cleanup       PROCEDURE()
#EMBED(%curlCleanupData, 'Cleanup DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|Cleanup()|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlCleanupBeforeParent, 'Cleanup Before Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|Cleanup()|Before Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
  PARENT.Cleanup()
#EMBED(%curlCleanupAfterParent, 'Cleanup After Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|Cleanup()|After Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(9000)}')
#! Reset  
#?%curlVar.Reset        PROCEDURE()
#EMBED(%curlResetData, 'Reset DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|Reset()|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlResetBeforeParent, 'Reset Before Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|Reset()|Before Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
  PARENT.Reset()
#EMBED(%curlResetAfterParent, 'Reset After Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|Reset()|After Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(9000)}')
#! AddError  
#?%curlVar.AddError     PROCEDURE(CURLE Id, *STRING Message)
#EMBED(%curlAddErrorData, 'AddError DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|AddError(CURLE Id, *STRING Message)|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlAddErrorBeforeParent, 'AddError Before Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|AddError(CURLE Id, *STRING Message)|Before Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
  PARENT.AddError(Id, Message)
#EMBED(%curlAddErrorAfterParent, 'AddError After Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|AddError(CURLE Id, *STRING Message)|After Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(9000)}')
#! AddErrors  
#?%curlVar.AddErrors     PROCEDURE(curl::ErrorBlock ErrsIn)
#EMBED(%curlAddErrorsData, 'AddErrors DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|AddErrors(curl::ErrorBlock ErrsIn)|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlAddErrorsBeforeParent, 'AddErrors Before Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|AddErrors(curl::ErrorBlock ErrsIn)|Before Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
  PARENT.AddErrors(ErrsIn)
#EMBED(%curlAddErrorsAfterParent, 'AddErrors After Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|AddErrors(curl::ErrorBlock ErrsIn)|After Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(9000)}')
#! StrError  
#?%curlVar.StrError     PROCEDURE(CURLcode errcode)
#?sErrTxt               CSTRING(256)
#EMBED(%curlStrErrorData, 'StrError DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|StrError(CURLcode errcode)|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlStrErrorBeforeParent, 'StrError Before Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|StrError(CURLcode errcode)|Before Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
  sErrTxt = PARENT.StrError(errcode)
#EMBED(%curlStrErrorAfterParent, 'StrError After Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|StrError(CURLcode errcode)|After Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(9000)}')
  RETURN sErrTxt
#! ReadFile  
#?%curlVar.ReadFile     PROCEDURE(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>)
#?nRes                  CURLcode, AUTO
#EMBED(%curlReadFileData, 'ReadFile DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|ReadFile(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>)|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlReadFileBeforeParent, 'ReadFile Before Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|ReadFile(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>)|Before Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
  nRes = PARENT.ReadFile(pRemoteFile, pLocalFile, xferproc)
#EMBED(%curlReadFileAfterParent, 'ReadFile After Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|ReadFile(STRING pRemoteFile, STRING pLocalFile, <curl::ProgressDataProcType xferproc>)|After Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(9000)}')
  RETURN nRes
#! XFerInfo  
#?%curlVar.XFerInfo     PROCEDURE(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)
#?nRes                  LONG, AUTO
#EMBED(%curlXFerInfoData, 'XFerInfo DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|XFerInfo(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlXFerInfoBeforeParent, 'XFerInfo Before Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|XFerInfo(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)|Before Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
  nRes = PARENT.XFerInfo(dltotal, dlnow, ultotal, ulnow)
#EMBED(%curlXFerInfoAfterParent, 'XFerInfo After Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|XFerInfo(REAL dltotal, REAL dlnow, REAL ultotal, REAL ulnow)|After Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(9000)}')
  RETURN nRes
#! DebugCallback  
#?%curlVar.DebugCallback  PROCEDURE(CURL_INFOTYPE ptype, STRING ptypetxt, STRING ptext)
#EMBED(%curlDebugCallbackData, 'DebugCallback DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|DebugCallback(CURL_INFOTYPE ptype, STRING ptypetxt, STRING ptext)|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlDebugCallbackBeforeParent, 'DebugCallback Before Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|DebugCallback(CURL_INFOTYPE ptype, STRING ptypetxt, STRING ptext)|Before Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
  PARENT.DebugCallback(ptype, ptypetxt, ptext)
#EMBED(%curlDebugCallbackAfterParent, 'DebugCallback After Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|DebugCallback(CURL_INFOTYPE ptype, STRING ptypetxt, STRING ptext)|After Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(9000)}')
  #IF(%curlBaseClass = 'TCurlMailClass')
#! SetOptions  
#?%curlVar.SetOptions  PROCEDURE()
#?nRes                  CURLcode, AUTO
#EMBED(%curlSetOptionsData, 'SetOptions DATA'), DATA, %curlVar, TREE('libcurl|'& %curlVar &'|SetOptions()|DATA' & '{{COLOR(' & %ColorDataSection & '),PRIORITY(5)}')
  #?CODE
#EMBED(%curlSetOptionsBeforeParent, 'SetOptions Before Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|SetOptions()|Before Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(10)}')
  nRes = PARENT.SetOptions()
#EMBED(%curlSetOptionsAfterParent, 'SetOptions After Parent'), %curlVar, TREE('libcurl|'& %curlVar &'|SetOptions()|After Parent' & '{{COLOR(' & %ColorCodeSection & '),PRIORITY(9000)}')
  RETURN nRes
  #ENDIF
