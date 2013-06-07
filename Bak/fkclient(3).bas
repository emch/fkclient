'' Extended library
#Include "ext/containers/hashtable.bi" '' Include first

'' Libraries
#Include "sdl/sdl.bi"
#Include "sdl/sdl_image.bi"
#Include "gl/gl.bi"
#Include "gl/glu.bi"
#Include "gl/glext.bi"

'' Project headers
#Include "headers/keystates.bi"
#Include "headers/vector3d.bi"
#Include "headers/chunk.bi"
#Include "headers/chunk_manager.bi"
#Include "headers/block.bi"
#Include "headers/params.bi"
#Include "headers/globals.bi"
#Include "headers/config.bi"
#Include "headers/logging.bi"
#Include "headers/camera.bi"
#Include "headers/sdl_helpers.bi"

'' Prototypes
Declare Function InitWindow() As Integer
Declare Function InitScene() As Integer
Declare Sub ResizeScene()
Declare Function DrawScene() as Integer
Declare Function LoadTextures() As Integer
Declare Function FlipImageHorizontally(As SDL_Surface Ptr) As SDL_Surface Ptr

'' Variables
Dim Shared video As SDL_Surface Ptr
Dim Shared flags As Integer = SDL_DOUBLEBUF Or SDL_HWSURFACE Or SDL_OPENGL Or SDL_OPENGLBLIT

'' SDL Event holder and keystates
Dim event As SDL_Event
Dim noError As Integer = TRUE
Dim Shared myKeyStates As KeyStates = KeyStates()

'' Loop indicator
Dim loopOn As Byte = TRUE

'' Configuration hashtable
Dim Shared configParams As ext.fbext_HashTable((String))

'' Camera and timers
Dim Shared myCamera As FreeflyCamera = FreeflyCamera(Vector3d(0,0,0), @myKeyStates) '' load initial vector from save?
Dim As Single current_time, elapsed_time, last_time

'' Lights
'' NONE YET!

'' Scene objects
Dim Shared testChunk As Chunk = Chunk()

'' Texture management
Dim Shared myTexNames As GLuint Ptr
myTexNames = Callocate(NUM_TEX, SizeOf(GLuint))

'' Entry point
ClearLogFile()										'' Clearing logfile for a new session!
noError = LoadConfigFile(@configParams)	'' Load config file in configuration hashtable

'' CONFIG VARIABLES, find a cleaner way but the idea is here!

Dim Shared scr_width As Single
Dim Shared scr_height As Single
Dim Shared scr_maxfps As Single

scr_width = Val(*configParams.GetValue(SCR_WIDTH_PARAM))
scr_height = Val(*configParams.GetValue(SCR_HEIGHT_PARAM))
scr_maxfps = Val(*configParams.GetValue(SCR_MAXFPS_PARAM))

'' Error checking, find a cleaner way and use dedicated functions (config file correction) in config.bi
'' see checkconfig in config.bas
If scr_width = 0.0 Then 
	scr_width = SCR_WIDTH_DEFAULT
	LogToFile(SCR_WIDTH_PARAM + " not found in config file, default parameter used")
EndIf
If scr_height = 0.0 Then
	scr_height = SCR_HEIGHT_DEFAULT
	LogToFile(SCR_HEIGHT_PARAM + " not found in config file, default parameter used")
EndIf
If scr_maxfps = 0.0 Then
	scr_maxfps = SCR_MAXFPS_DEFAULT
	LogToFile(SCR_MAXFPS_PARAM + " not found in config file, default parameter used")
EndIf
'' END CONFIG VARIABLES

' Initializaing systems
noError = noError Or InitWindow()		'' Init SDL window container and check if no error occurs
noError = noError Or InitScene()			'' Init OpenGL and check if no error occurs
ResizeScene()									'' Set viewport accordingly
noError = noError Or LoadTextures()		'' Loading textures

' Loading game content
'' Temporary
'' Load objects
testChunk.Load()
testChunk.CreateMesh(myTexNames)
'' End temporary

