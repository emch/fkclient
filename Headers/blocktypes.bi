#Ifndef __HEADER_BLOCKTYPE_BI__
#define __HEADER_BLOCKTYPE_BI__

#Include "sdl/sdl.bi"

#Define TEXTURE_FILE				"Res/Textures/blocktypes.png"
#Define BLOCK_TEX_SIZE			16		'' block texture size in pixels (height & width)
#Define TILESET_HEIGHT			256
#Define TILESET_WIDTH			256
#Define NUM_TEX					(TILESET_HEIGHT/BLOCK_TEX_SIZE)*(TILESET_WIDTH/BLOCK_TEX_SIZE)	'' Number of textures

Enum BlockTypes
	BTYPE_ERROR = 0
	BTYPE_DEBUG = 1
End Enum

#EndIf