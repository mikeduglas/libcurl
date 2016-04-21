 MEMBER

  PRAGMA ('link (C%V%DOS%X%%L%.LIB)')

 INCLUDE ('ERRORS.CLW')
 INCLUDE ('JSON.INC'),ONCE
  MAP
     !_TRACE(STRING sDbgMessage)
    json::DebugInfo(STRING s)
    MODULE('winapi')
         __OutPutDebugString( *CSTRING szMsg ), RAW, PASCAL, DLL(TRUE), NAME('OutPutDebugStringA')        
     END
  END

json::DebugInfo               PROCEDURE(STRING s)
prefix                          STRING('[JSON] ')
cs                              CSTRING(LEN(s) + LEN(prefix) + 1)
  CODE
  cs = prefix & s
  __OutPutDebugString(cs)

!_TRACE                    PROCEDURE(STRING sDbgMessage)
!szMessage         CSTRING(2048)
!lMsgLen           LONG
!szOutPut          CSTRING(124)
!lMsgPtr           LONG
! CODE
!    szMessage = CLIP( sDbgMessage )
!    lMsgLen = LEN( CLIP( szMessage ) )
!    IF lMsgLen <= 120
!      szMessage = CLIP( szMessage ) & '<10><13>'
!      __OutPutDebugString( szMessage )
!    ELSE
!      szOutPut = szMessage[ 1 : 120 ] & '<10><13>'
!      __OutPutDebugString( szOutPut )
!      lMsgPtr = 121
!      LOOP
!        IF lMsgPtr >= lMsgLen
!          BREAK
!        END
!        IF lMsgPtr + 120 > lMsgLen
!          szOutPut = szMessage[ lMsgPtr : lMsgLen ] & '<10><13>'
!          __OutPutDebugString( szOutPut )
!          BREAK
!        ELSE
!          szOutPut = szMessage[ lMsgPtr : lMsgPtr + 120 ] & '<10><13>'
!          __OutPutDebugString( szOutPut )
!        END
!        lMsgPtr += 121
!      END
!      szOutPut = '<10><13>'
!      __OutPutDebugString( szOutPut )
!    END



JSONDataClass.Construct PROCEDURE()
  CODE
     SELF.JSONObject &= new JSONDataValueQueue
     SELF.formatter   &= new JSONDataPicturesQueue
     SELF.externalNames  &= new JSONDataPicturesQueue
     SELF.hiddenNames    &= new JSONDataPicturesQueue
     SELF.QofQ &= new JSONQueueOfQueue
     
     SELF._UseEscapeString = true
     SELF.clipValues = true
     SELF.SetLostArrayDataField('')
 
JSONDataClass.Destruct PROCEDURE()
  CODE
  	SELF.DisposeIt()

JSONDataClass.DisposeIt PROCEDURE()
idx LONG
 CODE
    IF NOT SELF.JSONObject &= NULL
       SELF.ClearObject(SELF.JSONObject)
       DISPOSE(SELF.JSONObject)
    END
    IF NOT SELF.formatter &= NULL
       FREE(SELF.formatter)
       DISPOSE(SELF.formatter)
    END
    IF NOT SELF.externalNames &= NULL
       FREE(SELF.externalNames)
       DISPOSE(SELF.externalNames)
    END    
    IF NOT SELF.hiddenNames &= NULL
       FREE(SELF.hiddenNames)
       DISPOSE(SELF.hiddenNames)
    END    
    SELF.DisposeTmpString()
    IF NOT SELF._EscapedString &=  NULL
       DISPOSE(SELF._EscapedString)
    END
    IF NOT SELF.QofQ &= NULL
       FREE(SELF.QofQ)
       DISPOSE(SELF.QofQ)
    END

JSONDataClass.CreateNewTmpString           PROCEDURE(LONG strSize)
 CODE
    SELF.DisposeTmpString()
    SELF.retValTmp &= new STRING(strSize)    

JSONDataClass.DisposeTmpString               PROCEDURE()
 CODE
    IF NOT SELF.retValTmp &=  NULL
       DISPOSE(SELF.retValTmp)
    END

JSONDataClass.AssignRefTmpString              PROCEDURE(*STRING strRefValue)
 CODE
 	  SELF.DisposeTmpString()
 	  SELF.retValTmp &= strRefValue

JSONDataClass.GetTmpStringValue            PROCEDURE()
 CODE
 	  IF NOT SELF.retValTmp &=  NULL
 	  	 RETURN CLIP(SELF.retValTmp)
 	  ELSE
 	  	 RETURN ''
 	  END
JSONDataClass.ClearObject                     PROCEDURE()
 CODE
    SELF.ClearObject(SELF.JSONObject)
    FREE(SELF.formatter)
    FREE(SELF.externalNames)
    SELF._ObjectIsArray = FALSE
    
JSONDataClass.ClearObject                     PROCEDURE(*JSONDataValueQueue jsonQueue)
idx LONG
 CODE
    SELF.SetLostArrayDataField('')
    IF NOT jsonQueue &= NULL
       LOOP idx = 1 TO RECORDS(jsonQueue)
            GET(jsonQueue, idx)
            IF ERRORCODE()
               BREAK
            END
            DISPOSE(jsonQueue.Value)
       END
       FREE(jsonQueue)
    END
    SELF.JSONObjectSize = 0

JSONDataClass.ClearObjectArray                     PROCEDURE()
 CODE
    SELF.ClearObject()
    SELF._ObjectIsArray = TRUE
    
JSONDataClass.GetObjectIsArray             PROCEDURE()
 CODE
    RETURN SELF._ObjectIsArray

JSONDataClass.SetLostArrayDataField        PROCEDURE(STRING fieldName)
 CODE
    IF CLIP(fieldName)
       SELF._LostArrayData = true
       SELF._LostArrayDataField = CLIP(fieldName)
    ELSE
       SELF._LostArrayData = false
       SELF._LostArrayDataField = ''
    END

JSONDataClass.GetLostArrayData             PROCEDURE()
 CODE
    RETURN SELF._LostArrayData
    
JSONDataClass.GetLostArrayDataField        PROCEDURE()
 CODE
    RETURN SELF._LostArrayDataField

JSONDataClass.SetClipValues             PROCEDURE(BYTE value)
 CODE
    IF value
       SELF.clipValues = true
    ELSE
       SELF.clipValues = false
    END

JSONDataClass.GetClipValues             PROCEDURE()
 CODE
    RETURN SELF.clipValues

JSONDataClass.SetRemoveFieldPrefix         PROCEDURE(BYTE value)
 CODE
    IF value
       SELF._RemoveFieldPrefix = true
    ELSE
       SELF._RemoveFieldPrefix = false
    END

JSONDataClass.GetRemoveFieldPrefix         PROCEDURE()
 CODE
     RETURN SELF._RemoveFieldPrefix

JSONDataClass.SetSupportNullString         PROCEDURE(BYTE value)
 CODE
    IF value
       SELF._SupportNullString = true
    ELSE
       SELF._SupportNullString = false
    END
 
JSONDataClass.GetSupportNullString         PROCEDURE()
 CODE
     RETURN SELF._SupportNullString

JSONDataClass.SetEscapeString              PROCEDURE(BYTE value)
 CODE
    IF value
       SELF._UseEscapeString = true
    ELSE
       SELF._UseEscapeString = false
    END
    
JSONDataClass.GetEscapeString              PROCEDURE()
 CODE
    RETURN SELF._UseEscapeString

JSONDataClass.UnEscapeString            PROCEDURE(STRING value)
UnEscChar       STRING(1),AUTO
EscChar         STRING(10),AUTO
LenEscChar      BYTE,AUTO

lSLen           ULONG,AUTO
lOriginalSLen   ULONG,AUTO
SAux1           &STRING
SAux2           &STRING

lIndex          ULONG,AUTO
lLastIndex      ULONG,AUTO
indexQ          QUEUE
i                ULONG
                END
lI              ULONG,AUTO  
tFound          ULONG,AUTO
lIndex1         ULONG,AUTO
lIndex2         ULONG,AUTO
lSubLen         ULONG,AUTO
 CODE
    SAux1 &= SELF._EscapedString

    IF NOT SAux1 &= NULL
       DISPOSE(SAux1)
    END

    lSLen = LEN(Value)
    lOriginalSLen = lSLen
    SAux1 &= NEW(STRING(lSLen))
    SAux1 = Value

    UnEscChar = '"'
    EscChar   = '\"'
    LenEscChar= 2
    Do ReplaceEscChar

    UnEscChar = CHR(13)
    EscChar   = '\r'
    LenEscChar= 2
    Do ReplaceEscChar

    UnEscChar = CHR(10)
    EscChar   = '\n'
    LenEscChar= 2
    Do ReplaceEscChar

    UnEscChar = '\'
    EscChar   = '\\'
    LenEscChar= 2
    Do ReplaceEscChar

    SELF._EscapedString &= SAux1
    RETURN SAux1[1:lSLen]

ReplaceEscChar   ROUTINE
    lLastIndex = 1
    FREE(indexQ)
    LOOP
       lIndex = INSTRING(EscChar[1:(LenEscChar)],SAux1,1,lLastIndex)
       IF lIndex THEN
          indexQ.i = lIndex
          ADD(indexQ)
          lLastIndex = lIndex + 1
       ELSE
          BREAK
       END
    END
    tFound = RECORDS(indexQ)
    IF tFound>0
       SAux2 &= NEW(STRING(lSLen - (tFound * LenEscChar) + tFound))
       lIndex1 = 1
       lLastIndex = 0
       LOOP lI = 1 TO RECORDS(indexQ)
            GET(indexQ,lI)
            IF NOT ERRORCODE()
               lSubLen = indexQ.i - lLastIndex - 1
               lIndex2 = lIndex1 + lSubLen 
               SAux2[lIndex1 : lIndex2] = SUB(SAux1, lLastIndex + 1 ,lSubLen) & UnEscChar
               lLastIndex = indexQ.i
               lIndex1 = lIndex2
            END
       END
       !from last to end
       IF lLastIndex < lSLen
          SAux2[lIndex1 : LEN(SAux2)] = SAux1[(lLastIndex+1) : lSLen]
       END
       lSLen = lSLen - (tFound * LenEscChar) + tFound 
       DISPOSE(SAux1)
       SAux1 &= SAux2
    END


JSONDataClass.EscapeString              PROCEDURE(STRING value)
CharToReplace   STRING(1),AUTO
ReplacedBy      STRING(10),AUTO
LenReplacedBy   BYTE,AUTO
lIndex          ULONG,AUTO
lLastIndex      ULONG,AUTO
lIndex1         ULONG,AUTO
lIndex2         ULONG,AUTO
lSubLen         ULONG,AUTO

