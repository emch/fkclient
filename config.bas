'#Include "ext/templates.bi"
#Include "ext/containers/hashtable.bi"
#Include "ext/strings/substr.bi"

#Include "headers/config.bi"
#Include "headers/globals.bi"
#Include "headers/params.bi" 		'' config file name
#Include "headers/logging.bi"
#Include "fbstrings.bi"				'' string splitting (Explode)

Dim Shared defaultConfig As ext.fbext_HashTable((single))

Function LoadConfigFile(hashtable As ext.fbext_HashTable((String)) Ptr) As Integer
	Open CONFIG_FILE_NAME For Input As #1
	
	''Dim noError As Integer = TRUE
	Dim lineBuffer As String
	Dim arrayBuffer() As String
	
	Do Until Eof(1)
		Line Input #1, lineBuffer
		FB.Strings.StrExplode(lineBuffer, "#", arrayBuffer())
		If arrayBuffer(0) <> "" Then '' if no comment/empty line, process
			''Print arrayBuffer(0)
			FB.Strings.StrExplode(lineBuffer, "=", arrayBuffer())

			'' Deleting spaces at the end of arrayBuffer(0) to allow spaces around "="
			While instr(Len(arrayBuffer(0))-1, arrayBuffer(0), " ") <> FALSE
				arrayBuffer(0) = ext.strings.SubStr(arrayBuffer(0), 0, Len(arrayBuffer(0))-1)
			Wend
			
			hashtable->insert(arrayBuffer(0), arrayBuffer(1))
		EndIf
	Loop
	
	Close #1
	
	'' log if error
	Return TRUE ''no error
End Function

Function CheckConfig(hashtable As ext.fbext_HashTable((String)) Ptr, key As String, outputVar As Any Ptr) As Integer
	Dim value As String = Str(hashtable->GetValue(key))
	
	If value = "" Then
		'' load default parameter : name generation at compile time?
		Return FALSE
	EndIf
	
	'' TODO : generic typing? --> see ext/templates.bi --> try to understand the way it works!
	'' use casting to typeof(outputVar)
	''outputVar = *value
	Return TRUE
End Function

Function UpdateConfigFile(hashtable As ext.fbext_HashTable((String)) Ptr) As Integer
	Return TRUE
End Function

Function LoadDefaultConfig() As Integer
	Return TRUE
End Function

Function ResetConfigFile() As Integer
	Return TRUE
End Function
