#Ifndef __HEADER_MESH_BI__
#define __HEADER_MESH_BI__

#Include "gl/gl.bi"

#Define NUM_VERTEX_COORDS 	3
#Define NUM_NORMAL_COORDS 	3
#Define NUM_COLOR_COORDS	4
#Define NUM_INDEX_COORDS	1
#Define MAX_VERTICES 		16384	'' maximum number of vertices in one mesh

Type Mesh
	Private:
	_size As Integer					'' maximum number of vertices
	_vertexArray As GLfloat Ptr	'' glVertexPointer
	_normalArray As GLfloat Ptr 	'' glNormalPointer
	_colorArray As GLfloat Ptr 	'' glColorPointer
	_indexArray As GLfloat Ptr		'' glIndexPointer
	'' texcoords
	'' edgeflag?
	
	Public:
	Declare Constructor(As Integer)
	Declare Destructor()
	Declare Function GetVertexArray() As GLfloat Ptr
	Declare Function GetNormalArray() As GLfloat Ptr
	Declare Function GetColorArray() As GLfloat Ptr
	Declare Function GetIndexArray() As GLfloat Ptr
End Type

#EndIf
