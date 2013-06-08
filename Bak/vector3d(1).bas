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

Constructor Vector3d(tocopy As Vector3d Ptr)
	This._x = tocopy->X
	This._y = tocopy->Y
	This._z = tocopy->Z
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

Sub Vector3d.Normalize()
	Dim norm As Single = Sqr(This.X * This.X + This.Y * This.Y + This.Z * This.Z)
	If norm <> 0 Then
		This._x /= norm
		This._y /= norm
		This._z /= norm
	EndIf
End Sub

Operator +(v As Vector3d, w As Vector3d) As Vector3d
	Return Vector3d(v.X+w.X, v.Y+w.Y, v.Z+w.Z)
End Operator

Operator -(v As Vector3d, w As Vector3d) As Vector3d
	Return Vector3d(v.X-w.X, v.Y-w.Y, v.Z-w.Z)
End Operator

Operator *(c As Single, v As Vector3d) As Vector3d
	Return Vector3d(c*v.X, c*v.Y, c*v.Z)
End Operator

Operator /(v As Vector3d, c As Single) As Vector3d
	Return Vector3d(v.X/c, v.Y/c, v.Z/c)
End Operator

Function CrossProduct(v As Vector3d, w As Vector3d) As Vector3d '' TODO
	Return Vector3d(v.Y*w.Z-v.Z*w.Y, w.X*v.Z-v.X*w.Z, v.X*w.Y-w.X*v.Y)
End Function
