#Ifndef __HEADER_CAMERA_BI__
#define __HEADER_CAMERA_BI__

#Include "headers/vector3d.bi"

Type Camera
	Private:
	_position As Vector3d Ptr
	_direction As Vector3d Ptr
	_vertical As Vector3d Ptr
	
	Public:
	Declare Constructor()
	Declare Function GetPosition() As Vector3d Ptr
	Declare Function GetDirection() As Vector3d Ptr
	Declare Function GetVertical() As Vector3d Ptr
	Declare Sub SetPosition(As Vector3d Ptr)
	Declare Sub SetDirection(As Vector3d Ptr)
	
	Declare Sub Move()
	Declare Sub Move(x As Single, y As Single, z As Single)
	Declare Sub PointAt(As Single, As Single, As Single)
End Type

#EndIf