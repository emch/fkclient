#Include "headers/mesh.bi"

Constructor Mesh(size As Integer)
	This._size = size
	This._vertexArray = Callocate(NUM_VERTEX_COORDS*size, SizeOf(Single))
	This._normalArray = Callocate(NUM_NORMAL_COORDS*size, SizeOf(Single))
	This._colorArray = Callocate(NUM_COLOR_COORDS*size, SizeOf(Single))
	This._indexArray = Callocate(NUM_INDEX_COORDS*size, SizeOf(Single))
End Constructor

Destructor Mesh()
	DeAllocate(this._vertexArray)
End Destructor
