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
	This._sensivity = 0.2
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
	This._theta -= mouseMotionEvent.xrel*This._sensivity
	This._phi 	-= mouseMotionEvent.yrel*This._sensivity
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
	'double realspeed = (_keystates[_keyconf["boost"]])?10*_speed:_speed;
   ' if (_keystates[_keyconf["forward"]]) 
   '     _position += _forward * (realspeed * timestep); //on avance
   ' if (_keystates[_keyconf["backward"]])
   '     _position -= _forward * (realspeed * timestep); //on recule
   ' if (_keystates[_keyconf["strafe_left"]])
   '     _position += _left * (realspeed * timestep); //on se déplace sur la gauche
   ' if (_keystates[_keyconf["strafe_right"]]) 
   '     _position -= _left * (realspeed * timestep); //on se déplace sur la droite
   ' if (_verticalMotionActive)
   ' {
   '     if (timestep > _timeBeforeStoppingVerticalMotion)
   '         _verticalMotionActive = false;
   '     else
   '         _timeBeforeStoppingVerticalMotion -= timestep;
   '     _position += Vector3D(0,0,_verticalMotionDirection*realspeed*timestep); //on monte ou on descend, en fonction de la valeur de _verticalMotionDirection
   ' }
   ' _target = _position + _forward; //comme on a bougé, on recalcule la cible fixée par la caméra
End Sub

Sub FreeflyCamera.SetSpeed(speed As Single)
	This._speed = speed
End Sub

Sub FreeflyCamera.SetSensivity(sensivity As Single)
	This._sensivity = sensivity
End Sub

Sub FreeflyCamera.SetPosition(position As Vector3d)
	This._position.SetX(position.X)
	This._position.SetX(position.X)
	This._position.SetX(position.X)
End Sub

Sub FreeflyCamera.Look()
	'gluLookAt(_position.X,_position.Y,_position.Z, _target.X,_target.Y,_target.Z, 0,0,1);
End Sub
