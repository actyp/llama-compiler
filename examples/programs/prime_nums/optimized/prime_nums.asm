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
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$48, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	callq	GC_init@PLT
	movq	display_array@GOTPCREL(%rip), %r15
	movq	(%r15), %rax
	movq	%rax, 8(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, (%r15)
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
	leaq	.L__unnamed_2(%rip), %rax
	movq	%rax, (%rbx)
	movq	$31, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_read_int@PLT
	movq	(%r15), %rcx
	movq	%rax, (%rcx)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_3(%rip), %rax
	movq	%rax, (%rbx)
	movq	$29, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r15), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_4(%rip), %rax
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r15), %rbx
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 8(%rbx)
	movq	(%r15), %rax
	movq	8(%rax), %rax
	movq	$0, (%rax)
	movq	(%r15), %rax
	movq	%rax, 16(%rsp)
	cmpq	$2, (%rax)
	jl	.LBB4_3
# %bb.1:
	movq	8(%rax), %rdi
	callq	lla_incr@PLT
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
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r15), %rax
	movq	%rax, 24(%rsp)
	cmpq	$3, (%rax)
	jl	.LBB4_3
# %bb.2:
	movq	8(%rax), %rdi
	callq	lla_incr@PLT
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
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
.LBB4_3:                                # %.thread
	movl	$6, %edi
	callq	"fn3:loop"@PLT
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
	leaq	.L__unnamed_7(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r15), %rax
	movq	8(%rax), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_8(%rip), %rax
	movq	%rax, (%rbx)
	movq	$30, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rax
	movq	%rax, (%r15)
	xorl	%eax, %eax
	addq	$48, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
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
	.globl	"fn1:prime"                     # -- Begin function fn1:prime
	.p2align	4, 0x90
	.type	"fn1:prime",@function
