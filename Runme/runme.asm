BITS 64
%assign	STDIN	0
%assign	STDOUT 1

section .rodata
msg_input db '> ',0
msg_input_len equ $-msg_input
msg_err db `Wrong!\n`,0
msg_err_len equ $-msg_err
msg_ok db `Good job!\n`,0
msg_ok_len equ $-msg_ok


section .mytext progbits alloc exec write align=16
global _start:

%macro sys_exit 1
  mov eax, 0x3c
  mov edi, %1
  syscall
%endmacro

%macro sys_write 2
  mov eax, 0x1
  ; stdout
  mov edi, STDOUT
  ; buffer
  mov rsi, %1
  ; len
  mov edx, %2
  syscall
%endmacro

%macro sys_read 2
  mov eax, 0x0
  ; stdout
  mov edi, STDIN
  ; buffer
  mov rsi, %1
  ; len
  mov edx, %2
  syscall
%endmacro

%macro encrypt_below 0
  ; key
  mov rax, [rcx]
  ; length of a block to encrypt
  mov edi, enc_end - %%enc_start
  xor esi, esi
%%do_for:
  cmp esi, edi
  jz %%enc_start
  xor [%%enc_start + esi], al
  inc esi
  jmp %%do_for
%%enc_start:
%endmacro

%macro test_char 1
  ; provided input/key
  inc rcx
  cmp [rcx], byte %1
  jz %%good
  sys_write msg_err, msg_err_len
  sys_exit 1
%%good:
%endmacro

_start:
  sys_write msg_input, msg_input_len
  sub rsp, 16
  sys_read rsp, 16
  ; pointer to input
  mov rcx, rsp
  dec rcx

  test_char 'L'
  encrypt_below
  test_char '1'
  encrypt_below
  test_char 'n'
  encrypt_below
  test_char 'u'
  encrypt_below
  test_char 'x'
  encrypt_below
  test_char 'D'
  encrypt_below
  test_char 'a'
  encrypt_below
  test_char 'y'
  encrypt_below
  test_char 'Z'

  sys_write msg_ok, msg_ok_len
  sys_exit 0
enc_end:
