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
	movq	(%rcx), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	leaq	16(%rsp), %rax
	movq	%rax, (%rcx)
	movq	%rcx, %rbx
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 16(%rsp)
	movq	(%rbx), %rax
	movq	(%rax), %rax
	movq	$65, (%rax)
	movl	$96, %edi
	callq	malloc@PLT
	movq	%rax, %rbx
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, (%r15)
	movq	$3, 8(%r15)
	movq	$4, 16(%r15)
	movl	$160, %edi
	callq	malloc@PLT
	movq	%rax, %rbx
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r12
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, (%r12)
	movq	$4, 8(%r12)
	movq	$5, 16(%r12)
	movl	$120, %edi
	callq	malloc@PLT
	movq	%rax, %r13
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r13, (%rbp)
	movq	$3, 8(%rbp)
	movq	$5, 16(%rbp)
	movq	%r15, %rdi
	callq	"fn2:minit"@PLT
	movq	%r12, %rdi
	callq	"fn2:minit"@PLT
	movq	%r15, %rdi
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
	leaq	.L__unnamed_2(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r12, %rdi
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
	leaq	.L__unnamed_3(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r15, %rdi
	movq	%r12, %rsi
	movq	%rbp, %rdx
	callq	"fn1:mmult"@PLT
	movq	%rbp, %rdi
	callq	"fn3:mprint"@PLT
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	%rax, (%rcx)
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
	.globl	"fn1:mmult"                     # -- Begin function fn1:mmult
	.p2align	4, 0x90
	.type	"fn1:mmult",@function
"fn1:mmult":                            # @"fn1:mmult"
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$448, %rsp                      # imm = 0x1C0
	.cfi_def_cfa_offset 480
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %r8
	movq	8(%r8), %rcx
	movq	%rcx, 152(%rsp)
	leaq	32(%rsp), %rcx
	movq	%rcx, 8(%r8)
	leaq	16(%rdi), %rcx
	movq	%rcx, 160(%rsp)
	movq	16(%rdi), %rbx
	leaq	8(%rsi), %rax
	movq	%rax, 168(%rsp)
	cmpq	8(%rsi), %rbx
	jne	.LBB5_45
# %bb.1:
	movq	8(%rdx), %rax
	cmpq	8(%rdi), %rax
	jne	.LBB5_45
# %bb.2:
	leaq	16(%rdx), %rbx
	movq	%rbx, 144(%rsp)
	movq	16(%rdx), %r9
	leaq	16(%rsi), %rax
	movq	%rax, 264(%rsp)
	cmpq	16(%rsi), %r9
	jne	.LBB5_45
# %bb.3:
	leaq	8(%rdx), %r10
	leaq	8(%rdi), %r9
	movq	%r10, 120(%rsp)
	movq	8(%rdx), %rax
	decq	%rax
	movq	%rax, 176(%rsp)
	movq	%rbx, 184(%rsp)
	movq	%r10, 192(%rsp)
	movq	%rbx, 200(%rsp)
	movq	%rdx, 208(%rsp)
	movq	%rcx, 216(%rsp)
	movq	%r10, 128(%rsp)
	movq	%rbx, 136(%rsp)
	movq	%rdx, 224(%rsp)
	movq	%rdx, 232(%rsp)
	movq	%r9, 240(%rsp)
	movq	%rdi, 248(%rsp)
	movq	%rsi, 256(%rsp)
	jns	.LBB5_4
.LBB5_45:                               # %.critedge
	movq	152(%rsp), %rax
	movq	%rax, 8(%r8)
	xorl	%eax, %eax
	addq	$448, %rsp                      # imm = 0x1C0
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB5_4:                                # %.lr.ph217
	.cfi_def_cfa_offset 480
	movq	$0, 56(%rsp)
.LBB5_5:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_7 Depth 2
                                        #       Child Loop BB5_21 Depth 3
	movq	56(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	184(%rsp), %rcx
	movq	(%rcx), %rcx
	testq	%rax, %rax
	setns	15(%rsp)
	decq	%rcx
	movq	%rcx, 272(%rsp)
	jns	.LBB5_6
.LBB5_43:                               # %._crit_edge214
                                        #   in Loop: Header=BB5_5 Depth=1
	movq	16(%rsp), %rax
	movq	%rax, 112(%rsp)
	movq	112(%rsp), %rcx
	incq	%rcx
	movq	%rcx, 440(%rsp)
	cmpq	176(%rsp), %rcx
	jg	.LBB5_45
# %bb.44:                               # %._crit_edge226
                                        #   in Loop: Header=BB5_5 Depth=1
	movq	%rcx, 56(%rsp)
	jmp	.LBB5_5
.LBB5_6:                                # %.lr.ph213
                                        #   in Loop: Header=BB5_5 Depth=1
	movq	16(%rsp), %rax
	movq	%rax, 72(%rsp)
	movq	$0, 64(%rsp)
.LBB5_7:                                #   Parent Loop BB5_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB5_21 Depth 3
	movq	64(%rsp), %rcx
	movq	72(%rsp), %rdx
	movq	%rcx, 24(%rsp)
	movq	%rdx, 40(%rsp)
	movq	192(%rsp), %rax
	movq	(%rax), %rdi
	movq	200(%rsp), %rax
	movq	(%rax), %rsi
	movq	%rsi, 368(%rsp)
	testq	%rdx, %rdx
	js	.LBB5_10
# %bb.8:                                #   in Loop: Header=BB5_7 Depth=2
	cmpq	%rdi, %rdx
	jge	.LBB5_10
# %bb.9:                                #   in Loop: Header=BB5_7 Depth=2
	cmpq	%rsi, %rcx
	jge	.LBB5_10
# %bb.12:                               #   in Loop: Header=BB5_7 Depth=2
	imulq	%rdx, %rsi
	addq	%rcx, %rsi
	movq	208(%rsp), %rax
	movq	(%rax), %rax
	movq	$0, (%rax,%rsi,8)
	movq	216(%rsp), %rax
	movq	(%rax), %rax
	decq	%rax
	movq	%rax, 280(%rsp)
	jns	.LBB5_14
# %bb.13:                               # %._crit_edge222
                                        #   in Loop: Header=BB5_7 Depth=2
	movq	40(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	%rax, 104(%rsp)
	movq	%rcx, 96(%rsp)
.LBB5_41:                               #   in Loop: Header=BB5_7 Depth=2
	movq	96(%rsp), %rcx
	movq	104(%rsp), %rax
	movq	%rax, 336(%rsp)
	incq	%rcx
	movq	%rcx, 432(%rsp)
	cmpq	272(%rsp), %rcx
	jg	.LBB5_43
# %bb.42:                               # %._crit_edge225
                                        #   in Loop: Header=BB5_7 Depth=2
	movq	336(%rsp), %rax
	movq	%rax, 72(%rsp)
	movq	%rcx, 64(%rsp)
	jmp	.LBB5_7
.LBB5_14:                               # %.lr.ph
                                        #   in Loop: Header=BB5_7 Depth=2
	cmpb	$0, 15(%rsp)
	je	.LBB5_15
# %bb.20:                               # %.lr.ph.split.us
                                        #   in Loop: Header=BB5_7 Depth=2
	movq	40(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	$0, 80(%rsp)
	.p2align	4, 0x90
.LBB5_21:                               #   Parent Loop BB5_5 Depth=1
                                        #     Parent Loop BB5_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	80(%rsp), %rax
	movq	88(%rsp), %rdx
	movq	%rax, 48(%rsp)
	movq	%rdx, 288(%rsp)
	movq	128(%rsp), %rax
	movq	(%rax), %rsi
	movq	136(%rsp), %rax
	movq	(%rax), %rcx
	movq	%rcx, 376(%rsp)
	testq	%rdx, %rdx
	js	.LBB5_18
# %bb.22:                               #   in Loop: Header=BB5_21 Depth=3
	cmpq	%rsi, %rdx
	jge	.LBB5_18
# %bb.23:                               #   in Loop: Header=BB5_21 Depth=3
	movq	24(%rsp), %rsi
	cmpq	%rcx, %rsi
	jge	.LBB5_18
# %bb.24:                               #   in Loop: Header=BB5_21 Depth=3
	imulq	%rdx, %rcx
	addq	%rsi, %rcx
	movq	224(%rsp), %rax
	shlq	$3, %rcx
	addq	(%rax), %rcx
	movq	%rcx, 296(%rsp)
	movq	120(%rsp), %rax
	movq	144(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	288(%rsp), %rdx
	cmpq	(%rax), %rdx
	movq	%rcx, 384(%rsp)
	jge	.LBB5_34
# %bb.25:                               #   in Loop: Header=BB5_21 Depth=3
	movq	24(%rsp), %rsi
	cmpq	%rcx, %rsi
	jge	.LBB5_34
# %bb.26:                               #   in Loop: Header=BB5_21 Depth=3
	imulq	%rdx, %rcx
	addq	%rsi, %rcx
	movq	232(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rax
	movq	%rax, 304(%rsp)
	movq	240(%rsp), %rax
	movq	160(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	16(%rsp), %rdx
	cmpq	(%rax), %rdx
	movq	%rcx, 312(%rsp)
	jge	.LBB5_36
# %bb.27:                               #   in Loop: Header=BB5_21 Depth=3
	cmpq	%rcx, 48(%rsp)
	jge	.LBB5_36
# %bb.28:                               #   in Loop: Header=BB5_21 Depth=3
	movq	168(%rsp), %rax
	movq	264(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	48(%rsp), %rdx
	cmpq	(%rax), %rdx
	movq	%rcx, 392(%rsp)
	jge	.LBB5_38
# %bb.29:                               #   in Loop: Header=BB5_21 Depth=3
	movq	24(%rsp), %rsi
	cmpq	%rcx, %rsi
	jge	.LBB5_38
# %bb.30:                               #   in Loop: Header=BB5_21 Depth=3
	movq	248(%rsp), %rax
	movq	(%rax), %rax
	movq	312(%rsp), %rdi
	imulq	16(%rsp), %rdi
	addq	%rdx, %rdi
	imulq	%rdx, %rcx
	addq	%rsi, %rcx
	movq	256(%rsp), %rdx
	movq	(%rdx), %rdx
	movq	(%rdx,%rcx,8), %rcx
	imulq	(%rax,%rdi,8), %rcx
	addq	304(%rsp), %rcx
	movq	296(%rsp), %rax
	movq	%rcx, (%rax)
	movq	48(%rsp), %rax
	incq	%rax
	movq	%rax, 320(%rsp)
	cmpq	280(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rcx, 344(%rsp)
	jg	.LBB5_40
# %bb.31:                               # %._crit_edge223
                                        #   in Loop: Header=BB5_21 Depth=3
	movq	320(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rcx, 88(%rsp)
	movq	%rax, 80(%rsp)
	jmp	.LBB5_21
.LBB5_40:                               # %._crit_edge.us-lcssa.us
                                        #   in Loop: Header=BB5_7 Depth=2
	movq	%rcx, 400(%rsp)
	movq	%rcx, 360(%rsp)
	movq	%rcx, 424(%rsp)
	movq	24(%rsp), %rax
	movq	%rcx, 104(%rsp)
	movq	%rax, 96(%rsp)
	jmp	.LBB5_41
.LBB5_38:                               # %.preheader
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_4(%rip), %r15
	.p2align	4, 0x90
.LBB5_39:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB5_39
.LBB5_10:                               # %.preheader170
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_4(%rip), %r15
	.p2align	4, 0x90
.LBB5_11:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB5_11
.LBB5_15:                               # %.lr.ph..lr.ph.split_crit_edge
	movq	40(%rsp), %rax
	movq	%rax, 352(%rsp)
	movq	%rax, 328(%rsp)
	movq	128(%rsp), %rcx
	movq	(%rcx), %rdx
	movq	136(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	%rcx, 408(%rsp)
	testq	%rax, %rax
	js	.LBB5_18
# %bb.16:                               # %.lr.ph..lr.ph.split_crit_edge
	cmpq	%rdx, %rax
	jge	.LBB5_18
# %bb.17:                               # %.lr.ph..lr.ph.split_crit_edge
	cmpq	%rcx, 24(%rsp)
	jge	.LBB5_18
# %bb.32:
	movq	120(%rsp), %rcx
	movq	144(%rsp), %rax
	movq	(%rax), %rax
	movq	328(%rsp), %rdx
	cmpq	(%rcx), %rdx
	movq	%rax, 416(%rsp)
	jge	.LBB5_34
# %bb.33:
	cmpq	%rax, 24(%rsp)
	jge	.LBB5_34
.LBB5_36:                               # %.preheader167
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_4(%rip), %r15
	.p2align	4, 0x90
.LBB5_37:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB5_37
.LBB5_18:                               # %.preheader169
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_4(%rip), %r15
	.p2align	4, 0x90
.LBB5_19:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB5_19
.LBB5_34:                               # %.preheader168
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_4(%rip), %r15
	.p2align	4, 0x90
.LBB5_35:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB5_35
.Lfunc_end5:
	.size	"fn1:mmult", .Lfunc_end5-"fn1:mmult"
	.cfi_endproc
                                        # -- End function
	.globl	"fn2:minit"                     # -- Begin function fn2:minit
	.p2align	4, 0x90
	.type	"fn2:minit",@function
"fn2:minit":                            # @"fn2:minit"
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$144, %rsp
	.cfi_def_cfa_offset 176
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %rsi
	movq	8(%rsi), %rax
	movq	%rax, 64(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%rsi)
	leaq	8(%rdi), %rax
	movq	%rax, 72(%rsp)
	movq	8(%rdi), %rax
	leaq	16(%rdi), %rcx
	decq	%rax
	movq	%rax, 80(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%rcx, 96(%rsp)
	movq	%rdi, 104(%rsp)
	jns	.LBB6_1
.LBB6_14:
	movq	64(%rsp), %rax
	movq	%rax, 8(%rsi)
	xorl	%eax, %eax
	addq	$144, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB6_1:                                # %.lr.ph41
	.cfi_def_cfa_offset 176
	movq	$0, 24(%rsp)
	movabsq	$-6757718126012409997, %rdi     # imm = 0xA237C32B16CFD773
.LBB6_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_5 Depth 2
	movq	24(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	88(%rsp), %rcx
	movq	(%rcx), %rcx
	leaq	(%rax,%rax), %rdx
	testq	%rax, %rax
	setns	15(%rsp)
	decq	%rcx
	movq	%rcx, 112(%rsp)
	movq	%rdx, 48(%rsp)
	jns	.LBB6_3
.LBB6_12:                               # %._crit_edge
                                        #   in Loop: Header=BB6_2 Depth=1
	movq	16(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	40(%rsp), %rax
	incq	%rax
	movq	%rax, 136(%rsp)
	cmpq	80(%rsp), %rax
	jg	.LBB6_14
# %bb.13:                               # %._crit_edge47
                                        #   in Loop: Header=BB6_2 Depth=1
	movq	%rax, 24(%rsp)
	jmp	.LBB6_2
	.p2align	4, 0x90
.LBB6_3:                                # %.lr.ph
                                        #   in Loop: Header=BB6_2 Depth=1
	testq	%rax, %rax
	js	.LBB6_9
# %bb.4:                                # %.lr.ph.split.us
                                        #   in Loop: Header=BB6_2 Depth=1
	movq	$0, 32(%rsp)
	.p2align	4, 0x90
.LBB6_5:                                #   Parent Loop BB6_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	32(%rsp), %rcx
	movq	%rcx, 56(%rsp)
	movq	(%rsi), %rax
	movq	(%rax), %rbx
	imulq	$137, (%rbx), %rax
	addq	48(%rsp), %rcx
	addq	%rax, %rcx
	movq	%rcx, %rax
	imulq	%rdi
	addq	%rcx, %rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$6, %rdx
	addq	%rax, %rdx
	imulq	$101, %rdx, %rax
	subq	%rax, %rcx
	movq	%rcx, (%rbx)
	movq	72(%rsp), %rdx
	movq	96(%rsp), %rax
	movq	(%rax), %rax
	movq	16(%rsp), %rcx
	cmpq	(%rdx), %rcx
	movq	%rax, 120(%rsp)
	jge	.LBB6_10
# %bb.6:                                #   in Loop: Header=BB6_5 Depth=2
	movq	56(%rsp), %rdx
	cmpq	%rax, %rdx
	jge	.LBB6_10
# %bb.7:                                #   in Loop: Header=BB6_5 Depth=2
	imulq	%rcx, %rax
	addq	%rdx, %rax
	movq	104(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	(%rsi), %rdx
	movq	(%rdx), %rdx
	movq	(%rdx), %rdx
	movq	%rdx, (%rcx,%rax,8)
	movq	56(%rsp), %rax
	incq	%rax
	movq	%rax, 128(%rsp)
	cmpq	112(%rsp), %rax
	jg	.LBB6_12
# %bb.8:                                # %._crit_edge45
                                        #   in Loop: Header=BB6_5 Depth=2
	movq	%rax, 32(%rsp)
	jmp	.LBB6_5
.LBB6_9:
	movq	(%rsi), %rax
	movq	(%rax), %rsi
	imulq	$137, (%rsi), %rcx
	addq	48(%rsp), %rcx
	movq	%rcx, %rax
	imulq	%rdi
	addq	%rcx, %rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$6, %rdx
	addq	%rax, %rdx
	imulq	$101, %rdx, %rax
	subq	%rax, %rcx
	movq	%rcx, (%rsi)
.LBB6_10:                               # %.preheader
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_4(%rip), %r15
	.p2align	4, 0x90
.LBB6_11:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB6_11
.Lfunc_end6:
	.size	"fn2:minit", .Lfunc_end6-"fn2:minit"
	.cfi_endproc
                                        # -- End function
	.globl	"fn3:mprint"                    # -- Begin function fn3:mprint
	.p2align	4, 0x90
	.type	"fn3:mprint",@function
"fn3:mprint":                           # @"fn3:mprint"
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
	subq	$136, %rsp
	.cfi_def_cfa_offset 192
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %rax
	movq	%rax, 48(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r15)
	leaq	8(%rdi), %rax
	movq	%rax, 56(%rsp)
	movq	8(%rdi), %rax
	leaq	16(%rdi), %rcx
	decq	%rax
	movq	%rax, 64(%rsp)
	movq	%rcx, 72(%rsp)
	movq	%rcx, 80(%rsp)
	movq	%rdi, 88(%rsp)
	jns	.LBB7_1
.LBB7_13:
	movq	48(%rsp), %rax
	movq	%rax, 8(%r15)
	xorl	%eax, %eax
	addq	$136, %rsp
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
.LBB7_1:                                # %.lr.ph33
	.cfi_def_cfa_offset 192
	movq	$0, 24(%rsp)
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_5(%rip), %r12
	leaq	.L__unnamed_6(%rip), %r13
.LBB7_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_5 Depth 2
	movq	24(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	72(%rsp), %rcx
	movq	(%rcx), %rcx
	testq	%rax, %rax
	setns	15(%rsp)
	decq	%rcx
	movq	%rcx, 96(%rsp)
	jns	.LBB7_3
.LBB7_11:                               # %._crit_edge
                                        #   in Loop: Header=BB7_2 Depth=1
	movq	16(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	40(%rsp), %rbp
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
	incq	%rbp
	movq	%rbp, 128(%rsp)
	cmpq	64(%rsp), %rbp
	jg	.LBB7_13
# %bb.12:                               # %._crit_edge39
                                        #   in Loop: Header=BB7_2 Depth=1
	movq	%rbp, 24(%rsp)
	jmp	.LBB7_2
	.p2align	4, 0x90
.LBB7_3:                                # %.lr.ph
                                        #   in Loop: Header=BB7_2 Depth=1
	testq	%rax, %rax
	js	.LBB7_9
# %bb.4:                                # %.lr.ph.split.us
                                        #   in Loop: Header=BB7_2 Depth=1
	movq	$0, 32(%rsp)
	.p2align	4, 0x90
.LBB7_5:                                #   Parent Loop BB7_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	32(%rsp), %rax
	movq	%rax, 104(%rsp)
	movq	56(%rsp), %rsi
	movq	80(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	16(%rsp), %rdx
	cmpq	(%rsi), %rdx
	movq	%rcx, 112(%rsp)
	jge	.LBB7_9
# %bb.6:                                #   in Loop: Header=BB7_5 Depth=2
	cmpq	%rcx, %rax
	jge	.LBB7_9
# %bb.7:                                #   in Loop: Header=BB7_5 Depth=2
	imulq	%rdx, %rcx
	addq	%rax, %rcx
	movq	88(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax,%rcx,8), %rdi
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
	movq	%r13, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	104(%rsp), %rax
	incq	%rax
	movq	%rax, 120(%rsp)
	cmpq	96(%rsp), %rax
	jg	.LBB7_11
# %bb.8:                                # %._crit_edge37
                                        #   in Loop: Header=BB7_5 Depth=2
	movq	%rax, 32(%rsp)
	jmp	.LBB7_5
.LBB7_9:                                # %.preheader
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_4(%rip), %rbp
	.p2align	4, 0x90
.LBB7_10:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbp, (%rbx)
	movq	$54, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB7_10
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

	.type	.L__unnamed_1,@object           # @0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__unnamed_1:
	.asciz	"Runtime Error: Division by zero\n"
	.size	.L__unnamed_1, 33

	.type	.L__unnamed_4,@object           # @1
.L__unnamed_4:
	.asciz	"Runtime Error: Out of bounds error in array ref call\n"
	.size	.L__unnamed_4, 54

	.type	.L__unnamed_6,@object           # @2
.L__unnamed_6:
	.asciz	" "
	.size	.L__unnamed_6, 2

	.type	.L__unnamed_5,@object           # @3
.L__unnamed_5:
	.asciz	"\n"
	.size	.L__unnamed_5, 2

	.type	.L__unnamed_2,@object           # @4
.L__unnamed_2:
	.asciz	"\ntimes\n\n"
	.size	.L__unnamed_2, 9

	.type	.L__unnamed_3,@object           # @5
.L__unnamed_3:
	.asciz	"\nmakes\n\n"
	.size	.L__unnamed_3, 9

	.section	".note.GNU-stack","",@progbits
