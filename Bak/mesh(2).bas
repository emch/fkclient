#Include "sdl/sdl.bi"
#Include "sdl/sdl_image.bi"

#Include "headers/mesh.bi"
#Include "headers/globals.bi"
#Include "headers/vector3d.bi"
#Include "headers/block.bi"
#Include "headers/logging.bi"
#Include "headers/blocktype.bi"

Constructor Mesh(size As Integer)
	This._size = size
	This._num = 0
	This._indexArrayIndice = 0
	This._vertexArray = Callocate(NUM_VERTEX_COORDS*size, SizeOf(GLfloat))
	This._normalArray = Callocate(NUM_NORMAL_COORDS*size, SizeOf(GLfloat))
	This._colorArray = Callocate(NUM_COLOR_COORDS*size, SizeOf(GLfloat))
	This._indexArray = Callocate(NUM_INDEX_COORDS*size, SizeOf(GLuint))
	This._texcoordArray = Callocate(NUM_TEX_COORDS*size, SizeOf(Integer))
End Constructor

Destructor Mesh()
	DeAllocate(this._vertexArray)
	DeAllocate(this._normalArray)
	DeAllocate(this._colorArray)
	DeAllocate(this._indexArray)
	DeAllocate(this._texcoordArray)
End Destructor

Function Mesh.GetVertexArray() As GLfloat Ptr
	Return This._vertexArray
End Function

Function Mesh.GetNormalArray() As GLfloat Ptr
	Return This._normalArray
End Function

Function Mesh.GetColorArray() As GLfloat Ptr
	Return This._colorArray
End Function

Function Mesh.GetIndexArray() As GLuint Ptr
	Return This._indexArray
End Function

Function Mesh.GetTexCoordArray() As Integer Ptr
	Return This._texcoordArray
End Function

Sub Mesh.AddVertex(vect As Vector3d, norm As Vector3d, r As GLfloat, g As GLfloat, b As GLfloat, a As GLfloat, t1 As Integer, t2 As Integer)
	Dim vertexArrayIndex As Integer 		= NUM_VERTEX_COORDS 	* This._num
	Dim normalArrayIndex As Integer 		= NUM_NORMAL_COORDS 	* This._num
	Dim colorArrayIndex As Integer 		= NUM_COLOR_COORDS 	* This._num
	Dim texcoordArrayIndex As Integer 	= NUM_TEX_COORDS		* This._num
	
	'' Fill vertex array
	This._vertexArray[vertexArrayIndex] = vect.X
	This._vertexArray[vertexArrayIndex+1] = vect.Y
	This._vertexArray[vertexArrayIndex+2] = vect.Z
	
	'' Fill normal array
	This._normalArray[normalArrayIndex] = norm.X
	This._normalArray[normalArrayIndex+1] = norm.Y
	This._normalArray[normalArrayIndex+2] = norm.Z
	
	'' Fill color array
	This._colorArray[colorArrayIndex] = r
	This._colorArray[colorArrayIndex+1] = g
	This._colorArray[colorArrayIndex+2] = b
	This._colorArray[colorArrayIndex+3] = a
	
	'' Fill texcoord array
	This._texcoordArray[texcoordArrayIndex] = t1
	This._texcoordArray[texcoordArrayIndex+1] = t2
	
	'' Increase current number of vertices
	This._num += 1
End Sub

Sub Mesh.AddTriangle(ind1 As GLuint, ind2 As GLuint, ind3 As GLuint)
	Dim indexArrayIndex As Integer = This._indexArrayIndice
	
	This._indexArray[indexArrayIndex] = ind1
	This._indexArray[indexArrayIndex+1] = ind2
	This._indexArray[indexArrayIndex+2] = ind3
	
	This._indexArrayIndice += 3
End Sub

