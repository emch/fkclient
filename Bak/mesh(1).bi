#Ifndef __HEADER_MESH_BI__
#define __HEADER_MESH_BI__

#Include "gl/gl.bi"
#Include "headers/params.bi"

#Define NUM_VERTEX_COORDS 	3
#Define NUM_NORMAL_COORDS 	3
#Define NUM_COLOR_COORDS	4
#Define NUM_INDEX_COORDS	1
#Define MAX_VERTICES 		4*BLOCKS_PER_CHUNK	'' maximum number of vertices in one mesh = 16384

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
	'' Rendering arrays
	Declare Function GetVertexArray() As GLfloat Ptr
	Declare Function GetNormalArray() As GLfloat Ptr
	Declare Function GetColorArray() As GLfloat Ptr
	Declare Function GetIndexArray() As GLfloat Ptr
	'' Mesh generation functions
	Declare Function AppendCube(As Integer, As Integer, As Integer) As Byte
End Type

#EndIf
