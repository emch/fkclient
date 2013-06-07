#Ifndef __HEADER_GUI_BI__
#define __HEADER_GUI_BI__

'' Here put all the functions related to gui:
'' -management (drawing, rendering, ...)
'' -widget creation
'' -events management
'' -...

Type GuiManager
	Private:
	_isEnabled As Byte
	_isVisible As Byte
	
	Public:
	Declare Constructor()
	Declare Destructor()
End Type

Type GuiWidget
	Private:
	_position As Integer 'create a vector2d class?
	_width As Integer
	_height As Integer 'vector2d dimensions?
	_isEnabled As Byte
	_isVisible As Byte
	'color? texture?
	
	Public:
	Declare Constructor()
	Declare Destructor()
End Type

Type GuiButton Extends GuiWidget
	Private:
	_text As String
	'callback->ptr to function
End Type

#EndIf