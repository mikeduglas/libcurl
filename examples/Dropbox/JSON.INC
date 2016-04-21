!ABCIncludeFile(ABC)

OMIT('_EndOfInclude_',_JSONStringClassPresente_)
_SystemStringPresente_ EQUATE(1)

!http://www.w3resource.com/JSON/structures.php
!A collection of name/value pairs. 
!
!An ordered list of values

  ITEMIZE,PRE(JSONDataType)
None        EQUATE(0)
String      EQUATE(1)
Number      EQUATE(2)
Bool        EQUATE(3)
Decimal     EQUATE(4)
Array       EQUATE(5)
Object      EQUATE(6)
NamedArray  EQUATE(7)
NamedObject EQUATE(8)
EscString   EQUATE(9)
StringValue EQUATE(10)
NullString  EQUATE(11)
  END

JSONDataValueQueue  QUEUE,TYPE
Name                  CSTRING(256)
Value                 &STRING
                    END
JSONDataPicturesQueue  QUEUE,TYPE
Name                  CSTRING(256)
Picture               CSTRING(256)
                    END

JSONQueueOfQueue QUEUE,TYPE
Name                  CSTRING(256)
Q                     &QUEUE
 END                    
JSONDataClass     CLASS, MODULE('JSON.CLW'),LINK('JSON.CLW', _ABCLinkMode_), DLL(_ABCDllMode_), TYPE
!region PROTECTED
QofQ                         &JSONQueueOfQueue,PROTECTED
JSONObject                   &JSONDataValueQueue,PROTECTED
formatter                    &JSONDataPicturesQueue,PROTECTED
externalNames                &JSONDataPicturesQueue,PROTECTED
hiddenNames                  &JSONDataPicturesQueue,PROTECTED
_RemoveFieldPrefix           BYTE,PROTECTED
_ObjectIsArray               BYTE,PROTECTED
_UseEscapeString             BYTE,PROTECTED
_SupportNullString           BYTE,PROTECTED
_EscapedString               &STRING,PROTECTED
JSONObjectSize               LONG,PROTECTED
retValTmp                    &STRING,PROTECTED
clipValues                   BYTE,PROTECTED
_LostArrayData               BYTE,PROTECTED
_LostArrayDataField          CSTRING(256),PROTECTED
Construct                    PROCEDURE()
Destruct                     PROCEDURE()
DisposeIt                    PROCEDURE(),PROTECTED
CreateNewTmpString           PROCEDURE(LONG strSize),PROTECTED
DisposeTmpString             PROCEDURE(),PROTECTED
AssignRefTmpString           PROCEDURE(*STRING strRefValue),PROTECTED
GetTmpStringValue            PROCEDURE(),STRING,PROTECTED
TryGetFormatterPicture       PROCEDURE(STRING fieldName, *CSTRING picture), BYTE, PROTECTED
GroupToJSON                  PROCEDURE(*GROUP JSONObject,*STRING retVal),BYTE,PROTECTED
LongArrToJSON                PROCEDURE(*LONG[] values),STRING,PROTECTED
StringArrToJSON              PROCEDURE(*STRING[] values),STRING,PROTECTED
StringToJSON                 PROCEDURE(STRING name, STRING value),STRING, PROTECTED
BoolToJSON                   PROCEDURE(STRING name, BYTE value),STRING, PROTECTED
NumberToJSON                 PROCEDURE(STRING name, LONG value),STRING, PROTECTED
NumberToJSON                 PROCEDURE(STRING name, *ANY value, STRING picture),STRING, PROTECTED
DecimalToJSON                PROCEDURE(STRING name, *DECIMAL value),STRING, PROTECTED
PairToJSON                   PROCEDURE(STRING JsonPairName, ? JsonPairValue),STRING,PROTECTED
PairToJSON                   PROCEDURE(STRING JsonPairName, ? JsonPairValue, STRING ljPicture),STRING,PROTECTED
JSONToGroup                  PROCEDURE(*STRING pJSONString,LONG pInitStr, LONG pEndStr,*GROUP JSONObject),PROTECTED
GetStringType                PROCEDURE(*STRING pJSONString),UNSIGNED,PROTECTED
GetFieldName                 PROCEDURE(STRING fieldName),STRING,PROTECTED
SetLostArrayDataField        PROCEDURE(STRING fieldName),PROTECTED
!endregion
GetLostArrayData             PROCEDURE(),BYTE
GetLostArrayDataField        PROCEDURE(),STRING
SetClipValues                PROCEDURE(BYTE value)
GetClipValues                PROCEDURE(),BYTE
EscapeString                 PROCEDURE(STRING value),STRING
UnEscapeString               PROCEDURE(STRING value),STRING
SetEscapeString              PROCEDURE(BYTE value)
GetEscapeString              PROCEDURE(),BYTE
FindNumberFormatter          PROCEDURE(STRING fieldName),BYTE
SetNumberFormatter           PROCEDURE(STRING fieldName, STRING picture) !It is only appliyed to numbers
GetFormatterPicture          PROCEDURE(STRING fieldName),STRING
DeleteNumberFormatter        PROCEDURE(STRING fieldName)
DeleteAllNumberFormatters    PROCEDURE()
SetExternalName              PROCEDURE(STRING fieldName, STRING fieldExternalName)
GetExternalName              PROCEDURE(STRING fieldName),STRING
DeleteExternalName           PROCEDURE(STRING fieldName)
DeleteAllExternalNames       PROCEDURE()
FindExternalName             PROCEDURE(STRING fieldName),BYTE
HideGroupField               PROCEDURE(STRING fieldName)
UnhideGroupField             PROCEDURE(STRING fieldName)
UnhideAllGroupFields         PROCEDURE(STRING fieldName)
HideAllGroupFields           PROCEDURE(*GROUP pJSONObject)
IsHiddenGroupField           PROCEDURE(STRING fieldName),BYTE
SetRemoveFieldPrefix         PROCEDURE(BYTE value)
GetRemoveFieldPrefix         PROCEDURE(),BYTE
SetSupportNullString         PROCEDURE(BYTE value)
GetSupportNullString         PROCEDURE(),BYTE

