#Include "headers/triangle.bi"
#Include "headers/vertex.bi"

Constructor Triangle(a As Vertex, b As Vertex, c As Vertex)
	this._vertices = Callocate(3, SizeOf(Vertex))
End Constructor
