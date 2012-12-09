#Ifndef __HEADER_MESH_BI__
#define __HEADER_MESH_BI__

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
