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
	movq	%rsp, %rax
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
	leaq	.Lstr.9(%rip), %rax
	movq	%rax, (%rbx)
	movq	$35, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_read_int@PLT
	movq	%rax, %r14
	movq	%rax, 8(%rsp)
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
	andb	$1, %al
	movb	%al, 7(%rsp)
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
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB5_5
# %bb.1:                                # %body
	cmpq	$1, %rax
	je	.LBB5_4
# %bb.2:                                # %body
	cmpq	$2, %rax
	je	.LBB5_4
# %bb.3:                                # %body
	cmpq	$3, %rax
	jne	.LBB5_7
.LBB5_4:                                # %"case_pile:1:Left"
	movb	$1, %al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB5_5:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB5_7:
	.cfi_def_cfa_offset 16
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_8:                                # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$85, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_8
.Lfunc_end5:
	.size	"_pile:1_equality", .Lfunc_end5-"_pile:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"fn1:print_pile"                # -- Begin function fn1:print_pile
	.p2align	4, 0x90
	.type	"fn1:print_pile",@function
"fn1:print_pile":                       # @"fn1:print_pile"
	.cfi_startproc
# %bb.0:                                # %entry
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
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %r15
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 8(%rsp)
	cmpq	$1, (%rdi)
	jne	.LBB6_3
# %bb.1:                                # %match_param_check_1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.2(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	jmp	.LBB6_2
.LBB6_3:                                # %match_check_2
	cmpq	$2, (%rdi)
	jne	.LBB6_5
# %bb.4:                                # %match_param_check_2
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.3(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	jmp	.LBB6_2
.LBB6_5:                                # %match_check_3
	cmpq	$3, (%rdi)
	jne	.LBB6_7
# %bb.6:                                # %match_param_check_3
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.4(%rip), %rax
	movq	%rax, (%rbx)
	movq	$6, 8(%rbx)
.LBB6_2:                                # %match_finished
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r15, 8(%r14)
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB6_7:                                # %match_failed.preheader
	.cfi_def_cfa_offset 48
	leaq	.Lstr.5(%rip), %rbx
	.p2align	4, 0x90
.LBB6_8:                                # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB6_8
.Lfunc_end6:
	.size	"fn1:print_pile", .Lfunc_end6-"fn1:print_pile"
	.cfi_endproc
                                        # -- End function
	.globl	"fn2:move"                      # -- Begin function fn2:move
	.p2align	4, 0x90
	.type	"fn2:move",@function
"fn2:move":                             # @"fn2:move"
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
	leaq	.Lstr.6(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rdi
	callq	"fn1:print_pile"@PLT
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
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rdi
	callq	"fn1:print_pile"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.8(%rip), %rax
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
.Lfunc_end7:
	.size	"fn2:move", .Lfunc_end7-"fn2:move"
	.cfi_endproc
                                        # -- End function
	.globl	"fn3:hanoi"                     # -- Begin function fn3:hanoi
	.p2align	4, 0x90
	.type	"fn3:hanoi",@function
"fn3:hanoi":                            # @"fn3:hanoi"
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
	jle	.LBB8_1
# %bb.2:                                # %if_then
	movq	32(%rsp), %rdi
	decq	%rdi
	movq	16(%rsp), %rsi
	movq	24(%rsp), %rdx
	movq	8(%rsp), %rcx
	callq	"fn3:hanoi"@PLT
	movq	16(%rsp), %rdi
	movq	8(%rsp), %rsi
	callq	"fn2:move"@PLT
	movq	32(%rsp), %rdi
	decq	%rdi
	movq	24(%rsp), %rsi
	movq	8(%rsp), %rdx
	movq	16(%rsp), %rcx
	callq	"fn3:hanoi"@PLT
                                        # kill: def $al killed $al def $eax
	jmp	.LBB8_3
.LBB8_1:
	xorl	%eax, %eax
.LBB8_3:                                # %if_merge
	movq	%rbx, 8(%r14)
                                        # kill: def $al killed $al killed $eax
	addq	$40, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
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

	.type	.Lstr,@object                   # @str
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lstr:
	.asciz	"Runtime Error: Division by zero\n"
	.size	.Lstr, 33

	.type	.Lstr.1,@object                 # @str.1
.Lstr.1:
	.asciz	"Runtime Error: Invalid constructor of type pile encountered in comparison operation\n"
	.size	.Lstr.1, 85

	.type	.Lstr.2,@object                 # @str.2
.Lstr.2:
	.asciz	"left"
	.size	.Lstr.2, 5

	.type	.Lstr.3,@object                 # @str.3
.Lstr.3:
	.asciz	"middle"
	.size	.Lstr.3, 7

	.type	.Lstr.4,@object                 # @str.4
.Lstr.4:
	.asciz	"right"
	.size	.Lstr.4, 6

	.type	.Lstr.5,@object                 # @str.5
.Lstr.5:
	.asciz	"Runtime Error: Given expression could not be matched with some clause\n"
	.size	.Lstr.5, 71

	.type	.Lstr.6,@object                 # @str.6
.Lstr.6:
	.asciz	"Moving from: "
	.size	.Lstr.6, 14

	.type	.Lstr.7,@object                 # @str.7
.Lstr.7:
	.asciz	" to "
	.size	.Lstr.7, 5

	.type	.Lstr.8,@object                 # @str.8
.Lstr.8:
	.asciz	"\n"
	.size	.Lstr.8, 2

	.type	.Lstr.9,@object                 # @str.9
.Lstr.9:
	.asciz	"Please, give the number of rings: "
	.size	.Lstr.9, 35

	.section	".note.GNU-stack","",@progbits
