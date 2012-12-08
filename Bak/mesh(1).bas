#Include "headers/mesh.bi"
#Include "headers/vertex.bi"
#Include "headers/triangle.bi"

Constructor Mesh(size As Integer)
	This._vertices = Callocate(size, SizeOf(Vertex))
	this._triangles = Callocate(size/3, SizeOf(Triangle))
End Constructor

Destructor Mesh()
	DeAllocate(this._vertices)
	DeAllocate(this._triangles)
End Destructor
