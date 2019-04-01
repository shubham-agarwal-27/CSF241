.model tiny
.486
.data
	disp db ?
	row db 0
	siz db 1
	curr db 10
.code
.startup
	
	;get display mode
	mov ah,0fh
	int 10h
	mov disp,al


	;set text mode of display 25 x 80
	mov ah,0
	mov al,3
	int 10h

	;print the pattern
x1:
	;set the cursor position
	mov ah,02h
	mov dh,row
	mov dl,curr
	mov bh,0
	int 10h

	;print the row
	mov ah,09h
	mov al,' '
	mov bh,0
	mov bl,00100010b
	movzx cx,siz
	int 10h

	;increment size of row
	mov bl,siz
	add bl,2
	mov siz,bl

	;change starting column of row
	mov bl,curr
	dec bl
	mov curr,bl
	
	;increment row
	mov bl,row
	inc bl
	mov row,bl
	cmp bl,10
	jne x1

	;blocking function
	mov ah,07h
x10:
	int 21h
	cmp al,'?'
	jnz x10


	;set original display mode back
	mov ah,0
	mov al,disp
	int 10h
.exit
end