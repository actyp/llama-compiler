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
	subq	$48, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	callq	GC_init@PLT
	movq	display_array@GOTPCREL(%rip), %r12
	movq	(%r12), %r13
	leaq	40(%rsp), %rax
	movq	%rax, (%r12)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 40(%rsp)
	movq	(%r12), %rax
	movq	(%rax), %rax
	movq	$65, (%rax)
	movb	$0, 15(%rsp)
	movl	$96, %edi
	callq	malloc@PLT
	movq	%rax, %r15
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, 24(%rsp)
	movq	%r15, (%rbx)
	movq	$3, 8(%rbx)
	movq	$4, 16(%rbx)
	movl	$160, %edi
	callq	malloc@PLT
	movq	%rax, %r15
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, 16(%rsp)
	movq	%r15, (%rbx)
	movq	$4, 8(%rbx)
	movq	$5, 16(%rbx)
	movl	$120, %edi
	callq	malloc@PLT
	movq	%rax, %r15
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, 32(%rsp)
	movq	%r15, (%rbx)
	movq	$3, 8(%rbx)
	movq	$5, 16(%rbx)
	movq	24(%rsp), %rdi
	callq	"fn2:minit"@PLT
	movq	16(%rsp), %rdi
	callq	"fn2:minit"@PLT
	movq	24(%rsp), %rdi
	callq	"fn3:mprint"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rdi
	callq	"fn3:mprint"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.6(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	24(%rsp), %rdi
	movq	16(%rsp), %rsi
	movq	32(%rsp), %rdx
	callq	"fn1:mmult"@PLT
	movq	32(%rsp), %rdi
	callq	"fn3:mprint"@PLT
	andb	$1, %al
	movb	%al, 14(%rsp)
	movq	%r13, (%r12)
	xorl	%eax, %eax
	addq	$48, %rsp
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
	.globl	"fn1:mmult"                     # -- Begin function fn1:mmult
	.p2align	4, 0x90
	.type	"fn1:mmult",@function
"fn1:mmult":                            # @"fn1:mmult"
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
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	leaq	8(%rsp), %rax
	movq	%rax, 8(%rcx)
	movq	%rdi, 32(%rsp)
	movq	%rsi, 48(%rsp)
	movq	%rdx, (%rsp)
	movq	16(%rdi), %rax
	movq	8(%rsi), %rcx
	cmpq	%rcx, %rax
	je	.LBB5_2
# %bb.1:
	xorl	%eax, %eax
	testb	%al, %al
	je	.LBB5_4
.LBB5_5:                                # %logical_non_short_circuit11
	movq	(%rsp), %rcx
	movq	16(%rcx), %rcx
	movq	48(%rsp), %rdx
	cmpq	16(%rdx), %rcx
	sete	%cl
	andb	%cl, %al
	testb	%al, %al
	jne	.LBB5_7
	jmp	.LBB5_51
.LBB5_2:                                # %logical_non_short_circuit
	xorq	%rcx, %rax
	movq	(%rsp), %rcx
	movq	8(%rcx), %rcx
	movq	32(%rsp), %rdx
	xorq	8(%rdx), %rcx
	orq	%rax, %rcx
	sete	%al
	testb	%al, %al
	jne	.LBB5_5
.LBB5_4:
	xorl	%eax, %eax
	testb	%al, %al
	je	.LBB5_51
.LBB5_7:                                # %if_then
	movq	(%rsp), %rax
	movq	8(%rax), %rax
	decq	%rax
	xorl	%r12d, %r12d
	xorl	%ecx, %ecx
	movq	%rax, 56(%rsp)                  # 8-byte Spill
.LBB5_8:                                # %for_check
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_10 Depth 2
                                        #       Child Loop BB5_19 Depth 3
	movq	%rcx, 24(%rsp)
	cmpq	%rax, %rcx
	jg	.LBB5_51
# %bb.9:                                # %for_body
                                        #   in Loop: Header=BB5_8 Depth=1
	movq	(%rsp), %rax
	movq	16(%rax), %rax
	decq	%rax
	xorl	%edx, %edx
	movq	%rcx, 72(%rsp)                  # 8-byte Spill
	movq	%rax, 64(%rsp)                  # 8-byte Spill
.LBB5_10:                               # %for_check26
                                        #   Parent Loop BB5_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB5_19 Depth 3
	movq	%rdx, 16(%rsp)
	cmpq	%rax, %rdx
	jg	.LBB5_50
# %bb.11:                               # %for_body27
                                        #   in Loop: Header=BB5_10 Depth=2
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	testb	%r12b, %r12b
	jne	.LBB5_16
# %bb.12:                               # %for_body27
                                        #   in Loop: Header=BB5_10 Depth=2
	movq	24(%rsp), %rax
	testq	%rax, %rax
	js	.LBB5_16
# %bb.13:                               # %for_body27
                                        #   in Loop: Header=BB5_10 Depth=2
	movq	(%rsp), %rcx
	cmpq	8(%rcx), %rax
	jge	.LBB5_16
# %bb.14:                               # %for_body27
                                        #   in Loop: Header=BB5_10 Depth=2
	movq	16(%rsp), %rdx
	testq	%rdx, %rdx
	js	.LBB5_16
# %bb.15:                               # %for_body27
                                        #   in Loop: Header=BB5_10 Depth=2
	movq	16(%rcx), %rsi
	cmpq	%rsi, %rdx
	jge	.LBB5_16
# %bb.18:                               # %array_ref_bound_check_success
                                        #   in Loop: Header=BB5_10 Depth=2
	imulq	%rsi, %rax
	addq	%rax, %rdx
	movq	(%rcx), %rax
	movq	$0, (%rax,%rdx,8)
	movq	32(%rsp), %rax
	movq	16(%rax), %rax
	decq	%rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB5_19:                               # %for_check45
                                        #   Parent Loop BB5_8 Depth=1
                                        #     Parent Loop BB5_10 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	%rcx, 40(%rsp)
	cmpq	96(%rsp), %rcx                  # 8-byte Folded Reload
	jg	.LBB5_49
# %bb.20:                               # %for_body46
                                        #   in Loop: Header=BB5_19 Depth=3
	testb	%r12b, %r12b
	jne	.LBB5_25
# %bb.21:                               # %for_body46
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	24(%rsp), %rdx
	testq	%rdx, %rdx
	js	.LBB5_25
# %bb.22:                               # %for_body46
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	(%rsp), %rsi
	cmpq	8(%rsi), %rdx
	jge	.LBB5_25
# %bb.23:                               # %for_body46
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	16(%rsp), %rbx
	testq	%rbx, %rbx
	js	.LBB5_25
# %bb.24:                               # %for_body46
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	16(%rsi), %rdi
	cmpq	%rdi, %rbx
	jge	.LBB5_25
# %bb.27:                               # %array_ref_bound_check_success55
                                        #   in Loop: Header=BB5_19 Depth=3
	testb	%r12b, %r12b
	jne	.LBB5_32
# %bb.28:                               # %array_ref_bound_check_success55
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	24(%rsp), %rax
	testq	%rax, %rax
	js	.LBB5_32
# %bb.29:                               # %array_ref_bound_check_success55
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	(%rsp), %rbp
	cmpq	8(%rbp), %rax
	jge	.LBB5_32
# %bb.30:                               # %array_ref_bound_check_success55
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	16(%rsp), %r8
	testq	%r8, %r8
	js	.LBB5_32
# %bb.31:                               # %array_ref_bound_check_success55
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	16(%rbp), %r9
	cmpq	%r9, %r8
	jge	.LBB5_32
# %bb.34:                               # %array_ref_bound_check_success77
                                        #   in Loop: Header=BB5_19 Depth=3
	testb	%r12b, %r12b
	jne	.LBB5_39
# %bb.35:                               # %array_ref_bound_check_success77
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	24(%rsp), %r10
	testq	%r10, %r10
	js	.LBB5_39
# %bb.36:                               # %array_ref_bound_check_success77
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	32(%rsp), %r11
	cmpq	8(%r11), %r10
	jge	.LBB5_39
# %bb.37:                               # %array_ref_bound_check_success77
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	40(%rsp), %r14
	testq	%r14, %r14
	js	.LBB5_39
# %bb.38:                               # %array_ref_bound_check_success77
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	16(%r11), %r15
	cmpq	%r15, %r14
	jge	.LBB5_39
# %bb.41:                               # %array_ref_bound_check_success99
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	%rdi, 104(%rsp)                 # 8-byte Spill
	movq	%rsi, 112(%rsp)                 # 8-byte Spill
	testb	%r12b, %r12b
	jne	.LBB5_46
# %bb.42:                               # %array_ref_bound_check_success99
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	40(%rsp), %r12
	testq	%r12, %r12
	js	.LBB5_46
# %bb.43:                               # %array_ref_bound_check_success99
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	48(%rsp), %r13
	cmpq	8(%r13), %r12
	jge	.LBB5_46
# %bb.44:                               # %array_ref_bound_check_success99
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	16(%rsp), %rdi
	testq	%rdi, %rdi
	js	.LBB5_46
# %bb.45:                               # %array_ref_bound_check_success99
                                        #   in Loop: Header=BB5_19 Depth=3
	movq	16(%r13), %rsi
	cmpq	%rsi, %rdi
	jge	.LBB5_46
# %bb.48:                               # %array_ref_bound_check_success122
                                        #   in Loop: Header=BB5_19 Depth=3
	imulq	%r15, %r10
	addq	%r10, %r14
	movq	%rcx, %r10
	movq	(%r11), %rcx
	movq	(%rcx,%r14,8), %rcx
	imulq	%rsi, %r12
	addq	%r12, %rdi
	movq	(%r13), %rsi
	imulq	(%rsi,%rdi,8), %rcx
	imulq	%r9, %rax
	addq	%rax, %r8
	movq	(%rbp), %rax
	addq	(%rax,%r8,8), %rcx
	imulq	104(%rsp), %rdx                 # 8-byte Folded Reload
	addq	%rdx, %rbx
	movq	112(%rsp), %rax                 # 8-byte Reload
	movq	(%rax), %rax
	movq	%rcx, (%rax,%rbx,8)
	movq	%r10, %rcx
	incq	%rcx
	xorl	%r12d, %r12d
	jmp	.LBB5_19
.LBB5_49:                               # %for_after47
                                        #   in Loop: Header=BB5_10 Depth=2
	movq	80(%rsp), %rdx                  # 8-byte Reload
	incq	%rdx
	movq	72(%rsp), %rcx                  # 8-byte Reload
	movq	64(%rsp), %rax                  # 8-byte Reload
	jmp	.LBB5_10
.LBB5_50:                               # %for_after28
                                        #   in Loop: Header=BB5_8 Depth=1
	incq	%rcx
	movq	56(%rsp), %rax                  # 8-byte Reload
	jmp	.LBB5_8
.LBB5_51:                               # %if_merge
	movq	display_array@GOTPCREL(%rip), %rax
	movq	88(%rsp), %rcx                  # 8-byte Reload
	movq	%rcx, 8(%rax)
	xorl	%eax, %eax
	addq	$120, %rsp
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
.LBB5_25:                               # %array_ref_bound_check_failed54.preheader
	.cfi_def_cfa_offset 176
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_26:                               # %array_ref_bound_check_failed54
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_26
.LBB5_32:                               # %array_ref_bound_check_failed76.preheader
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_33:                               # %array_ref_bound_check_failed76
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_33
.LBB5_39:                               # %array_ref_bound_check_failed98.preheader
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_40:                               # %array_ref_bound_check_failed98
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_40
.LBB5_46:                               # %array_ref_bound_check_failed121.preheader
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_47:                               # %array_ref_bound_check_failed121
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_47
.LBB5_16:                               # %array_ref_bound_check_failed.preheader
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_17:                               # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_17
.Lfunc_end5:
	.size	"fn1:mmult", .Lfunc_end5-"fn1:mmult"
	.cfi_endproc
                                        # -- End function
	.globl	"fn2:minit"                     # -- Begin function fn2:minit
	.p2align	4, 0x90
	.type	"fn2:minit",@function
"fn2:minit":                            # @"fn2:minit"
	.cfi_startproc
# %bb.0:                                # %entry
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
	movq	8(%r15), %r8
	movq	%rsp, %rax
	movq	%rax, 8(%r15)
	movq	%rdi, 24(%rsp)
	movq	8(%rdi), %r9
	decq	%r9
	xorl	%r11d, %r11d
	movabsq	$-6757718126012409997, %r14     # imm = 0xA237C32B16CFD773
	xorl	%r10d, %r10d
.LBB6_1:                                # %for_check
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_3 Depth 2
	movq	%r10, 16(%rsp)
	cmpq	%r9, %r10
	jg	.LBB6_13
# %bb.2:                                # %for_body
                                        #   in Loop: Header=BB6_1 Depth=1
	movq	24(%rsp), %rax
	movq	16(%rax), %rbx
	decq	%rbx
	xorl	%edi, %edi
	.p2align	4, 0x90
.LBB6_3:                                # %for_check1
                                        #   Parent Loop BB6_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rdi, 8(%rsp)
	cmpq	%rbx, %rdi
	jg	.LBB6_12
# %bb.4:                                # %for_body2
                                        #   in Loop: Header=BB6_3 Depth=2
	movq	(%r15), %rax
	movq	(%rax), %rsi
	imulq	$137, (%rsi), %rax
	movq	16(%rsp), %rcx
	leaq	(%rax,%rcx,2), %rcx
	addq	8(%rsp), %rcx
	movq	%rcx, %rax
	imulq	%r14
	addq	%rcx, %rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$6, %rdx
	addq	%rax, %rdx
	imulq	$101, %rdx, %rax
	subq	%rax, %rcx
	movq	%rcx, (%rsi)
	testb	%r11b, %r11b
	jne	.LBB6_9
# %bb.5:                                # %for_body2
                                        #   in Loop: Header=BB6_3 Depth=2
	movq	16(%rsp), %rax
	testq	%rax, %rax
	js	.LBB6_9
# %bb.6:                                # %for_body2
                                        #   in Loop: Header=BB6_3 Depth=2
	movq	24(%rsp), %rcx
	cmpq	8(%rcx), %rax
	jge	.LBB6_9
# %bb.7:                                # %for_body2
                                        #   in Loop: Header=BB6_3 Depth=2
	movq	8(%rsp), %rdx
	testq	%rdx, %rdx
	js	.LBB6_9
# %bb.8:                                # %for_body2
                                        #   in Loop: Header=BB6_3 Depth=2
	movq	16(%rcx), %rsi
	cmpq	%rsi, %rdx
	jge	.LBB6_9
# %bb.11:                               # %array_ref_bound_check_success
                                        #   in Loop: Header=BB6_3 Depth=2
	imulq	%rsi, %rax
	addq	%rax, %rdx
	movq	(%rcx), %rax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movq	(%rcx), %rcx
	movq	%rcx, (%rax,%rdx,8)
	incq	%rdi
	jmp	.LBB6_3
	.p2align	4, 0x90
.LBB6_12:                               # %for_after3
                                        #   in Loop: Header=BB6_1 Depth=1
	incq	%r10
	jmp	.LBB6_1
.LBB6_9:                                # %array_ref_bound_check_failed.preheader
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB6_10:                               # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB6_10
.LBB6_13:                               # %for_after
	movq	%r8, 8(%r15)
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
.Lfunc_end6:
	.size	"fn2:minit", .Lfunc_end6-"fn2:minit"
	.cfi_endproc
                                        # -- End function
	.globl	"fn3:mprint"                    # -- Begin function fn3:mprint
	.p2align	4, 0x90
	.type	"fn3:mprint",@function
"fn3:mprint":                           # @"fn3:mprint"
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rsp, %rax
	movq	%rax, 8(%rcx)
	movq	%rdi, 8(%rsp)
	movq	8(%rdi), %rax
	decq	%rax
	xorl	%ebp, %ebp
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.Lstr.2(%rip), %r12
	xorl	%ecx, %ecx
	movq	%rax, 24(%rsp)                  # 8-byte Spill
.LBB7_1:                                # %for_check
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_3 Depth 2
	movq	%rcx, 48(%rsp)
	cmpq	%rax, %rcx
	jg	.LBB7_13
# %bb.2:                                # %for_body
                                        #   in Loop: Header=BB7_1 Depth=1
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax
	movq	16(%rax), %r13
	decq	%r13
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB7_3:                                # %for_check1
                                        #   Parent Loop BB7_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r15, 40(%rsp)
	cmpq	%r13, %r15
	jg	.LBB7_12
# %bb.4:                                # %for_body2
                                        #   in Loop: Header=BB7_3 Depth=2
	testb	%bpl, %bpl
	jne	.LBB7_9
# %bb.5:                                # %for_body2
                                        #   in Loop: Header=BB7_3 Depth=2
	movq	48(%rsp), %rax
	testq	%rax, %rax
	js	.LBB7_9
# %bb.6:                                # %for_body2
                                        #   in Loop: Header=BB7_3 Depth=2
	movq	8(%rsp), %rcx
	cmpq	8(%rcx), %rax
	jge	.LBB7_9
# %bb.7:                                # %for_body2
                                        #   in Loop: Header=BB7_3 Depth=2
	movq	40(%rsp), %rdx
	testq	%rdx, %rdx
	js	.LBB7_9
# %bb.8:                                # %for_body2
                                        #   in Loop: Header=BB7_3 Depth=2
	movq	16(%rcx), %rsi
	cmpq	%rsi, %rdx
	jge	.LBB7_9
# %bb.11:                               # %array_ref_bound_check_success
                                        #   in Loop: Header=BB7_3 Depth=2
	imulq	%rsi, %rax
	addq	%rax, %rdx
	movq	(%rcx), %rax
	movq	(%rax,%rdx,8), %rdi
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
	movq	%r12, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	incq	%r15
	jmp	.LBB7_3
	.p2align	4, 0x90
.LBB7_12:                               # %for_after3
                                        #   in Loop: Header=BB7_1 Depth=1
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
	movq	32(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	24(%rsp), %rax                  # 8-byte Reload
	jmp	.LBB7_1
.LBB7_9:                                # %array_ref_bound_check_failed.preheader
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB7_10:                               # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB7_10
.LBB7_13:                               # %for_after
	movq	display_array@GOTPCREL(%rip), %rax
	movq	16(%rsp), %rcx                  # 8-byte Reload
	movq	%rcx, 8(%rax)
	xorl	%eax, %eax
	addq	$56, %rsp
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
	.size	"fn3:mprint", .Lfunc_end7-"fn3:mprint"
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
	.asciz	" "
	.size	.Lstr.2, 2

	.type	.Lstr.3,@object                 # @str.3
.Lstr.3:
	.asciz	"\n"
	.size	.Lstr.3, 2

	.type	.Lstr.4,@object                 # @str.4
.Lstr.4:
	.asciz	"Runtime Error: Non positive dimension size on array declaration\n"
	.size	.Lstr.4, 65

	.type	.Lstr.5,@object                 # @str.5
.Lstr.5:
	.asciz	"\ntimes\n\n"
	.size	.Lstr.5, 9

	.type	.Lstr.6,@object                 # @str.6
.Lstr.6:
	.asciz	"\nmakes\n\n"
	.size	.Lstr.6, 9

	.section	".note.GNU-stack","",@progbits
