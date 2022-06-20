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
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	callq	GC_init@PLT
	movq	display_array@GOTPCREL(%rip), %r15
	movq	(%r15), %r12
	movq	%rsp, %rax
	movq	%rax, (%r15)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 16(%rsp)
	movl	$128, %edi
	callq	malloc@PLT
	movq	%rax, %r14
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	xorl	%r13d, %r13d
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, 8(%rsp)
	movq	%r14, (%rbx)
	movq	$16, 8(%rbx)
	movq	16(%rsp), %rax
	movq	$65, (%rax)
	movabsq	$-6757718126012409997, %r8      # imm = 0xA237C32B16CFD773
	xorl	%edi, %edi
	.p2align	4, 0x90
.LBB4_1:                                # %for_check
                                        # =>This Inner Loop Header: Depth=1
	movq	%rdi, 24(%rsp)
	cmpq	$15, %rdi
	jg	.LBB4_8
# %bb.2:                                # %for_body
                                        #   in Loop: Header=BB4_1 Depth=1
	movq	16(%rsp), %rbx
	imulq	$137, (%rbx), %rax
	movq	24(%rsp), %rcx
	leaq	(%rax,%rcx), %rsi
	leaq	220(%rax,%rcx), %rcx
	movq	%rcx, %rax
	imulq	%r8
	leaq	220(%rdx,%rsi), %rax
	movq	%rax, %rdx
	shrq	$63, %rdx
	sarq	$6, %rax
	addq	%rdx, %rax
	imulq	$101, %rax, %rax
	subq	%rax, %rcx
	movq	%rcx, (%rbx)
	testb	%r13b, %r13b
	jne	.LBB4_5
# %bb.3:                                # %for_body
                                        #   in Loop: Header=BB4_1 Depth=1
	movq	24(%rsp), %rax
	testq	%rax, %rax
	js	.LBB4_5
# %bb.4:                                # %for_body
                                        #   in Loop: Header=BB4_1 Depth=1
	movq	8(%rsp), %rcx
	cmpq	8(%rcx), %rax
	jge	.LBB4_5
# %bb.7:                                # %array_ref_bound_check_success
                                        #   in Loop: Header=BB4_1 Depth=1
	movq	(%rcx), %rcx
	movq	16(%rsp), %rdx
	movq	(%rdx), %rdx
	movq	%rdx, (%rcx,%rax,8)
	incq	%rdi
	jmp	.LBB4_1
.LBB4_8:                                # %for_after
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
	leaq	.Lstr.5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$16, 8(%rbx)
	movq	8(%rsp), %rsi
	movq	%rbx, %rdi
	callq	"fn3:print_array"@PLT
	movq	8(%rsp), %rdi
	callq	"fn1:bsort"@PLT
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
	movq	$15, 8(%rbx)
	movq	8(%rsp), %rsi
	movq	%rbx, %rdi
	callq	"fn3:print_array"@PLT
	andb	$1, %al
	movb	%al, 7(%rsp)
	movq	%r12, (%r15)
	xorl	%eax, %eax
	addq	$32, %rsp
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
.LBB4_5:                                # %array_ref_bound_check_failed.preheader
	.cfi_def_cfa_offset 80
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB4_6:                                # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB4_6
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function
	.globl	"fn1:bsort"                     # -- Begin function fn1:bsort
	.p2align	4, 0x90
	.type	"fn1:bsort",@function
"fn1:bsort":                            # @"fn1:bsort"
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
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %r14
	movq	%rsp, %rax
	movq	%rax, 8(%r15)
	movq	%rdi, 8(%rsp)
	movl	$1, %edi
	callq	GC_malloc@PLT
	movq	%rax, 24(%rsp)
	movb	$1, (%rax)
	xorl	%r12d, %r12d
.LBB5_1:                                # %while_check
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_3 Depth 2
	movq	24(%rsp), %rax
	cmpb	$1, (%rax)
	jne	.LBB5_25
# %bb.2:                                # %while_body
                                        #   in Loop: Header=BB5_1 Depth=1
	movq	24(%rsp), %rax
	movb	$0, (%rax)
	movq	8(%rsp), %rax
	movq	8(%rax), %r13
	addq	$-2, %r13
	xorl	%ebx, %ebx
	jmp	.LBB5_3
	.p2align	4, 0x90
