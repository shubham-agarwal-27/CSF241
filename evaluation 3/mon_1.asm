.model tiny
.486
.data
	disp db ?
	row db 0
	col db 0
.code
.startup
	
	;get display mode
	mov ah,0fh
	int 10h
	mov disp,al


	;set text mode of display
	mov ah,0
	mov al,3
	int 10h

	;print 10 x 10 spaces with blue color
x1:
	;set cursor position
	mov ah,2
	mov dh,row
	mov dl,0
	mov bh,0
	int 10h

	;print space at current pixel with blue color
	mov ah,09h
	mov al,' '
	mov bh,0
	mov bl,00010001b
	mov cx,10
	int 10h

	;Increment row
	mov cl,row
	inc cl
	mov row,cl
	cmp cl,10
	jne x1

	mov row,0
;print 10 x 10 blinking stars with white color
x2:
	;set cursor position
	mov ah,2
	mov dh,row
	mov dl,0
	mov bh,0
	int 10h

	;print space at current pixel with blue color
	mov ah,09h
	mov al,'*'
	mov bh,0
	mov bl,10010111b
	mov cx,10
	int 10h

	;Increment row
	mov cl,row
	inc cl
	mov row,cl
	cmp cl,10
	jne x2

	;Move the cursor position for better view of screen
	mov ah,2
	mov dh,row
	mov dl,0
	mov bh,0
	int 10h

	
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
