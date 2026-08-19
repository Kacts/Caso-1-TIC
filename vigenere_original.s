	.text
	.intel_syntax noprefix
	.file	"vigenere.c"
	.globl	ajustarRangoByte                # -- Begin function ajustarRangoByte
	.p2align	4, 0x90
	.type	ajustarRangoByte,@function
ajustarRangoByte:                       # @ajustarRangoByte
# %bb.0:
	push	ebp
	mov	ebp, esp
	mov	eax, dword ptr [ebp + 8]
	cmp	dword ptr [ebp + 8], 255
	jle	.LBB0_2
# %bb.1:
	mov	eax, dword ptr [ebp + 8]
	sub	eax, 256
	mov	dword ptr [ebp + 8], eax
.LBB0_2:
	cmp	dword ptr [ebp + 8], 0
	jge	.LBB0_4
# %bb.3:
	mov	eax, dword ptr [ebp + 8]
	add	eax, 256
	mov	dword ptr [ebp + 8], eax
.LBB0_4:
	mov	eax, dword ptr [ebp + 8]
	pop	ebp
	ret
.Lfunc_end0:
	.size	ajustarRangoByte, .Lfunc_end0-ajustarRangoByte
                                        # -- End function
	.globl	transformarBytesClave           # -- Begin function transformarBytesClave
	.p2align	4, 0x90
	.type	transformarBytesClave,@function
transformarBytesClave:                  # @transformarBytesClave
# %bb.0:
	push	ebp
	mov	ebp, esp
	sub	esp, 24
	mov	eax, dword ptr [ebp + 28]
	mov	eax, dword ptr [ebp + 24]
	mov	eax, dword ptr [ebp + 20]
	mov	eax, dword ptr [ebp + 16]
	mov	eax, dword ptr [ebp + 12]
	mov	eax, dword ptr [ebp + 8]
	mov	dword ptr [ebp - 4], 0
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [ebp - 4]
	cmp	eax, dword ptr [ebp + 12]
	jge	.LBB1_9
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
	mov	eax, dword ptr [ebp + 8]
	mov	ecx, dword ptr [ebp - 4]
	movzx	eax, byte ptr [eax + ecx]
	mov	dword ptr [ebp - 8], eax
	mov	eax, dword ptr [ebp + 16]
	mov	ecx, dword ptr [ebp + 24]
	movzx	eax, byte ptr [eax + ecx]
	mov	dword ptr [ebp - 12], eax
	cmp	dword ptr [ebp + 28], 1
	jne	.LBB1_4
# %bb.3:                                #   in Loop: Header=BB1_1 Depth=1
	mov	eax, dword ptr [ebp - 8]
	add	eax, dword ptr [ebp - 12]
	mov	dword ptr [ebp - 16], eax
	jmp	.LBB1_5
.LBB1_4:                                #   in Loop: Header=BB1_1 Depth=1
	mov	eax, dword ptr [ebp - 8]
	sub	eax, dword ptr [ebp - 12]
	mov	dword ptr [ebp - 16], eax
.LBB1_5:                                #   in Loop: Header=BB1_1 Depth=1
	mov	eax, dword ptr [ebp - 16]
	mov	dword ptr [esp], eax
	call	ajustarRangoByte
	mov	dword ptr [ebp - 16], eax
	mov	eax, dword ptr [ebp - 16]
	mov	dl, al
	mov	eax, dword ptr [ebp + 8]
	mov	ecx, dword ptr [ebp - 4]
	mov	byte ptr [eax + ecx], dl
	mov	eax, dword ptr [ebp + 24]
	add	eax, 1
	mov	dword ptr [ebp + 24], eax
	mov	eax, dword ptr [ebp + 24]
	cmp	eax, dword ptr [ebp + 20]
	jne	.LBB1_7
# %bb.6:                                #   in Loop: Header=BB1_1 Depth=1
	mov	dword ptr [ebp + 24], 0
.LBB1_7:                                #   in Loop: Header=BB1_1 Depth=1
	jmp	.LBB1_8
.LBB1_8:                                #   in Loop: Header=BB1_1 Depth=1
	mov	eax, dword ptr [ebp - 4]
	add	eax, 1
	mov	dword ptr [ebp - 4], eax
	jmp	.LBB1_1
.LBB1_9:
	mov	eax, dword ptr [ebp + 24]
	add	esp, 24
	pop	ebp
	ret
.Lfunc_end1:
	.size	transformarBytesClave, .Lfunc_end1-transformarBytesClave
                                        # -- End function
	.globl	procesarArchivo                 # -- Begin function procesarArchivo
	.p2align	4, 0x90
	.type	procesarArchivo,@function
