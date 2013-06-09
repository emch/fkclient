#Ifndef __HEADER_GUI_BI__
#define __HEADER_GUI_BI__

#Include "gl/gl.bi"
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

Type GuiManager 'Make it a parameter of fkclient
	Private:
	_widgets 			As LinkedList
	_isEnabled 			As Byte
	_isVisible 			As Byte
	_eventsource 		As GuiEventSource
	
	_size 				As Integer		'' maximum number of vertices
	_num 					As Integer 		'' number of vertices
	_indexArrayIndice As Integer		'' running indice in indexArray
	_vertexArray 		As GLfloat Ptr	'' glVertexPointer
	_normalArray 		As GLfloat Ptr '' glNormalPointer
	_colorArray 		As GLfloat Ptr '' glColorPointer
	_indexArray 		As GLuint Ptr
	_texcoordArray 	As Integer Ptr '' glTexCoordPointer
	
	'' Rendering arrays
	Declare Function GetVertexArray() As GLfloat Ptr
	Declare Function GetNormalArray() As GLfloat Ptr
	Declare Function GetColorArray() As GLfloat Ptr
	Declare Function GetIndexArray() As GLuint Ptr
	Declare Function GetTexCoordArray() As Integer Ptr 
	Declare Function GetNumVertices() As Integer
	Declare Function GetNumIndices() As Integer
	
	'' Mesh generation functions
	'Declare Sub AddVertex(As Vector3d, As Vector3d, As GLfloat, As GLfloat, As GLfloat, As GLfloat, As Integer, As Integer)
	'Declare Sub AddTriangle(As GLuint, As GLuint, As GLuint)
	Declare Function AppendQuad() As Byte
	Declare Sub LoadTexInfo() ' Load info from the first/unique TDF file located in Res/Gui
	
	Public:
	Declare Constructor()
	Declare Destructor()
	Declare Sub InitGui()
	Declare Sub RenderGui()
	Declare Sub PollEvents() 'Get through all widgets
	Declare Sub AddWidget(As GuiWidget Ptr)
	Declare Sub RemoveWidget(As GuiWidget Ptr)
End Type

Type GuiFont
	Private:
	_fntfile As String
End Type

Type GuiWidget
	Private:
	_parent							As GuiWidget Ptr
	_position 						As Vector2d
	_dimensions 					As Vector2d
	_imargins(4)					As Integer
	_isEnabled 						As Byte
	_isVisible 						As Byte
	_font 							As GuiFont
	_fntcolor 						As Integer
	_backcolor 						As Integer
	_eventsCbs(GUI_NUM_EVENTS) As Any Ptr
	'texture info?
	'http://virtualink.wikidot.com/fbtut:fbpdatatype
	
	Public:
	Declare Constructor()
	Declare Destructor()
	Declare Sub	SetEnabled(As Byte)
End Type

'Widgets in a GuiPanel are defined relatively to it (position)
Type GuiPanel Extends GuiWidget 
	Private:
	_widgets 	As LinkedList
End Type

Type GuiButton Extends GuiWidget
	Private:
	_text 		As String
	_textpos		As Vector2d
End Type

#EndIf