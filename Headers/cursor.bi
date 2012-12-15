#Ifndef __HEADER_CURSOR_BI__
#define __HEADER_CURSOR_BI__

Type Cursor
	Private:
	_xrel As Integer 	'xrel?
	_yrel As Integer	'yrel?
	
	Public:
	Declare Constructor()
	Declare Function GetXrel() As Integer
	Declare Function GetYrel() As Integer
	Declare Sub Update(As Integer, As Integer, As Integer, As Integer)
End Type

#EndIf
