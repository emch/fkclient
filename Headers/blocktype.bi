#Ifndef __HEADER_BLOCKTYPE_BI__
#define __HEADER_BLOCKTYPE_BI__

#Include "sdl/sdl.bi"

#Define TEXTURE_FILE				"Res/Textures/blocktypes.png"
#Define BLOCK_TEX_SIZE			16		'' block texture size in pixels (height & width)
#Define TILESET_HEIGHT			256
#Define TILESET_WIDTH			256
#Define NUM_TEX					(TILESET_HEIGHT/BLOCK_TEX_SIZE)*(TILESET_WIDTH/BLOCK_TEX_SIZE)	'' Number of textures

Enum BlockTypes
	BTYPE_COBBLESTONE = 0
	BTYPE_DIRT = 2
	BTYPE_TNT = 8
	BTYPE_DEFAULT = 168
End Enum

Type BlockType
	Private:
	_id			As BlockTypes
	_name			As String
	_texture		As SDL_Surface Ptr

	Public:
	Declare Destructor()
	Declare Constructor()
	Declare Constructor(As String)
	Declare Constructor(As String, As BlockTypes)
	
	Declare Function GetName() As String
	Declare Sub SetName(As String)
	Declare Function ExtractTex(As SDL_Rect) As SDL_Surface Ptr
	Declare Function GetTexture() As SDL_Surface Ptr
End Type

#endif