#Include "headers/blocktype.bi"

Constructor Blocktype(b_name As String) ', texcoord As UByte, texcoordup As UByte)
	This._name = b_name
	'This._texcoord = texcoord
	'This._texcoordup = texcoordup
End Constructor

Function Blocktype.GetName() As String
	Return This._name
End Function

'Function Blocktype.GetTexCoord() As UByte
'	Return This._texcoord
'End Function
'
'Function Blocktype.GetTexCoordUp() As UByte
'	Return This._texcoordup
'End Function

Sub Blocktype.SetName(b_name As String)
	This._name = b_name
End Sub

'Sub Blocktype.SetTexCoord(b_texcoord As UByte)
'	This._texcoord = b_texcoord
'End Sub
'
'Sub Blocktype.SetTexCoordUp(b_texcoordup As UByte)
'	This._texcoordup = b_texcoordup
'End Sub
