#Ifndef __HEADER_LINKEDLIST_BI__
#define __HEADER_LINKEDLIST_BI__

Type LinkedListItem	'' accessed internally only
	Private:
	_value As Any Ptr
	_next As LinkedListItem Ptr
End Type

Type LinkedList
	Private:
	_len As Integer
	_first As LinkedListItem Ptr
	_last As LinkedListItem Ptr
	
	Public:
	Declare Constructor()
	Declare Destructor()
	
	Declare Function AddItem(As Any Ptr) As UInteger
	Declare Function GetItem(As UInteger) As Any Ptr
	Declare Sub InsertItem(As Any Ptr, As UInteger = 0)
	Declare Sub MoveItem(As UInteger = 0, As UInteger = 0)
	Declare Sub RemoveItem(As UInteger)
	Declare Sub RemoveAll()
	Declare Sub SwapItems(As UInteger, As uInteger = 0)
	
	Declare Property NumItems() As UInteger
End Type

#EndIf
