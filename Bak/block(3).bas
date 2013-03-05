'' Compile as library first

#Include "GL/gl.bi"
#Include "GL/glu.bi"
#Include "headers/block.bi"
#Include "headers/vector3d.bi"
#Include "headers/globals.bi" '' booleans
#Include "headers/blocktype.bi"

Constructor Block
	This._isActive = TRUE
End Constructor

Function Block.IsActive() As Byte
	If This._isActive = TRUE Then
		Return TRUE
	EndIf
	Return FALSE
End Function

Property Block.SetActive(activate As Integer)
	This._isActive = activate
End Property