#Ifndef __HEADER_MESH_BI__
#define __HEADER_MESH_BI__

#Include "gl/gl.bi"
#Include "headers/params.bi"
#Include "headers/vector3d.bi"

#Define NUM_VERTEX_COORDS 	3
#Define NUM_NORMAL_COORDS 	3
#Define NUM_COLOR_COORDS	4
#Define NUM_INDEX_COORDS	2 '' 6/4
#Define MAX_VERTICES 		10*4*BLOCKS_PER_CHUNK	'' maximum number of vertices in one mesh = 98304 (cf. 6 faces et 4 vertices par face)

Type Mesh
	Private:
	_size As Integer					'' maximum number of vertices
	_num As Integer 					'' number of vertices
	_indexArrayIndice As Integer	'' running indice in indexArray
	_vertexArray As GLfloat Ptr	'' glVertexPointer
	_normalArray As GLfloat Ptr 	'' glNormalPointer
	_colorArray As GLfloat Ptr 	'' glColorPointer
	_indexArray As Integer Ptr		'' glIndexPointer
	'' texcoords
	'' edgeflag?
	
	Public:
	Declare Constructor(As Integer)
	Declare Destructor()
	'' Rendering arrays
	Declare Function GetVertexArray() As GLfloat Ptr
	Declare Function GetNormalArray() As GLfloat Ptr
	Declare Function GetColorArray() As GLfloat Ptr
	Declare Function GetIndexArray() As Integer Ptr
	'' Mesh generation functions
	Declare Function AddVertex(As Vector3d, As Vector3d, As GLfloat, As GLfloat, As GLfloat, As GLfloat) As Integer
	Declare Sub AddTriangle(As Integer, As Integer, As Integer)
	Declare Function AppendCube(As Single, As Single, As Single) As Byte
End Type

#EndIf
