#Ifndef __HEADER_CHUNK_BI__
#define __HEADER_CHUNK_BI__

#Include "headers/params.bi"
#Include "headers/block.bi"
#Include "headers/mesh.bi"

Type Chunk
	Private:
	_blocks as Block Ptr Ptr Ptr
	_mesh As Mesh Ptr
	
	Public:
	Declare Constructor()
	Declare Destructor()
	''Declare Function GetBlock(As Integer, As Integer, As Integer) As Block
	Declare Sub Load()
	Declare Sub CreateMesh()
	Declare Property Update(As Single)
	Declare Sub Render(As Vector3d)
	Declare Function GetBlocks() As Block Ptr Ptr Ptr
End Type

#endif