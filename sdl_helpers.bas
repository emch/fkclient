#Include "sdl/sdl.bi"
#Include "sdl/sdl_types.bi"
#Include "headers/sdl_helpers.bi"
#Include "headers/logging.bi"
#Include "headers/blocktypes.bi"

Sub FlipHorizontally(surface As SDL_Surface Ptr)
	Dim flipped As SDL_Surface Ptr = SDL_CreateRGBSurface(SDL_SWSURFACE, surface->w, surface->h, surface->Format->BitsPerPixel, 0, 0, 0, 0)
	'image->format->Rmask, image->format->Gmask, image->format->Bmask, image->format->Amask
	Dim As Integer x,y
	Dim TexPos As SDL_Rect
	
	SDL_LockSurface(flipped)
	SDL_LockSurface(surface)
	For y = 0 To surface->h - 1
		For x = 0 To surface->w - 1
			PutPixel(flipped, x, y, GetPixel(surface, surface->w - x - 1, y))
		Next
	Next
	SDL_UnlockSurface(surface)
	SDL_UnlockSurface(flipped)
	
	TexPos.w = BLOCK_TEX_SIZE
	TexPos.h = BLOCK_TEX_SIZE
		
	If SDL_BlitSurface(flipped, @TexPos, surface, NULL) = -1 Then
		LogToFile("Blitting failed: " + *SDL_GetError())
	EndIf
	
	SDL_FreeSurface(flipped)
End Sub

Sub PutPixel(surface As SDL_Surface Ptr, x As Integer, y As Integer, pixel As Uint32)
	Dim bpp As Integer = surface->Format->BytesPerPixel
	Dim p As Uint8 Ptr = Cast(Uint8 Ptr, surface->pixels + y*surface->pitch + x*bpp)
	
	Select Case bpp
		Case 1
			*p = pixel
		Case 2
			*Cast(Uint16 Ptr, p) = pixel
		Case 3
			If SDL_BYTEORDER = SDL_BIG_ENDIAN Then
				p[0] = (pixel Shr 16) And &Hff
            p[1] = (pixel Shr 8) And &Hff
            p[2] = pixel And &Hff
			Else
				p[0] = pixel And &Hff
            p[1] = (pixel Shr 8) And &Hff
            p[2] = (pixel Shr 16) And &Hff
			EndIf
		Case 4
			*Cast(Uint32 Ptr, p) = pixel
	End Select
End Sub

Function GetPixel(surface As SDL_Surface Ptr, x As Integer, y As Integer) As Uint32
	Dim bpp As Integer = surface->Format->BytesPerPixel
	Dim p As Uint8 Ptr = Cast(Uint8 Ptr, surface->pixels + y*surface->pitch + x*bpp)

	Select Case bpp
		Case 1
			Return *p
		Case 2
			Return *Cast(Uint16 Ptr, p)
		Case 3
			If SDL_BYTEORDER = SDL_BIG_ENDIAN Then
				Return p[0] Shl 16 Or p[1] Shl 8 Or p[2]
			Else
				Return p[0] Or p[1] Shl 8 Or p[2] Shl 16
			EndIf
		Case 4
			Return *Cast(Uint32 Ptr, p)
		Case Else
			Return 0
	End Select
End Function