#Ifndef __HEADER_GUI_BI__
#define __HEADER_GUI_BI__

'' Here put all the functions related to gui:
'' -management (drawing, rendering, ...)
'' -widget creation
'' -events management
'' -...
'' widgets are opengl quads which rotate with the camera!! + texture
'' gui textures should be located in one file only + another files defines the different parts (corner, top, ...)

#Include "headers/linked_list.bi"
#Include "headers/vector2d.bi"

#Define GUI_NUM_EVENTS 3

Enum GuiEventSource
	GUI_EVENT_NONE 					= 0
	GUI_EVENT_MOUSE_LEFT_CLICK		= 1
	GUI_EVENT_MOUSE_RIGHT_CLICK	= 2
	GUI_EVENT_MOUSE_WHEEL_CLICK	= 3
	GUI_EVENT_MOUSE_WHEEL_UP		= 4
	GUI_EVENT_MOUSE_WHEEL_DOWN		= 5
End Enum

Enum GuiWidgetType
	WIDGET_PANEL  = 0
	WIDGET_BUTTON = 1
End Enum

Type GuiEvent
	Private:
	_source 		As GuiEventSource
End Type

Type GuiManager
	Private:
	_widgets 	As LinkedList
	_isEnabled 	As Byte
	_isVisible 	As Byte
	
	Public:
	Declare Constructor()
	Declare Destructor()
	Declare Sub RenderGui()	 ' opengl rendering (VBO)
	'TODO : get access to mouse cursor position & SDL events
	'cf. GuiManager parameter of fkclient.bas
	Declare Sub PollEvents() ' identify events in considered widget and deal with them
End Type

Type GuiFont
	Private:
	_fntfile As String
End Type

Type GuiWidget
	Private:
	_parent							As GuiWidget Ptr 'LinkedListItem?
	_position 						As Vector2d
	_dimensions 					As Vector2d
	_imargins(4)					As Integer
	_isEnabled 						As Byte
	_isVisible 						As Byte
	_font 							As GuiFont
	_fntcolor 						As Integer
	_backcolor 						As Integer
	_event							As GuiEvent ' put in GuiManager and bool here only?
	
	'Callbacks (if no pointer set, no callback called for this event!)
	_eventsCb(GUI_NUM_EVENTS) 	As Any Ptr
	'texture info?
	'http://virtualink.wikidot.com/fbtut:fbpdatatype see 'creating a callback function'
	
	Public:
	Declare Constructor()
	Declare Destructor()
End Type

'Widgets in a GuiPanel are defined relatively to it (position)
Type GuiPanel Extends GuiWidget 
	Private:
	_widgets 	As Integer 'linked_list?
End Type

'Type GuiLabel Extends GuiWidget
'	Private:
'	_text As String
'End Type

Type GuiButton Extends GuiWidget
	Private:
	_text 		As String
	_textpos		As Vector2d
End Type

#EndIf