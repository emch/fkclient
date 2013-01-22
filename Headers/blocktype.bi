#Ifndef __HEADER_BLOCKTYPE_BI__
#define __HEADER_BLOCKTYPE_BI__

#Define TEXTURE_FILE			"blocktypes.png"
#Define BLOCK_TEX_SIZE		16		'' block texture size in pixels (height & width)

Type BlockType
	Private:
	_name			As String
	'' rather define coordinates in texture atlas! (top-left coordinate)
	'_texcoord 	As UByte	'' block texture coordinate for sides
	'_texcoordup	As UByte	'' if defined, texture for up side (otherwise, same as sides)
	
	Public:
	Declare Constructor()
	Declare Constructor(As String) ', As UByte, As UByte)
	
	Declare Function GetName() As String
	'Declare Function GetTexCoord() As UByte
	'Declare Function GetTexCoordUp() As UByte
	
	Declare Sub SetName(As String)
	'Declare Sub SetTexCoord(As UByte)
	'Declare Sub SetTexCoordUp(As UByte)
End Type

Type BlockTypes
	Private:
	_num As Integer					'' number of blocktypes
	_blocktypes As BlockType Ptr	'' array containing all block types
	
	Public:
	Declare Sub LoadBlocktypes() '' in fine: load from FKD datafile
End Type

#endif