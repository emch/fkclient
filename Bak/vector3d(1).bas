#Include "headers/vector3d.bi"

Constructor Vector3d() '' default constructor
	This._x = 0.0f
	This._y = 0.0f
	This._z = 0.0f
End Constructor

Constructor Vector3d(b_x As Single, b_y As Single, b_z As Single) '' complete constructor
	This._x = b_x
	This._y = b_y
	This._z = b_z
End Constructor

Property Vector3d.X As Single
	Return This._x
End Property

Property Vector3d.Y As Single
	Return This._y
End Property

Property Vector3d.Z As Single
	Return This._z
End Property

Sub Vector3d.SetX(b_x As Single)
	This._x = b_x
End Sub

Sub Vector3d.SetY(b_y As Single)
	This._y = b_y
End Sub

Sub Vector3d.SetZ(b_z As Single)
	This._z = b_z
End Sub

Function VectAdd(vect1 As Vector3d Ptr, vect2 As Vector3d Ptr) As Vector3d Ptr
	Return New Vector3d(vect1->X+vect2->X, vect1->Y+vect2->Y, vect1->Z+vect2->Z)
End Function

Function VectConstMult(vect As Vector3d Ptr, constt As Single) As Vector3d Ptr
	Return New Vector3d(constt * vect->X, constt * vect->Y, constt * vect->Z)
End Function

Function VectMult(vect1 As Vector3d Ptr, vect2 As Vector3d Ptr) As Vector3d Ptr
	Return New Vector3d(vect1->Y*vect2->Z-vect1->Z*vect2->Y, vect2->X*vect1->Z-vect2->Z*vect1->X, vect1->X*vect2->Y-vect2->X*vect1->Z)
End Function

Function VectScalarProd(vect1 As Vector3d Ptr, vect2 As Vector3d Ptr) As Single
	Return vect1->X * vect2->X + vect1->Y * vect2->Y + vect1->Z * vect2->Z
End Function

'' Orthogonal projection of vect over a vector over
Sub VectOrthProj(vect As Vector3d Ptr, over As Vector3d Ptr, outvect As Vector3d Ptr)
	'' a*(x.a)/norm(A)^2
End Sub

'' Normalize vector
Function VectNormalize(invect As Vector3d Ptr) As Vector3d Ptr
	Dim norm As Single = Sqr(invect->X * invect->X + invect->Y * invect->Y + invect->Z * invect->Z)
	outvect = New Vector3d(invect->X/norm, invect->Y/norm, invect->Z/norm)
End Function

Function VectCopy(tocopy As Vector3d Ptr) As Vector3d Ptr
	Return New Vector3d(tocopy->X, tocopy->Y, tocopy->Z)
End Function
