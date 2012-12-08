' see glDrawArrays and how to 'activate' arrays

#Ifndef __HEADER_MESH_BI__
#define __HEADER_MESH_BI__

#Include "headers/vertex.bi"
#Include "headers/triangle.bi"

Type Mesh
	Private:
	_size As Integer				'' maximum number of vertices
	_vertices As Vertex Ptr
	_triangles As triangle Ptr
	
	Public:
	Declare Constructor(As Integer)
	Declare Destructor()
End Type

#EndIf
