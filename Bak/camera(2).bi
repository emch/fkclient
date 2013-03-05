#Ifndef __HEADER_CAMERA_BI__
#define __HEADER_CAMERA_BI__

#Include "headers/vector3d.bi"
#Include "headers/keystates.bi"
#Include "sdl/sdl_events.bi"

Type FreeflyCamera
	Private:
	_speed As Single
	_sensivity As Single
	
	_timeBeforeStoppingVerticalMotion As UInteger
	_verticalMotionActive As Integer
	_verticalMotionDirection As Integer
	
	_keystates As KeyStates Ptr
	
	_position As Vector3d
	_target As Vector3d
	_forward As Vector3d
	_left As Vector3d
	
	_theta As Single
	_phi As Single
	
	Declare Sub VectorsFromAngles()
	
	Public:
	Declare Constructor(As Vector3d, As KeyStates Ptr)
	Declare Destructor()
	'' Destructor : destroy hashtables in memory?
	
	Declare Sub OnMouseMotion(As SDL_MouseMotionEvent)
	Declare Sub OnMouseButton(As SDL_MouseButtonEvent)
	Declare Sub OnKeyboard(As SDL_KeyboardEvent, As Integer)
	Declare Sub KeystatesIterator(ByRef key As Const String, ByVal value As Integer Ptr)
	
	Declare Sub Animate(As UInteger)
	Declare Sub SetSpeed(As Single)
	Declare Sub SetSensivity(As Single)
	
	Declare Sub SetPosition(As Vector3d)
	
	Declare Sub Look()
End Type

#EndIf