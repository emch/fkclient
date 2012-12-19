#Include "gl/gl.bi"
#Include "gl/glu.bi"
#Include "headers/camera.bi"
#Include "headers/vector3d.bi"
#Include "headers/logging.bi"
#Include "headers/globals.bi"
#Include "sdl/sdl_events.bi"

Constructor FreeflyCamera(position As Vector3d, keystates As KeyStates Ptr) '' TODO : load parameters from config file ...
	This._position = position
	This._phi = 0
	This._theta = 0
	This.VectorsFromAngles()
	
	This._speed = 0.01
	This._sensivity = 0.2
	This._verticalMotionActive = FALSE
	
	This._keystates = keystates
End Constructor

Destructor FreeflyCamera()

End Destructor

Sub FreeflyCamera.VectorsFromAngles()
	
End Sub

Sub FreeflyCamera.OnMouseMotion(mouseMotionEvent As SDL_MouseMotionEvent)
	This._theta -= mouseMotionEvent.xrel*This._sensivity
	This._phi 	-= mouseMotionEvent.yrel*This._sensivity
	This.VectorsFromAngles()
End Sub

Sub OnMouseButton(mouseButtonEvent As SDL_MouseButtonEvent)
	
End Sub

Sub OnKeyboard(keyboardEvent As SDL_KeyboardEvent)
	
End Sub

Sub Animate(timestep As UInteger)
	
End Sub

Sub SetSpeed(speed As Single)
	
End Sub

Sub SetSensitivity(sensitivity As Single)
	
End Sub

Sub SetPosition(position As Vector3d)
	
End Sub

Sub Look()
	
End Sub
