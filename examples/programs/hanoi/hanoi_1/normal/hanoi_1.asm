	.text
	.file	"llama"
	.globl	_free_array_of_malloc           # -- Begin function _free_array_of_malloc
	.p2align	4, 0x90
	.type	_free_array_of_malloc,@function
_free_array_of_malloc:                  # @_free_array_of_malloc
	.cfi_startproc
# %bb.0:                                # %entry
	movq	(%rdi), %rdi
	jmp	free@PLT                        # TAILCALL
.Lfunc_end0:
	.size	_free_array_of_malloc, .Lfunc_end0-_free_array_of_malloc
	.cfi_endproc
                                        # -- End function
	.globl	_runtime_error                  # -- Begin function _runtime_error
	.p2align	4, 0x90
	.type	_runtime_error,@function
_runtime_error:                         # @_runtime_error
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rsi, %r14
	movq	%rdi, %r15
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	%r14, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	_runtime_error, .Lfunc_end1-_runtime_error
	.cfi_endproc
                                        # -- End function
	.globl	_binary_int_division            # -- Begin function _binary_int_division
	.p2align	4, 0x90
	.type	_binary_int_division,@function
_binary_int_division:                   # @_binary_int_division
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	testq	%rsi, %rsi
	jne	.LBB2_3
# %bb.1:                                # %runtime_error.preheader
	leaq	.Lstr(%rip), %rbx
	.p2align	4, 0x90
.LBB2_2:                                # %runtime_error
                                        # =>This Inner Loop Header: Depth=1
	movl	$33, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB2_2
.LBB2_3:                                # %body
	movq	%rdi, %rax
	cqto
	idivq	%rsi
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	_binary_int_division, .Lfunc_end2-_binary_int_division
	.cfi_endproc
                                        # -- End function
	.globl	_binary_float_division          # -- Begin function _binary_float_division
	.p2align	4, 0x90
	.type	_binary_float_division,@function
_binary_float_division:                 # @_binary_float_division
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	xorps	%xmm2, %xmm2
	ucomiss	%xmm1, %xmm2
	jne	.LBB3_3
	jp	.LBB3_3
# %bb.1:                                # %runtime_error.preheader
	leaq	.Lstr(%rip), %rbx
	.p2align	4, 0x90
.LBB3_2:                                # %runtime_error
                                        # =>This Inner Loop Header: Depth=1
	movl	$33, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB3_2
.LBB3_3:                                # %body
	divss	%xmm1, %xmm0
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	_binary_float_division, .Lfunc_end3-_binary_float_division
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	callq	GC_init@PLT
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rbp
	leaq	8(%rsp), %rax
	movq	%rax, (%rcx)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.4(%rip), %rax
	movq	%rax, (%rbx)
	movq	$35, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_read_int@PLT
	movq	%rax, %r15
	movq	%rax, 16(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r12
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.5(%rip), %rax
	movq	%rax, (%r12)
	movq	$5, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r13
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.6(%rip), %rax
	movq	%rax, (%r13)
	movq	$6, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.7(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%r15, %rdi
	movq	%r12, %rsi
	movq	%r13, %rdx
	movq	%rbx, %rcx
	callq	"fn2:hanoi"@PLT
	andb	$1, %al
	movb	%al, 15(%rsp)
	movq	display_array@GOTPCREL(%rip), %rax
	movq	%rbp, (%rax)
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function
	.globl	"fn1:move"                      # -- Begin function fn1:move
	.p2align	4, 0x90
	.type	"fn1:move",@function
"fn1:move":                             # @"fn1:move"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %r12
	movq	%rsp, %rax
	movq	%rax, 8(%r15)
	movq	%rdi, 16(%rsp)
	movq	%rsi, 8(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.1(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.2(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.3(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r12, 8(%r15)
	addq	$24, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	"fn1:move", .Lfunc_end5-"fn1:move"
	.cfi_endproc
                                        # -- End function
	.globl	"fn2:hanoi"                     # -- Begin function fn2:hanoi
	.p2align	4, 0x90
	.type	"fn2:hanoi",@function
"fn2:hanoi":                            # @"fn2:hanoi"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 32(%rsp)
	movq	%rsi, 16(%rsp)
	movq	%rdx, 8(%rsp)
	movq	%rcx, 24(%rsp)
	testq	%rdi, %rdi
	jle	.LBB6_1
# %bb.2:                                # %if_then
	movq	32(%rsp), %rdi
	decq	%rdi
	movq	16(%rsp), %rsi
	movq	24(%rsp), %rdx
	movq	8(%rsp), %rcx
	callq	"fn2:hanoi"@PLT
	movq	16(%rsp), %rdi
	movq	8(%rsp), %rsi
	callq	"fn1:move"@PLT
	movq	32(%rsp), %rdi
	decq	%rdi
	movq	24(%rsp), %rsi
	movq	8(%rsp), %rdx
	movq	16(%rsp), %rcx
	callq	"fn2:hanoi"@PLT
                                        # kill: def $al killed $al def $eax
	jmp	.LBB6_3
.LBB6_1:
	xorl	%eax, %eax
.LBB6_3:                                # %if_merge
	movq	%rbx, 8(%r14)
                                        # kill: def $al killed $al killed $eax
	addq	$40, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	"fn2:hanoi", .Lfunc_end6-"fn2:hanoi"
	.cfi_endproc
                                        # -- End function
	.type	display_array,@object           # @display_array
	.bss
	.globl	display_array
	.p2align	3
display_array:
	.zero	16
	.size	display_array, 16

	.type	.Lstr,@object                   # @str
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lstr:
	.asciz	"Runtime Error: Division by zero\n"
	.size	.Lstr, 33

	.type	.Lstr.1,@object                 # @str.1
.Lstr.1:
	.asciz	"Moving from: "
	.size	.Lstr.1, 14

	.type	.Lstr.2,@object                 # @str.2
.Lstr.2:
	.asciz	" to "
	.size	.Lstr.2, 5

	.type	.Lstr.3,@object                 # @str.3
.Lstr.3:
	.asciz	"\n"
	.size	.Lstr.3, 2

	.type	.Lstr.4,@object                 # @str.4
.Lstr.4:
	.asciz	"Please, give the number of rings: "
	.size	.Lstr.4, 35

	.type	.Lstr.5,@object                 # @str.5
.Lstr.5:
	.asciz	"left"
	.size	.Lstr.5, 5

	.type	.Lstr.6,@object                 # @str.6
.Lstr.6:
	.asciz	"right"
	.size	.Lstr.6, 6

	.type	.Lstr.7,@object                 # @str.7
.Lstr.7:
	.asciz	"middle"
	.size	.Lstr.7, 7

	.section	".note.GNU-stack","",@progbits