lReplaced       BYTE,AUTO
lSLen           ULONG,AUTO
lOriginalSLen   ULONG,AUTO
SAux1           &STRING
SAux2           &STRING
indexQ          QUEUE
i                ULONG
                END
lI              ULONG,AUTO  
tFound          ULONG,AUTO
 CODE
    IF LEN(CLIP(value)) = 0
       RETURN ''
    END
    IF NOT SELF._UseEscapeString
       RETURN value
    END
    
    SAux1 &= SELF._EscapedString

    IF NOT SAux1 &= NULL
       DISPOSE(SAux1)
    END

    lSLen = LEN(Value)
    lOriginalSLen = lSLen
    SAux1 &= NEW(STRING(lSLen))
    SAux1 = Value
    
    CharToReplace= '\'
    ReplacedBy   = '\\'
    LenReplacedBy= 2
    Do ReplaceOneChar
 
    CharToReplace= '"'
    ReplacedBy   = '\"'
    LenReplacedBy= 2
    Do ReplaceOneChar

    CharToReplace= CHR(13)
    ReplacedBy   = '\r'
    LenReplacedBy= 2
    Do ReplaceOneChar

    CharToReplace= CHR(10)
    ReplacedBy   = '\n'
    LenReplacedBy= 2
    Do ReplaceOneChar

    SELF._EscapedString &= SAux1
    RETURN SAux1[1:lSLen]

ReplaceOneChar   ROUTINE
    lLastIndex = 1
    FREE(indexQ)
    LOOP
       lIndex = INSTRING(CharToReplace,SAux1,1,lLastIndex)
       IF lIndex THEN
          indexQ.i = lIndex
          ADD(indexQ)
          lLastIndex = lIndex + 1
       ELSE
          BREAK
       END
    END
    tFound = RECORDS(indexQ)
    IF tFound>0
       SAux2 &= NEW(STRING(lSLen - tFound + (tFound * LenReplacedBy)))
       lIndex1 = 1
       lLastIndex = 0
       LOOP lI = 1 TO RECORDS(indexQ)
            GET(indexQ,lI)
            IF NOT ERRORCODE()
               lSubLen = indexQ.i - lLastIndex - 1
               lIndex2 = lIndex1 + lSubLen + LenReplacedBy - 1
               SAux2[lIndex1 : lIndex2] = SUB(SAux1, lLastIndex + 1 ,lSubLen) & ReplacedBy[1:LenReplacedBy]
               lLastIndex = indexQ.i
               lIndex1 = lIndex2+LenReplacedBy - 1
            END
       END
       !from last to end
       IF lLastIndex < lSLen
          SAux2[lIndex1 : LEN(SAux2)] = SAux1[(lLastIndex+1) : lSLen]
       END
       lSLen = lSLen - tFound + (tFound * LenReplacedBy)
       DISPOSE(SAux1)
       SAux1 &= SAux2
    END
    
    
JSONDataClass.StringToJSON              PROCEDURE(STRING name, STRING value)
lVT      BYTE
lPicture CSTRING(256)
 CODE
    IF SELF.GetSupportNullString() AND CLIP(value)='' AND SELF.GetFormatterPicture(name) = '@NULL'
       IF CLIP(name)
          RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": null'
       ELSE
          RETURN 'null'
       END
    ELSE
       lVT = SELF.GetStringType(value)
       IF lVT =  JSONDataType:Bool OR lVT = JSONDataType:Array OR lVT = JSONDataType:Object OR lVT = JSONDataType:Number
          IF CLIP(name)
             IF lVT = JSONDataType:Number
                IF SELF.TryGetFormatterPicture(name,lPicture)
                   IF lPicture = '@STRING'
                      RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": "'& CLIP(value)&'"'
                   ELSE
                      IF lPicture = '@BOOL'
                         RETURN SELF.BoolToJSON(name, CHOOSE(value<>'' AND CLIP(value)<>'0', true,false))
                      ELSE
                         RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": "'& FORMAT(CLIP(value), lPicture) &'"'
                      END
                   END
                ELSE
                   !Numbers will always be clipped
                   RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": '& CLIP(value)
                END
             ELSE
                IF SELF.clipValues
                   RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": '& CLIP(value)
                ELSE
                   RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": '& value
                END                
             END
          ELSE
             IF SELF.clipValues
                RETURN CLIP(value)
             ELSE
                RETURN value
             END
          END
       ELSE
          IF CLIP(name)
             IF SELF.clipValues
                RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": "'& CLIP(SELF.EscapeString(CLIP(value)))&'"'
             ELSE
                RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": "'& SELF.EscapeString(value)&'"'
             END
          ELSE
             IF SELF.clipValues
                RETURN '"'& CLIP(SELF.EscapeString(CLIP(value)))&'"'
             ELSE
                RETURN '"'& SELF.EscapeString(value)&'"'
             END
          END
       END    
    END
    
JSONDataClass.BoolToJSON                PROCEDURE(STRING name, BYTE value)
 CODE
    IF CLIP(name)
       IF value
          RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": true'
       ELSE
          RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": false'
       END
    ELSE
       IF value
          RETURN 'true'
       ELSE
          RETURN 'false'
       END
    END
    
JSONDataClass.DecimalToJSON             PROCEDURE(STRING name, *DECIMAL value)
 CODE
    IF CLIP(name)
       RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": '& value
    ELSE
       RETURN value
    END
 
JSONDataClass.NumberToJSON              PROCEDURE(STRING name, LONG value)
 CODE   
    RETURN SELF.NumberToJSON(name, value, SELF.GetFormatterPicture(name))   

JSONDataClass.NumberToJSON      PROCEDURE(STRING name, *ANY value, STRING picture)
 CODE
    IF CLIP(name)
       IF CLIP(picture)
          IF picture = '@BOOL'
             IF value
                RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": true'
             ELSE
                RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": false'
             END
          ELSE
             RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": "'& FORMAT(value, picture) &'"'
          END
       ELSE
          RETURN '"'&SELF.EscapeString(SELF.GetFieldName(name)) &'": '& value
       END
    ELSE
       IF CLIP(picture)
          IF picture = '@BOOL'
             IF value
                RETURN 'true'
             ELSE
                RETURN 'false'
             END
          ELSE
             RETURN '"'& FORMAT(value, picture) &'"'
          END
       ELSE
          RETURN value
       END
    END

JSONDataClass.ToJSON                    PROCEDURE(*BYTE[] values)
retLen LONG,AUTO
retVal CSTRING(8192)
idx    LONG,AUTO
 CODE
    retLen = MAXIMUM(values,1)
    idx = 1
    LOOP idx = 1 to retLen
         IF values[idx]>0
            retVal = CLIP(retVal) & ', true'
         ELSE
            retVal = CLIP(retVal) & ', false'
         END
    END
    return '[' &CLIP(retVal)& ']'


JSONDataClass.ToJSON                    PROCEDURE(*LONG[] values)
 CODE
    RETURN SELF.LongArrToJSON(values)
    
JSONDataClass.ToJSON                    PROCEDURE(*STRING[] values)
 CODE
    RETURN SELF.StringArrToJSON(values)
    
JSONDataClass.LongArrToJSON             PROCEDURE(*LONG[] values)
retLen LONG,AUTO
retVal CSTRING(8192)
idx    LONG,AUTO
 CODE
    retLen = MAXIMUM(values,1)
    idx = 1
    LOOP idx = 1 to retLen
         retVal = CLIP(retVal) & ', ' & values[idx]
    END
    RETURN '[' &CLIP(retVal)& ']'

JSONDataClass.StringArrToJSON           PROCEDURE(*STRING[] values)
retLen LONG,AUTO
retVal CSTRING(64000)
idx    LONG,AUTO
 CODE
    retLen = MAXIMUM(values,1)
    idx = 1
    LOOP idx = 1 to retLen
         IF SELF.GetSupportNullString() AND CLIP(values[idx])=''
            retVal = CLIP(retVal) & ', null'
         ELSE
            retVal = CLIP(retVal) & ', ' & '"'& SELF.EscapeString(values[idx])&'"'
         END
    END
    RETURN '[' &CLIP(retVal)& ']'

JSONDataClass.GetGroupNumberOfFields       PROCEDURE(*GROUP jsonGroup)
idx       LONG,AUTO
dimx      LONG,AUTO
JQName    CSTRING(256)!MAX Name size is 256
 CODE
    idx = 1
    LOOP
       JQName = WHO(jsonGroup, idx)          
       IF JQName=''
          BREAK
       END
       idx+=1
    END
    RETURN idx

JSONDataClass.GetGroupMaxSize              PROCEDURE(*GROUP jsonGroup)
idx       LONG,AUTO
totalSize LONG,AUTO
JQName    CSTRING(256)!MAX Name size is 256
innerGroup &GROUP
dimx      LONG,AUTO
idimx     LONG,AUTO
 CODE
    totalSize = 0!SIZE(jsonGroup)
    idx = 1
    LOOP
       JQName = WHO(jsonGroup, idx)          
       IF JQName=''
          IF totalSize>0
             totalSize -= 2 !remove the last separator
          END
          BREAK
       END
       totalSize += LEN(SELF.GetFieldName(JQName)) + 2 + 2!name has double quote and a separator ': '
       dimx = HOWMANY(jsonGroup, idx)
       IF dimx = 1
          IF ISGROUP(jsonGroup, idx)
             innerGroup &= GETGROUP(jsonGroup, idx)
             totalSize += SELF.GetGroupMaxSize(innerGroup)
          ELSE
             IF ISSTRING(WHAT(jsonGroup, idx))
                totalSize += SIZE(WHAT(jsonGroup, idx)) + 2 +4!string double quote
             ELSE
                IF SELF.IsSubQueue(JQName)
                   totalSize += (SELF.GetGroupMaxSize(SELF.QofQ.Q) * RECORDS(SELF.QofQ.Q)) + 2
                ELSE
                   totalSize += 20 !and int size to string is no more than 20
                END
             END
          END
       ELSE
          !DIM will be translated to and array of type: 
          !"NAME": [val1, val2, ...]
          IF ISGROUP(jsonGroup, idx)
             innerGroup &= GETGROUP(jsonGroup, idx, 1)
             totalSize += SELF.GetGroupMaxSize(innerGroup)
          ELSE
             IF ISSTRING(WHAT(jsonGroup, idx,1))
                LOOP IdimX = 1 to dimx
                     totalSize += 2 + SIZE(WHAT(jsonGroup, idx, IdimX)) + 2 +4!string double quote
                END                
             ELSE
                totalSize += (dimx * 2) + (20 * dimx)!and int size to string is no more than 20
             END
          END
       END
       totalSize += 2 !add separator ', '
       idx+=1
    END
    RETURN totalSize+2! add the open and close curlibraces

