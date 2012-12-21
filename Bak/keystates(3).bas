#Include "SDL/SDL_keysym.bi"			''keycodes
#Include "headers/keystates.bi"
#Include "headers/globals.bi"

Constructor KeyStates	'' in fine : load from config file
	This.AddKey("forward", 	SDLK_w)
	This.AddKey("backward", SDLK_s)
	This.AddKey("left", 		SDLK_a)
	This.AddKey("right", 	SDLK_d)
	This.AddKey("boost",		SDLK_LSHIFT)
End Constructor

Sub KeyStates.AddKey(keyfunc As String, keycode As SDLKey)
	This._conf.insert(keyfunc, keycode)
	This._state.insert(keyfunc, FALSE)	'' default state is false
End Sub

Function KeyStates.GetKeyState(keyfunc As String) As Integer
	Return *This._state.GetValue(keyfunc) '' working?
End Function

Function KeyStates.GetKeyCode(keyfunc As String) As SDLKey
	Return CInt(*This._conf.GetValue(keyfunc))
End Function

Sub KeyStates.SetKeyState(keyfunc As String, keystate As Integer)
	This._state.remove(keyfunc)
	This._state.insert(keyfunc, keystate)
End Sub

Function GetConfHashtable() As ext.fbext_HashTable((Integer))
	
End Function
