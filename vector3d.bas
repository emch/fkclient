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