procesarArchivo:                        # @procesarArchivo
# %bb.0:
	push	ebp
	mov	ebp, esp
	push	ebx
	push	edi
	push	esi
	sub	esp, 2108
	mov	eax, dword ptr [ebp + 24]
	mov	eax, dword ptr [ebp + 20]
	mov	eax, dword ptr [ebp + 16]
	mov	eax, dword ptr [ebp + 12]
	mov	eax, dword ptr [ebp + 8]
	mov	dword ptr [ebp - 2080], 0
	mov	dword ptr [ebp - 2084], 0
	mov	ecx, dword ptr [ebp + 8]
	lea	eax, [.L.str]
	mov	dword ptr [esp], ecx
	mov	dword ptr [esp + 4], eax
	call	fopen
	mov	dword ptr [ebp - 20], eax
	cmp	dword ptr [ebp - 20], 0
	jne	.LBB2_2
# %bb.1:
	lea	eax, [.L.str.1]
	mov	dword ptr [esp], eax
	call	printf
	mov	dword ptr [ebp - 16], -1
	jmp	.LBB2_8
.LBB2_2:
	mov	ecx, dword ptr [ebp + 12]
	lea	eax, [.L.str.2]
	mov	dword ptr [esp], ecx
	mov	dword ptr [esp + 4], eax
	call	fopen
	mov	dword ptr [ebp - 24], eax
	cmp	dword ptr [ebp - 24], 0
	jne	.LBB2_4
# %bb.3:
	lea	eax, [.L.str.3]
	mov	dword ptr [esp], eax
	call	printf
	mov	eax, dword ptr [ebp - 20]
	mov	dword ptr [esp], eax
	call	fclose
	mov	dword ptr [ebp - 16], -1
	jmp	.LBB2_8
.LBB2_4:
	lea	ecx, [ebp - 2072]
	mov	eax, dword ptr [ebp - 20]
	mov	dword ptr [esp], ecx
	mov	dword ptr [esp + 4], 1
	mov	dword ptr [esp + 8], 2048
	mov	dword ptr [esp + 12], eax
	call	fread
	mov	dword ptr [ebp - 2076], eax
.LBB2_5:                                # =>This Inner Loop Header: Depth=1
	cmp	dword ptr [ebp - 2076], 0
	jle	.LBB2_7
# %bb.6:                                #   in Loop: Header=BB2_5 Depth=1
	lea	ebx, [ebp - 2072]
	mov	edi, dword ptr [ebp - 2076]
	mov	esi, dword ptr [ebp + 16]
	mov	edx, dword ptr [ebp + 20]
	mov	ecx, dword ptr [ebp - 2084]
	mov	eax, dword ptr [ebp + 24]
	mov	dword ptr [esp], ebx
	mov	dword ptr [esp + 4], edi
	mov	dword ptr [esp + 8], esi
	mov	dword ptr [esp + 12], edx
	mov	dword ptr [esp + 16], ecx
	mov	dword ptr [esp + 20], eax
	call	transformarBytesClave
	mov	dword ptr [ebp - 2084], eax
	lea	edx, [ebp - 2072]
	mov	ecx, dword ptr [ebp - 2076]
	mov	eax, dword ptr [ebp - 24]
	mov	dword ptr [esp], edx
	mov	dword ptr [esp + 4], 1
	mov	dword ptr [esp + 8], ecx
	mov	dword ptr [esp + 12], eax
	call	fwrite
	mov	eax, dword ptr [ebp - 2076]
	add	eax, dword ptr [ebp - 2080]
	mov	dword ptr [ebp - 2080], eax
	lea	ecx, [ebp - 2072]
	mov	eax, dword ptr [ebp - 20]
	mov	dword ptr [esp], ecx
	mov	dword ptr [esp + 4], 1
	mov	dword ptr [esp + 8], 2048
	mov	dword ptr [esp + 12], eax
	call	fread
	mov	dword ptr [ebp - 2076], eax
	jmp	.LBB2_5
.LBB2_7:
	mov	eax, dword ptr [ebp - 20]
	mov	dword ptr [esp], eax
	call	fclose
	mov	eax, dword ptr [ebp - 24]
	mov	dword ptr [esp], eax
	call	fclose
	mov	eax, dword ptr [ebp - 2080]
	mov	dword ptr [ebp - 16], eax
.LBB2_8:
	mov	eax, dword ptr [ebp - 16]
	add	esp, 2108
	pop	esi
	pop	edi
	pop	ebx
	pop	ebp
	ret
.Lfunc_end2:
	.size	procesarArchivo, .Lfunc_end2-procesarArchivo
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	push	ebp
	mov	ebp, esp
	push	edi
	push	esi
	sub	esp, 64
	mov	eax, dword ptr [ebp + 12]
	mov	eax, dword ptr [ebp + 8]
	mov	dword ptr [ebp - 12], 0
	cmp	dword ptr [ebp + 8], 5
	je	.LBB3_2
# %bb.1:
	lea	eax, [.L.str.4]
	mov	dword ptr [esp], eax
	call	printf
	lea	eax, [.L.str.5]
	mov	dword ptr [esp], eax
	call	printf
	lea	eax, [.L.str.6]
	mov	dword ptr [esp], eax
	call	printf
	mov	dword ptr [ebp - 12], 1
	jmp	.LBB3_16
