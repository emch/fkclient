#Include "headers/camera.bi"
#Include "headers/vector3d.bi"

Constructor Camera()
	This._position = New Vector3d()
	This._direction = New Vector3d() '' change to handle initial direction?
End Constructor

Function Camera.GetPosition() As Vector3d Ptr
	Return This._position
End Function

Function Camera.GetDirection() As Vector3d Ptr
	Return This._direction
End Function

Sub Camera.SetPosition(b_pos As Vector3d Ptr)
	This._position = b_pos
End Sub

Sub Camera.SetDirection(b_dir As Vector3d Ptr)
	This._direction = b_dir
End Sub
