#Ifndef __HEADER_CAMERA_BI__
#define __HEADER_CAMERA_BI__

#Include "headers/vector3d.bi"
#Include "headers/cursor.bi"

Type FreeflyCamera '' currently : freefly camera (implement different modes?)
	Private:
	_position As Vector3d Ptr
	_direction As Vector3d Ptr
	_vertical As Vector3d Ptr
	
	Public:
	Declare Constructor()
	Declare Sub Initialize()
	Declare Function GetPosition() As Vector3d Ptr
	Declare Function GetDirection() As Vector3d Ptr
	Declare Function GetVertical() As Vector3d Ptr
	Declare Sub SetPosition(As Vector3d Ptr)
	Declare Sub SetDirection(As Vector3d Ptr)
	
	Declare Sub Move()
	Declare Sub MoveBy(x As Single, y As Single, z As Single)
	Declare Sub Rotate(As Cursor Ptr)
End Type

#EndIf