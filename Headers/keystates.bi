#Ifndef __HEADER_KEYSTATES_BI__
#define __HEADER_KEYSTATES_BI__

#Include "ext/containers/hashtable.bi"
#Include "SDL/SDL_keysym.bi"

Type KeyStates
	Private:
	_conf As ext.fbext_HashTable((Integer))					'' in both hashtable, key is "forward" or "backward" or ...
	_state As ext.fbext_HashTable((Integer))					'' and Integer is an SDLKey identifier
	
	Public:
	Declare Constructor()
	Declare Sub AddKey(As String, As SDLKey)			'' used to load keys from config file or default key otherwise
	Declare Function GetKeyState(As String) As Integer
	Declare Function GetKeyCode(As String) As SDLKey
	Declare Sub SetKeyState(As String, As Integer)
End Type

#EndIf
