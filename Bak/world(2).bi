#Ifndef __HEADER_WORLD_BI__
#define __HEADER_WORLD_BI__

#Include "headers/vector3d.bi"

#Define 	MAX_ALTITUDE	255	'' In number of blocks
#Define	MIN_ALTITUDE	0		'' In number of blocks

Type World
	Private:
	_name As String				'' world (folder) name. Folder must contain 3 files: .fkwn (info), .fkwi (index), .fkwd (data)
	_seed As ULongInt				'' world seed
	
	Public:
	Declare Constructor(As String, As ULongInt)
	
	'Declare Sub Load(As String, As Vector3d)			'' Load from FKW files
	'Declare Sub Generate(As String, As Vector3d)		'' Generate FKW file
End Type

#EndIf
