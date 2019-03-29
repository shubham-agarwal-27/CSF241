.model tiny
.486
.data
	data1 db 'hell','lleh','abcd','hell','hell'
	res1 db ?
	count db 5
	flag db 0 	;if equal to hell then flag = 0
	check db 'hell'
.code
.startup
	lea si,data1
	lea di,check
	mov cl,count
	
	;bl will store the count
	mov bl,0
x1:
	;set flag as zero for all the iterations
	mov flag,0

	;check for the first letter
	mov al,[si]
	inc si
	cmp al,[di]
	je x2
	mov flag,1
x2:
	;check for the second letter
	mov al,[si]
	inc si
	cmp al,[di+1]
	je x3
	mov flag,1

x3:
	;check for the third letter
	mov al,[si]
	inc si
	cmp al,[di+2]
	je x4
	mov flag,1

x4:
	;check for the fourth letter
	mov al,[si]
	inc si
	cmp al,[di+3]
	je x5
	mov flag,1
x5:
	cmp flag,0
	jne x6
	inc bl
x6:
	dec cl
	jne x1
.exit
end