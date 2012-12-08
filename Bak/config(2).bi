#Ifndef __HEADER_CONFIG_BI__
#define __HEADER_CONFIG_BI__

''config file management using hashtables
'#Include "ext/templates.bi"
#Include "ext/containers/hashtable.bi"

#Define GET_DEFAULT_NAME(param)	param _ _DEFAULT

Declare Function LoadConfigFile(As ext.fbext_HashTable((String)) Ptr) As Integer
Declare Function CheckConfig(As ext.fbext_HashTable((String)) Ptr, As String, As Any Ptr) As Integer

Declare Function UpdateConfigFile(As ext.fbext_HashTable((String)) Ptr) As Integer
Declare Function LoadDefaultConfig() As Integer
Declare Function ResetConfigFile() As Integer

#EndIf