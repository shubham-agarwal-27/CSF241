.model tiny
.486
.data
	fname db 'compre.txt',0
	handle dw ?
	ask db 'Give two digit input',0dh,0ah,'$'
	nline db 0dh,0ah,'$'
	disp db ?
	row db 0
	col db 0
	data db ?
	ent db ?
	val db ?
.code
.startup
	
	;get display mode
	mov ah,0fh
	int 10h
	mov disp,al


	;Print the question on screen
	lea dx,ask
	mov ah,9h
	int 21h

	;take input of first digit
	MOV AH, 01H
	int 21h
	sub al,'0'
	;bl will cuurrently store the bits 0-2 i.e the foreground color
	mov bl,al 
	mov cl,4
	rol bl,cl

	mov ah,01H
	int 21H
	sub al,'0'
	add bl,al
	rol bl,cl
	mov data,bl



	;take enter input
	MOV AH, 01H
	LEA SI, ent
	INT 21H

	;set text display mode
	mov ah,0
	mov al,3
	int 10h

	;open the file name given as input
	mov ah,3dh
	mov al,0
	lea dx,fname
	int 21H
	mov handle,ax


	;Read froom the file
	mov ah,3fh
	mov bx,handle
	mov cx,1
	lea dx,val
	int 21h
	
	;print the first twenty characters on the screen
x1:
	;set the cursor position
	mov ah,2
	mov dh,row
	mov dl,0
	mov bh,0
	int 10h

	;print at the position
	mov ah,9h
	mov al,val
	mov bh,0
	mov bl,data
	mov cx,80
	int 10h

	;increment row
	mov dl,row
	inc dl
	mov row,dl
	cmp dl,25
	jne x1

	;closing the file
	mov ah,3eh
	mov bx,handle
	int 21h

	;blocking function
	mov ah,07h
x10:
	int 21h
	cmp al,')'
	jnz x10


	;set original display mode back
	mov ah,0
	mov al,disp
	int 10h
.exit
end
