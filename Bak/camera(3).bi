#Ifndef __HEADER_CAMERA_BI__
#define __HEADER_CAMERA_BI__

#Include "headers/vector3d.bi"
#Include "headers/cursor.bi"
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
	
	Declare Sub OnMouseMotion(As SDL_MouseMotionEvent) 	'' Integer represents SDL_MouseMotionEvent
	Declare Sub OnMouseButton(As SDL_ButtonEvent)	'' Integer represents SDL_MouseButtonEvent
	Declare Sub OnKeyboard(As Integer)		'' Integer represents SDL_KeyboardEvent
	
	Declare Sub Animate(As UInteger)
	Declare Sub SetSpeed(As Single)
	Declare Sub SetSensitivity(As Single)
	
	Declare Sub SetPosition(As Vector3d)
	
	Declare Sub Look()
End Type

#EndIf