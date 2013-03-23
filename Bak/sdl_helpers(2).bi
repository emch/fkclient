#Ifndef __HEADER_SDLHELPERS_BI__
#define __HEADER_SDLHELPERS_BI__

Declare Function FlipHorizontally(As SDL_Surface Ptr) As SDL_Surface Ptr
Declare Sub PutPixel(As SDL_Surface Ptr, As Integer, As Integer, As Uint32)
Declare Function GetPixel(As SDL_Surface Ptr, As Integer, As Integer) As Uint32

#EndIf