#Include "headers/mesh.bi"

Constructor Mesh(size As Integer)
	This._size = size
	This._vertexArray = Callocate(NUM_VERTEX_COORDS*size, SizeOf(GLfloat))
	This._normalArray = Callocate(NUM_NORMAL_COORDS*size, SizeOf(GLfloat))
	This._colorArray = Callocate(NUM_COLOR_COORDS*size, SizeOf(GLfloat))
	This._indexArray = Callocate(NUM_INDEX_COORDS*size, SizeOf(GLfloat))
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
