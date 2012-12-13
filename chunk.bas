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
End Destructor

Sub Chunk.Load() '' adapt to load from file/other source
	Dim As Integer i, j, k
	
	For i = 0 To CHUNK_SIZE - 1
		For j = 0 To CHUNK_SIZE - 1
			For k = 0 To CHUNK_SIZE - 1
				This._blocks[i][j][k] = Block()
			Next
		Next
	Next
End Sub

Sub Chunk.CreateMesh()
	Dim As Integer x,y,z
	
	This._mesh = New Mesh(MAX_VERTICES)
	
	'' Fill mesh arrays with data from Chunk
	For x = 0 To CHUNK_SIZE - 1
		For y = 0 To CHUNK_SIZE - 1
			For z = 0 To CHUNK_SIZE - 1
				If This._blocks[x][y][z].IsActive() = TRUE Then
					This._mesh->AppendCube(x,y,z) '' add a cube to the mesh
				EndIf
			Next
		Next
	Next
End Sub

Property Chunk.Update(dt As Single)
	'' UpdateMesh here !
End Property

Sub Chunk.Render(b_position As Vector3d)
	'' Activate rendering from arrays
	glEnableClientState(GL_VERTEX_ARRAY And GL_NORMAL_ARRAY And GL_COLOR_ARRAY)
	
	'' Assign pointers to data
	glVertexPointer(NUM_VERTEX_COORDS, GL_FLOAT, 0, This._mesh->GetVertexArray())
	glNormalPointer(GL_FLOAT, 0, This._mesh->GetNormalArray())
	glColorPointer(NUM_COLOR_COORDS, GL_FLOAT, 0, This._mesh->GetColorArray())
	
	glPushMatrix()
	'' Translate Chunk position
	glTranslatef(b_position.X, b_position.Y, b_position.Z)

	glDrawArrays(GL_TRIANGLES, 0, This._mesh->GetNumVertices())
	'glDrawElements(GL_TRIANGLES, This._mesh->GetNumVertices(), GL_INT, This._mesh->GetIndexArray()) '' not working
	
	glPopMatrix()
	
	'' Disable rendering from arrays
	glDisableClientState(GL_COLOR_ARRAY And GL_NORMAL_ARRAY And GL_VERTEX_ARRAY)
End Sub

Function Chunk.GetBlocks() As Block Ptr Ptr Ptr
	Return This._blocks
End Function