JSONDataClass.GetGroupSize              PROCEDURE(*GROUP jsonGroup)
idx        LONG,AUTO
dimx       LONG,AUTO
idimx      LONG,AUTO
totalSize  LONG,AUTO
JQName     CSTRING(256)!MAX Name size is 256
lPicture   CSTRING(256)!MAX Name size is 256
innerGroup &GROUP
 CODE
    !Note missing recursion in the GROUP using WHAT 
    !and taking references to strings and or nested groups into account
    totalSize = 0!SIZE(jsonGroup)
    idx = 1
    LOOP
       dimx = 1
       JQName = WHO(jsonGroup, idx)          
       IF JQName=''
          IF totalSize>0
             totalSize -= 2 !remove the last separator
          END
          BREAK
       END
       dimx = HOWMANY(jsonGroup, idx)
       totalSize += LEN(SELF.GetFieldName(JQName)) + 2 + 2!name has double quote and a separator ': '
       IF dimx = 1
          IF ISGROUP(jsonGroup, idx)
             innerGroup &= GETGROUP(jsonGroup, idx)
             totalSize += SELF.GetGroupSize(innerGroup)
          ELSE          
             IF ISSTRING(WHAT(jsonGroup, idx))
                IF SELF.TryGetFormatterPicture(JQName, lPicture) AND lPicture<>'@STRING' AND lPicture<>'@BOOL' AND lPicture<>'@NULL'
                   totalSize += LEN(FORMAT(WHAT(jsonGroup, idx), lPicture)) + 2 +4!string double quote
                ELSE                
                   totalSize += LEN(WHAT(jsonGroup, idx)) + 2 +4!string double quote
                END
             ELSE
                IF SELF.IsSubQueue(JQName)
                   totalSize += (SELF.GetGroupSize(SELF.QofQ.Q) * RECORDS(SELF.QofQ.Q)) + 2
                ELSE
                   totalSize += 20 !and int size to string is no more than 20                
                END
             END
          END
          totalSize += 2 !add separator ', '
       ELSE
          !DIM will be translated to and array of type: 
          !"NAME": [val1, val2, ...]
          totalSize += 2! the open close curlly braces'[]'
          IF ISGROUP(jsonGroup, idx)
             innerGroup &= GETGROUP(jsonGroup, idx, 1)
             totalSize += (dimx * 2) + (SELF.GetGroupSize(innerGroup) * dimx) !add the ', ' separing each array item
          ELSE          
             IF ISSTRING(WHAT(jsonGroup, idx))
                LOOP IdimX = 1 to dimx
                     totalSize += 2 + (LEN(WHAT(jsonGroup, idx, IdimX)) + 2) +4!string double quote               
                END
             ELSE
                totalSize += (dimx * 2) + (20 * dimx)!and int size to string is no more than 20
             END
          END
          totalSize += 2 !add separator ', '
       END
       idx+=1
    END
    RETURN totalSize+2! add the open and close curlibraces

JSONDataClass.ToJSON                    PROCEDURE(*GROUP JSONObject)
retJsonValueSize    LONG,AUTO
lretVal &STRING
 CODE
    retJsonValueSize = SELF.GetGroupSize(JSONObject)
    lretVal &= new STRING(retJsonValueSize)
    IF SELF.GroupToJSON(JSONObject, lretVal)
       SELF.AssignRefTmpString(lretVal)
       RETURN SELF.GetTmpStringValue()
    ELSE
       DISPOSE(lretVal)
       SELF.CreateNewTmpString(1)
       RETURN ''
    END
    
JSONDataClass.GroupToJSON               PROCEDURE(*GROUP JSONObject,*STRING retVal)
lFirst              BYTE,AUTO
idx                 LONG,AUTO
JQName              CSTRING(256)
retIdx              LONG,AUTO
retJsonValueSize    LONG,AUTO
fieldSize           LONG,AUTO
innerGroup &GROUP
innerIdx   LONG,AUTO
innerHowMany LONG,AUTO

ljPicture STRING(50),AUTO

lGroupRetVal &STRING
lIsHidden BYTE
dimx      LONG,AUTO
idimx     LONG,AUTO
retValQ &STRING
 CODE
    IF ADDRESS(JSONObject) = 0
       RETURN false
    ELSE
       idx = 1
       retIdx = 1
       lFirst = true
       LOOP
          JQName = WHO(JSONObject, idx)
          IF JQName=''
             BREAK
          ELSE
             dimx = HOWMANY(JSONObject, idx)
             
             lIsHidden = SELF.IsHiddenGroupField(JQName)
             IF ISGROUP(JSONObject, idx)
                IF NOT lIsHidden
                   IF dimx > 1
                      !DIM will be translated to and array of type: 
                      !"NAME": [val1, val2, ...]
                      innerGroup &= GETGROUP(JSONObject, idx, 1)
                      retJsonValueSize = SELF.GetGroupMaxSize(innerGroup)
                      lGroupRetVal &= new STRING(retJsonValueSize)
                      
                      IF lFirst
                         retVal = '"'&SELF.GetFieldName(JQName)&'": ['
                      ELSE
                         retVal = CLIP(retVal)&', '&'"'&SELF.GetFieldName(JQName)&'": ['
                      END

                      LOOP idimx = 1 TO dimx
                         innerGroup &= GETGROUP(JSONObject, idx, idimx)
                         IF SELF.GroupToJSON(innerGroup,lGroupRetVal)
                            IF idimx = 1
                               retVal = CLIP(retVal) & CLIP(lGroupRetVal)
                            ELSE
                               retVal = CLIP(retVal) & ', '&CLIP(lGroupRetVal)
                            END
                         END
                      END
                      DISPOSE(lGroupRetVal)
                      retVal = CLIP(retVal) & ']'
                   ELSE
                         innerGroup &= GETGROUP(JSONObject, idx)
                         retJsonValueSize = SELF.GetGroupMaxSize(innerGroup)
                         lGroupRetVal &= new STRING(retJsonValueSize)
                         IF SELF.GroupToJSON(innerGroup,lGroupRetVal)
                            IF lFirst
                               retVal = '"'&SELF.GetFieldName(JQName)&'": '&CLIP(lGroupRetVal)
                            ELSE
                               retVal = CLIP(retVal)&', '&'"'&SELF.GetFieldName(JQName)&'": '&CLIP(lGroupRetVal)
                            END
                         END
                         DISPOSE(lGroupRetVal) 
                   END
                END
                innerIdx = 1
                LOOP
                   IF WHO(innerGroup, innerIdx) = ''
                      innerIdx-=1
                      BREAK
                   END
                   innerIdx+=1
                END
                idx += innerIdx
             ELSE
             !IS Not GROUP
                IF NOT lIsHidden
                   IF dimx = 1
                     IF SELF.IsSubQueue(JQName)
                         IF lFirst
                            retVal = '"'&CLIP(JQName)&'": '&SELF.ToJSON(SELF.QofQ.Q)
                         ELSE
                            retVal = CLIP(retVal)&', "'& CLIP(JQName)&'": '&SELF.ToJSON(SELF.QofQ.Q)
                         END
                     ELSE
                         IF lFirst
                            retVal = SELF.PairToJSON(JQName, WHAT(JSONObject, idx))
                         ELSE
                            retVal = CLIP(retVal)&', '&SELF.PairToJSON(JQName, WHAT(JSONObject, idx))
                         END
                      END
                   ELSE
                      !DIM will be translated to and array of type: 
                      !"NAME": [val1, val2, ...]
                      IF lFirst
                         retVal = '"'&SELF.GetFieldName(JQName)&'": ['
                      ELSE
                         retVal = CLIP(retVal)&', '&'"'&SELF.GetFieldName(JQName)&'": ['
                      END
                      LOOP idimx = 1 TO dimx
                          !Only STRING or CSTRING could be empty, any LONG/SHORT/BYTE will be 0 and all the array will be displayed.
                          IF CLIP(WHAT(JSONObject, idx, idimx))=''
                             BREAK
                          END
                          IF idimx = 1
                             retVal = CLIP(retVal) & SELF.PairToJSON('', WHAT(JSONObject, idx, idimx), SELF.GetFormatterPicture(JQName))
                          ELSE
                             retVal = CLIP(retVal) & ', '&SELF.PairToJSON('', WHAT(JSONObject, idx, idimx), SELF.GetFormatterPicture(JQName))
                          END
                      END
      
                      retVal = CLIP(retVal) & ']'
                   END
                END
             END
          END
          idx+=1
          IF lFirst AND NOT lIsHidden
             lFirst = false
          END
       END!Loop
       
       retVal = '{{'&CLIP(retVal)&'}'
       RETURN true
    END

JSONDataClass.PairToJSON                PROCEDURE(STRING JsonPairName, ? JsonPairValue)
 CODE   
    RETURN SELF.PairToJSON(JsonPairName, JsonPairValue, SELF.GetFormatterPicture(JsonPairName))
    
JSONDataClass.PairToJSON                PROCEDURE(STRING JsonPairName, ? JsonPairValue, STRING ljPicture)
 CODE
    IF ISSTRING(JsonPairValue)               
       RETURN SELF.StringToJSON(JsonPairName, JsonPairValue)
    ELSE
       !This should be  number
      IF CLIP(ljPicture)      
         RETURN SELF.NumberToJSON(JsonPairName, JsonPairValue,CLIP(ljPicture))
      ELSE
         IF INT(ABS(JsonPairValue))<ABS(JsonPairValue)
            !Is DECIMAL
            RETURN SELF.StringToJSON(JsonPairName, JsonPairValue)
         ELSE
            RETURN SELF.NumberToJSON(JsonPairName, JsonPairValue)
         END
      END
    END
    RETURN ''

JSONDataClass.ToJSON                    PROCEDURE(*QUEUE JSONArray)
 CODE
    RETURN SELF.ToJSON('', JSONArray)
    
JSONDataClass.ToJSON                    PROCEDURE(STRING JSONArrayName, *QUEUE JSONArray)
 CODE
    RETURN SELF.ToJSON(JSONArrayName, JSONArray, 0 , 0)
 
JSONDataClass.ToJSON                       PROCEDURE(*QUEUE pJSONArray,LONG pStartRecord, LONG pEndRecord)
 CODE
    RETURN SELF.ToJSON('', pJSONArray, pStartRecord, pEndRecord)

