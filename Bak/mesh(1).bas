#Include "headers/mesh.bi"
#Include "headers/globals.bi"
#Include "headers/vector3d.bi"
#Include "headers/block.bi"

Constructor Mesh(size As Integer)
	This._size = size
	This._num = 0
	This._vertexArray = Callocate(NUM_VERTEX_COORDS*size, SizeOf(GLfloat))
	This._normalArray = Callocate(NUM_NORMAL_COORDS*size, SizeOf(GLfloat))
	This._colorArray = Callocate(NUM_COLOR_COORDS*size, SizeOf(GLfloat))
	This._indexArray = Callocate(NUM_INDEX_COORDS*size, SizeOf(Integer))
End Constructor

Destructor Mesh()
	DeAllocate(this._vertexArray)
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

Function Mesh.GetIndexArray() As Integer Ptr
	Return This._indexArray
End Function

Function Mesh.AddVertex(vect As Vector3d, norm As Vector3d, r As GLfloat, g As GLfloat, b As GLfloat, a As GLfloat) As Integer
	'' Return current position in _indexArray
	This._num += 1
	Return This._num
End Function

Sub Mesh.AddTriangle(ind1 As Integer, ind2 As Integer, ind3 As Integer)
	
End Sub

Function Mesh.AppendCube(x As Single, y As Single, z As Single) As Byte
	'' Cube extremities
	Dim p1 As Vector3d = Vector3d(x-BLOCK_RENDER_SIZE, y-BLOCK_RENDER_SIZE, z+BLOCK_RENDER_SIZE)
	Dim p2 As Vector3d = Vector3d(x+BLOCK_RENDER_SIZE, y-BLOCK_RENDER_SIZE, z+BLOCK_RENDER_SIZE)
   Dim p3 As Vector3d = Vector3d(x+BLOCK_RENDER_SIZE, y+BLOCK_RENDER_SIZE, z+BLOCK_RENDER_SIZE)
   Dim p4 As Vector3d = Vector3d(x-BLOCK_RENDER_SIZE, y+BLOCK_RENDER_SIZE, z+BLOCK_RENDER_SIZE)
   Dim p5 As Vector3d = Vector3d(x+BLOCK_RENDER_SIZE, y-BLOCK_RENDER_SIZE, z-BLOCK_RENDER_SIZE)
   Dim p6 As Vector3d = Vector3d(x-BLOCK_RENDER_SIZE, y-BLOCK_RENDER_SIZE, z-BLOCK_RENDER_SIZE)
   Dim p7 As Vector3d = Vector3d(x-BLOCK_RENDER_SIZE, y+BLOCK_RENDER_SIZE, z-BLOCK_RENDER_SIZE)
   Dim p8 As Vector3d = Vector3d(x+BLOCK_RENDER_SIZE, y+BLOCK_RENDER_SIZE, z-BLOCK_RENDER_SIZE)
	
	'' Normal vector
	Dim n1 As Vector3d = Vector3d()
	
	'' Indices
	Dim As Integer v1, v2, v3, v4, v5, v6, v7, v8
	
	'' Color / Texture?
	Dim r As GLfloat = 1.0
	Dim g As GLfloat = 1.0
	Dim b As GLfloat = 1.0
	Dim a As GLfloat = 1.0
	
	'' Beginning cube drawing
	' Front
	n1 = Vector3d(0.0, 0.0, 1.0)
	
	v1 = This.AddVertex(p1, n1, r, g, b, a)
	v2 = This.AddVertex(p2, n1, r, g, b, a)
	v3 = This.AddVertex(p3, n1, r, g, b, a)
	v4 = This.AddVertex(p4, n1, r, g, b, a)
	
	This.AddTriangle(v1, v2, v3)
	This.AddTriangle(v1, v3, v4)
	
	' Back
   n1 = Vector3d(0.0, 0.0, -1.0)

   v5 = This.AddVertex(p5, n1, r, g, b, a)
   v6 = This.AddVertex(p6, n1, r, g, b, a)
   v7 = This.AddVertex(p7, n1, r, g, b, a)
   v8 = This.AddVertex(p8, n1, r, g, b, a)

   This.AddTriangle(v5, v6, v7)
   This.AddTriangle(v5, v7, v8)
	
	' Right
	n1 = Vector3d(1.0, 0.0, 0.0)
	
	v2 = This.AddVertex(p2, n1, r, g, b, a)
	v5 = This.AddVertex(p5, n1, r, g, b, a)
	v8 = This.AddVertex(p8, n1, r, g, b, a)
	v3 = This.AddVertex(p3, n1, r, g, b, a)
	
	This.AddTriangle(v2, v5, v8)
	This.AddTriangle(v2, v8, v3)
	
	' Left
	n1 = Vector3d(-1.0, 0.0, 0.0)
	
	v6 = This.AddVertex(p6, n1, r, g, b, a)
	v1 = This.AddVertex(p1, n1, r, g, b, a)
	v4 = This.AddVertex(p4, n1, r, g, b, a)
	v7 = This.AddVertex(p7, n1, r, g, b, a)
	
	This.AddTriangle(v6, v1, v4)
	This.AddTriangle(v6, v4, v7)
   
   ' Top
	n1 = Vector3d(0.0, 1.0, 0.0)
	
	v4 = This.AddVertex(p4, n1, r, g, b, a)
	v3 = This.AddVertex(p3, n1, r, g, b, a)
	v8 = This.AddVertex(p8, n1, r, g, b, a)
	v7 = This.AddVertex(p7, n1, r, g, b, a)
	
	This.AddTriangle(v4, v3, v8)
	This.AddTriangle(v4, v8, v7)
	
	' Bottom
	n1 = Vector3d(0.0, -1.0, 0.0)
	
	v6 = This.AddVertexToMesh(m_meshID, p6, n1, r, g, b, a);
	v5 = m_pRenderer->AddVertexToMesh(m_meshID, p5, n1, r, g, b, a);
	v2 = m_pRenderer->AddVertexToMesh(m_meshID, p2, n1, r, g, b, a);
	v1 = m_pRenderer->AddVertexToMesh(m_meshID, p1, n1, r, g, b, a);
	
	m_pRenderer->AddTriangleToMesh(m_meshID, v6, v5, v2);
	m_pRenderer->AddTriangleToMesh(m_meshID, v6, v2, v1);
	
	Return TRUE
End Function
