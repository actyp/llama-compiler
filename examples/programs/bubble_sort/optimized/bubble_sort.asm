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
	subq	$80, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	callq	GC_init@PLT
	movq	display_array@GOTPCREL(%rip), %r15
	movq	(%r15), %rax
	movq	%rax, 40(%rsp)
	movq	%rsp, %rax
	movq	%rax, (%r15)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 24(%rsp)
	movl	$128, %edi
	callq	malloc@PLT
	movq	%rax, %r14
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, 8(%rsp)
	movq	%rbx, 48(%rsp)
	movq	%r14, (%rbx)
	leaq	8(%rbx), %rax
	movq	%rax, 56(%rsp)
	movq	$16, 8(%rbx)
	movq	24(%rsp), %rax
	movq	$65, (%rax)
	movq	$0, 16(%rsp)
	movabsq	$-6757718126012409997, %rsi     # imm = 0xA237C32B16CFD773
	.p2align	4, 0x90
.LBB4_1:                                # =>This Inner Loop Header: Depth=1
	movq	16(%rsp), %rax
	movq	%rax, 32(%rsp)
	movq	24(%rsp), %rdi
	imulq	$137, (%rdi), %rcx
	leaq	(%rax,%rcx), %rbx
	leaq	220(%rax,%rcx), %rcx
	movq	%rcx, %rax
	imulq	%rsi
	leaq	220(%rdx,%rbx), %rax
	movq	%rax, %rdx
	shrq	$63, %rdx
	sarq	$6, %rax
	addq	%rdx, %rax
	imulq	$101, %rax, %rax
	subq	%rax, %rcx
	movq	%rcx, 64(%rsp)
	movq	%rcx, (%rdi)
	movq	56(%rsp), %rcx
	movq	32(%rsp), %rax
	cmpq	(%rcx), %rax
	jge	.LBB4_2
