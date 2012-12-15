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
   Declare Property X As Single
   Declare Property Y As Single
   Declare Property Z As Single
   Declare Sub SetX(As Single)
   Declare Sub SetY(As Single)
   Declare Sub SetZ(As Single)
End Type

Declare Function VectAdd(As Vector3d Ptr, As Vector3d Ptr) As Vector3d Ptr		'' adding vectors
Declare Function VectConstMult(As Vector3d Ptr, As Single) As Vector3d Ptr			'' multiplying by constant
Declare Function VectMult(As Vector3d Ptr, As Vector3d Ptr) As Vector3d Ptr			'' vectorial product
Declare Function VectScalarProd(As Vector3d Ptr, As Vector3d Ptr) As Single	'' scalar product
Declare Sub VectOrthProj(As Vector3d Ptr, As Vector3d Ptr, As Vector3d Ptr)	'' orthgonal projection
Declare Sub VectNormalize(As Vector3d Ptr, As Vector3d Ptr)							'' normalization
Declare Function VectCopy(As Vector3d Ptr) As Vector3d Ptr							'' copy

#EndIf