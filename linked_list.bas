#Include "headers/linked_list.bi"

Constructor LinkedList()
	This._len = 0
End Constructor

Destructor LinkedList()
	This.RemoveAll()
End Destructor

Function LinkedList.AddItem(b_data As Any Ptr) As UInteger
	If This._len = 0 Then	'' first item in list
		This._first = Allocate(SizeOf(LinkedListItem))
		This._last = This._first
		
		This._first->_next = This._first
		This._first->_data = b_data
	Else
		This._last->_next = Allocate(SizeOf(LinkedListItem))
		This._last = This._last->_next
		
		This._last->_data = b_data
	EndIf
	
	This._len += 1
	Return This._len
End Function

Function LinkedList.GetItem(id As UInteger) As Any Ptr
	Dim i As Integer
	Dim item As LinkedListItem Ptr
	
	If id < This._len Then
		item = This._first
		For i = 1 To id
			item = item->_next
		Next
	EndIf
	
	Return item
End Function

'' Insert an item AT the given id
Sub LinkedList.InsertItem(b_data As Any Ptr, id As UInteger = 0)
	Dim oldItem As LinkedListItem Ptr
	Dim prevItem As LinkedListItem Ptr
	Dim newItem As LinkedListItem Ptr
			
	If id < This._len Then 	'' do nothing otherwise
		oldItem = This.GetItem(id)
		newItem = Allocate(SizeOf(LinkedListItem))
		newItem->_next = oldItem
		newItem->_data = b_data
		
		If id = 0 Then			'' insert as first item
			This._first = newItem
		Else
			'' we have to retrieve the previous item to change its _next attribute
			prevItem = This.GetItem(id - 1)
			prevItem->_next = newItem
		EndIf
	EndIf
	
	This._len += 1
End Sub

Sub LinkedList.RemoveItem(id As UInteger)
	Dim prevItem As LinkedListItem Ptr
	Dim currItem As LinkedListItem Ptr	'' item to delete
	
	If id < This._len Then
		currItem = This.GetItem(id)
		If id = 0 Then
			This._first = currItem->_next
		Else
			prevItem = This.GetItem(id)
			prevItem->_next = currItem->_next
		EndIf
	EndIf
	
	DeAllocate(currItem)
	This._len -= 1
End Sub

Sub LinkedList.MoveItem(idfrom As UInteger = 0, idto As UInteger = 0)
	Dim itemfrom As LinkedListItem Ptr
	
	If idfrom < This._len And idto < This._len Then
		itemfrom = This.GetItem(idfrom)
		This.InsertItem(itemfrom->_data, idto)
		This.RemoveItem(idfrom)
	EndIf
End Sub

Sub LinkedList.RemoveAll()
	While This._len <> 0
		This.RemoveItem(0)
	Wend
End Sub

Sub LinkedList.SwapItems(id1 As UInteger, id2 As uInteger = 0)
	Dim item1 As LinkedListItem Ptr
	Dim item2 As LinkedListItem Ptr
	Dim As Integer max, min
	
	If id1 < This._len And id2 < This._len And id1 <> id2 Then
		If id1 < id2 Then
			min = id1
			max = id2
		Else
			min = id2
			max = id1
		EndIf
		
		item1 = This.GetItem(min)
		item2 = This.GetItem(max)
		This.InsertItem(item1->_data, max)
		This.RemoveItem(min)
		This.InsertItem(item2->_data, min)
		This.RemoveItem(max + 1)
	EndIf
End Sub
	
Property LinkedList.NumItems() As UInteger
	Return This._len
End Property
