#Include "gl/gl.bi"
#Include "gl/glu.bi"
#Include "headers/camera.bi"
#Include "headers/vector3d.bi"
#Include "headers/logging.bi"
#Include "headers/cursor.bi"

Constructor Camera()
	This._position = New Vector3d()
	This._direction = New Vector3d(0.0, 0.0, -1.0) 	'' initial direction points in screen (set as param/config?)
	This._vertical = New Vector3d(0.0, -1.0, 0.0)	'' initial vertical (Y axis is pointing toward the bottom of the screen)
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

'' Moving camera in its current referential
Sub Camera.MoveBy(x As Single, y As Single, z As Single)
	'Dim orthovect As Vector3d Ptr
	'VectProd(This._direction, This._vertical, orthovect)
	'implement different camera modes
	
	This.GetPosition()->SetX(This.GetPosition()->X + x)	'' TODO: for X, we move along the vector orthogonal to vertical & direction
	This.GetPosition()->SetY(This.GetPosition()->Y + y)	'' TODO: for Y, we move along the vertical?
	This.GetPosition()->SetZ(This.GetPosition()->Z + z)	'' TODO: for Z, we move along the direction
	'This.Move()
End Sub

'' Pointing to a given point
Sub Camera.Rotate(cursor As Cursor Ptr) '' in which referential should vect be expressed?
	
	
	'' Look at
	'glLoadIdentity
	'gluLookAt(This.GetPosition()->X, This.GetPosition()->Y, This.GetPosition()->Z, locx->X, locx->Y, locx->Z, 0.0, -1.0, 0.0)
End Sub
