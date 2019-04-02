.model tiny
.486
.data
	fname db 'compre.txt',0
	handle dw ?
	disp db ?
	row db 11
	col db 0
	color db ?
	count db 30
	buffer db ?
.code
.startup
	
	;get display mode
	mov ah,0fh
	int 10h
	mov disp,al

	;take digit input
	mov ah,01h
	int 21h
	sub al,'0'
	mov color,al

	;take enter input
	mov ah,01h
	int 21h

	;set text display mode
	mov ah,0
	mov al,3
	int 10h


	;open the file
	mov ah,3dh
	mov al,0
	lea dx,fname
	int 21h
	mov handle,ax

	;move the file pointer by 20 places
	mov ah,42h
	mov al,0
	mov bx,handle
	mov cx,0
	mov dx,20
	int 21h

x1:
	;read the character at given pointer
	mov ah,3fh
	mov bx,handle
	mov cx,1
	lea dx,buffer
	int 21h

	;set cursor pointer
	mov ah,02h
	mov dh,row
	mov dl,col
	mov bh,0
	int 10h


	;print the character on screen
	mov ah,09h
	mov al,buffer
	mov bh,0
	mov bl,color
	mov cx,80
	int 10h

	;increment row
	mov dl,row
	inc dl
	mov row,dl
	cmp dl,14
	jne x1
	

	;closing the file
	mov ah,3eh
	mov bx,handle
	int 21h

	;blocking function
	mov ah,07h
x2: 
	int 21h
	cmp al,')'
	jnz x2

	;set original display mode back
	mov ah,0
	mov al,disp
	int 10h
.exit
end
