#Include "sdl/sdl.bi"
#Include "sdl/sdl_image.bi"
#Include "headers/blocktype.bi"

Constructor Blocktype(b_name As String)
	This._name = b_name
	This._texture = NULL
End Constructor

Constructor Blocktype(b_name As String, b_x As Byte, b_y As Byte)
	'use an id (numeral position in tileset) rather than position (in pixel)
	Dim subTexPos As SDL_Rect
	subTexPos.x = b_x
	subTexPos.y = b_y
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