JSONDataClass.ToJSON                       PROCEDURE(STRING pJSONArrayName, *QUEUE pJSONArray,LONG pStartRecord, LONG pEndRecord)
idx  LONG,AUTO
idxFirst  LONG,AUTO
recs LONG,AUTO
retJsonValueSize        LONG,AUTO
retVal &STRING
retValG &STRING
lQueueCols LONG,AUTO
 CODE
     IF ADDRESS(pJSONArray) = 0
       RETURN ''
    ELSE
       IF pStartRecord=pEndRecord AND pStartRecord<1
          idxFirst = 1
          recs = RECORDS(pJSONArray)
       ELSE
          IF pEndRecord = 0
             recs = RECORDS(pJSONArray)
          ELSE
             recs = pEndRecord
          END      
       END
       IF pStartRecord>pEndRecord OR recs = 0
          RETURN '[]'
       END       

       lQueueCols=0
       LOOP
          lQueueCols+=1
          IF WHO(pJSONArray, lQueueCols) = ''
             lQueueCols-=1
             BREAK
          END
       END    
       retJsonValueSize = SELF.GetGroupMaxSize(pJSONArray)
       retValG &= new STRING(retJsonValueSize+1)

       retJsonValueSize = SELF.GetGroupMaxSize(pJSONArray)
       retVal &= new STRING(((retJsonValueSize+1) * recs))

       IF lQueueCols=1 AND ISGROUP(pJSONArray, 1) = false
          !Is an array
          LOOP idx = 1 TO recs
               GET(pJSONArray,idx)
               IF ERRORCODE()
                  BREAK
               END               
               retValG = SELF.PairToJSON('',WHAT(pJSONArray, 1))
               IF idx = 1
                   retVal = CLIP(retValG)
               ELSE
                   retVal = CLIP(retVal) & ',' & CLIP(retValG)
               END
          END
       ELSE      
          LOOP idx = 1 TO recs
               GET(pJSONArray,idx)
               IF ERRORCODE()
                  BREAK
               END
               IF SELF.GroupToJSON(pJSONArray, retValG)
                  IF idx = 1
                      retVal = CLIP(retValG)
                  ELSE
                      retVal = CLIP(retVal) & ',' & CLIP(retValG)
                  END
               END            
          END
       END

       DISPOSE(retValG)
       SELF.AssignRefTmpString(retVal)
       IF CLIP(pJSONArrayName)<>''
          RETURN '{{"'&SELF.GetFieldName(pJSONArrayName)&'": ['&SELF.GetTmpStringValue()&']}'
       ELSE
          RETURN '['&SELF.GetTmpStringValue()&']'
       END
    END

JSONDataClass.AddString                 PROCEDURE(STRING name, STRING value)
 CODE
    IF SELF.GetObjectIsArray() = True
       ASSERT(false,'The method AddString(name,value) can only be call if the Object is NOT an Array.|Calling ClearObjectArray method is setting the object as an array.|You should call the ClearObject method.')
       RETURN
    END
    SELF.JSONObject.Name = CLIP(name)
    SELF.JSONObject.Value &= new STRING(SIZE(value)+100)
    IF SELF.GetSupportNullString() AND CLIP(value)='' AND SELF.GetFormatterPicture(name) = '@NULL'
       SELF.JSONObject.Value = 'null'
    ELSE    
       IF SELF.clipValues
          SELF.JSONObject.Value = '"'&CLIP(SELF.EscapeString(CLIP(value)))&'"'
       ELSE
          SELF.JSONObject.Value = '"'&SELF.EscapeString(value)&'"'
       END
    END
    SELF.JSONObjectSize += LEN(SELF.JSONObject.Name) + LEN(SELF.JSONObject.Value)
    ADD(SELF.JSONObject)
    
JSONDataClass.AddBool                   PROCEDURE(STRING name, BYTE value)
 CODE
    IF SELF.GetObjectIsArray() = True
       ASSERT(false,'The method AddBool(name,value) can only be call if the Object is NOT an Array.|Calling ClearObjectArray method is setting the object as an array.|You should call the ClearObject method.')
       RETURN
    END
    SELF.JSONObject.Name = CLIP(name)
    IF value > 0
       SELF.JSONObject.Value &= new STRING(4)
       SELF.JSONObject.Value = 'true'
    ELSE
       SELF.JSONObject.Value &= new STRING(5)
       SELF.JSONObject.Value = 'false'
    END
    SELF.JSONObjectSize += LEN(SELF.JSONObject.Name) + LEN(SELF.JSONObject.Value)
    ADD(SELF.JSONObject)

JSONDataClass.AddNumber                 PROCEDURE(STRING name, LONG value)
snum CSTRING(14)
 CODE
    IF SELF.GetObjectIsArray() = True
       ASSERT(false,'The method AddNumber(name,value) can only be call if the Object is NOT an Array.|Calling ClearObjectArray method is setting the object as an array.|You should call the ClearObject method.')
       RETURN
    END
    SELF.JSONObject.Name = CLIP(name)
    snum = value   
    SELF.JSONObject.Value &= new STRING(LEN(CLIP(snum)))
    SELF.JSONObject.Value = CLIP(snum)
    SELF.JSONObjectSize += LEN(SELF.JSONObject.Name) + LEN(SELF.JSONObject.Value)
    ADD(SELF.JSONObject)
    
JSONDataClass.AddNumber         PROCEDURE(STRING name, LONG value, STRING picture)
snum CSTRING(100)
 CODE
    IF SELF.GetObjectIsArray() = True
       ASSERT(false,'The method AddNumber(name,value) can only be call if the Object is NOT an Array.|Calling ClearObjectArray method is setting the object as an array.|You should call the ClearObject method.')
       RETURN
    END
    SELF.JSONObject.Name = CLIP(name)
    snum = FORMAT(value, picture)
    SELF.JSONObject.Value &= new STRING(LEN(CLIP(snum)))
    SELF.JSONObject.Value = '"'&CLIP(snum)&'"'
    SELF.JSONObjectSize += LEN(SELF.JSONObject.Name) + LEN(SELF.JSONObject.Value)
    ADD(SELF.JSONObject)

JSONDataClass.AddGroup                  PROCEDURE(STRING name, *GROUP value)
grpLen LONG,AUTO
 CODE
    IF SELF.GetObjectIsArray() = True
       ASSERT(false,'The method AddGroup(name,value) can only be call if the Object is NOT an Array.|Calling ClearObjectArray method is setting the object as an array.|You should call the ClearObject method.')
       RETURN
    END
    SELF.JSONObject.Name = CLIP(name)
    grpLen = SELF.GetGroupSize(value)
    SELF.JSONObject.Value &= new STRING(grpLen)
    SELF.JSONObject.Value = SELF.ToJSON(value)
    SELF.JSONObjectSize += LEN(SELF.JSONObject.Name) + LEN(SELF.JSONObject.Value)
    ADD(SELF.JSONObject)

JSONDataClass.AddGroup                  PROCEDURE(*GROUP value)
grpLen LONG,AUTO
 CODE
    IF SELF.GetObjectIsArray() = FALSE
       ASSERT(false,'The method AddGroup(value) can only be call if the Object is an Array.|Call first the ClearObjectArray method.')
       RETURN
    END
    SELF.JSONObject.Name = ''
    grpLen = SELF.GetGroupSize(value)
    SELF.JSONObject.Value &= new STRING(grpLen)
    SELF.JSONObject.Value = SELF.ToJSON(value)
    SELF.JSONObjectSize += LEN(SELF.JSONObject.Value)
    ADD(SELF.JSONObject)
 
JSONDataClass.AddQueue                  PROCEDURE(STRING name, *QUEUE value)
grpLen LONG,AUTO
recs   LONG,AUTO
totalSize LONG,AUTO
 CODE
    IF SELF.GetObjectIsArray() = True
       ASSERT(false,'The method AddQueue(name,value) can only be call if the Object is NOT an Array.|Calling ClearObjectArray method is setting the object as an array.|You should call the ClearObject method.')
       RETURN
    END
    recs = RECORDS(value)
    SELF.JSONObject.Name = CLIP(name)
    IF recs = 0
       SELF.JSONObject.Value &= new STRING(2)
       SELF.JSONObject.Value = '[]'
    ELSE
       grpLen = SELF.GetGroupMaxSize(value) + 2 !the group size + {}
       totalSize = (grpLen * recs) + recs - 1 + 2 !
       SELF.JSONObject.Value &= new STRING(totalSize)
       SELF.JSONObject.Value = SELF.ToJSON(value)
    END
    SELF.JSONObjectSize += LEN(SELF.JSONObject.Name) + LEN(SELF.JSONObject.Value)
    ADD(SELF.JSONObject)

JSONDataClass.GetJSONObjectSize         PROCEDURE()
recs LONG,AUTO
totalSize LONG,AUTO
 CODE
    totalSize = 0
    recs = RECORDS(SELF.JSONObject)
    totalSize = SELF.JSONObjectSize
    IF NOT SELF.GetObjectIsArray()
       totalSize += (recs * 2) ! the quoates arround the name
    END
    totalSize += ((recs-1) * 2) ! the comman and space between the name and the value    
    RETURN totalSize
    
JSONDataClass.ToJSON                    PROCEDURE()
idx  LONG,AUTO
recs LONG,AUTO
retVal &STRING
 CODE
    retVal &= new STRING(SELF.GetJSONObjectSize())
    recs = RECORDS(SELF.JSONObject)
    LOOP idx = 1 TO recs
         GET(SELF.JSONObject,idx)
         IF ERRORCODE()
            BREAK
         END
         IF SELF.GetObjectIsArray()
            IF idx = 1
               retVal = CLIP(SELF.JSONObject.Value)
            ELSE               
               retVal = CLIP(retVal) & ', ' & CLIP(SELF.JSONObject.Value)
            END
         ELSE
            IF idx = 1
               retVal = '"' & SELF.JSONObject.Name& '": ' & CLIP(SELF.JSONObject.Value)
            ELSE               
               retVal = CLIP(retVal) & ', "' & SELF.JSONObject.Name& '": ' & CLIP(SELF.JSONObject.Value)
            END
         END
    END
    SELF.AssignRefTmpString(retVal)
    IF SELF.GetObjectIsArray()
       RETURN '['&SELF.GetTmpStringValue()&']'
    ELSE
       RETURN '{{'&SELF.GetTmpStringValue()&'}'
    END
    
JSONDataClass.ToJSONFile                   PROCEDURE(STRING fileName)
idx  LONG,AUTO
recs LONG,AUTO
retVal &STRING
JSONDataClass_OutFile FILE,DRIVER('DOS'),CREATE
          RECORD
buffer      STRING(32768)
          END
        END
