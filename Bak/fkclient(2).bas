'' Extended library
#Include "ext/containers/hashtable.bi" ''include first

'' Libraries
#Include "SDL/SDL.bi"
#Include "gl/gl.bi"
#Include "gl/glu.bi"

'' Project headers
#Include "headers/keystates.bi"
#Include "headers/vector3d.bi"
#Include "headers/chunk.bi"
#Include "headers/block.bi"
#Include "headers/params.bi"
#Include "headers/globals.bi" '' booleans
#Include "headers/config.bi"	'' configuration file management
#Include "headers/logging.bi"	'' logging
#Include "headers/camera.bi"

'' Prototypes
Declare Function InitWindow() As Integer
Declare Function InitScene() As Integer
Declare Sub ResizeScene()
Declare Function DrawScene() as Integer

'' Variables
Dim Shared video As SDL_Surface Ptr
Dim Shared fullscreenOn As Byte = FALSE

'' SDL Event holder and keystates
Dim event As SDL_Event
Dim noError As Integer = TRUE
Dim Shared myKeyStates As KeyStates = KeyStates()

'' Loop indicator
Dim loopOn As Byte = TRUE

'' Configuration hashtable
Dim Shared configParams As ext.fbext_HashTable((String))

'' Camera
Dim Shared myCamera As FreeflyCamera = FreeflyCamera(Vector3d(0,0,0), @myKeyStates) '' load initial vector from save?

'' Lights
'' NONE YET!

'' Scene objects
Dim Shared testChunk As Chunk = Chunk()

'' Entry point
ClearLogFile()										'' Clearing logfile for a new session!
noError = LoadConfigFile(@configParams)	'' Load config file in configuration hashtable

'' CONFIG VARIABLES, find a cleaner way but the idea is here!

Dim Shared scr_width As Single
Dim Shared scr_height As Single

scr_width = Val(*configParams.GetValue(SCR_WIDTH_PARAM))
scr_height = Val(*configParams.GetValue(SCR_HEIGHT_PARAM))

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

'' END CONFIG VARIABLES


noError = noError Or InitWindow()		'' Init SDL window container and check if no error occurs
noError = noError Or InitScene()			'' Init OpenGL and check if no error occurs
ResizeScene()									'' Set viewport accordingly

'' Game loop
While loopOn And noError
	'While ''useful?
	SDL_PollEvent(@event)
		Select Case event.type			
			'' Keyboard event
			Case SDL_KEYDOWN:
				Select Case event.key.keysym.sym
					Case SDLK_ESCAPE:	'' not working sometimes
						loopOn = FALSE
					'Case SDLK_F11:
					'	fullscreenOn = Not fullscreenOn
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
	'Wend
	
	'' Temporary (future dev option) : wireframe
	glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)

	current_time = SDL_GetTicks()
	elapsed_time = current_time - last_time
	last_time = current_time

	'' moving the camera
   myCamera.Animate(elapsed_time)
   
   noError = noError Or DrawScene()

   glFlush
   
   SDL_GL_SwapBuffers
Wend

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
	SDL_EnableKeyRepeat(100, 10) ' in fine : delete, change delay?
	SDL_WM_GrabInput(SDL_GRAB_ON) 	'mouse confined to application window
	SDL_ShowCursor(SDL_DISABLE)		'disabling mouse cursor
	'' TODO : show cross in the middle of the screen!
	
	video = SDL_SetVideoMode(scr_width, scr_height, 24, SDL_DOUBLEBUF or SDL_OPENGL or SDL_OPENGLBLIT)'' Or SDL_FULLSCREEN)
	''video = SDL_SetVideoMode (800, 600, 24, SDL_HWSURFACE OR SDL_DOUBLEBUF) --> use when menu mode???
	
	If video = NULL Then
	   LogToFile("Failed to initialise SDL: " + *SDL_GetError())
	   Return FALSE
	End If

	LogToFile("SDL initialised")
	Return TRUE
End Function

Function InitScene() As Integer
	glShadeModel GL_SMOOTH                                  	'' Enable Smooth Shading
	glClearColor 0.0, 0.0, 0.0, 0.5                         	'' Black Background
	glClearDepth 1.0                                        	'' Depth Buffer Setup
	glEnable GL_DEPTH_TEST                                  	'' Enables Depth Testing
	glDepthFunc GL_LEQUAL                                   	'' The Type Of Depth Testing To Do
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST        	'' Really Nice Perspective Calculations
	glEnable GL_CULL_FACE
	
	'' Initialize camera position/direction
	'myCamera.Initialize()
	
	'' Temporary
	'' Load objects
	testChunk.Load()
	testChunk.CreateMesh()
	'' End temporary
	
	LogToFile("OpenGL initialised")
	Return TRUE																'' no error occurred
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
	
	'SDL_WarpMouse(scr_width/2, scr_height/2)
	
	'' Rendering objects
	Dim chunkPos As Vector3d = Vector3d(0.0, 0.0, -10.0)
	testChunk.Render(chunkPos)
	
	Return TRUE
End Function