#Ifndef __HEADER_CURSOR_BI__
#define __HEADER_CURSOR_BI__

Type Cursor
	Private:
	_x As Integer 	'xrel?
	_y As Integer	'yrel?
	
	Public:
	Declare Constructor()
	Declare Function GetX() As Integer
	Declare Function GetY() As Integer
	Declare Sub Update(As Integer, As Integer, As Integer, As Integer)
End Type

#EndIf
