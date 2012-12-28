#Ifndef __HEADER_BLOCK_BI__
#define __HEADER_BLOCK_BI__

#Include "vector3d.bi"
#Include "blocktype.bi"

#Define BLOCK_RENDER_SIZE	0.5

Type Block
	Private:
	_isActive As Byte
	_blocktype As Blocktype Ptr
   
   Public:
   Declare Constructor()
   Declare Function IsActive() As Byte
   Declare Property SetActive(As Integer)
End Type

#endif