'' Game loop
While loopOn And noError
	While SDL_PollEvent(@event)
		Select Case event.type			
			'' Keyboard event
			Case SDL_KEYDOWN:
				Select Case event.key.keysym.sym
					Case SDLK_ESCAPE:	'' not working sometimes
						loopOn = FALSE
						'Exit While
					Case SDLK_F11:
						' see the way keys are managed below?
						' some problems here (resize)
						flags = video->flags
						video = SDL_SetVideoMode(0, 0, 0, flags Xor SDL_FULLSCREEN)
						If video = NULL Then
							video = SDL_SetVideoMode(0, 0, 0, flags)
							LogToFile("Failed to switch to fullscreen mode: " + *SDL_GetError())
						EndIf
						If video = NULL Then
							LogToFile("Failed to switch back to windowed mode: " + *SDL_GetError())
							Exit While
						EndIf
						ResizeScene()
						'Exit While
				End Select
				myCamera.OnKeyboard(event.key, TRUE)
			Case SDL_KEYUP:
				myCamera.OnKeyboard(event.key, FALSE)
			'' Mouse event
			Case SDL_MOUSEBUTTONDOWN:
				myCamera.OnMouseButton(event.button)
			Case SDL_MOUSEMOTION
				myCamera.OnMouseMotion(event.motion)
		End Select
	Wend
	
	If loopOn = FALSE Then
		Exit While
	EndIf
	
	'' Wireframe
	'glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)

	current_time = SDL_GetTicks()
	elapsed_time = current_time - last_time
	last_time = current_time

	'' moving the camera
   myCamera.Animate(elapsed_time)
   
   noError = noError Or DrawScene()

	glFlush

   '' fps maximum (delay)
   SDL_Delay(1000/scr_maxfps)
   
   SDL_GL_SwapBuffers
Wend

'' Garbage collector
testChunk.Destructor()
DeAllocate(myTexNames)

'' End message
LogToFile("Game ended")

SDL_Quit
'' End of program

Function InitWindow() As Integer
	If SDL_Init(SDL_INIT_VIDEO) <> 0 Then
	   LogToFile("Failed to initialise SDL: " + *SDL_GetError())
	   Return FALSE
	End If
	
	'' Set SDL
	SDL_WM_SetCaption(APP_NAME + VERSION_MESSAGE, NULL)
	SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1)
	SDL_EnableKeyRepeat(100, 10) 		''in fine : delete, change delay?
	SDL_WM_GrabInput(SDL_GRAB_ON) 	''mouse confined to application window
	SDL_ShowCursor(SDL_DISABLE)		''disabling mouse cursor
	'' TODO : show cross in the middle of the screen!
	
	video = SDL_SetVideoMode(scr_width, scr_height, 24, flags)
	''video = SDL_SetVideoMode (800, 600, 24, SDL_HWSURFACE OR SDL_DOUBLEBUF) --> use when menu mode???
	
	If video = NULL Then
	   LogToFile("Failed to initialise SDL: " + *SDL_GetError())
	   Return FALSE
	End If

	LogToFile("SDL initialised")
	Return TRUE
End Function

Function InitScene() As Integer
	glShadeModel(GL_SMOOTH)                                  '' Enable Smooth Shading
	glClearColor(0.0, 0.0, 0.0, 0.5)                         '' Black Background
	glClearDepth(1.0)                                        '' Depth Buffer Setup
	glEnable(GL_DEPTH_TEST)                                  '' Enables Depth Testing
	glEnable(GL_TEXTURE_2D)												'' Enables texturing
	'glEnable(GL_LIGHTING) 'Lighting !!! See http://sjbaker.org/steve/omniv/opengl_lighting.html
	glDepthFunc(GL_LEQUAL)                                 	'' The Type Of Depth Testing To Do
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)        '' Really Nice Perspective Calculations
	glEnable(GL_CULL_FACE)												'' Backface culling (defined by normal)
	
	'' Load textures here?
	
	LogToFile("OpenGL initialised")
	Return TRUE																'' No error occurred
End Function

