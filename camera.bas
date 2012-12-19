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

Sub FreeflyCamera.OnMouseButton(mouseButtonEvent As SDL_MouseButtonEvent)
	
End Sub

Sub FreeflyCamera.OnKeyboard(keyboardEvent As SDL_KeyboardEvent)
	
End Sub

Sub FreeflyCamera.Animate(timestep As UInteger)
	
End Sub

Sub FreeflyCamera.SetSpeed(speed As Single)
	
End Sub

Sub FreeflyCamera.SetSensitivity(sensitivity As Single)
	
End Sub

Sub FreeflyCamera.SetPosition(position As Vector3d)
	
End Sub

Sub FreeflyCamera.Look()
	
End Sub
