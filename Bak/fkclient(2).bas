'' Extended library
#Include "ext/containers/hashtable.bi" ''include first

'' Libraries
#Include "SDL/SDL.bi"
#Include "SDL/SDL.bi"
#Include "GL/gl.bi"
#Include "GL/glu.bi"

'' Project headers
#Include "Headers/vector3d.bi"
#Include "Headers/chunk.bi"
#Include "Headers/block.bi"
#Include "Headers/params.bi"
#Include "Headers/globals.bi" 	'' booleans
#Include "Headers/config.bi"	'' configuration file management
#Include "Headers/logging.bi"	'' logging

'' Prototypes
Declare Function InitWindow() As Integer
Declare Function InitScene() As Integer
Declare Sub ResizeScene()
Declare Function DrawScene() as Integer

'' Variables
Dim Shared video As SDL_Surface Ptr
Dim Shared fullscreenOn As Byte = FALSE

'' SDL Event holder
Dim event As SDL_Event
Dim noError As Integer = TRUE

'' Loop indicator
Dim loopOn As Byte = TRUE

'' Configuration hashtable
Dim Shared configParams As ext.fbext_HashTable((String))

'' Scene objects
Dim Shared testChunk As Chunk = Chunk()

'' Entry point
ClearLogFile()									'' Clearing logfile for a new session!
noError = LoadConfigFile(@configParams)'' Load config file in configuration hashtable

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
	While SDL_PollEvent(@event)
		'' provisoire ? (mettre dans une state machine dédiée ?)
		Select Case event.type
			'' Red cross ...
			Case SDL_QUIT_:
				loopOn = FALSE
			'' Keyboard event
			Case SDL_KEYDOWN:
				Select Case event.key.keysym.sym
					Case SDLK_ESCAPE: '' provisoire (cf. retour vers menu)
						loopOn = FALSE
					Case SDLK_F11:
						fullscreenOn = Not fullscreenOn
				End Select
			'' Mouse event
			Case SDL_MOUSEBUTTONDOWN:
				Select Case event.button.button
					Case SDL_BUTTON_LEFT:
						''Print "left"
					Case SDL_BUTTON_RIGHT:
						''Print "right"
					Case SDL_BUTTON_MIDDLE:
						''Print "middle"
					Case SDL_BUTTON_WHEELDOWN:
						''Print "down"
					Case SDL_BUTTON_WHEELUP:
						''Print "up"
				End Select
		End Select	
	Wend
	
	'' Temporary (future dev option) : wireframe
	glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)

   noError = noError Or DrawScene()

   glFlush
   
   SDL_GL_SwapBuffers
   SDL_Delay 40			'' avoid high CPU usage (temporary)
Wend

SDL_Quit
'' End of program

Function InitWindow() As Integer
	If SDL_Init(SDL_INIT_VIDEO) <> 0 Then
	   LogToFile("Failed to initialise SDL: " + *SDL_GetError())
	   Return FALSE
	End If
	
	'' Set SDL videomode
	SDL_WM_SetCaption(APP_NAME + VERSION_MESSAGE, NULL)
	
	video = SDL_SetVideoMode(scr_width, scr_height, 24, SDL_DOUBLEBUF or SDL_OPENGL or SDL_OPENGLBLIT)'' Or SDL_FULLSCREEN)
	''SDL_SetVideoMode (800, 600, 24, SDL_HWSURFACE OR SDL_DOUBLEBUF) --> use when menu mode???
	
	If video = NULL Then
	   LogToFile("Failed to initialise SDL: " + *SDL_GetError())
	   Return FALSE
	End If
	
	SDL_GL_SetAttribute SDL_GL_DOUBLEBUFFER, 1
	
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
	
	'' Temporary
	'' Load objects
	testChunk.Load()
	
	'' test (provisoire)
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
	glLoadIdentity									            '' Reset the scene

	glTranslatef(0.0f,0.0f,-6.0f) '' see how to make a camera ...
	
	'' Rendering objects
	testChunk.Render(New Vector3d())
	
	Return TRUE
End Function