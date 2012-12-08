#Include "headers/chunk.bi"
#Include "headers/block.bi"

Constructor Chunk
	Dim i As Integer
	Dim j As Integer
	
	This._blocks = Callocate(CHUNK_SIZE, SizeOf(Block Ptr Ptr))
	
	For i = 0 To CHUNK_SIZE - 1
		This._blocks[i] = Callocate(CHUNK_SIZE, SizeOf(Block Ptr))
		
		For j = 0 To CHUNK_SIZE - 1
			This._blocks[i][j] = Callocate(CHUNK_SIZE, SizeOf(Block))
		Next j
	Next i
End Constructor

Destructor Chunk
	Dim i As Integer
	Dim j As Integer
	
	For i = 0 To CHUNK_SIZE - 1
		For j = 0 To CHUNK_SIZE - 1
			DeAllocate(This._blocks[i][j])
		Next
		DeAllocate(This._blocks[i])
	Next
	
	DeAllocate(This._blocks)
End Destructor

Property Chunk.Update(dt As Single)

End Property

Sub RenderChunk(b_chunk As Chunk, b_position As Vector3d)
	
End Sub
