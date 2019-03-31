.model tiny
.486
.data
	fname db 'samp.txt',0
	handle dw ?
	ans db 0
	count db 20
	store db ?
.code
.startup
	
	;Open the file samp.txt
	mov ah,3dh
	mov al,2
	lea dx,fname
	int 21h
	mov handle,ax

x1:
	;Read a character at the current file pointer
	mov ah,3fh
	mov bx,handle
	mov cx,1
	lea dx ,store
	int 21h
	;check if we reached EOF or not
	cmp ax,0
	je x2

	mov dl,store
	cmp dl,'!'
	jne x3
	mov bl,ans
	inc bl
	mov ans,bl
	jmp x1

x3:	mov dl,store
	cmp dl,'.'
	jne x4
	mov bl,ans
	inc bl
	mov ans,bl
	jmp x1

x4:	mov dl,store
	cmp dl,'?'
	jne x1
	mov bl,ans
	inc bl
	mov ans,bl

	jmp x1

x2:	
	;Close the file mfn2.txt
	mov ah,3eh
	mov bx,handle
	int 21h

.exit
end