.LBB5_23:                               # %array_ref_bound_check_success36
                                        #   in Loop: Header=BB5_3 Depth=2
	shlq	$3, %rdi
	addq	(%rax), %rdi
	shlq	$3, %rsi
	addq	(%rcx), %rsi
	callq	"fn2:swap"@PLT
	movq	24(%rsp), %rax
	movb	$1, (%rax)
.LBB5_24:                               # %if_merge
                                        #   in Loop: Header=BB5_3 Depth=2
	incq	%rbx
.LBB5_3:                                # %for_check
                                        #   Parent Loop BB5_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbx, 16(%rsp)
	cmpq	%r13, %rbx
	jg	.LBB5_1
# %bb.4:                                # %for_body
                                        #   in Loop: Header=BB5_3 Depth=2
	testb	%r12b, %r12b
	jne	.LBB5_7
# %bb.5:                                # %for_body
                                        #   in Loop: Header=BB5_3 Depth=2
	movq	16(%rsp), %rax
	testq	%rax, %rax
	js	.LBB5_7
# %bb.6:                                # %for_body
                                        #   in Loop: Header=BB5_3 Depth=2
	movq	8(%rsp), %rcx
	cmpq	8(%rcx), %rax
	jge	.LBB5_7
# %bb.13:                               # %array_ref_bound_check_success
                                        #   in Loop: Header=BB5_3 Depth=2
	testb	%r12b, %r12b
	jne	.LBB5_16
# %bb.14:                               # %array_ref_bound_check_success
                                        #   in Loop: Header=BB5_3 Depth=2
	movq	16(%rsp), %rdx
	movq	%rdx, %rdi
	incq	%rdi
	js	.LBB5_16
# %bb.15:                               # %array_ref_bound_check_success
                                        #   in Loop: Header=BB5_3 Depth=2
	movq	8(%rsp), %rsi
	cmpq	8(%rsi), %rdi
	jge	.LBB5_16
# %bb.8:                                # %array_ref_bound_check_success9
                                        #   in Loop: Header=BB5_3 Depth=2
	movq	(%rcx), %rcx
	movq	(%rcx,%rax,8), %rax
	movq	(%rsi), %rcx
	cmpq	8(%rcx,%rdx,8), %rax
	jle	.LBB5_24
# %bb.9:                                # %if_then
                                        #   in Loop: Header=BB5_3 Depth=2
	testb	%r12b, %r12b
	jne	.LBB5_12
# %bb.10:                               # %if_then
                                        #   in Loop: Header=BB5_3 Depth=2
	movq	16(%rsp), %rdi
	testq	%rdi, %rdi
	js	.LBB5_12
# %bb.11:                               # %if_then
                                        #   in Loop: Header=BB5_3 Depth=2
	movq	8(%rsp), %rax
	cmpq	8(%rax), %rdi
	jge	.LBB5_12
# %bb.18:                               # %array_ref_bound_check_success23
                                        #   in Loop: Header=BB5_3 Depth=2
	testb	%r12b, %r12b
	jne	.LBB5_21
# %bb.19:                               # %array_ref_bound_check_success23
                                        #   in Loop: Header=BB5_3 Depth=2
	movq	16(%rsp), %rsi
	incq	%rsi
	js	.LBB5_21
# %bb.20:                               # %array_ref_bound_check_success23
                                        #   in Loop: Header=BB5_3 Depth=2
	movq	8(%rsp), %rcx
	cmpq	8(%rcx), %rsi
	jl	.LBB5_23
.LBB5_21:                               # %array_ref_bound_check_failed35.preheader
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_22:                               # %array_ref_bound_check_failed35
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_22
	.p2align	4, 0x90
.LBB5_7:                                # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	leaq	.Lstr.1(%rip), %rdi
	movl	$54, %esi
	callq	_runtime_error@PLT
	jmp	.LBB5_7
	.p2align	4, 0x90
.LBB5_12:                               # %array_ref_bound_check_failed22
                                        # =>This Inner Loop Header: Depth=1
	leaq	.Lstr.1(%rip), %rdi
	movl	$54, %esi
	callq	_runtime_error@PLT
	jmp	.LBB5_12