sz      LONG,AUTO
start   LONG,AUTO
amount  LONG,AUTO
CurErr  SIGNED,AUTO
 CODE
  IF fileName = ''
    RETURN BadFileErr
  END
  JSONDataClass_OutFile{PROP:Name} = fileName
  CREATE (JSONDataClass_OutFile)
  IF ERRORCODE() THEN RETURN ERRORCODE().
  OPEN (JSONDataClass_OutFile)
  IF ERRORCODE() THEN RETURN ERRORCODE().
  sz = SELF.GetJSONObjectSize()
  SEND (JSONDataClass_OutFile, 'FILEBUFFERS=' & ROUND(sz/512, 1))

  CurErr = 0
  !Add first char
  IF SELF.GetObjectIsArray()
     JSONDataClass_OutFile.buffer [1 : 1] = '['
  ELSE
     JSONDataClass_OutFile.buffer [1 : 1] = '{{'
  END
  ADD (JSONDataClass_OutFile, 1)
  CurErr = ERRORCODE()
  IF CurErr <> 0
     RETURN CurErr
  END

  recs = RECORDS(SELF.JSONObject)
  LOOP idx = 1 TO recs
       GET(SELF.JSONObject,idx)
       IF ERRORCODE()
          BREAK
       END
       IF SELF.GetObjectIsArray()
          amount = LEN(CLIP(SELF.JSONObject.Value))
          IF idx = 1
             JSONDataClass_OutFile.buffer [1 : amount] = CLIP(SELF.JSONObject.Value)
          ELSE     
             amount+=2
             JSONDataClass_OutFile.buffer [1 : amount] = ', ' & CLIP(SELF.JSONObject.Value)
          END
       ELSE
          amount = LEN(CLIP(SELF.JSONObject.Value))+LEN(SELF.JSONObject.Name)+4
          IF idx = 1
             JSONDataClass_OutFile.buffer [1 : amount] = '"' & SELF.JSONObject.Name& '": ' & CLIP(SELF.JSONObject.Value)
          ELSE               
             amount+=2
             JSONDataClass_OutFile.buffer [1 : amount] = ', "' & SELF.JSONObject.Name& '": ' & CLIP(SELF.JSONObject.Value)
          END
       END
       ADD (JSONDataClass_OutFile, amount)
  END

  !Add last char
  IF SELF.GetObjectIsArray()
     JSONDataClass_OutFile.buffer [1 : 1] = ']'
  ELSE
     JSONDataClass_OutFile.buffer [1 : 1] = '}'
  END
  ADD (JSONDataClass_OutFile, 1)
  CurErr = ERRORCODE()
  IF CurErr <> 0
     RETURN CurErr
  END

  CLOSE (JSONDataClass_OutFile)
  RETURN CurErr
  
JSONDataClass.FromJSONFile                 PROCEDURE(STRING fileName,*GROUP pJSONArray)
CurErr  SIGNED,AUTO
 CODE
    CurErr = SELF.FromFile(fileName)
    IF CurErr = 0    	
       SELF.FromJSON(SELF.GetTmpStringValue(),pJSONArray)
    END    
    SELF.DisposeTmpString()
    RETURN CurErr
 
JSONDataClass.FromJSONFile                 PROCEDURE(STRING fileName,*QUEUE pJSONArray)
CurErr  SIGNED,AUTO
 CODE
    CurErr = SELF.FromFile(fileName)
    IF CurErr = 0      
       SELF.FromJSON(SELF.GetTmpStringValue(),pJSONArray,'')
    END    
    SELF.DisposeTmpString()
    RETURN CurErr

!JSONDataClass.FromJSONCreateQueue          PROCEDURE(STRING queueName,*QUEUE queueReference)
! CODE
!    RETURN FALSE
JSONDataClass.IsSubQueue                   PROCEDURE(STRING queueName)
idx LONG
 CODE
    IF NOT SELF.QofQ &= NULL
       LOOP idx = 1 TO RECORDS(SELF.QofQ)
            GET(SELF.QofQ, idx)
            IF ERRORCODE()
               BREAK
            END
            IF UPPER(queueName) = UPPER(SELF.QofQ.Name)
               RETURN true
            END
       END
    END
    RETURN False
 
JSONDataClass.SetSubQueue                  PROCEDURE(STRING queueName,*QUEUE queueReference)
 CODE
    IF SELF.IsSubQueue(queueName)
       queueReference &= SELF.QofQ.Q       
    END

JSONDataClass.AddSubQueue       PROCEDURE(STRING queueName,*QUEUE queueReference)
idx LONG
 CODE
    IF SELF.IsSubQueue(queueName)
       SELF.QofQ.Q &= queueReference
       PUT(SELF.QofQ)
    ELSE       
       SELF.QofQ.Name = CLIP(queueName)
       SELf.QofQ.Q &= queueReference
       ADD(SELf.QofQ)
    END
    
JSONDataClass.ClearSubQueues               PROCEDURE()
 CODE
    FREE(SELF.QofQ)
 
    
JSONDataClass.FromFile                     PROCEDURE(STRING fileName)
SystemStringClass_InFile  FILE,DRIVER('DOS')
          RECORD
buffer      STRING(32768)
          END
        END
sz      LONG,AUTO
start   LONG,AUTO
fetch   LONG,AUTO
CurErr  SIGNED,AUTO
 CODE
  IF fileName = ''
    RETURN BadFileErr
  END
  SystemStringClass_InFile{PROP:Name} = fileName
  OPEN (SystemStringClass_InFile,40h)
  IF ERRORCODE() THEN
     RETURN ERRORCODE()
  END
  sz = BYTES(SystemStringClass_InFile)
  IF sz = 0
    CurErr = BadFileErr
  ELSE
    SEND (SystemStringClass_InFile, 'FILEBUFFERS=' & ROUND(sz/512, 1))
    SELF.CreateNewTmpString(sz)
    CurErr = 0
    start  = 1
    LOOP WHILE sz <> 0
      fetch = SIZE (SystemStringClass_InFile.buffer)
      IF fetch > sz
        fetch = sz
      END
      GET (SystemStringClass_InFile, start , fetch)
      CurErr = ERRORCODE()
      IF CurErr <> 0
        BREAK
      END
      SELF.retValTmp [start : start + fetch - 1] = SystemStringClass_InFile.buffer [1 : fetch]
      start += fetch
      sz    -= fetch
    END
  END
  CLOSE (SystemStringClass_InFile)  
  RETURN CurErr

JSONDataClass.FindNumberFormatter         PROCEDURE(STRING fieldName)
lIndex LONG,AUTO
lFound LONG,AUTO
 CODE
    lFound = FALSE
    IF NOT SELF.formatter &= NULL    
       LOOP lIndex = 1 TO RECORDS(SELF.formatter)
            GET(SELF.formatter,lIndex)
            IF NOT ERRORCODE()
               IF SELF.formatter.Name = UPPER(CLIP(fieldName))
                  lFound = TRUE
                  BREAK
               END
            END
       END
    END
    RETURN lFound

JSONDataClass.SetNumberFormatter         PROCEDURE(STRING fieldName, STRING picture)
 CODE
    IF NOT SELF.formatter &= NULL
       IF SELF.FindNumberFormatter(fieldName)
          IF CLIP(picture) = ''
             DELETE(SELF.formatter)
          ELSE
             IF UPPER(CLIP(picture)) = '@BOOL' OR UPPER(CLIP(picture)) = '@NULL' OR UPPER(CLIP(picture)) = '@STRING' 
                picture = UPPER(CLIP(picture))
             END
             SELF.formatter.Picture = picture
             PUT(SELF.formatter)
          END
       ELSE
          IF UPPER(CLIP(picture)) = '@BOOL' OR UPPER(CLIP(picture)) = '@NULL' OR UPPER(CLIP(picture)) = '@STRING' 
             picture = UPPER(CLIP(picture))
          END
          SELF.formatter.Name = UPPER(CLIP(fieldName))
          SELF.formatter.Picture = picture
          ADD(SELF.formatter)
       END
    END
  
JSONDataClass.DeleteNumberFormatter         PROCEDURE(STRING fieldName)
 CODE
    SELF.SetNumberFormatter(fieldName,'')

JSONDataClass.DeleteAllNumberFormatters     PROCEDURE()
 CODE
    IF NOT SELF.formatter &= NULL
       FREE(SELF.formatter)
    END

JSONDataClass.GetFormatterPicture     PROCEDURE(STRING fieldName)
 CODE
    IF NOT SELF.formatter &= NULL
       IF SELF.FindNumberFormatter(fieldName)
          RETURN SELF.formatter.Picture
       END
    END
    RETURN ''

JSONDataClass.TryGetFormatterPicture     PROCEDURE(STRING fieldName, *CSTRING picture)
retVal BYTE
 CODE
    retVal = FALSE
    picture = ''
    IF NOT SELF.formatter &= NULL
       IF SELF.FindNumberFormatter(fieldName)
          picture = SELF.formatter.Picture
          retVal = true
       END
    END   
    RETURN retVal

JSONDataClass.FindExternalName             PROCEDURE(STRING fieldName)
lIndex LONG,AUTO
lFound LONG,AUTO
 CODE
    lFound = FALSE
    IF NOT SELF.externalNames &= NULL    
       LOOP lIndex = 1 TO RECORDS(SELF.externalNames)
            GET(SELF.externalNames,lIndex)
            IF NOT ERRORCODE()
               IF UPPER(SELF.externalNames.Name) = UPPER(CLIP(fieldName))
                  lFound = TRUE
                  BREAK
               END
            END
       END
    END
    RETURN lFound
    
JSONDataClass.SetExternalName              PROCEDURE(STRING fieldName, STRING fieldExternalName)
 CODE
    IF NOT SELF.externalNames &= NULL    
       IF SELF.FindExternalName(fieldName)
          IF CLIP(fieldExternalName) = ''
             DELETE(SELF.externalNames)
          ELSE
             SELF.externalNames.Picture = fieldExternalName
             PUT(SELF.externalNames)
          END
       ELSE
          SELF.externalNames.Name = CLIP(fieldName)
          SELF.externalNames.Picture = fieldExternalName
          ADD(SELF.externalNames)
       END
    END

JSONDataClass.GetExternalName              PROCEDURE(STRING fieldName)
idxFound          LONG,AUTO
 CODE
    IF NOT SELF.externalNames &= NULL
       IF SELF.FindExternalName(fieldName)
          RETURN CLIP(SELF.externalNames.Picture)
       ELSE
          IF SELF.GetRemoveFieldPrefix()
             idxFound = INSTRING(':', fieldName,1,1)
             IF idxFound>0
                RETURN SUB(fieldName,idxFound+1,LEN(fieldName)-idxFound)
             END
          END
       END
    END
    RETURN ''

