#Ifndef __HEADER_CURSOR_BI__
#define __HEADER_CURSOR_BI__

Type Cursor
	Private:
	_x As Integer
	_y As Integer
	
	Public:
	Declare Constructor()
	Declare Function GetX() As Integer
	Declare Function GetY() As Integer
	Declare Function Update(As Integer, As Integer)
End Type

#EndIf
