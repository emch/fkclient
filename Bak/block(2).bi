#Ifndef __HEADER_BLOCK_BI__
#define __HEADER_BLOCK_BI__

#Include "vector3d.bi"
#Include "blocktype.bi"

#Define BLOCK_RENDER_SIZE	0.5	'' so that the cube will be one unit big

Type Block
	Private:
	_isActive As Byte
	_blocktype As Blocktype
   
   Public:
   Declare Constructor()
   ''Declare Destructor()
   Declare Function IsActive() As Byte
   Declare Property SetActive(As Integer)
End Type

'Declare Sub RenderBlock(As Block, As Vector3d)

#endif