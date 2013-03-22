'' Note: useless class (most probably)

#Include "sdl/sdl.bi"
#Include "sdl/sdl_image.bi"
#Include "headers/blocktype.bi"
#Include "headers/logging.bi"

Constructor Blocktype(b_name As String)
	This._name = b_name
	This._texture = Callocate(1, SizeOf(SDL_Surface))
End Constructor

Destructor Blocktype()
	DeAllocate(This._texture)
End Destructor

Constructor Blocktype(b_name As String, id As BlockTypes)
	Dim subTexPos As SDL_Rect
	Dim numTexAxis As Integer = TILESET_WIDTH / BLOCK_TEX_SIZE	' number of textures on x axis
	
	subTexPos.x = (id Mod numTexAxis)*BLOCK_TEX_SIZE
	subTexPos.y = (id - id Mod numTexAxis)*BLOCK_TEX_SIZE
	' Checking that we do not go out of the tileset image
	If subTexPos.x > TILESET_WIDTH - BLOCK_TEX_SIZE Then
		subTexPos.x = TILESET_WIDTH - BLOCK_TEX_SIZE
	EndIf
	If subTexPos.y > TILESET_HEIGHT - BLOCK_TEX_SIZE Then
		subTexPos.y = TILESET_HEIGHT - BLOCK_TEX_SIZE
	EndIf
	
	subTexPos.w = BLOCK_TEX_SIZE
	subTexPos.h = BLOCK_TEX_SIZE
	
	This._id = id
	This._name = b_name
	
	This._texture = IMG_Load("debug.png") 'This.ExtractTex(subTexPos) --> bugging
	If This._texture = NULL Then
		LogToFile("Loading texture failed: " + *SDL_GetError())
	EndIf
End Constructor

Function Blocktype.GetName() As String
	Return This._name
End Function

Sub Blocktype.SetName(b_name As String)
	This._name = b_name
End Sub

'' Extract texture as SDL_Surface from a tileset
'' Bug here
Function Blocktype.ExtractTex(b_pos As SDL_Rect) As SDL_Surface Ptr
	Dim tileset As SDL_Surface Ptr = IMG_Load(TEXTURE_FILE)
	Dim texture As SDL_Surface Ptr = NULL
	Dim texPos As SDL_Rect
	texPos.x = 0
	texPos.y = 0
	
	If tileset = NULL Then
		LogToFile("Loading image failed: " + *SDL_GetError())
	Else
		SDL_BlitSurface(tileset, @b_pos, texture, @texPos)
		SDL_FreeSurface(tileset)
	EndIf
	
	Return texture
End Function

Function Blocktype.GetTexture() As SDL_Surface Ptr
	Return This._texture
End Function
