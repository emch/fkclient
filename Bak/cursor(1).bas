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

Sub Cursor.Update(xrel As Integer, yrel As Integer, s_width As Integer, s_height As Integer)
	This._xrel = xrel ' - s_width/2
	This._yrel = yrel ' - s_height/2
End Sub
