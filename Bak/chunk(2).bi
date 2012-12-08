#Ifndef __HEADER_CHUNK_BI__
#define __HEADER_CHUNK_BI__

#Include "headers/params.bi"
#Include "block.bi"
#Include "headers/mesh.bi"

Type Chunk
	Private:
	_blocks as Block Ptr Ptr Ptr
	_mesh As Mesh
	
	Public:
	Declare Constructor()
	Declare Destructor()
	Declare Sub CreateMesh()
	Declare Property Update(As Single)
	Declare Property Render(As Vector3d)
End Type

#endif