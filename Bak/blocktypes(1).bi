#Ifndef __HEADER_BLOCKTYPE_BI__
#define __HEADER_BLOCKTYPE_BI__

#Include "sdl/sdl.bi"

#Define TEXTURE_FILE				"Res/Textures/blocktypes.png"
#Define BLOCK_TEX_SIZE			16		'' block texture size in pixels (height & width)
#Define TILESET_HEIGHT			256
#Define TILESET_WIDTH			256
#Define NUM_ACTIVE_TEX			6		'' Number of active textures
#Define NUM_TEX					(TILESET_HEIGHT/BLOCK_TEX_SIZE)*(TILESET_WIDTH/BLOCK_TEX_SIZE)	'' Maximum number of textures

Enum BlockTypes
	BTYPE_ERROR = 0			'' no texture!
	BTYPE_DEBUG = 1
	BTYPE_GRAVEL = 2
	BTYPE_COBBLESTONE = 3
	BTYPE_DIRT = 4
	BTYPE_GRASS = 5
End Enum

#EndIf