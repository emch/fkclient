#ifndef __HEADER_VECTOR3D_BI__
#define __HEADER_VECTOR3D_BI__

''#Inclib "vector3d"

Type Vector3d
	Private:
   _x As Single
   _y As Single
   _z As Single
   
   Public:
   Declare Constructor()
   Declare Constructor(As Single, As Single, As Single)
   Declare Property X As Single
   Declare Property Y As Single
   Declare Property Z As Single
End Type

#endif