ToJSON                       PROCEDURE(*GROUP pJSONObject),STRING
ToJSON                       PROCEDURE(*QUEUE pJSONArray),STRING
ToJSON                       PROCEDURE(STRING pJSONArrayName, *QUEUE pJSONArray),STRING
ToJSON                       PROCEDURE(*QUEUE pJSONArray,LONG pStartRecord, LONG pEndRecord),STRING
ToJSON                       PROCEDURE(STRING pJSONArrayName, *QUEUE pJSONArray,LONG pStartRecord, LONG pEndRecord),STRING
ToJSON                       PROCEDURE(*BYTE[] values),STRING
ToJSON                       PROCEDURE(*LONG[] values),STRING
ToJSON                       PROCEDURE(*STRING[] values),STRING
FromJSON                     PROCEDURE(*STRING pJSONString,*GROUP pJSONObject)
FromJSON                     PROCEDURE(*STRING pJSONString,*QUEUE pJSONArray)
FromJSON                     PROCEDURE(*STRING pJSONString,*QUEUE pJSONArray, STRING pPicture)
FromJSON                     PROCEDURE(STRING pJSONString,*GROUP pJSONObject)
FromJSON                     PROCEDURE(STRING pJSONString,*QUEUE pJSONArray)
FromJSON                     PROCEDURE(STRING pJSONString,*QUEUE pJSONArray, STRING pPicture)
FromJSON                     PROCEDURE(*STRING pJSONString,*QUEUE pJSONArray, STRING pPicture, LONG parrayStart, LONG parrayEnd),PROTECTED
FromJSONFile                 PROCEDURE(STRING fileName,*QUEUE pJSONArray),BYTE,PROC
FromJSONFile                 PROCEDURE(STRING fileName,*GROUP pJSONArray),BYTE,PROC
FromFile                     PROCEDURE(STRING fileName),BYTE,PROTECTED
!region subqueue
AddSubQueue                  PROCEDURE(STRING queueName,*QUEUE queueReference)
ClearSubQueues               PROCEDURE()
IsSubQueue                   PROCEDURE(STRING queueName),BYTE
SetSubQueue                  PROCEDURE(STRING queueName,*QUEUE queueReference)
!endregion
!region JSON Object
ClearObject                  PROCEDURE()
ClearObjectArray             PROCEDURE()
GetObjectIsArray             PROCEDURE(),BYTE
ClearObject                  PROCEDURE(*JSONDataValueQueue jsonQueue),PROTECTED
GetGroupNumberOfFields       PROCEDURE(*GROUP jsonGroup), LONG
GetGroupSize                 PROCEDURE(*GROUP jsonGroup), LONG
GetGroupMaxSize              PROCEDURE(*GROUP jsonGroup), LONG
GetJSONObjectSize            PROCEDURE(), LONG, PROTECTED
ToJSON                       PROCEDURE(),STRING
ToJSONFile                   PROCEDURE(STRING fileName),BYTE,PROC
AddString                    PROCEDURE(STRING name, STRING value)
AddBool                      PROCEDURE(STRING name, BYTE value)
AddNumber                    PROCEDURE(STRING name, LONG value)
AddNumber                    PROCEDURE(STRING name, LONG value, STRING picture)
AddGroup                     PROCEDURE(STRING name, *GROUP value)
AddQueue                     PROCEDURE(STRING name, *QUEUE value)
AddGroup                     PROCEDURE(*GROUP value)
!endregion
!region JSON String Parsing
TryGetName                   PROCEDURE(STRING pJSONString, *STRING name),BYTE,PROC
TryGetValue                  PROCEDURE(STRING pJSONString, *STRING value),BYTE,PROC
TryGetNameValue              PROCEDURE(STRING pJSONString,*STRING name, *STRING value),BYTE,PROC
TryGetNameValuePositions     PROCEDURE(*STRING pJSONString,*LONG nameStart,*LONG nameEnd,*LONG valueStart,*LONG valueEnd),BYTE
TryGetNextPairPositions      PROCEDURE(*STRING pJSONString,*LONG pairStart,*LONG pairEnd,*LONG nameStart,*LONG nameEnd,*LONG valueStart,*LONG valueEnd),BYTE
TryGetNextPairPositions      PROCEDURE(*STRING pJSONString, LONG itemEnd,*LONG pairStart,*LONG pairEnd,*LONG nameStart,*LONG nameEnd,*LONG valueStart,*LONG valueEnd),BYTE
TryGetNextArrayItemPositions PROCEDURE(*STRING pJSONString,*LONG arrayStart,*LONG arrayEnd,*LONG itemStart,*LONG itemEnd),BYTE
GetValueType                 PROCEDURE(*STRING pJSONString, LONG valueStart,LONG valueEnd),UNSIGNED
AssignANY                    PROCEDURE(*STRING pJSONString,*ANY lCurrentField,BYTE lType,STRING pJQPicture,*LONG pvalueStart,*LONG pvalueEnd),PROTECTED
AssignGroupField             PROCEDURE(*STRING pJSONString,*GROUP pJSONObject,*LONG pnameStart,*LONG pnameEnd,*LONG pvalueStart,*LONG pvalueEnd),PROTECTED
AssignGroupFieldIdx          PROCEDURE(*STRING pJSONString,*GROUP pJSONObject,STRING pJQPicture,LONG pGroupItemIndex ,*LONG pvalueStart,*LONG pvalueEnd),PROTECTED
!endregion
                    END

_EndOfInclude_                    