#Ifndef __HEADER_CAMERA_BI__
#define __HEADER_CAMERA_BI__

#Include "headers/vector3d.bi"

Type Camera
	Private:
	_position As Vector3d
	_direction As Vector3d
	
	Public:
	Declare Constructor()
	Declare Constructor(As Vector3d)
	Declare Function GetPosition() As Vector3d
	Declare Function GetDirection() As Vector3d
	Declare Sub SetPosition(As Vector3d)
	Declare Sub SetDirection(As Vector3d)
End Type

#EndIf