#Include "headers/globals.bi"
#Include "headers/chunk.bi"
#Include "headers/block.bi"
#Include "headers/mesh.bi"
#Include "headers/logging.bi"
#Include "gl/gl.bi"

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
	This._mesh->Destructor()
End Destructor

Sub Chunk.Load() '' adapt to load from binary information
	Dim As Integer i, j, k
	
	For i = 0 To CHUNK_SIZE - 1
		For j = 0 To CHUNK_SIZE - 1
			For k = 0 To CHUNK_SIZE - 1
				This._blocks[i][j][k] = Block()
			Next
		Next
	Next
End Sub

Sub Chunk.CreateMesh(texNames As GLuint Ptr)
	Dim As Integer x,y,z
	
	This._mesh = New Mesh(MAX_VERTICES)
	
	'' Fill mesh arrays with data from Chunk
	For x = 0 To CHUNK_SIZE - 1
		For y = 0 To CHUNK_SIZE - 1
			For z = 0 To CHUNK_SIZE - 1
				If This._blocks[x][y][z].IsActive() = TRUE Then
					This._mesh->AppendCube(x,y,z, texNames[This._blocks[x][y][z].GetBlocktype()])
				EndIf
			Next
		Next
	Next
End Sub

Property Chunk.Update(dt As Single)
	'' UpdateMesh here ! --> use an array?
End Property

Sub Chunk.Render(b_position As Vector3d)
	'' Activate rendering from arrays
	glEnableClientState(GL_VERTEX_ARRAY)
	glEnableClientState(GL_NORMAL_ARRAY)
	glEnableClientState(GL_COLOR_ARRAY)
	glEnableClientState(GL_TEXTURE_COORD_ARRAY)
	
	'' Assign pointers to data
	glVertexPointer(NUM_VERTEX_COORDS, GL_FLOAT, 0, This._mesh->GetVertexArray())
	glNormalPointer(GL_FLOAT, 0, This._mesh->GetNormalArray())
	glColorPointer(NUM_COLOR_COORDS, GL_FLOAT, 0, This._mesh->GetColorArray())
	glTexCoordPointer(NUM_TEX_COORDS, GL_INT, 0, This._mesh->GetTexCoordArray())
	
	glPushMatrix()
	'' Translate Chunk position
	glTranslatef(b_position.X, b_position.Y, b_position.Z)

	'' Draw mesh
	glDrawElements(GL_TRIANGLES, This._mesh->GetNumIndices(), GL_UNSIGNED_INT, This._mesh->GetIndexArray())
	
	glPopMatrix()
	
	'' Disable rendering from arrays
	glDisableClientState(GL_VERTEX_ARRAY)
	glDisableClientState(GL_NORMAL_ARRAY)
	glDisableClientState(GL_COLOR_ARRAY)
	glDisableClientState(GL_TEXTURE_COORD_ARRAY)
End Sub

Function Chunk.GetBlocks() As Block Ptr Ptr Ptr
	Return This._blocks
End Function
