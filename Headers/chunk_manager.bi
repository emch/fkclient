#Ifndef __HEADER_CHUNKMANAGER_BI__
#define __HEADER_CHUNKMANAGER_BI__

#Include "headers/linked_list.bi"

Type ChunkManager
	Private:
	ChunkLoadList 			As LinkedList 	'' chunks to load (from a given source)
	ChunkRenderList 		As LinkedList	'' chunks to render
	ChunkUnloadList		As LinkedList
	ChunkVisibilityList	As LinkedList
	ChunkSetupList			As LinkedList
	
	Public:
	Declare Constructor()
	Declare Destructor()
	
	Declare Sub Update()
	Declare Sub UpdateLoadList()
	Declare Sub UpdateSetupList()
	Declare Sub UpdateRebuildList()
	Declare Sub UpdateUnloadList()
	Declare Sub UpdateVisibilityList()
	Declare Sub UpdateRenderList()
End Type

#EndIf
