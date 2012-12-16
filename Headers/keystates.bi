#Ifndef __HEADER_KEYSTATES_BI__
#define __HEADER_KEYSTATES_BI__

#Include "ext/containers/hashtable.bi"

Type KeyStates
	Private:
	_conf As ext.fbext_HashTable((Integer))					'' in both hashtable, key is "forward" or "backward" or ...
	_state As ext.fbext_HashTable((Integer))					'' and Integer is an SDLKey identifier
	
	Public:
	Declare Constructor()
	Declare Sub AddKey(As String, As Integer)					'' used to load keys from config file or default key otherwise
	Declare Function GetKeyState(As String) As Integer
	Declare Function GetKeyCode(As String) As Integer
	Declare Sub SetKeyState(As String, As Integer)
End Type

#EndIf