# %bb.4:                                #   in Loop: Header=BB4_1 Depth=1
	movq	48(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	64(%rsp), %rdx
	movq	%rdx, (%rcx,%rax,8)
	movq	32(%rsp), %rax
	incq	%rax
	movq	%rax, 72(%rsp)
	cmpq	$15, %rax
	ja	.LBB4_6
# %bb.5:                                # %._crit_edge
                                        #   in Loop: Header=BB4_1 Depth=1
	movq	%rax, 16(%rsp)
	jmp	.LBB4_1
.LBB4_2:                                # %.preheader
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_2(%rip), %r15
	.p2align	4, 0x90
.LBB4_3:                                # =>This Inner Loop Header: Depth=1
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
	movq	$54, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_3
.LBB4_6:
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
	leaq	.L__unnamed_3(%rip), %rax
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
	leaq	.L__unnamed_4(%rip), %rax
	movq	%rax, (%rbx)
	movq	$15, 8(%rbx)
	movq	8(%rsp), %rsi
	movq	%rbx, %rdi
	callq	"fn3:print_array"@PLT
	movq	40(%rsp), %rax
	movq	%rax, (%r15)
	xorl	%eax, %eax
	addq	$80, %rsp
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
	.globl	"fn1:bsort"                     # -- Begin function fn1:bsort
	.p2align	4, 0x90
	.type	"fn1:bsort",@function
"fn1:bsort":                            # @"fn1:bsort"
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$128, %rsp
	.cfi_def_cfa_offset 160
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, %rbx
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rax
	movq	%rax, 48(%rsp)
	leaq	8(%rsp), %r15
	movq	%r15, 8(%r14)
	movl	$1, %edi
	callq	GC_malloc@PLT
	movq	%rax, 16(%rsp)
	movb	$1, (%rax)
	leaq	8(%rbx), %rax
	movq	%rax, 32(%rsp)
	movq	%rax, 56(%rsp)
	movq	%rbx, 64(%rsp)
	movq	%rbx, 72(%rsp)
	movq	%r15, 120(%rsp)
	jmp	.LBB5_1
	.p2align	4, 0x90
.LBB5_16:                               # %._crit_edge
                                        #   in Loop: Header=BB5_1 Depth=1
	movq	16(%rsp), %rax
	cmpb	$0, (%rax)
	je	.LBB5_17
.LBB5_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_3 Depth 2
	movq	16(%rsp), %rax
	movb	$0, (%rax)
	movq	32(%rsp), %rax
	movq	(%rax), %rax
	addq	$-2, %rax
	movq	%rax, 80(%rsp)
	js	.LBB5_16
# %bb.2:                                # %.lr.ph
                                        #   in Loop: Header=BB5_1 Depth=1
	movq	$0, 24(%rsp)
	.p2align	4, 0x90
.LBB5_3:                                #   Parent Loop BB5_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	24(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	56(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	%rcx, 96(%rsp)
	cmpq	%rcx, %rax
	jge	.LBB5_4
# %bb.6:                                #   in Loop: Header=BB5_3 Depth=2
	movq	64(%rsp), %rax
	movq	(%rax), %rcx
	movq	%rcx, 104(%rsp)
	movq	88(%rsp), %rax
	leaq	(%rcx,%rax,8), %rcx
	movq	%rcx, 40(%rsp)
	leaq	1(%rax), %rcx
	movq	%rcx, 112(%rsp)
	cmpq	96(%rsp), %rcx
	jge	.LBB5_7
# %bb.9:                                #   in Loop: Header=BB5_3 Depth=2
	movq	40(%rsp), %rdx
	movq	(%rdx), %rdx
	movq	104(%rsp), %rsi
	cmpq	8(%rsi,%rax,8), %rdx
	jle	.LBB5_14
# %bb.10:                               #   in Loop: Header=BB5_3 Depth=2
	movq	32(%rsp), %rdx
	cmpq	(%rdx), %rcx
	jge	.LBB5_11
# %bb.13:                               #   in Loop: Header=BB5_3 Depth=2
	movq	72(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	16(%r14), %rdx
	movq	%r15, 16(%r14)
	movq	40(%rsp), %rsi
	movq	(%rsi), %rdi
	movq	8(%rcx,%rax,8), %rbx
	movq	%rbx, (%rsi)
	movq	%rdi, 8(%rcx,%rax,8)
	movq	%rdx, 16(%r14)
	movq	16(%rsp), %rax
	movb	$1, (%rax)
.LBB5_14:                               #   in Loop: Header=BB5_3 Depth=2
	movq	112(%rsp), %rax
	cmpq	80(%rsp), %rax
	jg	.LBB5_16
# %bb.15:                               # %._crit_edge81
                                        #   in Loop: Header=BB5_3 Depth=2
	movq	%rax, 24(%rsp)
	jmp	.LBB5_3
.LBB5_4:                                # %.preheader67
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_2(%rip), %r15
	.p2align	4, 0x90
.LBB5_5:                                # =>This Inner Loop Header: Depth=1
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
	movq	$54, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB5_5
.LBB5_7:                                # %.preheader66
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_2(%rip), %r15
	.p2align	4, 0x90
.LBB5_8:                                # =>This Inner Loop Header: Depth=1
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
	movq	$54, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB5_8
.LBB5_11:                               # %.preheader
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_2(%rip), %r15
	.p2align	4, 0x90
.LBB5_12:                               # =>This Inner Loop Header: Depth=1
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
	movq	$54, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB5_12
.LBB5_17:
	movq	48(%rsp), %rax
	movq	%rax, 8(%r14)
	xorl	%eax, %eax
	addq	$128, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
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
# %bb.0:
	movq	display_array@GOTPCREL(%rip), %r8
	movq	16(%r8), %rcx
	leaq	-8(%rsp), %rdx
	movq	%rdx, 16(%r8)
	movq	(%rdi), %rdx
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	movq	%rdx, (%rsi)
	movq	%rcx, 16(%r8)
	xorl	%eax, %eax
	retq
.Lfunc_end6:
	.size	"fn2:swap", .Lfunc_end6-"fn2:swap"
                                        # -- End function
	.globl	"fn3:print_array"               # -- Begin function fn3:print_array
	.p2align	4, 0x90
	.type	"fn3:print_array",@function
"fn3:print_array":                      # @"fn3:print_array"
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$72, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rsi, %rbx
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %rax
	movq	%rax, 32(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r15)
	callq	lla_print_string@PLT
	leaq	8(%rbx), %rax
	movq	%rax, 40(%rsp)
	movq	8(%rbx), %rax
	decq	%rax
	movq	%rax, 48(%rsp)
	movq	%rbx, 56(%rsp)
	jns	.LBB7_1
.LBB7_9:
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	32(%rsp), %rcx
	movq	%rcx, 8(%r15)
	addq	$72, %rsp
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
.LBB7_1:                                # %.lr.ph
	.cfi_def_cfa_offset 112
	movq	$0, 16(%rsp)
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_6(%rip), %r12
	.p2align	4, 0x90
.LBB7_2:                                # =>This Inner Loop Header: Depth=1
	movq	16(%rsp), %rax
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	je	.LBB7_4
# %bb.3:                                #   in Loop: Header=BB7_2 Depth=1
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
.LBB7_4:                                #   in Loop: Header=BB7_2 Depth=1
	movq	40(%rsp), %rcx
	movq	24(%rsp), %rax
	cmpq	(%rcx), %rax
	jge	.LBB7_5
# %bb.7:                                #   in Loop: Header=BB7_2 Depth=1
	movq	56(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	(%rcx,%rax,8), %rdi
	callq	lla_print_int@PLT
	movq	24(%rsp), %rax
	incq	%rax
	movq	%rax, 64(%rsp)
	cmpq	48(%rsp), %rax
	jg	.LBB7_9
# %bb.8:                                # %._crit_edge18
                                        #   in Loop: Header=BB7_2 Depth=1
	movq	%rax, 16(%rsp)
	jmp	.LBB7_2
.LBB7_5:                                # %.preheader
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_2(%rip), %r15
	.p2align	4, 0x90
.LBB7_6:                                # =>This Inner Loop Header: Depth=1
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
	movq	$54, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB7_6
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

	.type	.L__unnamed_1,@object           # @0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__unnamed_1:
	.asciz	"Runtime Error: Division by zero\n"
	.size	.L__unnamed_1, 33

	.type	.L__unnamed_2,@object           # @1
.L__unnamed_2:
	.asciz	"Runtime Error: Out of bounds error in array ref call\n"
	.size	.L__unnamed_2, 54

	.type	.L__unnamed_6,@object           # @2
.L__unnamed_6:
	.asciz	", "
	.size	.L__unnamed_6, 3

	.type	.L__unnamed_5,@object           # @3
.L__unnamed_5:
	.asciz	"\n"
	.size	.L__unnamed_5, 2

	.type	.L__unnamed_3,@object           # @4
.L__unnamed_3:
	.asciz	"Initial array: "
	.size	.L__unnamed_3, 16

	.type	.L__unnamed_4,@object           # @5
.L__unnamed_4:
	.asciz	"Sorted array: "
	.size	.L__unnamed_4, 15

	.section	".note.GNU-stack","",@progbits
