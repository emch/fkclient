'' Compile as library first

#Include "GL/gl.bi"
#Include "GL/glu.bi"
#Include "headers/block.bi"
#Include "headers/vector3d.bi"
#Include "headers/globals.bi" '' booleans
#Include "headers/blocktype.bi"

Constructor Block
	This._isActive = TRUE
End Constructor

Property Block.IsActive() As Byte
	If This._isActive = TRUE Then
		Return TRUE
	EndIf
	Return FALSE
End Property

Property Block.SetActive(activate As Integer)
	This._isActive = activate
End Property

Sub RenderBlock(myblock As Block, b_position As Vector3d) '', neighbours() As Block, b_dims As Vector3d) As Integer
	'' Get to position
	glTranslatef(b_position.X,b_position.Y,-b_position.Z)
	
	'' Draw a GL quad
	glBegin GL_QUADS
		'' TOP
		glVertex3f( 1.0f, 1.0f,-1.0f)           '' Top Right Of The Quad (Top)
		glVertex3f(-1.0f, 1.0f,-1.0f)           '' Top Left Of The Quad (Top)
		glVertex3f(-1.0f, 1.0f, 1.0f)           '' Bottom Left Of The Quad (Top)
		glVertex3f( 1.0f, 1.0f, 1.0f)           '' Bottom Right Of The Quad (Top)
		
		'' BOTTOM
		glVertex3f( 1.0f,-1.0f, 1.0f)           '' Top Right Of The Quad (Bottom)
		glVertex3f(-1.0f,-1.0f, 1.0f)           '' Top Left Of The Quad (Bottom)
		glVertex3f(-1.0f,-1.0f,-1.0f)           '' Bottom Left Of The Quad (Bottom)
		glVertex3f( 1.0f,-1.0f,-1.0f)           '' Bottom Right Of The Quad (Bottom)

		'' FRONT
		glVertex3f( 1.0f, 1.0f, 1.0f)           '' Top Right Of The Quad (Front)
		glVertex3f(-1.0f, 1.0f, 1.0f)           '' Top Left Of The Quad (Front)
		glVertex3f(-1.0f,-1.0f, 1.0f)           '' Bottom Left Of The Quad (Front)
		glVertex3f( 1.0f,-1.0f, 1.0f)           '' Bottom Right Of The Quad (Front)

		'' BACK
		glVertex3f( 1.0f,-1.0f,-1.0f)           '' Bottom Left Of The Quad (Back)
		glVertex3f(-1.0f,-1.0f,-1.0f)           '' Bottom Right Of The Quad (Back)
		glVertex3f(-1.0f, 1.0f,-1.0f)           '' Top Right Of The Quad (Back)
		glVertex3f( 1.0f, 1.0f,-1.0f)           '' Top Left Of The Quad (Back)
		
		'' LEFT
		glVertex3f(-1.0f, 1.0f, 1.0f)           '' Top Right Of The Quad (Left)
		glVertex3f(-1.0f, 1.0f,-1.0f)           '' Top Left Of The Quad (Left)
		glVertex3f(-1.0f,-1.0f,-1.0f)           '' Bottom Left Of The Quad (Left)
		glVertex3f(-1.0f,-1.0f, 1.0f)           '' Bottom Right Of The Quad (Left)

		'' RIGHT
		glVertex3f( 1.0f, 1.0f,-1.0f)           '' Top Right Of The Quad (Right)
     	glVertex3f( 1.0f, 1.0f, 1.0f)           '' Top Left Of The Quad (Right)
     	glVertex3f( 1.0f,-1.0f, 1.0f)           '' Bottom Left Of The Quad (Right)
     	glVertex3f( 1.0f,-1.0f,-1.0f)           '' Bottom Right Of The Quad (Right)
	glEnd
End Sub