#Ifndef __HEADER_CHUNK_BI__
#define __HEADER_CHUNK_BI__

#Include "params.bi"
#Include "block.bi"

Type Chunk
	Private:
	Dim _blocks as Block Ptr Ptr Ptr
	
	Public:
	Declare Constructor()
	Declare Destructor()
	Declare Property Update(As Single)
	Declare Property Render(As Vector3d)
End Type

#endif