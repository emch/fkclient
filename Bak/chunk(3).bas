#Include "headers/globals.bi"
#Include "headers/chunk.bi"
#Include "headers/block.bi"
#Include "headers/mesh.bi"
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
End Destructor

Sub Chunk.CreateMesh()
	Dim As Integer x,y,z
	
	This._mesh = New Mesh(MAX_VERTICES)
	
	'' Fill mesh arrays with data from Chun
	For x = 0 To CHUNK_SIZE - 1
		For y = 0 To CHUNK_SIZE - 1
			For z = 0 To CHUNK_SIZE - 1
				If This._blocks[x][y][z].IsActive() = TRUE Then
					This._mesh->AppendCube(x,y,z)
				EndIf
			Next
		Next
	Next
End Sub

Property Chunk.Update(dt As Single)
	'' UpdateMesh here !
End Property

Property Chunk.Render(b_position As Vector3d)
	'' Activate rendering from arrays
	glEnableClientState(GL_COLOR_ARRAY Or GL_NORMAL_ARRAY Or GL_VERTEX_ARRAY) ''GL_TEXTURE_COORD_ARRAY Or
	
	'' simple call to glDrawElements via Mesh
	glVertexPointer(NUM_VERTEX_COORDS, GL_FLOAT, 0, This._mesh->GetVertexArray())
	glNormalPointer(GL_FLOAT, 0, This._mesh->GetNormalArray())
	glColorPointer(NUM_COLOR_COORDS, GL_FLOAT, 0, This._mesh->GetColorArray())
	glIndexPointer(GL_FLOAT, 0, This._mesh->GetIndexArray())
	''glTexCoordPointer : see how textures are rendered
	
	glDrawArrays(GL_TRIANGLES, 0, 36)
	
	'' Disable rendering from arrays
	glDisableClientState(GL_COLOR_ARRAY Or GL_NORMAL_ARRAY Or GL_VERTEX_ARRAY)
End Property