Sub ResizeScene()
	'' ReSizeGLScene
	glViewport 0, 0, scr_width, scr_height                	'' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                              	'' Select The Projection Matrix
	glLoadIdentity                                          	'' Reset The Projection Matrix
	gluPerspective(45.0, scr_width/scr_height, 0.1, 100.0)  	'' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                               	'' Select The Modelview Matrix
	glLoadIdentity                                          	'' Reset The Modelview Matrix
	
	LogToFile("Scene resized")
End Sub

Function DrawScene() As Integer
	glClear GL_COLOR_BUFFER_BIT OR GL_DEPTH_BUFFER_BIT
	'' Reset the scene
	glLoadIdentity
	
	'' gluLookAt...
	myCamera.Look()
	
	'' Rendering objects
	Dim chunkPos As Vector3d = Vector3d(0.0, 0.0, -10.0)
	testChunk.Render(chunkPos)
	
	Return TRUE
End Function

'' Error: some textures have left/right inverted
Function LoadTextures() As Integer
	Dim i As Integer
	Dim pass As Integer = TRUE
	
	Dim TexturePng As SDL_Surface Ptr
	TexturePng = SDL_CreateRGBSurface(SDL_HWSURFACE, BLOCK_TEX_SIZE, BLOCK_TEX_SIZE, 32, 0, 0, 0, 0)
	
   Dim TexTileset As SDL_Surface Ptr = IMG_Load(TEXTURE_FILE)
	Dim TexMode As Integer = GL_RGB
   
   If TexTileset = NULL Then
   	LogToFile("Tileset image not found: " + *SDL_GetError())
   	Return FALSE
   EndIf
   
   ' Checking tileset dimensions
   If ((TexTileset->h = TILESET_HEIGHT) = FALSE) Or ((TexTileset->w = TILESET_WIDTH) = FALSE) Then
   	LogToFile("Inadequate tileset image dimensions")
   	Return FALSE
   EndIf
	
	' Texture positions
   Dim TexPos As SDL_Rect
   Dim TexOutPos As SDL_Rect
	TexOutPos.x = 0
	TexOutPos.y = 0
	
	' Number of textures on x axis
   Dim numTexAxis As Integer = TILESET_WIDTH / BLOCK_TEX_SIZE
   
   glGenTextures(NUM_TEX, myTexNames)
   
	For i = 0 To NUM_TEX-1
		TexPos.x = (i Mod numTexAxis) * BLOCK_TEX_SIZE
		TexPos.y = (i - i Mod numTexAxis) * BLOCK_TEX_SIZE
		
		' Checking that we do not go out of the tileset image
		If TexPos.x > TILESET_WIDTH - BLOCK_TEX_SIZE Then
			TexPos.x = TILESET_WIDTH - BLOCK_TEX_SIZE
		EndIf
		If TexPos.y > TILESET_HEIGHT - BLOCK_TEX_SIZE Then
			TexPos.y = TILESET_HEIGHT - BLOCK_TEX_SIZE
		EndIf
		
		TexPos.w = BLOCK_TEX_SIZE
		TexPos.h = BLOCK_TEX_SIZE
		
		' Blitting surface to TexturePng
		If SDL_BlitSurface(TexTileSet, @TexPos, TexturePng, NULL) = -1 Then
			LogToFile("Blitting failed: " + *SDL_GetError())
		EndIf
		
		' Flipping TexturePng (horizontal inversion in blocktypes.png)
		FlipHorizontally(TexturePng)
		
		If TexturePng = NULL Then
   		LogToFile("Failed loading texture at indice " + Str(i) + ": " + *SDL_GetError())
   		pass = pass Or FALSE
		Else
			glBindTexture(GL_TEXTURE_2D, myTexNames[i])
			SDL_LockSurface(TexturePng)
		   glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TexturePng->w, TexturePng->h, 0, GL_BGRA, GL_UNSIGNED_BYTE, TexturePng->Pixels)
		   glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
			glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
			SDL_UnlockSurface(TexturePng)
		End If
	Next
	
	SDL_FreeSurface(TexturePng)
	SDL_FreeSurface(TexTileset)
	
	Return pass
End Function