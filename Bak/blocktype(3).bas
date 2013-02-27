#Include "sdl/sdl.bi"
#Include "sdl/sdl_image.bi"
#Include "headers/blocktype.bi"

Constructor Blocktype(b_name As String)
	This._name = b_name
	This._texture = NULL
End Constructor

Constructor Blocktype(b_name As String, id As UByte)
	Dim subTexPos As SDL_Rect
	Dim numTexAxis As Integer = TILESET_WIDTH / BLOCK_TEX_SIZE	' number of textures on x axis
	
	subTexPos.x = (id Mod numTexHeight)*BLOCK_TEX_SIZE
	subTexPos.y = (id - id Mod BLOCK_TEX_SIZE)*BLOCK_TEX_SIZE
	' Checking that we do not go out of the tileset image
	If subTexPos.x > TILESET_WIDTH - BLOCK_TEX_SIZE Then
		subTexPos.x = TILESET_WIDTH - BLOCK_TEX_SIZE
	EndIf
	If subTexPos.y > TILESET_HEIGHT - BLOCK_TEX_SIZE Then
		subTexPos.y = TILESET_HEIGHT - BLOCK_TEX_SIZE
	EndIf
	
	subTexPos.w = BLOCK_TEX_SIZE
	subTexPos.h = BLOCK_TEX_SIZE
	
	This._name = b_name
	This._texture = This.ExtractTex(subTexPos) 
End Constructor

Function Blocktype.GetName() As String
	Return This._name
End Function

Sub Blocktype.SetName(b_name As String)
	This._name = b_name
End Sub

'' Extract texture as SDL_Surface from a tileset
Function Blocktype.ExtractTex(b_pos As SDL_Rect) As SDL_Surface Ptr
	Dim tileset As SDL_Surface Ptr = IMG_Load(TEXTURE_FILE)
	Dim texture As SDL_Surface Ptr = NULL
	Dim texPos As SDL_Rect
	texPos.x = 0
	texPos.y = 0
	
	SDL_BlitSurface(tileset, @b_pos, texture, @texPos)
	SDL_FreeSurface(tileset)
	
	Return texture
End Function
