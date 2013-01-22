#Ifndef __HEADER_WORLD_BI__
#define __HEADER_WORLD_BI__

Type World
	Private:
	_name As String			'' world name
	_seed As ULongInt			'' world seed
	_nbchunks As Integer		'' number of chunks to render
	
	Public:
	Declare Constructor(As String, As ULongInt)
	
	Declare Sub Load(As String)			'' load from FKW files
	Declare Sub Generate(As String)
End Type

#EndIf
