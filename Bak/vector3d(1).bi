#Ifndef __HEADER_VECTOR3D_BI__
#define __HEADER_VECTOR3D_BI__

Type Vector3d
	Private:
   _x As Single
   _y As Single
   _z As Single
   
   Public:
   Declare Constructor()
   Declare Constructor(As Single, As Single, As Single)
   Declare Constructor(As Vector3d Ptr)
   Declare Property X As Single
   Declare Property Y As Single
   Declare Property Z As Single
   Declare Sub SetX(As Single)
   Declare Sub SetY(As Single)
   Declare Sub SetZ(As Single)
End Type

Declare Operator +(As Vector3d, As Vector3d) As Vector3d
Declare Operator -(As Vector3d, As Vector3d) As Vector3d
Declare Operator *(As Single, As Vector3d) As Vector3d
Declare Operator /(As Vector3d, As Single) As Vector3d
Declare Function CrossProduct(As Vector3d, As Vector3d) As Vector3d

#EndIf