	.text
	.file	"llama"
	.globl	_free_array_of_malloc           # -- Begin function _free_array_of_malloc
	.p2align	4, 0x90
	.type	_free_array_of_malloc,@function
_free_array_of_malloc:                  # @_free_array_of_malloc
	.cfi_startproc
# %bb.0:
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
# %bb.0:
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
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	lla_exit_with_error@PLT         # TAILCALL
.Lfunc_end1:
	.size	_runtime_error, .Lfunc_end1-_runtime_error
	.cfi_endproc
                                        # -- End function
	.globl	_binary_int_division            # -- Begin function _binary_int_division
	.p2align	4, 0x90
	.type	_binary_int_division,@function
_binary_int_division:                   # @_binary_int_division
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	testq	%rsi, %rsi
	je	.LBB2_1
# %bb.3:
	movq	%rdi, %rax
	cqto
	idivq	%rsi
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB2_1:                                # %.preheader
	.cfi_def_cfa_offset 32
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_1(%rip), %r15
	.p2align	4, 0x90
.LBB2_2:                                # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$33, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB2_2
.Lfunc_end2:
	.size	_binary_int_division, .Lfunc_end2-_binary_int_division
	.cfi_endproc
                                        # -- End function
	.globl	_binary_float_division          # -- Begin function _binary_float_division
	.p2align	4, 0x90
	.type	_binary_float_division,@function
_binary_float_division:                 # @_binary_float_division
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	xorps	%xmm2, %xmm2
	ucomiss	%xmm2, %xmm1
	jne	.LBB3_3
	jp	.LBB3_3
# %bb.1:                                # %.preheader
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_1(%rip), %r15
	.p2align	4, 0x90
