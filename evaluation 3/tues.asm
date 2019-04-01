.model tiny
.486
.data
	disp db ?
	row db 0
	col db 0

	;flag = 0 for brown color and flag = 1 for blue
	flag db 0 
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

x1:
	;set cursor position
	mov ah,2
	mov dh,row
	mov dl,col
	mov bh,0
	int 10h

	;check if flag is 0 i.e brown
	mov bl,flag
	cmp bl,0
	jne x2
	;flag is 0 i.e brown
	;print brown space in the current pixel
	mov ah,09h
	mov al,' '
	mov bh,0
	mov bl,01100110b
	mov cx,1
	int 10h

	;make flag = 1
	mov flag,1
	jmp x3
	;here we know flag is 1 i.e blue
x2:	
	;print blue space in the current pixel
	mov ah,09h
	mov al,' '
	mov bh,0
	mov bl,00010001b
	mov cx,1
	int 10h

	;make flag = 1
	mov flag,0	

x3:	;increment column by 1
	mov bl,col
	inc bl
	mov col,bl
	cmp bl,80
	jne x1

	;column has reached 80 , make it 0 and increment row by 1
	mov col,0

	mov dl,row
	inc dl
	mov row,dl
	cmp dl,25
	jne x1
	
	;blocking function
	mov ah,07h
x10:
	int 21h
	cmp al,'%'
	jnz x10


	;set original display mode back
	mov ah,0
	mov al,disp
	int 10h
.exit
end