.model tiny
.486
.data
	loc1 db 12h,34h, 0abh,0cdh,0efh,01h,20h,33h,99h,77h
	count db 10
	res1 db ?
.code
.startup
		lea si,loc1
		mov cl,count
		mov dl,0
	x1:
		;Check if the number is positive or not
		mov al,[si]
		cmp al,0
		jle x2

		;Check if the number is even or not
		mov bl,al
		and bl,1
		cmp bl,0
		jne x2

		;if Conditions satisfied, then increment answer
		inc dl

	x2:		
		;increment the data pointer
		inc si
		;Check if the end of data reached or not	
		dec cl
		cmp cl,0
		jne x1

		mov res1,dl
.exit
end