"fn1:prime":                            # @"fn1:prime"
# %bb.0:
	pushq	%rbx
	subq	$32, %rsp
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %rax
	movq	%rax, 24(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 8(%rbx)
	movq	%rdi, 16(%rsp)
	testq	%rdi, %rdi
	js	.LBB5_3
# %bb.1:
	cmpq	$1, %rdi
	jle	.LBB5_8
# %bb.5:
	cmpq	$2, %rdi
	jne	.LBB5_7
# %bb.6:                                # %._crit_edge36
	movb	$1, 13(%rsp)
	jmp	.LBB5_9
.LBB5_3:
	negq	%rdi
	callq	"fn1:prime"@PLT
	andb	$1, %al
	movb	%al, 14(%rsp)
.LBB5_4:
	movb	%al, 13(%rsp)
	jmp	.LBB5_9
.LBB5_7:
	testb	$1, %dil
	jne	.LBB5_10
.LBB5_8:                                # %._crit_edge37
	movb	$0, 13(%rsp)
.LBB5_9:
	movq	24(%rsp), %rax
	movq	%rax, 8(%rbx)
	movb	13(%rsp), %al
	addq	$32, %rsp
	popq	%rbx
	retq
.LBB5_10:
	movl	$3, %edi
	callq	"fn2:loop"@PLT
	andb	$1, %al
	movb	%al, 15(%rsp)
	jmp	.LBB5_4
.Lfunc_end5:
	.size	"fn1:prime", .Lfunc_end5-"fn1:prime"
                                        # -- End function
	.globl	"fn2:loop"                      # -- Begin function fn2:loop
	.p2align	4, 0x90
	.type	"fn2:loop",@function
"fn2:loop":                             # @"fn2:loop"
# %bb.0:
	pushq	%rbx
	subq	$32, %rsp
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %rax
	movq	16(%rbx), %rcx
	movq	%rcx, 16(%rsp)
	leaq	8(%rsp), %rcx
	movq	%rcx, 16(%rbx)
	movq	(%rax), %rax
	movq	%rax, 24(%rsp)
	movq	%rax, %rcx
	shrq	$63, %rcx
	addq	%rax, %rcx
	sarq	%rcx
	cmpq	%rdi, %rcx
	jge	.LBB6_2
# %bb.1:                                # %._crit_edge
	movb	$1, 7(%rsp)
	jmp	.LBB6_5
.LBB6_2:
	cqto
	idivq	%rdi
	testq	%rdx, %rdx
	je	.LBB6_3
# %bb.4:
	addq	$2, %rdi
	callq	"fn2:loop"@PLT
	andb	$1, %al
	movb	%al, 15(%rsp)
	movb	%al, 7(%rsp)
	jmp	.LBB6_5
.LBB6_3:                                # %._crit_edge13
	movb	$0, 7(%rsp)
.LBB6_5:
	movq	16(%rsp), %rax
	movq	%rax, 16(%rbx)
	movb	7(%rsp), %al
	addq	$32, %rsp
	popq	%rbx
	retq
.Lfunc_end6:
	.size	"fn2:loop", .Lfunc_end6-"fn2:loop"
                                        # -- End function
	.globl	"fn3:loop"                      # -- Begin function fn3:loop
	.p2align	4, 0x90
	.type	"fn3:loop",@function
"fn3:loop":                             # @"fn3:loop"
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
	movq	display_array@GOTPCREL(%rip), %r15
	movq	(%r15), %rax
	movq	8(%r15), %rcx
	movq	%rcx, 8(%rsp)
	movq	%rsp, %rcx
	movq	%rcx, 8(%r15)
	cmpq	%rdi, (%rax)
	jl	.LBB7_7
# %bb.1:
	movq	%rdi, %rbx
	decq	%rdi
	movq	%rdi, 16(%rsp)
	callq	"fn1:prime"@PLT
	testb	$1, %al
	je	.LBB7_3
# %bb.2:
	movq	(%r15), %rax
	movq	8(%rax), %rdi
	callq	lla_incr@PLT
	movq	16(%rsp), %rdi
	callq	lla_print_int@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r14
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_7(%rip), %rax
	movq	%rax, (%r14)
	movq	$2, 8(%r14)
	movq	%r14, %rdi
	callq	lla_print_string@PLT
.LBB7_3:
	movq	(%r15), %rax
	cmpq	%rbx, (%rax)
	je	.LBB7_6
# %bb.4:
	leaq	1(%rbx), %rdi
	movq	%rdi, 24(%rsp)
	callq	"fn1:prime"@PLT
	testb	$1, %al
	je	.LBB7_6
# %bb.5:
	movq	(%r15), %rax
	movq	8(%rax), %rdi
	callq	lla_incr@PLT
	movq	24(%rsp), %rdi
	callq	lla_print_int@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r14
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_7(%rip), %rax
	movq	%rax, (%r14)
	movq	$2, 8(%r14)
	movq	%r14, %rdi
	callq	lla_print_string@PLT
.LBB7_6:                                # %.critedge
	addq	$6, %rbx
	movq	%rbx, %rdi
	callq	"fn3:loop"@PLT
.LBB7_7:
	movq	8(%rsp), %rax
	movq	%rax, 8(%r15)
	xorl	%eax, %eax
	addq	$32, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	"fn3:loop", .Lfunc_end7-"fn3:loop"
	.cfi_endproc
                                        # -- End function
	.type	display_array,@object           # @display_array
	.bss
	.globl	display_array
	.p2align	4
display_array:
	.zero	24
	.size	display_array, 24

	.type	.L__unnamed_1,@object           # @0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__unnamed_1:
	.asciz	"Runtime Error: Division by zero\n"
	.size	.L__unnamed_1, 33

	.type	.L__unnamed_2,@object           # @1
.L__unnamed_2:
	.asciz	"Please, give the upper limit: "
	.size	.L__unnamed_2, 31

	.type	.L__unnamed_3,@object           # @2
.L__unnamed_3:
	.asciz	"Prime numbers between 0 and "
	.size	.L__unnamed_3, 29

	.type	.L__unnamed_4,@object           # @3
.L__unnamed_4:
	.asciz	"\n\n"
	.size	.L__unnamed_4, 3

	.type	.L__unnamed_5,@object           # @4
.L__unnamed_5:
	.asciz	"2\n"
	.size	.L__unnamed_5, 3

	.type	.L__unnamed_6,@object           # @5
.L__unnamed_6:
	.asciz	"3\n"
	.size	.L__unnamed_6, 3

	.type	.L__unnamed_7,@object           # @6
.L__unnamed_7:
	.asciz	"\n"
	.size	.L__unnamed_7, 2

	.type	.L__unnamed_8,@object           # @7
.L__unnamed_8:
	.asciz	" prime number(s) were found.\n"
	.size	.L__unnamed_8, 30

	.section	".note.GNU-stack","",@progbits
