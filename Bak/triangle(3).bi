#Ifndef __HEADER_TRIANGLE_BI__
#define __HEADER_TRIANGLE_BI__

#Include "headers/vertex.bi"

Type Triangle
	Private:
	_vertices As Vertex Ptr
	
	Public:
	Declare Constructor(As Vertex, As Vertex, As Vertex)
End Type

#EndIf
