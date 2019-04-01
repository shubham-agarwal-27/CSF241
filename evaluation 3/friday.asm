.model tiny
.486
.data
	disp db ?
	row db 24
	col db 79
	inp db ?
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

x1:	;Take the input from user without echo
	mov ah,08h
	int 21h
	mov inp,al

	;check if input is #
	cmp al,'#'
	je x2

	;set the cursor posiiton
	mov ah,02h
	mov dh,row
	mov dl,col
	mov bh,0
	int 10h

	;write the character at the pointer position
	mov ah,09h
	mov al,inp
	mov bh,0
	mov bl,00001011b
	mov cx,1
	int 10h

	;decrement the column pointer
	mov bl,col
	dec bl
	mov col,bl
	cmp bl,0
	jge x1

	mov col,79
	;decrement row 
	mov bl,row
	dec bl
	mov row,bl

	jmp x1

x2:	;set original display mode back
	mov ah,0
	mov al,disp
	int 10h
.exit
end