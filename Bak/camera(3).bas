#Include "ext/containers/hashtable.bi"
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
	This._sensivity = 0.02
	This._verticalMotionActive = FALSE
	
	This._keystates = keystates
End Constructor

Sub FreeflyCamera.VectorsFromAngles()
	Dim up As Vector3d = Vector3d(0.0,0.0,1.0) '' world vertical vector ???
	
   if This._phi > 89 Then
   	This._phi = 89
   ElseIf This._phi < -89 Then
   	This._phi = -89
   EndIf
   
   Dim r_temp As Single = Cos(This._phi * PI / 180)	'' cartesian to spherical coordinates
	This._forward.SetZ(Sin(This._phi * PI / 180))
	This._forward.SetX(r_temp * Cos(This._theta * PI / 180))
	This._forward.SetY(r_temp * Sin(This._theta * PI / 180))

	This._left = CrossProduct(up, This._forward)
	This._left.Normalize()
	
	This._target = This._position + This._forward
End Sub

Sub FreeflyCamera.OnMouseMotion(mouseMotionEvent As SDL_MouseMotionEvent)
	This._theta -= mouseMotionEvent.xrel * This._sensivity
	This._phi 	-= mouseMotionEvent.yrel * This._sensivity
	This.VectorsFromAngles()
End Sub

Sub FreeflyCamera.OnMouseButton(mouseButtonEvent As SDL_MouseButtonEvent)
	'' Wheeling up ...
	If mouseButtonEvent.button = SDL_BUTTON_WHEELUP And mouseButtonEvent.type = SDL_MOUSEBUTTONDOWN Then
		This._verticalMotionActive = TRUE 					'' activating vertical motion
		This._timeBeforeStoppingVerticalMotion = 250 	'' during 250 ms
		This._verticalMotionDirection = 1 					'' upwards
	'' Wheeling down ...
	ElseIf mouseButtonEvent.button = SDL_BUTTON_WHEELDOWN And mouseButtonEvent.type = SDL_MOUSEBUTTONDOWN Then
		This._verticalMotionActive = TRUE 					'' activating vertical motion
		This._timeBeforeStoppingVerticalMotion = 250 	'' during 250 ms
		This._verticalMotionDirection = -1 					'' downwards
	EndIf
End Sub

Sub FreeflyCamera.OnKeyboard(keyboardEvent As SDL_KeyboardEvent, downup As Integer)
	Select Case keyboardEvent.keysym.sym
		Case This._keystates->GetKeyCode("left"):
			This._keystates->SetKeyState("left", downup)
		Case This._keystates->GetKeyCode("right"):
			This._keystates->SetKeyState("right", downup)
		Case This._keystates->GetKeyCode("forward"):
			This._keystates->SetKeyState("forward", downup)
		Case This._keystates->GetKeyCode("backward"):
			This._keystates->SetKeyState("backward", downup)
	End Select
End Sub

Sub FreeflyCamera.Animate(timestep As UInteger)
	Dim realspeed As Single
	If This._keystates->GetKeyState("boost") = TRUE Then
		realspeed = 10 * This._speed 
	Else
		realspeed = This._speed
	EndIf
   
   If This._keystates->GetKeyState("forward") Then
   	This._position += (realspeed * timestep) * This._forward
   EndIf
   
	If This._keystates->GetKeyState("backward") Then
		This._position -= (realspeed * timestep) * This._forward
	EndIf
	
	If This._keystates->GetKeyState("left") Then
		This._position += (realspeed * timestep) * This._left
	EndIf
	
	If This._keystates->GetKeyState("right") Then
		This._position -= (realspeed * timestep) * This._left
	EndIf
	
	If _verticalMotionActive Then
		If timestep > This._timeBeforeStoppingVerticalMotion Then
			This._verticalMotionActive = FALSE
		Else
			This._timeBeforeStoppingVerticalMotion -= timestep
			This._position += Vector3D(0, 0, realspeed * timestep *This._verticalMotionDirection)
		EndIf
	EndIf
   
   This._target = This._position + This._forward '' recalculating target
End Sub

Sub FreeflyCamera.SetSpeed(speed As Single)
	This._speed = speed
End Sub

Sub FreeflyCamera.SetSensivity(sensivity As Single)
	This._sensivity = sensivity
End Sub

Sub FreeflyCamera.SetPosition(position As Vector3d)
	This._position.SetX(position.X)
	This._position.SetY(position.Y)
	This._position.SetZ(position.Z)
End Sub

Sub FreeflyCamera.Look()
	gluLookAt(This._position.X, This._position.Y, This._position.Z, This._target.X, This._target.Y, This._target.Z, 0, 0, 1)
End Sub
