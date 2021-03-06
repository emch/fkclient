#Ifndef __HEADER_PLAYER_BI__
#define __HEADER_PLAYER_BI__

#Include "headers/vector3d.bi"
#Include "sdl/sdl_events.bi"

Type Player
	Private:
	_position As Vector3d
	
	Public:
	Declare Constructor(As Vector3d)
	
	Declare Sub OnMouseMotion(As SDL_MouseMotionEvent)
	Declare Sub OnMouseButton(As SDL_MouseButtonEvent)
	Declare Sub OnKeyboard(As SDL_KeyboardEvent, As Integer)
End Type

#EndIf
