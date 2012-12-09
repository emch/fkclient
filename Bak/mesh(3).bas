#Include "headers/mesh.bi"

Constructor Mesh(size As Integer)
	This._size = size
	This._vertexArray = Callocate(3*size, SizeOf(Single))
	This._normalArray = Callocate(3*size, SizeOf(Single))
	This._colorArray = Callocate(4*size, SizeOf(Single))
	This._indexArray = Callocate(3*size, SizeOf(Single))
End Constructor

Destructor Mesh()
	DeAllocate(this._vertexArray)
End Destructor
