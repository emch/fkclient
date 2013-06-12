#Include "ext/containers/hashtable.bi"
#Include "headers/gui.bi"
#Include "headers/globals.bi" '' Booleans
#Include "headers/params.bi"
#Include "headers/mesh.bi"

'' Gui Manager Code
Constructor GuiManager()
	This._isEnabled = TRUE
	This._isVisible = TRUE
	
	This._widgets = Callocate(GUI_MAX_WIDGETS, SizeOf(GuiWidget Ptr))
	This._eventsource = GUI_EVENT_NONE
	
	This._guimesh = Callocate(4*GUI_MAX_WIDGETS, SizeOf(Mesh)) '4 vertices per widget!
End Constructor

Destructor GuiManager()
	DeAllocate(This._widgets)
	DeAllocate(This._guimesh)
End Destructor

Sub GuiManager.InitGui()
	'' Create and add default widgets to the GuiManager
	'This.LoadTexInfo()
End Sub

Sub GuiManager.RenderGui()
	'' OpenGL rendering
	' See Chunk Rendering
End Sub

Sub GuiManager.UpdateGui()
	'' Mesh updating
End Sub

Sub GuiManager.PollEvents()
	
End Sub

Function GuiManager.AddWidget(widget As GuiWidget Ptr) As Byte
	This.UpdateGui()
	Return TRUE
End Function

Function GuiManager.RemoveWidget(widget As GuiWidget Ptr) As Byte
	This.UpdateGui()
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