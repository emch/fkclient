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

Sub VectProd(vect1 As Vector3d Ptr, vect2 As Vector3d Ptr, outvect As Vector3d Ptr)
	outvect = New Vector3d(vect1->Y*vect2->Z-vect1->Z*vect2->Y, vect2->X*vect1->Z-vect2->Z*vect1->X, vect1->X*vect2->Y-vect2->X*vect1->Z)
End Sub
