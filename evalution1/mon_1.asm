.model tiny
.486
.data
	dat1 dw 1234h, 0abcdh,5678h,0ef01h,20h,3486h,9977h,0aabch,0bbbch,0123h
	count dw 10
.code
.startup
	lea si,dat1
	mov di,si
	inc di
	mov cx,count
	x1:
		mov al,[si]
		mov bl,[di]
		mov [si],bl
		mov [di],al
		inc si
		inc si
		inc di
		inc di

		dec cx
		cmp cx,0
		jne x1
.exit
end
