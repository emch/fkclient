#Ifndef __HEADER_MAPTABLE_BI__
#define __HEADER_MAPTABLE_BI__

#Include "sdl/sdl_keysym.bi"
#Include "ext/containers/hashtable.bi"

Type MapTable
	Private:
	_keys As ext.fbext_HashTable((SDLKey))
End Type

#EndIf
