#Include "headers/cursor.bi"

Constructor Cursor()
	This._x = 0
	This._y = 0
End Constructor

Function Cursor.GetX() As Integer
	Return This._x
End Function

Function Cursor.GetY() As Integer
	Return This._y
End Function

Sub Cursor.Update(x As Integer, y As Integer, s_height As Integer, s_width As Integer)
	This._x = x - s_width/2
	This._y = y - s_width/2
End Sub
