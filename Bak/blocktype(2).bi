#Ifndef __HEADER_BLOCKTYPE_BI__
#define __HEADER_BLOCKTYPE_BI__

#Include "sdl/sdl.bi"

#Define TEXTURE_FILE			"blocktypes.png"
#Define BLOCK_TEX_SIZE		16		'' block texture size in pixels (height & width)

Type BlockType
	Private:
	_name			As String
	_texture		As SDL_Surface Ptr

	Public:
	Declare Constructor()
	Declare Constructor(As String)
	Declare Constructor(As String, As Byte, As Byte)
	
	Declare Function GetName() As String
	Declare Sub SetName(As String)
	Declare Function ExtractTex() As SDL_Surface
End Type

Type BlockTypes
	Private:
	_num As Integer					'' number of blocktypes
	_blocktypes As BlockType Ptr	'' array containing all block types
	
	Public:
	Declare Sub LoadBlocktypes() '' in fine: load from FKD datafile
End Type

#endif