Function Mesh.AppendCube(x As Single, y As Single, z As Single, texName As GLuint) As Byte 'GLuint only (instead of Ptr)
	'' Cube extremities
	Dim v0v As Vector3d = Vector3d(x+BLOCK_RENDER_SIZE, y+BLOCK_RENDER_SIZE, z+BLOCK_RENDER_SIZE)
	Dim v1v As Vector3d = Vector3d(x-BLOCK_RENDER_SIZE, y+BLOCK_RENDER_SIZE, z+BLOCK_RENDER_SIZE)
   Dim v2v As Vector3d = Vector3d(x-BLOCK_RENDER_SIZE, y-BLOCK_RENDER_SIZE, z+BLOCK_RENDER_SIZE)
   Dim v3v As Vector3d = Vector3d(x+BLOCK_RENDER_SIZE, y-BLOCK_RENDER_SIZE, z+BLOCK_RENDER_SIZE)
   Dim v4v As Vector3d = Vector3d(x+BLOCK_RENDER_SIZE, y-BLOCK_RENDER_SIZE, z-BLOCK_RENDER_SIZE)
   Dim v5v As Vector3d = Vector3d(x+BLOCK_RENDER_SIZE, y+BLOCK_RENDER_SIZE, z-BLOCK_RENDER_SIZE)
   Dim v6v As Vector3d = Vector3d(x-BLOCK_RENDER_SIZE, y+BLOCK_RENDER_SIZE, z-BLOCK_RENDER_SIZE)
   Dim v7v As Vector3d = Vector3d(x-BLOCK_RENDER_SIZE, y-BLOCK_RENDER_SIZE, z-BLOCK_RENDER_SIZE)
   
   '' Texturing
   'Dim TexName As GLuint = texNames[8]
	glBindTexture(GL_TEXTURE_2D, texName)
   
   '' Textures coordinates
   'Dim t1 as vector2d = Vector2d(0,0) ...?
	
	'' Normal vector
	Dim n1 As Vector3d = Vector3d()
	
	'' IndicexArray length
	Dim indexArrayLength As Integer = This._num 'last indice before any modification
	
	'' Color / Texture?
	Dim r As GLfloat = 1.0
	Dim g As GLfloat = 1.0
	Dim b As GLfloat = 1.0
	Dim a As GLfloat = 1.0
	
	'' Beginning cube drawing
	' Top
	n1 = Vector3d(0.0, 0.0, 1.0)
	
	This.AddVertex(v0v, n1, r, g, b, a, 0, 0)
	This.AddVertex(v1v, n1, r, g, b, a, 1, 0)
	This.AddVertex(v2v, n1, r, g, b, a, 1, 1)
	This.AddVertex(v3v, n1, r, g, b, a, 0, 1)
	
	This.AddTriangle(indexArrayLength, indexArrayLength+1, indexArrayLength+2)
	This.AddTriangle(indexArrayLength+2, indexArrayLength+3, indexArrayLength)
	
	' Back
   n1 = Vector3d(1.0, 0.0, 0.0)

   This.AddVertex(v0v, n1, r, g, b, a, 0, 0)
   This.AddVertex(v3v, n1, r, g, b, a, 1, 0)
   This.AddVertex(v4v, n1, r, g, b, a, 1, 1)
   This.AddVertex(v5v, n1, r, g, b, a, 0, 1)

   This.AddTriangle(indexArrayLength+4, indexArrayLength+5, indexArrayLength+6)
   This.AddTriangle(indexArrayLength+6, indexArrayLength+7, indexArrayLength+4)
	
	' Left
	n1 = Vector3d(0.0, 1.0, 0.0)
	
	This.AddVertex(v0v, n1, r, g, b, a, 1, 0)
	This.AddVertex(v5v, n1, r, g, b, a, 1, 1)
	This.AddVertex(v6v, n1, r, g, b, a, 0, 1)
	This.AddVertex(v1v, n1, r, g, b, a, 0, 0)
	
	This.AddTriangle(indexArrayLength+8, indexArrayLength+9, indexArrayLength+10)
	This.AddTriangle(indexArrayLength+10, indexArrayLength+11, indexArrayLength+8)
	
	' Front
	n1 = Vector3d(-1.0, 0.0, 0.0)
	
	This.AddVertex(v1v, n1, r, g, b, a, 1, 0)
	This.AddVertex(v6v, n1, r, g, b, a, 1, 1)
	This.AddVertex(v7v, n1, r, g, b, a, 0, 1)
	This.AddVertex(v2v, n1, r, g, b, a, 0, 0)
	
	This.AddTriangle(indexArrayLength+12, indexArrayLength+13, indexArrayLength+14)
	This.AddTriangle(indexArrayLength+14, indexArrayLength+15, indexArrayLength+12)
   
   ' Right
	n1 = Vector3d(0.0, -1.0, 0.0)
	
	This.AddVertex(v7v, n1, r, g, b, a, 1, 1)
	This.AddVertex(v4v, n1, r, g, b, a, 0, 1)
	This.AddVertex(v3v, n1, r, g, b, a, 0, 0)
	This.AddVertex(v2v, n1, r, g, b, a, 1, 0)
	
	This.AddTriangle(indexArrayLength+16, indexArrayLength+17, indexArrayLength+18)
	This.AddTriangle(indexArrayLength+18, indexArrayLength+19, indexArrayLength+16)
	
	' Bottom
	n1 = Vector3d(0.0, 0.0, -1.0)
	
	This.AddVertex(v4v, n1, r, g, b, a, 0, 0)
	This.AddVertex(v7v, n1, r, g, b, a, 1, 0)
	This.AddVertex(v6v, n1, r, g, b, a, 1, 1)
	This.AddVertex(v5v, n1, r, g, b, a, 0, 1)
	
	This.AddTriangle(indexArrayLength+20, indexArrayLength+21, indexArrayLength+22)
	This.AddTriangle(indexArrayLength+22, indexArrayLength+23, indexArrayLength+20)
	
	Return TRUE
End Function

Function Mesh.GetNumVertices() As Integer
	Return This._num
End Function

Function Mesh.GetNumIndices() As Integer
	Return This._indexArrayIndice
End Function
