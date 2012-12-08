#Ifndef __HEADER_MESH_BI__
#define __HEADER_MESH_BI__

#Include "headers/vertex.bi"
#Include "headers/triangle.bi"

Type Mesh
	Private:
	_size As Integer				'' maximum number of vertices
	_vertices As Vertex Ptr		'' array of vertices to be rendered by OpenGL (see glDrawArrays/glDrawElements functions)
	_triangles As Triangle Ptr	'' useful?
	
	Public:
	Declare Constructor(As Integer)
	Declare Destructor()
End Type

#EndIf
