#Include "headers/cursor.bi"

Constructor Cursor()
	This._xrel = 0
	This._yrel = 0
End Constructor

Function Cursor.GetXrel() As Integer
	Return This._xrel
End Function

Function Cursor.GetYrel() As Integer
	Return This._yrel
End Function

Sub Cursor.Update(xrel As Integer, yrel As Integer, s_width As Integer, s_height As Integer)
	This._xrel = xrel ' - s_width/2
	This._yrel = yrel ' - s_height/2
End Sub
