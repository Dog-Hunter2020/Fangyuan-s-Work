;斐波那契数列实现

data segment
    inf db 0AH,0DH,"Please input the number: $"
	space db ' $'
    n        dw ?
    a       dw 1
    b       dw 1
    color    db 10000010b
data ends
code segment
assume cs:code,ds:data
start:
    mov  ax,data
    mov  ds,ax   
    lea  dx,inf;输出提示信息
    mov  ah,9
    int  21H
	;输入函数
	mov  bl,10;
    mov  cx,0
    call input
    cmp  cx,1
    jb   exit
    mov  n,cx 
	MOV DL,0AH;换行
    MOV AH,02H
    INT 21H
	
    mov  dl,'1'
    mov  ah,2
    int  21H   
    call spa
	mov  dl,'1'
    mov  ah,2
    int  21H
	call spa	
    dec  n;自减
	sub n,1
	
    jz   exit
fib:
    mov  ax,a
    add  ax,b
    jc   exit
    mov  bx,b
    mov  a,bx
    mov  b,ax
	mov  bx,10
    mov  cx,0
splite: 
    mov  dx,0
    div  bx
    add  dl,'0'
    inc  cx
    push dx
    cmp  ax,0
    jnz  splite
    mov  ah,2
print:
    pop  dx
	

	

 

	int  21H
	
    loop print
    call spa
    dec  n
    jnz  fib
exit:
    mov  ah,4ch
    int  21H
input:   
    mov  ah,7     ;input without displaying
    int  21H;键盘输入 在al中
    cmp  al,13    ;check the length
    je   inputOver  
    sub  al,30H;得到十进制数
    mov  ah,0
    xchg ax,cx;交换
    mul  bl      ;calculate the bit of 10
    add  cx,ax
    cmp  ch,0
    jnz  inputOver
    jmp  input
inputOver:
    ret
spa :
    lea  dx,space
	mov ah,09
    int  21H
	ret

code ends
end start
