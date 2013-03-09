#Ifndef __HEADER_MESH_BI__
#define __HEADER_MESH_BI__

#Include "gl/gl.bi"
#Include "headers/params.bi"
#Include "headers/vector3d.bi"

#Define NUM_VERTEX_COORDS 	3
#Define NUM_NORMAL_COORDS 	3
#Define NUM_COLOR_COORDS	4
#Define NUM_INDEX_COORDS	NUM_VERTEX_COORDS/2
#Define NUM_TEX_COORDS		2
#Define MAX_VERTICES 		24*BLOCKS_PER_CHUNK

Type Mesh
	Private:
	_size As Integer					'' maximum number of vertices
	_num As Integer 					'' number of vertices
	_indexArrayIndice As Integer	'' running indice in indexArray
	_vertexArray As GLfloat Ptr	'' glVertexPointer
	_normalArray As GLfloat Ptr 	'' glNormalPointer
	_colorArray As GLfloat Ptr 	'' glColorPointer
	_indexArray As GLuint Ptr
	_texcoordArray As Integer Ptr '' glTexCoordPointer
	
	Public:
	Declare Constructor(As Integer)
	Declare Destructor()
	'' Rendering arrays
	Declare Function GetVertexArray() As GLfloat Ptr
	Declare Function GetNormalArray() As GLfloat Ptr
	Declare Function GetColorArray() As GLfloat Ptr
	Declare Function GetIndexArray() As Integer Ptr
	Declare Function GetTexCoordArray() As Integer Ptr 
	Declare Function GetNumVertices() As Integer
	Declare Function GetNumIndices() As Integer
	'' Mesh generation functions
	Declare Sub AddVertex(As Vector3d, As Vector3d, As GLfloat, As GLfloat, As GLfloat, As GLfloat, As Integer, As Integer)
	Declare Sub AddTriangle(As UInteger, As UInteger, As UInteger)
	Declare Function AppendCube(As Single, As Single, As Single) As Byte
End Type

#EndIf
