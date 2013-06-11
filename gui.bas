#Include "ext/containers/hashtable.bi"
#Include "headers/gui.bi"
#Include "headers/globals.bi" '' Booleans
#Include "headers/params.bi"

'' Gui Manager Code
Constructor GuiManager()
	This._isEnabled = TRUE
	This._isVisible = TRUE
	
	This._widgets = Callocate(GUI_MAX_WIDGETS, SizeOf(GuiWidget Ptr))
	This._eventsource = GUI_EVENT_NONE
	
	'' Mesh information
	This._size = MAX_VERTICES	'' 4 vertices per widget!
	This._num = 0
	This._indexArrayIndice = 0
	This._vertexArray = Callocate(NUM_VERTEX_COORDS*MAX_VERTICES, SizeOf(GLfloat))
	This._normalArray = Callocate(NUM_NORMAL_COORDS*MAX_VERTICES, SizeOf(GLfloat))
	This._colorArray = Callocate(NUM_COLOR_COORDS*MAX_VERTICES, SizeOf(GLfloat))
	This._indexArray = Callocate(NUM_INDEX_COORDS*MAX_VERTICES, SizeOf(GLuint))
	This._texcoordArray = Callocate(NUM_TEX_COORDS*MAX_VERTICES, SizeOf(Integer))
End Constructor

Destructor GuiManager()
	DeAllocate(This._vertexArray)
	DeAllocate(This._normalArray)
	DeAllocate(This._colorArray)
	DeAllocate(This._indexArray)
	DeAllocate(This._texcoordArray)
	DeAllocate(This._widgets)
End Destructor

Function GuiManager.GetVertexArray() As GLfloat Ptr
	Return This._vertexArray
End Function

Function GuiManager.GetNormalArray() As GLfloat Ptr
	Return This._normalArray
End Function

Function GuiManager.GetColorArray() As GLfloat Ptr
	Return This._colorArray
End Function

Function GuiManager.GetIndexArray() As GLuint Ptr
	Return This._indexArray
End Function

Function GuiManager.GetTexCoordArray() As Integer Ptr
	Return This._texcoordArray
End Function

Sub GuiManager.AddVertex(vect As Vector3d, norm As Vector3d, r As GLfloat, g As GLfloat, b As GLfloat, a As GLfloat, t1 As Integer, t2 As Integer)
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

Sub GuiManager.AddTriangle(ind1 As GLuint, ind2 As GLuint, ind3 As GLuint)
	Dim indexArrayIndex As Integer = This._indexArrayIndice
	
	This._indexArray[indexArrayIndex] = ind1
	This._indexArray[indexArrayIndex+1] = ind2
	This._indexArray[indexArrayIndex+2] = ind3
	
	This._indexArrayIndice += 3
End Sub

'' Parameter depth means depth to screen (Z=0)
Function GuiManager.AppendQuad() As Byte
	''depth=GUI_GL_DEPTH (third Vector3d coordinate)
	Return TRUE
End Function

Sub GuiManager.InitGui()
	'' Create and add default widgets to the GuiManager
End Sub

Sub GuiManager.RenderGui()
	'' OpenGL rendering
End Sub

Sub GuiManager.UpdateGui()
	
End Sub

Sub GuiManager.PollEvents()
	
End Sub

Function GuiManager.AddWidget(widget As GuiWidget Ptr) As Byte
	Return TRUE
End Function

Function GuiManager.RemoveWidget(widget As GuiWidget Ptr) As Byte
	Return TRUE
End Function

Sub GuiManager.SetGuiEnabled(enabled As Byte)
	This._isEnabled = enabled
End Sub

Sub GuiManager.SetGuiVisible(visible As Byte) 
	This._isVisible = visible
End Sub
'' End Of Gui Manager Code

'' Widget Code
Constructor GuiWidget()

End Constructor
'' Use set functions to set parameters + SetParameters
'' End Of Widget Code