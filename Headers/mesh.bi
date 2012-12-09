#Ifndef __HEADER_MESH_BI__
#define __HEADER_MESH_BI__

#Define NUM_VERTEX_COORDS 	3
#Define NUM_NORMAL_COORDS 	3
#Define NUM_COLOR_COORDS	4
#Define NUM_INDEX_COORDS	1

Type Mesh
	Private:
	_size As Integer					'' maximum number of vertices
	_vertexArray As Single Ptr		'' glVertexPointer
	_normalArray As Single Ptr 	'' glNormalPointer
	_colorArray As Single Ptr 		'' glColorPointer
	_indexArray As Single Ptr		'' glIndexPointer
	'' texcoords
	'' edgeflag?
	
	Public:
	Declare Constructor(As Integer)
	Declare Destructor()
End Type

#EndIf
