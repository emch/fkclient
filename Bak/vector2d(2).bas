#Include "headers/vector2d.bi"

Constructor Vector2d() '' default constructor
	This._x = 0.0f
	This._y = 0.0f
End Constructor

Constructor Vector2d(b_x As Single, b_y As Single) '' complete constructor
	This._x = b_x
	This._y = b_y
End Constructor

Constructor Vector2d(tocopy As Vector2d Ptr) '' copy
	This._x = tocopy->X
	This._y = tocopy->Y
End Constructor

Property Vector2d.X As Single
	Return This._x
End Property

Property Vector2d.Y As Single
	Return This._y
End Property

Sub Vector2d.SetX(b_x As Single)
	This._x = b_x
End Sub

Sub Vector2d.SetY(b_y As Single)
	This._y = b_y
End Sub

Sub Vector2d.Normalize()
	Dim norm As Single = Sqr(This.X * This.X + This.Y * This.Y)
	If norm <> 0 Then
		This._x /= norm
		This._y /= norm
	EndIf
End Sub

Operator +(v As Vector2d, w As Vector2d) As Vector2d
	Return Vector2d(v.X+w.X, v.Y+w.Y)
End Operator

Operator -(v As Vector2d, w As Vector2d) As Vector2d
	Return Vector2d(v.X-w.X, v.Y-w.Y)
End Operator

Operator *(c As Single, v As Vector2d) As Vector2d
	Return Vector2d(c*v.X, c*v.Y)
End Operator

Operator /(v As Vector2d, c As Single) As Vector2d
	Return Vector2d(v.X/c, v.Y/c)
End Operator

Function CrossProduct(v As Vector3d, w As Vector3d) As Vector3d '' TODO
	Return Vector3d(v.Y*w.Z-v.Z*w.Y, w.X*v.Z-v.X*w.Z, v.X*w.Y-w.X*v.Y)
End Function
