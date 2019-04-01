.model tiny
.486
.data
	disp db ?
	row db 0
	col db 0
	col1 db 0
	col2 db 10

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

	;print 11 x 11 spaces with black color
x1:
	;set cursor position
	mov ah,2
	mov dh,row
	mov dl,0
	mov bh,0
	int 10h

	;print space at current pixel with black color
	mov ah,09h
	mov al,' '
	mov bh,0
	mov bl,0
	mov cx,11
	int 10h

	;Increment row
	mov cl,row
	inc cl
	mov row,cl
	cmp cl,11
	jne x1

	;Move the cursor position for better view of screen
	mov ah,2
	mov dh,row
	mov dl,0
	mov bh,0
	int 10h

	mov row,0

	;Print the pattern
x2:
	;print the left space
	;set the cursor position for left space
	mov ah,2
	mov dh,row
	mov dl,col1
	mov bh,0
	int 10h

	;print the space
	mov ah,09h
	mov al,' '
	mov bh,0
	mov bl,01000100b
	mov cx,1
	int 10h

	;set the cursor position for right space
	mov ah,2
	mov dh,row
	mov dl,col2
	mov bh,0
	int 10h

	;print the space
	mov ah,09h
	mov al,' '
	mov bh,0
	mov bl,01000100b
	mov cx,1
	int 10h

	;increment col1
	mov dl,col1
	inc dl
	mov col1,dl
	cmp dl,11
	je x3

	;decrement col2
	mov dl,col2
	dec dl
	mov col2,dl

	;increment row
	mov dl,row
	inc dl
	mov row,dl
	jmp x2

x3:
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