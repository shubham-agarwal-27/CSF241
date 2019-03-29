.model tiny
.486
.data
	loc1 dw 1234h, 0abcdh,5678h,0ef01h,20h,3486h,9977h,0aabch,0bbbch,0123h
	count dw 10
.code
.startup
	lea si,loc1
	mov cx,count
	x1:
		mov ax,[si]
		cmp ax,700fh
		jle x2
		not ax
		mov [si],ax

	x2:
		inc si
		inc si
		dec cx
		cmp cx,0
		jne x1
.exit
end