.LBB3_2:
	mov	eax, dword ptr [ebp + 12]
	mov	eax, dword ptr [eax + 4]
	mov	dword ptr [ebp - 16], eax
	mov	eax, dword ptr [ebp + 12]
	mov	eax, dword ptr [eax + 8]
	mov	dword ptr [ebp - 20], eax
	mov	eax, dword ptr [ebp + 12]
	mov	eax, dword ptr [eax + 12]
	mov	dword ptr [ebp - 24], eax
	mov	eax, dword ptr [ebp + 12]
	mov	eax, dword ptr [eax + 16]
	mov	dword ptr [ebp - 28], eax
	mov	ecx, dword ptr [ebp - 16]
	mov	eax, esp
	mov	dword ptr [eax], ecx
	mov	dword ptr [eax + 4], offset .L.str.7
	call	strcmp
	cmp	eax, 0
	jne	.LBB3_4
# %bb.3:
	mov	dword ptr [ebp - 40], 1
	jmp	.LBB3_8
.LBB3_4:
	mov	ecx, dword ptr [ebp - 16]
	mov	eax, esp
	mov	dword ptr [eax], ecx
	mov	dword ptr [eax + 4], offset .L.str.8
	call	strcmp
	cmp	eax, 0
	jne	.LBB3_6
# %bb.5:
	mov	dword ptr [ebp - 40], 0
	jmp	.LBB3_7
.LBB3_6:
	lea	eax, [.L.str.9]
	mov	dword ptr [esp], eax
	call	printf
	mov	dword ptr [ebp - 12], 1
	jmp	.LBB3_16
.LBB3_7:
	jmp	.LBB3_8
.LBB3_8:
	mov	eax, dword ptr [ebp - 28]
	mov	dword ptr [ebp - 32], eax
	mov	dword ptr [ebp - 36], 0
.LBB3_9:                                # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [ebp - 28]
	mov	ecx, dword ptr [ebp - 36]
	movsx	eax, byte ptr [eax + ecx]
	cmp	eax, 0
	je	.LBB3_11
# %bb.10:                               #   in Loop: Header=BB3_9 Depth=1
	mov	eax, dword ptr [ebp - 36]
	add	eax, 1
	mov	dword ptr [ebp - 36], eax
	jmp	.LBB3_9
.LBB3_11:
	cmp	dword ptr [ebp - 36], 0
	jne	.LBB3_13
# %bb.12:
	lea	eax, [.L.str.10]
	mov	dword ptr [esp], eax
	call	printf
	mov	dword ptr [ebp - 12], 1
	jmp	.LBB3_16
.LBB3_13:
	mov	edi, dword ptr [ebp - 20]
	mov	esi, dword ptr [ebp - 24]
	mov	edx, dword ptr [ebp - 32]
	mov	ecx, dword ptr [ebp - 36]
	mov	eax, dword ptr [ebp - 40]
	mov	dword ptr [esp], edi
	mov	dword ptr [esp + 4], esi
	mov	dword ptr [esp + 8], edx
	mov	dword ptr [esp + 12], ecx
	mov	dword ptr [esp + 16], eax
	call	procesarArchivo
	mov	dword ptr [ebp - 44], eax
	cmp	dword ptr [ebp - 44], 0
	jl	.LBB3_15
# %bb.14:
	lea	eax, [.L.str.11]
	mov	dword ptr [esp], eax
	call	printf
	mov	eax, dword ptr [ebp - 44]
	lea	ecx, [.L.str.12]
	mov	dword ptr [esp], ecx
	mov	dword ptr [esp + 4], eax
	call	printf
.LBB3_15:
	mov	dword ptr [ebp - 12], 0
.LBB3_16:
	mov	eax, dword ptr [ebp - 12]
	add	esp, 64
	pop	esi
	pop	edi
	pop	ebp
	ret
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"rb"
	.size	.L.str, 3

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"Error abriendo archivo de entrada\n"
	.size	.L.str.1, 35

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"wb"
	.size	.L.str.2, 3

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"Error abriendo archivo de salida\n"
	.size	.L.str.3, 34

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"Uso:\n"
	.size	.L.str.4, 6

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"  programa cifrar entrada salida clave\n"
	.size	.L.str.5, 40

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"  programa descifrar entrada salida clave\n"
	.size	.L.str.6, 43

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"cifrar"
	.size	.L.str.7, 7

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"descifrar"
	.size	.L.str.8, 10

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"Operacion invalida\n"
	.size	.L.str.9, 20

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"Clave vacia\n"
	.size	.L.str.10, 13

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"Archivo procesado correctamente\n"
	.size	.L.str.11, 33

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"Bytes procesados: %d\n"
	.size	.L.str.12, 22

	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym ajustarRangoByte
	.addrsig_sym transformarBytesClave
	.addrsig_sym procesarArchivo
	.addrsig_sym fopen
	.addrsig_sym printf
	.addrsig_sym fclose
	.addrsig_sym fread
	.addrsig_sym fwrite
	.addrsig_sym strcmp
