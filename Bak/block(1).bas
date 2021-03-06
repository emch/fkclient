'' Compile as library first

#Include "GL/gl.bi"
#Include "GL/glu.bi"
#Include "headers/block.bi"
#Include "headers/vector3d.bi"
#Include "headers/globals.bi" '' Booleans
#Include "headers/blocktypes.bi"

Constructor Block
	This._isActive = TRUE
	This._blocktype = BTYPE_GRASS
End Constructor

Constructor Block(b_isActive As Byte, b_blocktype As BlockTypes)
	This._isActive = b_isActive
	This._blocktype = b_blocktype
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

Function Block.GetBlocktype() As Blocktypes
	Return This._blocktype
End Function