#Ifndef __HEADER_VECTOR2D_BI__
#define __HEADER_VECTOR2D_BI__

Type Vector2d
	Private:
   _x As Single
   _y As Single
   
   Public:
   Declare Constructor()
   Declare Constructor(As Single, As Single)
   Declare Constructor(As Vector2d Ptr)
   Declare Property X As Single
   Declare Property Y As Single
   Declare Sub SetX(As Single)
   Declare Sub SetY(As Single)
   Declare Sub Normalize()
End Type

Declare Operator +(As Vector2d, As Vector2d) As Vector2d
Declare Operator -(As Vector2d, As Vector2d) As Vector2d
Declare Operator *(As Single, As Vector2d) As Vector2d
Declare Operator /(As Vector2d, As Single) As Vector2d
'Declare Function CrossProduct(As Vector2d, As Vector2d) As Vector2d

#EndIf