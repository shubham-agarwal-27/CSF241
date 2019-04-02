.model tiny
.486
.data
	fname db 10 dup(?),0
	handle dw ?
	nline db 0dh,0ah,'$'
	disp db ?
	row db 0
	col db 0
	char db ?
	count db 30
.code
.startup
	
	;get display mode
	mov ah,0fh
	int 10h
	mov disp,al

	;set text display mode
	mov ah,0
	mov al,3
	int 10h

	lea si,fname
	;first take the 10 character input and print it on first line
x1:
	;take character input
	mov ah,08h
	int 21h
	mov  char,al
	
	;set cursor position
	mov ah,02h
	mov dh,row
	mov dl,col
	mov bh,0
	int 10h

	;store charcter in fname
	mov dl,char
	mov [si],dl
	inc si

	;print it with magenta color
	mov ah,9h
	mov al,char
	mov bh,0
	mov bl,00000101b
	mov cx,1
	int 10h

	;increment col
	mov dl,col
	inc dl
	mov col,dl
	cmp dl,10
	jne x1

	mov col,1
	mov row,1

	;create the file name given as input
	mov ah,3ch
	lea dx,fname
	mov cl,20h
	int 21H
	mov handle,ax



x2:
	;take input
	mov ah,08h
	int 21h
	mov  char,al

	;check if the character was enter or not
	cmp al,0dh
	je x3


	;set cursor position
	mov ah,02h
	mov dh,row
	mov dl,col
	mov bh,0
	int 10h

	;print the character
	mov ah,9h
	mov al,char
	mov bh,0
	mov bl,00000101b
	mov cx,1
	int 10h

	;store charcter in file
	mov ah,40h
	mov bx,handle
	mov cx,1
	lea dx,char
	int 21h

	;check if 40 bytes written or not
	mov dl,count
	dec dl
	mov count,dl
	cmp dl,0
	jle x3

	;increment column
	mov dl,col
	inc dl
	mov col,dl
	cmp dl,10
	jne x2

	;if column reached 10 then increment row
	mov dl,row
	inc dl
	mov row,dl

	mov dl,row
	mov col,dl
	jmp x2


x3:

	;closing the file
	mov ah,3eh
	mov bx,handle
	int 21h

	;set original display mode back
	mov ah,0
	mov al,disp
	int 10h
.exit
end
