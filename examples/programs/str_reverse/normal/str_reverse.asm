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
	movl	$20, %edi
	callq	malloc@PLT
	movq	%rax, %r14
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
	movq	%rbx, 8(%rsp)
	movq	%r14, (%rbx)
	movq	$20, 8(%rbx)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.3(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	8(%rsp), %rsi
	movq	%rbx, %rdi
	callq	"fn1:reverse"@PLT
	movq	8(%rsp), %rdi
	callq	lla_print_string@PLT
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
	.globl	"fn1:reverse"                   # -- Begin function fn1:reverse
	.p2align	4, 0x90
	.type	"fn1:reverse",@function
"fn1:reverse":                          # @"fn1:reverse"
	.cfi_startproc
# %bb.0:                                # %entry
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
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %r14
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r15)
	movq	%rdi, 40(%rsp)
	movq	%rsi, 32(%rsp)
	callq	lla_strlen@PLT
	movq	%rax, 24(%rsp)
	decq	%rax
	xorl	%r8d, %r8d
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB5_1:                                # %for_check
                                        # =>This Inner Loop Header: Depth=1
	movq	%rdx, 16(%rsp)
	cmpq	%rax, %rdx
	jg	.LBB5_13
# %bb.2:                                # %for_body
                                        #   in Loop: Header=BB5_1 Depth=1
	testb	%r8b, %r8b
	jne	.LBB5_5
# %bb.3:                                # %for_body
                                        #   in Loop: Header=BB5_1 Depth=1
	movq	16(%rsp), %rsi
	testq	%rsi, %rsi
	js	.LBB5_5
# %bb.4:                                # %for_body
                                        #   in Loop: Header=BB5_1 Depth=1
	movq	32(%rsp), %rdi
	cmpq	8(%rdi), %rsi
	jge	.LBB5_5
# %bb.7:                                # %array_ref_bound_check_success
                                        #   in Loop: Header=BB5_1 Depth=1
	testb	%r8b, %r8b
	jne	.LBB5_10
# %bb.8:                                # %array_ref_bound_check_success
                                        #   in Loop: Header=BB5_1 Depth=1
	movq	16(%rsp), %rbx
	notq	%rbx
	addq	24(%rsp), %rbx
	js	.LBB5_10
# %bb.9:                                # %array_ref_bound_check_success
                                        #   in Loop: Header=BB5_1 Depth=1
	movq	40(%rsp), %rcx
	cmpq	8(%rcx), %rbx
	jge	.LBB5_10
# %bb.12:                               # %array_ref_bound_check_success6
                                        #   in Loop: Header=BB5_1 Depth=1
	movq	(%rdi), %rdi
	movq	(%rcx), %rcx
	movzbl	(%rcx,%rbx), %ecx
	movb	%cl, (%rdi,%rsi)
	incq	%rdx
	jmp	.LBB5_1
.LBB5_13:                               # %for_after
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB5_16
# %bb.14:                               # %for_after
	movq	24(%rsp), %rax
	testq	%rax, %rax
	js	.LBB5_16
# %bb.15:                               # %for_after
	movq	32(%rsp), %rcx
	cmpq	8(%rcx), %rax
	jge	.LBB5_16
# %bb.18:                               # %array_ref_bound_check_success22
	movq	(%rcx), %rcx
	movb	$0, (%rcx,%rax)
	movq	%r14, 8(%r15)
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
.LBB5_5:                                # %array_ref_bound_check_failed.preheader
	.cfi_def_cfa_offset 80
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_6:                                # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_6
.LBB5_10:                               # %array_ref_bound_check_failed5.preheader
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_11:                               # %array_ref_bound_check_failed5
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_11
.LBB5_16:                               # %array_ref_bound_check_failed21.preheader
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_17:                               # %array_ref_bound_check_failed21
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_17
.Lfunc_end5:
	.size	"fn1:reverse", .Lfunc_end5-"fn1:reverse"
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
	.asciz	"Runtime Error: Out of bounds error in array ref call\n"
	.size	.Lstr.1, 54

	.type	.Lstr.2,@object                 # @str.2
.Lstr.2:
	.asciz	"Runtime Error: Non positive dimension size on array declaration\n"
	.size	.Lstr.2, 65

	.type	.Lstr.3,@object                 # @str.3
.Lstr.3:
	.asciz	"\n!dlrow olleH"
	.size	.Lstr.3, 14

	.section	".note.GNU-stack","",@progbits