.LBB3_2:                                # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$33, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB3_2
.LBB3_3:
	divss	%xmm1, %xmm0
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
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
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	callq	GC_init@PLT
	movq	display_array@GOTPCREL(%rip), %r12
	movq	(%r12), %r13
	leaq	8(%rsp), %rax
	movq	%rax, (%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_2(%rip), %rax
	movq	%rax, (%rbx)
	movq	$35, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_read_int@PLT
	movq	%rax, %r14
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	$1, (%rax)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$3, (%rax)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	$2, (%rax)
	movq	%r14, %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	movq	%rax, %rcx
	callq	"fn3:hanoi"@PLT
	movq	%r13, (%r12)
	xorl	%eax, %eax
	addq	$16, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function
	.globl	"_pile:1_equality"              # -- Begin function _pile:1_equality
	.p2align	4, 0x90
	.type	"_pile:1_equality",@function
"_pile:1_equality":                     # @"_pile:1_equality"
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	(%rdi), %rax
	movq	%rax, 8(%rsp)
	cmpq	(%rsi), %rax
	sete	7(%rsp)
	jne	.LBB5_4
# %bb.1:
	movq	8(%rsp), %rax
	decq	%rax
	cmpq	$3, %rax
	jae	.LBB5_2
.LBB5_4:
	movb	7(%rsp), %al
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB5_2:                                # %.preheader
	.cfi_def_cfa_offset 48
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_3(%rip), %r15
	.p2align	4, 0x90
.LBB5_3:                                # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$85, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB5_3
.Lfunc_end5:
	.size	"_pile:1_equality", .Lfunc_end5-"_pile:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"fn1:print_pile"                # -- Begin function fn1:print_pile
	.p2align	4, 0x90
	.type	"fn1:print_pile",@function
"fn1:print_pile":                       # @"fn1:print_pile"
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rax
	movq	%rax, 16(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	(%rdi), %rax
	movq	%rax, 24(%rsp)
	cmpq	$1, %rax
	jne	.LBB6_2
# %bb.1:
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_4(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	andb	$1, %al
	movb	%al, 13(%rsp)
	jmp	.LBB6_8
.LBB6_2:
	cmpq	$2, %rax
	jne	.LBB6_4
# %bb.3:
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	andb	$1, %al
	movb	%al, 14(%rsp)
	jmp	.LBB6_8
.LBB6_4:
	cmpq	$3, %rax
	jne	.LBB6_5
# %bb.7:
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_6(%rip), %rax
	movq	%rax, (%rbx)
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	andb	$1, %al
	movb	%al, 15(%rsp)
.LBB6_8:
	movb	%al, 7(%rsp)
	movq	16(%rsp), %rax
	movq	%rax, 8(%r14)
	movb	7(%rsp), %al
	addq	$32, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB6_5:
	.cfi_def_cfa_offset 64
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_7(%rip), %r15
	.p2align	4, 0x90
.LBB6_6:                                # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$71, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB6_6
.Lfunc_end6:
	.size	"fn1:print_pile", .Lfunc_end6-"fn1:print_pile"
	.cfi_endproc
                                        # -- End function
	.globl	"fn2:move"                      # -- Begin function fn2:move
	.p2align	4, 0x90
	.type	"fn2:move",@function
"fn2:move":                             # @"fn2:move"
	.cfi_startproc
# %bb.0:
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
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r14
	movq	%rdi, %r12
	movq	display_array@GOTPCREL(%rip), %r13
	movq	8(%r13), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r15
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_8(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r12, %rdi
	callq	"fn1:print_pile"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_9(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r14, %rdi
	callq	"fn1:print_pile"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	addq	$8, %rsp
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
.Lfunc_end7:
	.size	"fn2:move", .Lfunc_end7-"fn2:move"
	.cfi_endproc
                                        # -- End function
	.globl	"fn3:hanoi"                     # -- Begin function fn3:hanoi
	.p2align	4, 0x90
	.type	"fn3:hanoi",@function
"fn3:hanoi":                            # @"fn3:hanoi"
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %r13
	movq	8(%r13), %rax
	movq	%rax, 8(%rsp)
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
	testq	%rdi, %rdi
	jle	.LBB8_2
# %bb.1:
	movq	%rcx, %r15
	movq	%rdx, %r14
	movq	%rsi, %r12
	movq	%rdi, %rbx
	decq	%rbx
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movq	%r14, %rcx
	callq	"fn3:hanoi"@PLT
	movq	%r12, %rdi
	movq	%r14, %rsi
	callq	"fn2:move"@PLT
	movq	%rbx, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	movq	%r12, %rcx
	callq	"fn3:hanoi"@PLT
.LBB8_2:
	movq	8(%rsp), %rax
	movq	%rax, 8(%r13)
	xorl	%eax, %eax
	addq	$16, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end8:
	.size	"fn3:hanoi", .Lfunc_end8-"fn3:hanoi"
	.cfi_endproc
                                        # -- End function
	.type	display_array,@object           # @display_array
	.bss
	.globl	display_array
	.p2align	3
display_array:
	.zero	16
	.size	display_array, 16

	.type	.L__unnamed_1,@object           # @0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__unnamed_1:
	.asciz	"Runtime Error: Division by zero\n"
	.size	.L__unnamed_1, 33

	.type	.L__unnamed_3,@object           # @1
.L__unnamed_3:
	.asciz	"Runtime Error: Invalid constructor of type pile encountered in comparison operation\n"
	.size	.L__unnamed_3, 85

	.type	.L__unnamed_4,@object           # @2
.L__unnamed_4:
	.asciz	"left"
	.size	.L__unnamed_4, 5

	.type	.L__unnamed_5,@object           # @3
.L__unnamed_5:
	.asciz	"middle"
	.size	.L__unnamed_5, 7

	.type	.L__unnamed_6,@object           # @4
.L__unnamed_6:
	.asciz	"right"
	.size	.L__unnamed_6, 6

	.type	.L__unnamed_7,@object           # @5
.L__unnamed_7:
	.asciz	"Runtime Error: Given expression could not be matched with some clause\n"
	.size	.L__unnamed_7, 71

	.type	.L__unnamed_8,@object           # @6
.L__unnamed_8:
	.asciz	"Moving from: "
	.size	.L__unnamed_8, 14

	.type	.L__unnamed_9,@object           # @7
.L__unnamed_9:
	.asciz	" to "
	.size	.L__unnamed_9, 5

	.type	.L__unnamed_10,@object          # @8
.L__unnamed_10:
	.asciz	"\n"
	.size	.L__unnamed_10, 2

	.type	.L__unnamed_2,@object           # @9
.L__unnamed_2:
	.asciz	"Please, give the number of rings: "
	.size	.L__unnamed_2, 35

	.section	".note.GNU-stack","",@progbits