JSONDataClass.GetFieldName                 PROCEDURE(STRING fieldName)
idxFound          LONG,AUTO
 CODE
    IF NOT SELF.externalNames &= NULL
       IF SELF.FindExternalName(fieldName)
          RETURN CLIP(SELF.externalNames.Picture)
       ELSE
          IF SELF.GetRemoveFieldPrefix()
             idxFound = INSTRING(':', fieldName,1,1)
             IF idxFound>0
                RETURN SUB(fieldName,idxFound+1,LEN(fieldName)-idxFound)
             END
          END      
       END
    END
    RETURN CLIP(fieldName)

JSONDataClass.DeleteExternalName           PROCEDURE(STRING fieldName)
 CODE
    IF NOT SELF.externalNames &= NULL
       IF SELF.FindExternalName(fieldName)
          DELETE(SELF.externalNames)
       END
    END

JSONDataClass.DeleteAllExternalNames       PROCEDURE()
 CODE
    IF NOT SELF.externalNames &= NULL
       FREE(SELF.externalNames)
    END

JSONDataClass.HideGroupField              PROCEDURE(STRING fieldName)
 CODE
    IF NOT SELF.IsHiddenGroupField(fieldName)
       SELF.hiddenNames.Name = fieldName
       ADD(SELF.hiddenNames)
    END

JSONDataClass.UnhideGroupField            PROCEDURE(STRING fieldName)
 CODE
    IF SELF.IsHiddenGroupField(fieldName)
       DELETE(SELF.hiddenNames)
    END

JSONDataClass.UnhideAllGroupFields         PROCEDURE(STRING fieldName)
 CODE
    IF NOT SELF.hiddenNames &= NULL    
       FREE(SELF.hiddenNames)
    END

JSONDataClass.HideAllGroupFields           PROCEDURE(*GROUP pJSONObject)
lIndex    LONG
JQName    CSTRING(256)!MAX Name size is 256
 CODE
    lIndex = 1
    LOOP
       JQName = WHO(pJSONObject, lIndex)
       IF JQName=''
          BREAK
       END
       SELF.HideGroupField(JQName)       
       lIndex += 1
    END
      
JSONDataClass.IsHiddenGroupField          PROCEDURE(STRING fieldName)
lIndex LONG,AUTO
lFound LONG,AUTO
 CODE
    lFound = FALSE
    IF NOT SELF.hiddenNames &= NULL    
       LOOP lIndex = 1 TO RECORDS(SELF.hiddenNames)
            GET(SELF.hiddenNames,lIndex)
            IF NOT ERRORCODE()
               IF UPPER(SELF.hiddenNames.Name) = UPPER(CLIP(fieldName))
                  lFound = TRUE
                  BREAK
               END
            END
       END
    END
    RETURN lFound

JSONDataClass.TryGetName                   PROCEDURE(STRING pJSONString, *STRING name)
nameStart LONG
nameEnd LONG 
valueStart LONG 
valueEnd LONG
 CODE
    IF SELF.TryGetNameValuePositions(pJSONString,nameStart,nameEnd,valueStart,valueEnd)
       name = pJSONString[nameStart : nameEnd]
       RETURN true
    ELSE 
       RETURN false
    END
    
JSONDataClass.TryGetValue                  PROCEDURE(STRING pJSONString, *STRING value)
nameStart LONG
nameEnd LONG 
valueStart LONG 
valueEnd LONG
 CODE
    IF SELF.TryGetNameValuePositions(pJSONString,nameStart,nameEnd,valueStart,valueEnd)
       value = pJSONString[valueStart : valueEnd]
       RETURN true
    ELSE 
       RETURN false
    END
    
JSONDataClass.TryGetNameValue              PROCEDURE(STRING pJSONString,*STRING name, *STRING value)
nameStart LONG
nameEnd LONG 
valueStart LONG 
valueEnd LONG
 CODE
    IF SELF.TryGetNameValuePositions(pJSONString,nameStart,nameEnd,valueStart,valueEnd)
       name = pJSONString[nameStart : nameEnd]
       value = pJSONString[valueStart : valueEnd]
       RETURN True
    ELSE 
       RETURN False
    END
    
JSONDataClass.TryGetNameValuePositions     PROCEDURE(*STRING pJSONString,*LONG nameStart,*LONG nameEnd,*LONG valueStart,*LONG valueEnd)
pairStart LONG
pairEnd   LONG
 CODE
    pairStart = 1
    pairEnd   = LEN(pJSONString)
    RETURN SELF.TryGetNextPairPositions(pJSONString,pairStart,pairEnd,nameStart,nameEnd,valueStart,valueEnd)
    
JSONDataClass.TryGetNextPairPositions      PROCEDURE(*STRING pJSONString,*LONG pairStart,*LONG pairEnd,*LONG nameStart,*LONG nameEnd,*LONG valueStart,*LONG valueEnd)
 CODE    
    RETURN SELF.TryGetNextPairPositions(pJSONString, LEN(pJSONString),pairStart,pairEnd,nameStart,nameEnd,valueStart,valueEnd)

JSONDataClass.TryGetNextPairPositions      PROCEDURE(*STRING pJSONString, LONG itemEnd,*LONG pairStart,*LONG pairEnd,*LONG nameStart,*LONG nameEnd,*LONG valueStart,*LONG valueEnd)
idxFound          LONG
openCurlyBrakets  LONG,AUTO
startCurlyBrakets BYTE,AUTO
valueIsObject     BYTE,AUTO
openBrakets       LONG,AUTO
startBrakets      BYTE,AUTO
idx               LONG,AUTO
idxSpaces         LONG,AUTO
openQuotes        BYTE,AUTO
retval            BYTE,AUTO
curretChar        STRING(1)
prevChar          STRING(1)
 CODE
    !this method process json pairs inside the string
    !the pairs are separated by ,
    !Reset Values
    !pairStart and pairEnd are calculated outside this method and only modified if they are 0 to set the initial values
    
  json::DebugInfo('TryGetNextPairPositions '& CLIP(pJSONString))

    nameStart  = 0
    nameEnd    = 0
    valueStart = 0
    valueEnd   = 0
    pairEnd    = -1
    IF CLIP(pJSONString) = ''
       RETURN FALSE
    END
    IF itemEnd = 0
       itemEnd = LEN(CLIP(pJSONString))
    END
    IF pairStart = 0 
       pairStart = 1
    END
    IF pairStart>=itemEnd
      json::DebugInfo('TryGetNextPairPositions  pairStart '& pairStart &', itemEnd '& itemEnd)
      RETURN FALSE
    END


  !Only process if there is a pair marked byt the double colon
    idxFound = INSTRING(':', pJSONString, 1, pairStart)
    IF idxFound = 0
       valueStart = pairStart
       valueEnd   = itemEnd
      json::DebugInfo('TryGetNextPairPositions double colon not found')
      RETURN FALSE
    END
  json::DebugInfo('TryGetNextPairPositions double colon found')
  prevChar   = ''
    curretChar = ''

    valueIsObject = FALSE
    openCurlyBrakets = 0
    openBrakets = 0
    openQuotes = FALSE
    startCurlyBrakets = FALSE
    !It can contain a array of values or a value, the value is one or more pair of Name and value separated by ','
    !If it found an array [] it just take it as a full value omitting the content
    LOOP idx = pairStart TO itemEnd BY 1
         IF pJSONString[idx] = ' ' OR pJSONString[idx] = CHR(13) OR pJSONString[idx] = CHR(10) OR pJSONString[idx] = CHR(9)
            CYCLE!Speed up the loop
         END
         curretChar = pJSONString[idx]
         IF idx-1 > 0
            prevChar   = pJSONString[idx-1]
         END
         
         IF valueStart > 0
            valueEnd = idx
            pairEnd  = valueEnd
         END
         CASE pJSONString[idx]
         OF ':'
            IF openBrakets = 0 AND openQuotes = FALSE AND nameEnd > 0
               IF valueStart = 0
                  idxSpaces=idx+1
                  !move spaces to find the value
                  LOOP 
                     IF pJSONString[idxSpaces]<>' '
                        BREAK
                     END
                     idxSpaces+=1
                  END                  
                  valueStart = idxSpaces
                  idx = idxSpaces - 1
                  CYCLE
               ELSE
                  IF valueIsObject = false
                     MESSAGE('Json string invalid')
                     !between the end of the name and the : can only have spaces 
                     RETURN FALSE               
                  END
               END
            END
         OF '"'         
            IF openBrakets = 0 AND prevChar<>'\'
                IF openQuotes = TRUE
                   openQuotes = FALSE
                   IF nameStart > 0 AND nameEnd = 0
                      nameEnd = idx - 1
                   END
                ELSE
                   openQuotes = TRUE
                   IF nameStart = 0
                      nameStart = idx + 1
                      !pairStart = idx!nameStart
                   END               
                END
                CYCLE
            END
         OF ','
            IF openQuotes = FALSE AND openBrakets = 0 AND nameStart>0 AND (openCurlyBrakets <= 0 OR (startCurlyBrakets = true AND openCurlyBrakets = 1))
               valueEnd = idx - 1
               pairEnd  = idx! - 1                 
               BREAK
            END
         OF '['
            IF openQuotes = FALSE 
               openBrakets +=1
            END
         OF ']'
            IF openQuotes = FALSE 
               openBrakets -=1
            END
         OF '{{'
            IF openBrakets = 0 AND openQuotes = FALSE 
               IF nameStart = 0
                  startCurlyBrakets = true 
               END
               IF valueStart = idx
                  valueIsObject = true
               END
               openCurlyBrakets +=1
            END
         OF '}'
            IF openBrakets = 0
               IF openQuotes = FALSE 
                  openCurlyBrakets -=1
               END
               IF openCurlyBrakets = 0
                  IF startCurlyBrakets
                     valueEnd = idx - 1
                  ELSE 
                     IF valueIsObject = true
                        valueEnd = idx
                     END
                  END
                  pairEnd  = idx!valueEnd
                  BREAK
               END
               IF openCurlyBrakets < 0
                  valueEnd = idx - 1
                  pairEnd  = valueEnd
                  BREAK
               END
            END
         !ELSE
         END         
    END
    IF valueEnd = 0
       valueEnd = itemEnd
       pairEnd  = valueEnd
    END
    !Remove tailing empty spaces
    LOOP idx = valueEnd TO 1 BY -1
         IF pJSONString[idx] = ' '
            CYCLE
         END
         valueEnd = idx
         !IF pJSONString[pairEnd]=' '
         !   pairEnd  = valueEnd
         !END         
         BREAK
    END
    IF pairEnd  < valueEnd
       pairEnd  = valueEnd
    END
    RETURN true

