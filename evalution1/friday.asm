.model tiny
.486
.data
	loc1 db 'E','B','E','E','B','B','E','B','A','E'
	count db 10
	flag db 0
	res1 db ?
.code
.startup
	lea si,loc1
	mov cl,count
	mov bl,0
	x1:
		;Check if the flag is 1
		mov dl,flag
		cmp dl,1
		jne x4
		;Check if the current alphabet is E or not
		mov al,[si]
		cmp al,'E'
		jne x4
		;If yes, then increment answer and jump to x2
		inc bl
		jmp x2

	x4:	;Check if the alphabet is B or not
		mov al,[si]
		cmp al,'B'
		jne x2
		;If yes, then change flag to 1
		mov flag,1
		jmp x3
	x2:
		;Since the alphabet is not B then make flag = 0
		mov flag,0
	x3:
		inc si
		dec cl
		cmp cl,0
		jne x1
	;Now move bl to result location
	mov res1,bl
.exit
end