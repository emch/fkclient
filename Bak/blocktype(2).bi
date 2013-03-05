#Ifndef __HEADER_BLOCKTYPE_BI__
#define __HEADER_BLOCKTYPE_BI__

#Include "sdl/sdl.bi"

#Define TEXTURE_FILE				"Res/Textures/blocktypes.png"
#Define BLOCK_TEX_SIZE			16		'' block texture size in pixels (height & width)
#Define TILESET_HEIGHT			256
#Define TILESET_WIDTH			256

Enum BlockTypes
	BTYPE_COBBLESTONE = 0
	BTYPE_TNT = 8
End Enum

Type BlockType
	Private:
	_id			As BlockTypes
	_name			As String
	_texture		As SDL_Surface Ptr

	Public:
	Declare Constructor()
	Declare Constructor(As String)
	Declare Constructor(As String, As BlockTypes)
	
	Declare Function GetName() As String
	Declare Sub SetName(As String)
	Declare Function ExtractTex(As SDL_Rect) As SDL_Surface Ptr
End Type

'Type BlockTypes
'	Private:
'	_num As Integer					'' number of blocktypes
'	_blocktypes As BlockType Ptr	'' array containing all block types
'	
'	Public:
'	Declare Sub LoadBlocktypes() '' in fine: load from FKD datafile
'End Type

#endif