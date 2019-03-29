.model tiny
.486
.data
	loc1 db 'A','C','H','Z','L','O','J','S','B','M'
	count db 10
.code
.startup
	lea si,loc1
	mov cl,count
	x1:
		;Check if the alphabet is less than L or not
		mov al,[si]
		cmp al,'L'
		jl x2
		;If yes, then convert into lower case
		add al,32
		mov [si],al

	x2:
		inc si
		dec cl
		cmp cl,0
		jne x1
.exit
end