JSONDataClass.TryGetNextArrayItemPositions PROCEDURE(*STRING pJSONString,*LONG arrayStart,*LONG arrayEnd,*LONG itemStart,*LONG itemEnd)
idx               LONG,AUTO
openCurlyBrakets  LONG,AUTO
itemIsObject      BYTE,AUTO
itemRead          BYTE,AUTO
startCurlyBrakets BYTE,AUTO
openBrakets       LONG,AUTO
openQuotes        BYTE,AUTO
strLen            LONG,AUTO
!S STRING(1)
curretChar        &STRING
 CODE
    IF CLIP(pJSONString) = ''
       RETURN FALSE
    END
    IF arrayStart>arrayEnd
       RETURN FALSE
    END
    IF itemStart>arrayEnd
       RETURN FALSE
    END
    strLen = LEN(pJSONString)
    IF arrayStart = 0
       arrayStart = 1
       !After this loop the arrayStart will be where the [ is
       !this is here just to trim
       LOOP
          curretChar &= pJSONString[arrayStart]
          IF curretChar = '['
             BREAK
          END
          IF NOT (curretChar = ' ' OR curretChar = CHR(13) OR curretChar = CHR(10) OR curretChar = CHR(9))
             !S = pJSONString[arrayStart]
             RETURN false
          END
          arrayStart += 1
          IF arrayStart>=strLen
             RETURN false
          END
       END
    END
    IF arrayEnd = 0 
       arrayEnd = strLen
       !After this loop the arrayEnd will be where the ] is
       !this is here just to trim
       LOOP
          curretChar &= pJSONString[arrayEnd]
          IF curretChar = ']'
             BREAK
          END
          IF NOT(curretChar = ' ' OR curretChar = CHR(13) OR curretChar = CHR(10) OR curretChar = CHR(9))
             !S = pJSONString[arrayEnd]
             RETURN false
          END
          arrayEnd -= 1
          IF arrayEnd<=arrayStart
             RETURN false
          END
       END
    END
    IF itemStart>=arrayEnd
       RETURN FALSE
    END
    IF itemStart = 0
       itemStart = arrayStart + 1
    ELSE
       !If item start in a , or blank space
       itemStart -= 1
       LOOP          
          itemStart += 1
          curretChar &= pJSONString[itemStart]
          IF curretChar = ',' OR curretChar = CHR(13) OR curretChar = CHR(10) OR curretChar = CHR(9)
             CYCLE
          END
          IF curretChar <> ' '
             BREAK
          END
          IF itemStart>=arrayEnd
             RETURN false
          END
       END
    END
    
    !Initialization of local variables
    !Array items can be simple items or objects that start and end with {}
    idx = itemStart - 1
    itemIsObject = false
    itemRead     = false
    itemEnd      = 0
    openQuotes   = false
    openCurlyBrakets = 0
    LOOP
       idx += 1
       IF idx >= arrayEnd
          BREAK
       END
       !
       curretChar &= pJSONString[idx]
       IF itemRead = FALSE AND NOT(curretChar = ' ' OR curretChar = CHR(13) OR curretChar = CHR(10) OR curretChar = CHR(9))
          itemRead = TRUE
       END
       IF curretChar = '"' AND pJSONString[idx-1]<>'\'
          IF openQuotes = FALSE
             openQuotes = TRUE
          ELSE
             openQuotes = FALSE
          END
          CYCLE
       END
       !
       IF openQuotes = FALSE
          CASE curretChar
          OF '{{'
             IF itemRead = FALSE
                itemIsObject = true
             END
             openCurlyBrakets += 1            
          OF '}'
             openCurlyBrakets -= 1
          OF ','
             IF NOT(itemIsObject = true OR openCurlyBrakets <> 0)
                itemEnd = idx - 1
                BREAK
             END          
          END
       END
    END !End LOOP
    IF itemEnd = 0
       itemEnd = arrayEnd - 1
    END
    !clip START
    idx = itemStart
    LOOP
       curretChar &= pJSONString[idx]
       IF NOT (curretChar = ' ' OR curretChar = CHR(13) OR curretChar = CHR(10) OR curretChar = CHR(9))
          itemStart = idx
          BREAK
       END
       idx+=1
       IF idx>=itemEnd
          BREAK
       END
    END
    
    RETURN TRUE

JSONDataClass.FromJSON      PROCEDURE(STRING pJSONString,*GROUP JSONObject)
lJSONString &STRING
lLen LONG
 CODE
    SELF.SetLostArrayDataField('')
    lLen = LEN(CLIP(pJSONString))
    lJSONString &= NEW STRING(lLen)
    lJSONString = pJSONString[1:(lLen)]
    SELF.JSONToGroup(lJSONString,1, lLen,JSONObject)
    DISPOSE(lJSONString)

JSONDataClass.FromJSON      PROCEDURE(*STRING pJSONString,*GROUP JSONObject)
 CODE    
    SELF.SetLostArrayDataField('')
    SELF.JSONToGroup(pJSONString,1, LEN(pJSONString),JSONObject)   
    
JSONDataClass.JSONToGroup   PROCEDURE(*STRING pJSONString,LONG pInitStr, LONG pEndStr,*GROUP JSONObject)
lpairStart  LONG,AUTO
lpairEnd    LONG,AUTO
lnameStart  LONG,AUTO 
lnameEnd    LONG,AUTO 
lvalueStart LONG,AUTO 
lvalueEnd   LONG,AUTO
lTotalLen   LONG,AUTO
 CODE
    lpairStart  = pInitStr
    lpairEnd    = 0
    lTotalLen   = pEndStr
    CLEAR(JSONObject)
    LOOP
       IF NOT SELF.TryGetNextPairPositions(pJSONString,lTotalLen,lpairStart,lpairEnd,lnameStart,lnameEnd,lvalueStart,lvalueEnd)
          BREAK
       END       
       SELF.AssignGroupField(pJSONString,JSONObject,lnameStart, lnameEnd, lvalueStart,lvalueEnd)
       lpairStart = lpairEnd+1
    END        

JSONDataClass.GetStringType PROCEDURE(*STRING pJSONString)
retVal UNSIGNED
 CODE
    RETURN SELF.GetValueType(pJSONString, 1, LEN(pJSONString))    
 
JSONDataClass.GetValueType PROCEDURE(*STRING pJSONString, LONG lvalueStart,LONG lvalueEnd)
 CODE
    IF lvalueEnd<lvalueStart
       RETURN JSONDataType:String
    END
    IF pJSONString[lvalueStart] = '['
       RETURN JSONDataType:Array
    END
    IF pJSONString[lvalueStart] = '{{'
       RETURN JSONDataType:Object
    END    
    IF pJSONString[lvalueStart] = '"'
       IF pJSONString[lvalueEnd] = ','
          IF pJSONString[lvalueEnd-1] = ']'
             RETURN JSONDataType:NamedArray
          ELSE
             IF pJSONString[lvalueEnd-1] = '}'
                RETURN JSONDataType:NamedObject
             END
          END
       ELSE
          IF pJSONString[lvalueEnd] = ']'
             RETURN JSONDataType:NamedArray
          ELSE
             IF pJSONString[lvalueEnd] = '}'
                RETURN JSONDataType:NamedObject
             END
          END
       END
       IF lvalueStart+2<lvalueEnd AND pJSONString[(lvalueStart+1):(lvalueStart+2)] = '\"'
          RETURN JSONDataType:EscString
       END      
       RETURN JSONDataType:String
    END
    IF pJSONString[(lvalueStart):(lvalueStart+1)] = '\"'
       RETURN JSONDataType:EscString
    END
    IF UPPER(pJSONString[(lvalueStart):(lvalueEnd)]) = 'TRUE' OR UPPER(pJSONString[(lvalueStart):(lvalueEnd)]) = 'FALSE'
       RETURN JSONDataType:Bool
    END
    IF UPPER(pJSONString[(lvalueStart):(lvalueEnd)]) = 'NULL'
       RETURN JSONDataType:NullString
    END
    IF NUMERIC(pJSONString[(lvalueStart):(lvalueEnd)])
       RETURN JSONDataType:Number
    END
    RETURN JSONDataType:StringValue !usually when the value is an string field
    
JSONDataClass.AssignGroupField PROCEDURE(*STRING pJSONString,*GROUP pJSONObject,*LONG pnameStart,*LONG pnameEnd,*LONG pvalueStart,*LONG pvalueEnd)
idx         LONG,AUTO
lJQObjName  CSTRING(256)
lJQName     CSTRING(256)
lJQValue    CSTRING(256)
innerGroup  &GROUP

dimx          LONG,AUTO
idimx         LONG,AUTO
litemStart    LONG,AUTO 
litemEnd      LONG,AUTO
 CODE
    IF pnameStart <= pnameEnd      
       idx = 0
       LOOP
          idx +=1
          lJQObjName = WHO(pJSONObject, idx)
          IF lJQObjName=''
             BREAK
          END
          IF UPPER(SELF.GetFieldName(lJQObjName)) = UPPER(pJSONString[(pnameStart):(pnameEnd)])
             IF ISGROUP(pJSONObject,idx)
                dimx = HOWMANY(pJSONObject, idx)
                IF dimx = 1            
                   innerGroup &= GETGROUP(pJSONObject, idx,1)
                   SELF.JSONToGroup( pJSONString, pvalueStart, pvalueEnd, innerGroup)
                ELSE
                   idimx = 0
                   litemStart = 0
                   litemEnd = 0
                   LOOP
                       idimx += 1
                       IF idimx > dimx
? ASSERT(litemStart >= pvalueEnd,'group dim item smaller than items in string, data will be lost. FieldName='&WHO(pJSONObject,idx))
                          SELF.SetLostArrayDataField(WHO(pJSONObject,idx))
                          BREAK
                       END
                       innerGroup &= GETGROUP(pJSONObject, idx,idimx)
                       IF NOT SELF.TryGetNextArrayItemPositions(pJSONString,pvalueStart,pvalueEnd,litemStart,litemEnd)
                          idimx-=1
                          BREAK
                       END
                       SELF.JSONToGroup( pJSONString, litemStart,litemEnd, innerGroup)
                       litemStart = litemEnd + 1
                   END
                   IF idimx < dimx
                      !Clean the rest of the array
                      LOOP
                         idimx += 1
                         IF idimx > dimx
                            BREAK
                         END
                         innerGroup &= GETGROUP(pJSONObject, idx,idimx)
                         CLEAR(innerGroup)
                      END
                   END
                END
             ELSE
                IF SELF.IsSubQueue(lJQObjName)
                   SELF.FromJSON(pJSONString,SELF.QofQ.Q, '', pvalueStart , pvalueEnd)
                ELSE
                   SELF.AssignGroupFieldIdx(pJSONString,pJSONObject,SELF.GetFormatterPicture(lJQObjName),idx,pvalueStart,pvalueEnd)
                END
             END
             BREAK
          ELSE
             !If it is not the name but it is a GROUP then skip all the internal items
             IF ISGROUP(pJSONObject,idx)
                innerGroup &= GETGROUP(pJSONObject, idx,1)
                idx += (SELF.GetGroupNumberOfFields(innerGroup) - 1)
             END
          END
       END
    ELSE
       SELF.AssignGroupFieldIdx(pJSONString,pJSONObject,'',1,pvalueStart,pvalueEnd)
    END

