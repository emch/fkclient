#Include "gl/gl.bi"
#Include "headers/camera.bi"
#Include "headers/vector3d.bi"
#Include "headers/logging.bi"

Constructor Camera()
	This._position = New Vector3d()
	This._direction = New Vector3d(0.0, 0.0, -1.0) 	'' initial direction points in screen (set as param/config?)
	This._vertical = New Vector3d(0.0, -1.0, 0.0)	'' Y axis is pointing toward the bottom of the screen
End Constructor

Sub Camera.Initialize()
	This.SetPosition(New Vector3d(0.0, 0.0, -10.0)) '' Put in parameter or read a file or ...
End Sub

Function Camera.GetPosition() As Vector3d Ptr
	Return This._position
End Function

Function Camera.GetDirection() As Vector3d Ptr
	Return This._direction
End Function

Function Camera.GetVertical() As Vector3d Ptr
	Return This._vertical
End Function

Sub Camera.SetPosition(b_pos As Vector3d Ptr)
	This._position = b_pos
End Sub

Sub Camera.SetDirection(b_dir As Vector3d Ptr)
	This._direction = b_dir
End Sub

Sub Camera.Move()
	glTranslatef(This.GetPosition()->X, This.GetPosition()->Y, This.GetPosition()->Z)
End Sub

Sub Camera.MoveBy(x As Single, y As Single, z As Single)
	Dim orthovect As Vector3d Ptr
	VectProd(This._direction, This._vertical, orthovect)
	
	'This.GetPosition()->SetX(This.GetPosition()->X + x)	'' for X, we move along the vector orthogonal to vertical & direction
	This.GetPosition()->SetX(This.GetPosition()->X + x)
	This.GetPosition()->SetY(This.GetPosition()->Y + y)	'' for Y, we move along the vertical
	This.GetPosition()->SetZ(This.GetPosition()->Z + z)	'' for Z, we move along the direction
	'This.Move()
End Sub

Sub Camera.PointAt(x As Single, y As Single, z As Single)
	
End Sub