.LBB5_16:                               # %array_ref_bound_check_failed8.preheader
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_17:                               # %array_ref_bound_check_failed8
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_17
.LBB5_25:                               # %while_after
	movq	%r14, 8(%r15)
	xorl	%eax, %eax
	addq	$32, %rsp
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
.Lfunc_end5:
	.size	"fn1:bsort", .Lfunc_end5-"fn1:bsort"
	.cfi_endproc
                                        # -- End function
	.globl	"fn2:swap"                      # -- Begin function fn2:swap
	.p2align	4, 0x90
	.type	"fn2:swap",@function
"fn2:swap":                             # @"fn2:swap"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rax
	movq	16(%rax), %rcx
	leaq	-32(%rsp), %rdx
	movq	%rdx, 16(%rax)
	movq	%rdi, -8(%rsp)
	movq	%rsi, -16(%rsp)
	movq	(%rdi), %rdx
	movq	%rdx, -24(%rsp)
	movq	(%rsi), %rdx
	movq	%rdx, (%rdi)
	movq	-16(%rsp), %rdx
	movq	-24(%rsp), %rsi
	movq	%rsi, (%rdx)
	movq	%rcx, 16(%rax)
	xorl	%eax, %eax
	retq
.Lfunc_end6:
	.size	"fn2:swap", .Lfunc_end6-"fn2:swap"
	.cfi_endproc
                                        # -- End function
	.globl	"fn3:print_array"               # -- Begin function fn3:print_array
	.p2align	4, 0x90
	.type	"fn3:print_array",@function
"fn3:print_array":                      # @"fn3:print_array"
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rsp, %rax
	movq	%rax, 8(%rcx)
	movq	%rdi, 32(%rsp)
	movq	%rsi, 16(%rsp)
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	movq	8(%rax), %r13
	decq	%r13
	xorl	%ebp, %ebp
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.Lstr.2(%rip), %r12
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB7_1:                                # %for_check
                                        # =>This Inner Loop Header: Depth=1
	movq	%r15, 8(%rsp)
	cmpq	%r13, %r15
	jg	.LBB7_10
# %bb.2:                                # %for_body
                                        #   in Loop: Header=BB7_1 Depth=1
	cmpq	$0, 8(%rsp)
	jle	.LBB7_4
# %bb.3:                                # %if_then
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
	movq	%r12, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
.LBB7_4:                                # %if_merge
                                        #   in Loop: Header=BB7_1 Depth=1
	testb	%bpl, %bpl
	jne	.LBB7_7
# %bb.5:                                # %if_merge
                                        #   in Loop: Header=BB7_1 Depth=1
	movq	8(%rsp), %rax
	testq	%rax, %rax
	js	.LBB7_7
# %bb.6:                                # %if_merge
                                        #   in Loop: Header=BB7_1 Depth=1
	movq	16(%rsp), %rcx
	cmpq	8(%rcx), %rax
	jge	.LBB7_7
# %bb.9:                                # %array_ref_bound_check_success
                                        #   in Loop: Header=BB7_1 Depth=1
	movq	(%rcx), %rcx
	movq	(%rcx,%rax,8), %rdi
	callq	lla_print_int@PLT
	incq	%r15
	jmp	.LBB7_1
.LBB7_10:                               # %for_after
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	24(%rsp), %rdx                  # 8-byte Reload
	movq	%rdx, 8(%rcx)
	addq	$40, %rsp
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
.LBB7_7:                                # %array_ref_bound_check_failed.preheader
	.cfi_def_cfa_offset 96
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB7_8:                                # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB7_8
.Lfunc_end7:
	.size	"fn3:print_array", .Lfunc_end7-"fn3:print_array"
	.cfi_endproc
                                        # -- End function
	.type	display_array,@object           # @display_array
	.bss
	.globl	display_array
	.p2align	4
display_array:
	.zero	24
	.size	display_array, 24

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
	.asciz	", "
	.size	.Lstr.2, 3

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
	.asciz	"Initial array: "
	.size	.Lstr.5, 16

	.type	.Lstr.6,@object                 # @str.6
.Lstr.6:
	.asciz	"Sorted array: "
	.size	.Lstr.6, 15

	.section	".note.GNU-stack","",@progbits