JSONDataClass.AssignANY             PROCEDURE(*STRING pJSONString,*ANY lCurrentField,BYTE lType,STRING pJQPicture,*LONG pvalueStart,*LONG pvalueEnd)
 CODE    
    CASE lType
    OF JSONDataType:NullString
       lCurrentField = ''
    OF JSONDataType:String                
       CASE CLIP(pJQPicture)
       OF '@BOOL'
          IF LOWER(pJSONString[(pvalueStart+1):(pvalueEnd-1)]) = 'true'
             lCurrentField = 1
          ELSE
             lCurrentField = 0
          END
       OF ''                
          lCurrentField = pJSONString[(pvalueStart+1):(pvalueEnd-1)]
       OF '@STRING'
       OROF '@NULL'
          lCurrentField = pJSONString[(pvalueStart+1):(pvalueEnd-1)]
       ELSE
          lCurrentField = DEFORMAT(pJSONString[(pvalueStart+1):(pvalueEnd-1)],pJQPicture)
       END
    OF JSONDataType:NamedObject
    OROF JSONDataType:NamedArray
         lCurrentField = pJSONString[(pvalueStart):(pvalueEnd-1)]
    OF JSONDataType:EscString
       IF pJSONString[(pvalueStart)] = '"' AND pJSONString[(pvalueEnd)] = '"'
           lCurrentField = '"'&SELF.UnEscapeString(pJSONString[(pvalueStart+3):(pvalueEnd-3)])&'"'
       ELSE
           lCurrentField = SELF.UnEscapeString(pJSONString[(pvalueStart+2):(pvalueEnd-2)])
       END
    ELSE
       CASE CLIP(pJQPicture)
       OF '@BOOL'
          IF LOWER(pJSONString[(pvalueStart):(pvalueEnd)]) = 'true'
             lCurrentField = 1
          ELSE
             lCurrentField = 0
          END
       OF ''
       OROF '@STRING'
       OROF '@NULL'
          lCurrentField = SELF.UnEscapeString(pJSONString[(pvalueStart):(pvalueEnd)])
       ELSE
          lCurrentField = DEFORMAT(pJSONString[(pvalueStart):(pvalueEnd)],pJQPicture)               
       END
    END               

JSONDataClass.AssignGroupFieldIdx             PROCEDURE(*STRING pJSONString,*GROUP pJSONObject,STRING pJQPicture,LONG pGroupItemIndex ,*LONG pvalueStart,*LONG pvalueEndCalc)
lCurrentField  ANY
lType         SIGNED
idx           LONG,AUTO
S             STRING(1)
pvalueEnd     LONG,AUTO
dimx          LONG,AUTO
idimx         LONG,AUTO
litemStart    LONG,AUTO 
litemEnd      LONG,AUTO
 CODE
             pvalueEnd = pvalueEndCalc
             idx = pValueEnd
             LOOP
                S = pJSONString[idx]
                IF NOT (S = ' ' OR S = CHR(13) OR S = CHR(10) OR S = CHR(9))
                   pValueEnd = idx
                   BREAK
                END
                idx-=1
                IF idx<=pValueStart
                   BREAK
                END
             END        

             lType = SELF.GetValueType(pJSONString, pValueStart, pValueEnd)
? ASSERT(lType <> JSONDataType:None,'value type not found val='&pJSONString[(pValueStart):(pValueEnd)])            

             dimx = HOWMANY(pJSONObject,pGroupItemIndex)
             IF dimx = 1                
                lCurrentField &= WHAT(pJSONObject,pGroupItemIndex)
                SELf.AssignANY(pJSONString,lCurrentField,lType, pJQPicture,pvalueStart,pvalueEnd)
             ELSE
? ASSERT(lType = JSONDataType:Array,'value type is not an array found val='&pJSONString[(pValueStart):(pValueEnd)])            
                IF lType <> JSONDataType:Array
                   SELF.SetLostArrayDataField(pJSONString[(pValueStart):(pValueEnd)])
                   RETURN
                END
                idimx = 0
                litemStart = 0
                litemEnd = 0
                LOOP
                    idimx += 1
                    IF idimx > dimx
                       !IF litemStart < pvalueEnd
? ASSERT(litemStart >= pvalueEnd,'dim item smaller than items in string, data will be lost. FieldName='&WHO(pJSONObject,pGroupItemIndex))
                       !END
                       SELF.SetLostArrayDataField(WHO(pJSONObject,pGroupItemIndex))
                       BREAK
                    END
                    lCurrentField &= WHAT(pJSONObject,pGroupItemIndex,idimx)
                    IF NOT SELF.TryGetNextArrayItemPositions(pJSONString,pvalueStart,pvalueEnd,litemStart,litemEnd)
                       BREAK
                    END
                    SELf.AssignANY(pJSONString,lCurrentField,lType, pJQPicture,litemStart,litemEnd)
                    litemStart = litemEnd + 1
                END
             END
             


JSONDataClass.FromJSON PROCEDURE(STRING pJSONString,*QUEUE pJSONArray)
 CODE
    SELF.FromJSON(pJSONString,pJSONArray,'')
 
JSONDataClass.FromJSON PROCEDURE(STRING pJSONString,*QUEUE pJSONArray, STRING pPicture)
lJSONString &STRING
lLen LONG
 CODE
    lLen = LEN(pJSONString)
    lJSONString &= NEW STRING(lLen)
    lJSONString = pJSONString
    SELF.FromJSON(lJSONString,pJSONArray,'')
    DISPOSE(lJSONString)

JSONDataClass.FromJSON PROCEDURE(*STRING pJSONString,*QUEUE pJSONArray) 
 CODE
    SELF.FromJSON(pJSONString,pJSONArray,'')
    
JSONDataClass.FromJSON PROCEDURE(*STRING pJSONString,*QUEUE pJSONArray, STRING pPicture)
 CODE
    SELF.FromJSON(pJSONString,pJSONArray, pPicture, 0, 0)
    
JSONDataClass.FromJSON PROCEDURE(*STRING pJSONString,*QUEUE pJSONArray, STRING pPicture, LONG parrayStart, LONG parrayEnd)
litemStart  LONG,AUTO 
litemEnd    LONG,AUTO

lpairStart  LONG,AUTO
lpairEnd    LONG,AUTO
lnameStart  LONG,AUTO 
lnameEnd    LONG,AUTO 
lvalueStart LONG,AUTO 
lvalueEnd   LONG,AUTO

lQueueCols SIGNED,AUTO
lDoblePos  UNSIGNED,AUTO

lstrType UNSIGNED,AUTO
  CODE
  
  json::DebugInfo('FromJSON: '& pJSONString)
  
    SELF.SetLostArrayDataField('')
    litemStart  =0
    litemEnd    =0
    !calculate the number of columns that the queue has
    lQueueCols=0
    LOOP
       lQueueCols+=1
       IF WHO(pJSONArray, lQueueCols) = ''
          lQueueCols-=1
          BREAK
       END
    END    

  json::DebugInfo('FromJSON: lQueueCols '& lQueueCols)

    FREE(pJSONArray)
    
    !if the array was stored with the name, remove the name
    IF parrayStart = 0 AND parrayEnd = 0
       lstrType = SELF.GetStringType(pJSONString)
      json::DebugInfo('FromJSON: lstrType '& lstrType)
      IF lstrType = JSONDataType:Object
        lpairStart = 1  !- FIX mikeduglas
          IF SELF.TryGetNextPairPositions(pJSONString,lpairStart,lpairEnd,lnameStart,lnameEnd,lvalueStart,lvalueEnd)
             parrayStart = lvalueStart
             parrayEnd = lvalueEnd
          END        
       END
    END
    
    LOOP
      json::DebugInfo('FromJSON: before TryGetNextArrayItemPositions, parrayStart '& parrayStart &' parrayEnd '& parrayEnd)
      
        IF NOT SELF.TryGetNextArrayItemPositions(pJSONString,parrayStart,parrayEnd,litemStart,litemEnd)
           BREAK
        END
      
      json::DebugInfo('FromJSON: after TryGetNextArrayItemPositions, parrayStart '& parrayStart &' parrayEnd '& parrayEnd &', litemStart '& litemStart &', litemEnd '& litemEnd)

      IF litemStart > litemEnd  !FIX mikeduglas -- EMTPY array, don't ADD(pJSONArray)
!        CYCLE
        BREAK
      END
      
      !Process the Item
        lpairStart  = litemStart
        lpairEnd    = 0
        
        lnameStart  = 0
        lnameEnd    = 0
        lvalueStart = 0
        lvalueEnd   = 0
        CLEAR(pJSONArray)
        IF lQueueCols = 1
           lpairStart  = litemStart
           lpairEnd    = litemEnd
           lDoblePos = INSTRING(':', pJSONString, 1, litemStart)
           IF lDoblePos > 0 AND lDoblePos < litemEnd
               IF SELF.TryGetNextPairPositions(pJSONString,lpairStart,lpairEnd,lnameStart,lnameEnd,lvalueStart,lvalueEnd)
                  SELF.AssignGroupFieldIdx(pJSONString,pJSONArray,'@STRING',1, lvalueStart, lvalueEnd)
               ELSE
                  SELF.AssignGroupFieldIdx(pJSONString,pJSONArray,'@STRING',1, litemStart, litemEnd)
               END
           ELSE
              SELF.AssignGroupFieldIdx(pJSONString,pJSONArray,'',1, litemStart, litemEnd)
           END
        ELSE
           LOOP
               IF NOT SELF.TryGetNextPairPositions(pJSONString, litemEnd,lpairStart,lpairEnd,lnameStart,lnameEnd,lvalueStart,lvalueEnd)
                  BREAK
               END
               SELF.AssignGroupField(pJSONString,pJSONArray,lnameStart, lnameEnd, lvalueStart,lvalueEnd)
               lpairStart = lpairEnd +1
           END
        END        
        ADD(pJSONArray)

        litemStart = litemEnd + 1
    END