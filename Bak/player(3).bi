#Ifndef __HEADER_PLAYER_BI__
#define __HEADER_PLAYER_BI__

#Include "headers/vector3d.bi"

Type Player
	Private:
	_position As Vector3d
	
	Public:
	Declare Sub OnMouseMotion(As SDL_MouseMotionEvent)
	Declare Sub OnMouseButton(As SDL_MouseButtonEvent)
	Declare Sub OnKeyboard(As SDL_KeyboardEvent, As Integer)
End Type

#EndIf
