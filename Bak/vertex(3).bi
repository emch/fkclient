#Ifndef __HEADER_VERTEX_BI__
#define __HEADER_VERTEX_BI__

#Include "headers/vector3d.bi"

Type Vertex
	Private:
	_pos As Vector3d
	_normal As Vector3d
	
	Public:
	Declare Constructor()
	Declare Destructor()
End Type

#EndIf
