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
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2                               # -- Begin function main
.LCPI4_0:
	.long	0x40a00000                      # float 5
.LCPI4_1:
	.long	0x40000000                      # float 2
	.text
	.globl	main
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
	subq	$408, %rsp                      # imm = 0x198
	.cfi_def_cfa_offset 464
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	callq	GC_init@PLT
	movq	display_array@GOTPCREL(%rip), %r12
	movq	(%r12), %rax
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	leaq	360(%rsp), %rax
	movq	%rax, (%r12)
	movb	$0, 360(%rsp)
	movq	$1, 128(%rsp)
	movq	(%r12), %rax
	movb	$97, 1(%rax)
	movq	(%r12), %rax
	movb	$1, 2(%rax)
	movl	$1078523331, 116(%rsp)          # imm = 0x4048F5C3
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	xorl	%r13d, %r13d
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.1(%rip), %rbp
	movq	%rbp, (%rbx)
	movq	$4, 8(%rbx)
	movq	%rbx, 296(%rsp)
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
	movq	$4, 8(%rbx)
	movq	%rbx, 288(%rsp)
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
	movq	%rbx, 280(%rsp)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 32(%rsp)
	movl	$240, %edi
	callq	malloc@PLT
	movq	%rax, %r15
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, 56(%rsp)
	movq	%r15, (%rbx)
	movq	$5, 8(%rbx)
	movq	$3, 16(%rbx)
	movq	$2, 24(%rbx)
	movq	128(%rsp), %rax
	movq	%rax, 352(%rsp)
	movq	56(%rsp), %rax
	movq	24(%rax), %rax
	movq	%rax, 344(%rsp)
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
	movq	128(%rsp), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$10, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r12), %rax
	movzbl	1(%rax), %edi
	callq	lla_print_char@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$10, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r12), %rax
	movzbl	2(%rax), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$11, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	116(%rsp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.9(%rip), %rax
	movq	%rax, (%rbx)
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	296(%rsp), %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.10(%rip), %rax
	movq	%rax, (%rbx)
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	288(%rsp), %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.11(%rip), %rax
	movq	%rax, (%rbx)
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	280(%rsp), %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movq	32(%rsp), %rax
	movq	$0, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.12(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	32(%rsp), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movq	32(%rsp), %rdi
	callq	lla_incr@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.13(%rip), %rax
	movq	%rax, (%rbx)
	movq	$18, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	32(%rsp), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movq	32(%rsp), %rdi
	callq	lla_decr@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.14(%rip), %rax
	movq	%rax, (%rbx)
	movq	$18, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	32(%rsp), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	testb	%r13b, %r13b
	jne	.LBB4_4
# %bb.1:                                # %entry
	movq	56(%rsp), %rax
	cmpq	$5, 8(%rax)
	jl	.LBB4_4
# %bb.2:                                # %entry
	movq	16(%rax), %rcx
	cmpq	$3, %rcx
	jl	.LBB4_4
# %bb.3:                                # %entry
	movq	24(%rax), %rdx
	cmpq	$1, %rdx
	jle	.LBB4_4
# %bb.6:                                # %array_ref_bound_check_success
	addq	%rdx, %rdx
	leaq	(%rdx,%rcx,4), %rcx
	movq	(%rax), %rax
	movq	$421, 8(%rax,%rcx,8)            # imm = 0x1A5
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	xorl	%ebp, %ebp
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.16(%rip), %rax
	movq	%rax, (%rbx)
	movq	$25, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	testb	%bpl, %bpl
	jne	.LBB4_10
# %bb.7:                                # %array_ref_bound_check_success
	movq	56(%rsp), %rax
	cmpq	$5, 8(%rax)
	jl	.LBB4_10
# %bb.8:                                # %array_ref_bound_check_success
	movq	16(%rax), %rcx
	cmpq	$3, %rcx
	jl	.LBB4_10
# %bb.9:                                # %array_ref_bound_check_success
	movq	24(%rax), %rdx
	cmpq	$1, %rdx
	jle	.LBB4_10
# %bb.12:                               # %array_ref_bound_check_success132
	addq	%rdx, %rdx
	leaq	(%rdx,%rcx,4), %rcx
	movq	(%rax), %rax
	movq	8(%rax,%rcx,8), %rdi
	callq	lla_print_int@PLT
	xorl	%r13d, %r13d
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	andb	$1, %al
	movb	%al, 55(%rsp)
	movl	$3, %edi
	callq	"fn5:f1"@PLT
	andb	$1, %al
	movb	%al, 54(%rsp)
	movq	(%r12), %rax
	movq	$2, 8(%rax)
	movq	(%r12), %rax
	movq	$1, 16(%rax)
	movq	(%r12), %rbx
	movl	$1, %edi
	callq	GC_malloc@PLT
	movq	%rax, 24(%rbx)
	movq	(%r12), %rbp
	movl	$8, %edi
	callq	malloc@PLT
	movq	%rax, %r15
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
	movq	%rbx, 32(%rbp)
	movq	%r15, (%rbx)
	movq	$1, 8(%rbx)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.17(%rip), %rax
	movq	%rax, (%rbx)
	movq	$13, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	"fn10:tf1"@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.18(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	"fn12:tf3"@PLT
	testb	%r13b, %r13b
	jne	.LBB4_14
# %bb.13:                               # %array_ref_bound_check_success132
	movq	(%r12), %rax
	movq	32(%rax), %rax
	cmpq	$0, 8(%rax)
	jle	.LBB4_14
# %bb.16:                               # %array_ref_bound_check_success189
	movq	(%rax), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	xorl	%ebp, %ebp
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	leaq	.Lstr.19(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$4, %edi
	callq	"fn13:loop"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	andb	$1, %al
	movb	%al, 53(%rsp)
	movq	32(%rsp), %rax
	movq	$42, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.24(%rip), %rax
	movq	%rax, (%rbx)
	movq	$15, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	32(%rsp), %rdi
	callq	"fn14:f6"@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	testb	%bpl, %bpl
	jne	.LBB4_20
# %bb.17:                               # %array_ref_bound_check_success189
	movq	56(%rsp), %rax
	cmpq	$0, 8(%rax)
	jle	.LBB4_20
# %bb.18:                               # %array_ref_bound_check_success189
	cmpq	$0, 16(%rax)
	jle	.LBB4_20
# %bb.19:                               # %array_ref_bound_check_success189
	cmpq	$0, 24(%rax)
	jle	.LBB4_20
# %bb.22:                               # %array_ref_bound_check_success222
	movq	(%rax), %rax
	movq	$42, (%rax)
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
	leaq	.Lstr.25(%rip), %rax
	movq	%rax, (%rbx)
	movq	$24, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	56(%rsp), %rdi
	callq	"fn15:f7"@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.26(%rip), %rax
	movq	%rax, (%rbx)
	movq	$17, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	"fn17:f8_f"@GOTPCREL(%rip), %rdi
	callq	"fn16:f8"@PLT
	callq	lla_print_float@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	andb	$1, %al
	movb	%al, 52(%rsp)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 336(%rsp)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	$2, (%rax)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	$2, 8(%rbx)
	movq	%rax, 16(%rbx)
	movq	$1, 8(%r15)
	movq	%rbx, 16(%r15)
	movq	%r15, 328(%rsp)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 272(%rsp)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 264(%rsp)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	$2, (%rax)
	movq	264(%rsp), %rcx
	movq	$1, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	%rax, 256(%rsp)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	$2, (%rax)
	movq	256(%rsp), %r13
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movq	272(%rsp), %rbp
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rbp, 8(%rbx)
	movq	%rax, 16(%rbx)
	movq	%r13, 8(%r15)
	movq	%rbx, 16(%r15)
	movq	%r15, 320(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.48(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, %rdi
	callq	"fn18:p_color"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.49(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movq	%rax, %rdi
	callq	"fn18:p_color"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	xorl	%edi, %edi
	callq	"fn21:pc_new"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.50(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	$1, 8(%rax)
	movq	%rax, %rdi
	callq	"fn19:p_opt"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.51(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$2, (%rax)
	movl	$1074161254, 8(%rax)            # imm = 0x40066666
	movq	%rax, %rdi
	callq	"fn19:p_opt"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.52(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
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
	leaq	.Lstr.53(%rip), %rax
	movq	%rax, (%rbx)
	movq	$13, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	$2, 8(%rax)
	movq	%rax, %rdi
	callq	"fn20:pmtype"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.54(%rip), %rax
	movq	%rax, (%rbx)
	movq	$15, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$2, (%rax)
	movl	$1067320345, 8(%rax)            # imm = 0x3F9E0419
	movq	%rax, %rdi
	callq	"fn20:pmtype"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.55(%rip), %rax
	movq	%rax, (%rbx)
	movq	$16, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movq	$1066275963, 8(%rax)            # imm = 0x3F8E147B
	movq	%rax, %rdi
	callq	"fn20:pmtype"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.56(%rip), %rax
	movq	%rax, (%rbx)
	movq	$17, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movabsq	$4615649186614870016, %rcx      # imm = 0x400E147B00000000
	movq	%rcx, 8(%rax)
	movq	%rax, %rdi
	callq	"fn20:pmtype"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.57(%rip), %rax
	movq	%rax, (%rbx)
	movq	$22, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movabsq	$-4571694052141621576, %rcx     # imm = 0xC08E147B40551EB8
	movq	%rcx, 8(%rax)
	movq	%rax, %rdi
	callq	"fn20:pmtype"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	$1, 8(%rax)
	movq	%rax, (%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$2, (%rax)
	movl	$1066192077, 8(%rax)            # imm = 0x3F8CCCCD
	movq	%rax, 80(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	$1, 8(%rax)
	movq	%rax, 72(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movabsq	$4579260103035505869, %rbx      # imm = 0x3F8CCCCD3F8CCCCD
	movq	%rbx, 8(%rax)
	movq	%rax, 24(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movabsq	$4582862983596395725, %rcx      # imm = 0x3F99999A3F8CCCCD
	movq	%rcx, 8(%rax)
	movq	%rax, 64(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movq	%rbx, 8(%rax)
	movq	%rax, 120(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.58(%rip), %rax
	movq	%rax, (%rbx)
	movq	$15, 8(%rbx)
	movq	%rbx, %rdi
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
	leaq	.Lstr.59(%rip), %rbp
	movq	%rbp, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.60(%rip), %r13
	movq	%r13, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rax
	subq	80(%rsp), %rax
	xorl	%edi, %edi
	sarq	$4, %rax
	sete	%dil
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rax
	subq	72(%rsp), %rax
	xorl	%edi, %edi
	sarq	$4, %rax
	sete	%dil
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rax
	subq	24(%rsp), %rax
	xorl	%edi, %edi
	sarq	$4, %rax
	sete	%dil
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rax
	subq	64(%rsp), %rax
	xorl	%edi, %edi
	sarq	$4, %rax
	sete	%dil
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.61(%rip), %rax
	movq	%rax, (%rbx)
	movq	$17, 8(%rbx)
	movq	%rbx, %rdi
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
	movq	%r13, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rax
	subq	80(%rsp), %rax
	xorl	%edi, %edi
	sarq	$4, %rax
	setne	%dil
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rax
	subq	72(%rsp), %rax
	xorl	%edi, %edi
	sarq	$4, %rax
	setne	%dil
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rax
	subq	24(%rsp), %rax
	xorl	%edi, %edi
	sarq	$4, %rax
	setne	%dil
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rax
	subq	64(%rsp), %rax
	xorl	%edi, %edi
	sarq	$4, %rax
	setne	%dil
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.62(%rip), %rax
	movq	%rax, (%rbx)
	movq	$18, 8(%rbx)
	movq	%rbx, %rdi
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
	movq	%rbp, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rdi
	movq	%rdi, %rsi
	callq	"_number:1_equality"@PLT
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rdi
	movq	80(%rsp), %rsi
	callq	"_number:1_equality"@PLT
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rdi
	movq	72(%rsp), %rsi
	callq	"_number:1_equality"@PLT
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rdi
	movq	24(%rsp), %rsi
	callq	"_number:1_equality"@PLT
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	24(%rsp), %rdi
	movq	64(%rsp), %rsi
	callq	"_number:1_equality"@PLT
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	24(%rsp), %rdi
	movq	120(%rsp), %rsi
	callq	"_number:1_equality"@PLT
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.63(%rip), %rax
	movq	%rax, (%rbx)
	movq	$20, 8(%rbx)
	movq	%rbx, %rdi
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
	movq	%r13, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rdi
	movq	%rdi, %rsi
	callq	"_number:1_equality"@PLT
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rdi
	movq	80(%rsp), %rsi
	callq	"_number:1_equality"@PLT
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rdi
	movq	72(%rsp), %rsi
	callq	"_number:1_equality"@PLT
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%rsp), %rdi
	movq	24(%rsp), %rsi
	callq	"_number:1_equality"@PLT
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	24(%rsp), %rdi
	movq	64(%rsp), %rsi
	callq	"_number:1_equality"@PLT
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	24(%rsp), %rdi
	movq	120(%rsp), %rsi
	callq	"_number:1_equality"@PLT
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	andb	$1, %al
	movb	%al, 51(%rsp)
	movl	$1, %edi
	callq	malloc@PLT
	movq	%rax, %r15
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, 240(%rsp)
	movq	%r15, (%rbx)
	movq	$1, 8(%rbx)
	movq	$1, 16(%rbx)
	movq	$1, 24(%rbx)
	movq	240(%rsp), %rdi
	callq	"fn23:f"@PLT
	movq	%rax, 248(%rsp)
	movl	$8, %edi
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
	movq	%rbx, 232(%rsp)
	movq	%r15, (%rbx)
	movq	$1, 8(%rbx)
	movq	$1, 16(%rbx)
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB4_25
# %bb.23:                               # %array_ref_bound_check_success222
	movq	232(%rsp), %rax
	cmpq	$0, 8(%rax)
	jle	.LBB4_25
# %bb.24:                               # %array_ref_bound_check_success222
	cmpq	$0, 16(%rax)
	jle	.LBB4_25
# %bb.27:                               # %array_ref_bound_check_success716
	movq	(%rax), %rax
	movq	"fn24:f"@GOTPCREL(%rip), %rcx
	movq	%rcx, (%rax)
	movb	$0, 50(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	xorl	%ebp, %ebp
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.65(%rip), %rax
	movq	%rax, (%rbx)
	movq	$15, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	"fn22:f9"@PLT
	movq	%rax, 312(%rsp)
	testb	%bpl, %bpl
	jne	.LBB4_30
# %bb.28:                               # %array_ref_bound_check_success716
	cmpq	$0, 8(%rax)
	jle	.LBB4_30
# %bb.29:                               # %array_ref_bound_check_success716
	cmpq	$0, 16(%rax)
	jle	.LBB4_30
# %bb.32:                               # %array_ref_bound_check_success738
	movq	(%rax), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	leaq	.Lstr.66(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	248(%rsp), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$1, %edi
	callq	malloc@PLT
	movq	%rax, %r15
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, 224(%rsp)
	movq	%r15, (%rbx)
	movq	$1, 8(%rbx)
	movq	$1, 16(%rbx)
	movq	$1, 24(%rbx)
	movq	224(%rsp), %rdi
	callq	"fn25:f10"@PLT
	andb	$1, %al
	movb	%al, 49(%rsp)
	movl	$10, %edi
	callq	"fn27:while_test"@PLT
	movl	$5, %edi
	callq	"fn28:for_test"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.69(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	"fn29:if_while_for"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	andb	$1, %al
	movb	%al, 48(%rsp)
	movq	$1, 216(%rsp)
	movq	$-1, 208(%rsp)
	movl	$1065353216, 112(%rsp)          # imm = 0x3F800000
	movl	$-1082130432, 108(%rsp)         # imm = 0xBF800000
	movl	$1, %edi
	callq	GC_malloc@PLT
	movq	%rax, 200(%rsp)
	movb	$1, (%rax)
	movq	200(%rsp), %rax
	movb	(%rax), %al
	movb	%al, 23(%rsp)
	movb	$0, 22(%rsp)
	movq	$3, 192(%rsp)
	movq	$-1, 184(%rsp)
	movq	$2, 176(%rsp)
	movl	$5, %edi
	movl	$2, %esi
	callq	_binary_int_division@PLT
	movq	%rax, 168(%rsp)
	movl	$1077936128, 104(%rsp)          # imm = 0x40400000
	movl	$-1082130432, 100(%rsp)         # imm = 0xBF800000
	movl	$1073741824, 96(%rsp)           # imm = 0x40000000
	movss	.LCPI4_0(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI4_1(%rip), %xmm1           # xmm1 = mem[0],zero,zero,zero
	callq	_binary_float_division@PLT
	movss	%xmm0, 92(%rsp)
	movq	$1, 160(%rsp)
	movss	.LCPI4_0(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI4_1(%rip), %xmm1           # xmm1 = mem[0],zero,zero,zero
	callq	lla_pow@PLT
	movss	%xmm0, 88(%rsp)
	movb	$0, 21(%rsp)
	movb	$1, 20(%rsp)
	movb	$0, 19(%rsp)
	movb	$1, 18(%rsp)
	movb	$0, 17(%rsp)
	movb	$1, 16(%rsp)
	movb	$0, 15(%rsp)
	movb	$1, 14(%rsp)
	movb	$0, 13(%rsp)
	movb	$1, 12(%rsp)
	movb	$0, 47(%rsp)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 152(%rsp)
	movq	$1, (%rax)
	movq	152(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 144(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.70(%rip), %rax
	movq	%rax, (%rbx)
	movq	$18, 8(%rbx)
	movq	%rbx, %rdi
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
	leaq	.Lstr.71(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	216(%rsp), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.72(%rip), %r15
	movq	%r15, (%rbx)
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	208(%rsp), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.73(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	112(%rsp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.74(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	108(%rsp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.59(%rip), %rbp
	movq	%rbp, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	23(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	22(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.75(%rip), %rax
	movq	%rax, (%rbx)
	movq	$19, 8(%rbx)
	movq	%rbx, %rdi
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
	leaq	.Lstr.76(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	192(%rsp), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	184(%rsp), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.77(%rip), %rax
	movq	%rax, (%rbx)
	movq	%rax, %rbp
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	176(%rsp), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	168(%rsp), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.78(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	104(%rsp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.74(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	100(%rsp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.79(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	96(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.80(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	92(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.71(%rip), %rbp
	movq	%rbp, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	160(%rsp), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.81(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	88(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	21(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.59(%rip), %r15
	movq	%r15, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	20(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	19(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	18(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	17(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	16(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	15(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	14(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	13(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	12(%rsp), %edi
	callq	lla_print_bool@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
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
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	144(%rsp), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	andb	$1, %al
	movb	%al, 46(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.82(%rip), %rax
	movq	%rax, (%rbx)
	movq	$38, 8(%rbx)
	movq	%rbx, %rdi
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
	leaq	.Lstr.83(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	"fn30:f_nest0"@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	andb	$1, %al
	movb	%al, 45(%rsp)
	movq	(%r12), %rax
	movq	$2, 40(%rax)
	movq	$3, 304(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.84(%rip), %rax
	movq	%rax, (%rbx)
	movq	$28, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	"fn35:f"@PLT
	andb	$1, %al
	movb	%al, 44(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.92(%rip), %rax
	movq	%rax, (%rbx)
	movq	$34, 8(%rbx)
	movq	%rbx, %rdi
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
	leaq	.Lstr.93(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	$3, 8(%rax)
	movq	%rax, %rdi
	callq	"fn37:f"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.94(%rip), %rax
	movq	%rax, (%rbx)
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$2, (%rax)
	movq	%rax, %rdi
	callq	"fn37:f"@PLT
	andb	$1, %al
	movb	%al, 43(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.77(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	"fn40:f1"@GOTPCREL(%rip), %rdi
	callq	"fn39:g"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.95(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	"fn41:f2"@GOTPCREL(%rip), %rdi
	callq	"fn39:g"@PLT
	andb	$1, %al
	movb	%al, 42(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.99(%rip), %rax
	movq	%rax, (%rbx)
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, %rdi
	callq	"fn42:pt"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.100(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 8(%rbx)
	movq	%rbx, %rdi
	callq	"fn42:pt"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.101(%rip), %rbp
	movq	%rbp, (%rbx)
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 8(%rbx)
	movq	%rbx, 8(%r15)
	movq	%r15, %rdi
	callq	"fn42:pt"@PLT
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
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	xorl	%edi, %edi
	callq	"fn43:gen"@PLT
	movq	%rax, 8(%rbx)
	movq	%rbx, 8(%r15)
	movq	%r15, %rdi
	callq	"fn42:pt"@PLT
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
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	"fn44:gen"@PLT
	movq	%rax, %rdi
	callq	"fn45:pp"@PLT
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
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	"fn46:gen"@PLT
	movq	%rax, %rdi
	callq	"fn47:pp"@PLT
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
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	"fn48:gen"@PLT
	movq	%rax, %rdi
	callq	"fn49:pp"@PLT
	andb	$1, %al
	movb	%al, 41(%rsp)
	movq	136(%rsp), %rax                 # 8-byte Reload
	movq	%rax, (%r12)
	xorl	%eax, %eax
	addq	$408, %rsp                      # imm = 0x198
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
.LBB4_4:                                # %array_ref_bound_check_failed.preheader
	.cfi_def_cfa_offset 464
	leaq	.Lstr.15(%rip), %rbx
	.p2align	4, 0x90
.LBB4_5:                                # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB4_5
.LBB4_10:                               # %array_ref_bound_check_failed131.preheader
	leaq	.Lstr.15(%rip), %rbx
	.p2align	4, 0x90
.LBB4_11:                               # %array_ref_bound_check_failed131
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB4_11
.LBB4_14:                               # %array_ref_bound_check_failed188.preheader
	leaq	.Lstr.15(%rip), %rbx
	.p2align	4, 0x90
.LBB4_15:                               # %array_ref_bound_check_failed188
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB4_15
.LBB4_20:                               # %array_ref_bound_check_failed221.preheader
	leaq	.Lstr.15(%rip), %rbx
	.p2align	4, 0x90
.LBB4_21:                               # %array_ref_bound_check_failed221
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB4_21
.LBB4_25:                               # %array_ref_bound_check_failed715.preheader
	leaq	.Lstr.15(%rip), %rbx
	.p2align	4, 0x90
.LBB4_26:                               # %array_ref_bound_check_failed715
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB4_26
.LBB4_30:                               # %array_ref_bound_check_failed737.preheader
	leaq	.Lstr.15(%rip), %rbx
	.p2align	4, 0x90
.LBB4_31:                               # %array_ref_bound_check_failed737
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB4_31
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function
	.globl	"fn1:nl"                        # -- Begin function fn1:nl
	.p2align	4, 0x90
	.type	"fn1:nl",@function
"fn1:nl":                               # @"fn1:nl"
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
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	andl	$1, %edi
	movb	%dil, 15(%rsp)
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
	movq	$2, 8(%rbx)
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
.Lfunc_end5:
	.size	"fn1:nl", .Lfunc_end5-"fn1:nl"
	.cfi_endproc
                                        # -- End function
	.globl	"fn2:f1_1"                      # -- Begin function fn2:f1_1
	.p2align	4, 0x90
	.type	"fn2:f1_1",@function
"fn2:f1_1":                             # @"fn2:f1_1"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	movq	%rdi, (%rsp)
	movl	$1, %edi
	callq	"fn3:f2_1"@PLT
	movq	%rax, %rdi
	callq	"fn4:g"@PLT
	movq	%rbx, 8(%r14)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	"fn2:f1_1", .Lfunc_end6-"fn2:f1_1"
	.cfi_endproc
                                        # -- End function
	.globl	"fn3:f2_1"                      # -- Begin function fn3:f2_1
	.p2align	4, 0x90
	.type	"fn3:f2_1",@function
"fn3:f2_1":                             # @"fn3:f2_1"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 16(%rsp)
	callq	"fn2:f1_1"@PLT
	movq	%rbx, 8(%r14)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	"fn3:f2_1", .Lfunc_end7-"fn3:f2_1"
	.cfi_endproc
                                        # -- End function
	.globl	"fn4:g"                         # -- Begin function fn4:g
	.p2align	4, 0x90
	.type	"fn4:g",@function
"fn4:g":                                # @"fn4:g"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rax
	movq	16(%rcx), %rdx
	leaq	-16(%rsp), %rsi
	movq	%rsi, 16(%rcx)
	movq	%rdi, -8(%rsp)
	movq	(%rax), %rax
	movq	%rdx, 16(%rcx)
	retq
.Lfunc_end8:
	.size	"fn4:g", .Lfunc_end8-"fn4:g"
	.cfi_endproc
                                        # -- End function
	.globl	"fn5:f1"                        # -- Begin function fn5:f1
	.p2align	4, 0x90
	.type	"fn5:f1",@function
"fn5:f1":                               # @"fn5:f1"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %r14
	leaq	8(%rsp), %rax
	movq	%rax, 8(%rbx)
	movq	%rdi, 16(%rsp)
	testq	%rdi, %rdi
	je	.LBB9_1
# %bb.2:                                # %if_else
	movq	16(%rsp), %rdi
	decq	%rdi
	callq	"fn5:f1"@PLT
	jmp	.LBB9_3
.LBB9_1:                                # %if_then
	movq	(%rbx), %rax
	movb	(%rax), %al
.LBB9_3:                                # %if_merge
	movq	%r14, 8(%rbx)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end9:
	.size	"fn5:f1", .Lfunc_end9-"fn5:f1"
	.cfi_endproc
                                        # -- End function
	.globl	"fn6:f2"                        # -- Begin function fn6:f2
	.p2align	4, 0x90
	.type	"fn6:f2",@function
"fn6:f2":                               # @"fn6:f2"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 16(%rsp)
	testq	%rdi, %rdi
	je	.LBB10_1
# %bb.2:                                # %if_else
	movq	16(%rsp), %rdi
	decq	%rdi
	callq	"fn7:f3"@PLT
	jmp	.LBB10_3
.LBB10_1:
	movl	$1, %eax
.LBB10_3:                               # %if_merge
	movq	%rbx, 8(%r14)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end10:
	.size	"fn6:f2", .Lfunc_end10-"fn6:f2"
	.cfi_endproc
                                        # -- End function
	.globl	"fn7:f3"                        # -- Begin function fn7:f3
	.p2align	4, 0x90
	.type	"fn7:f3",@function
"fn7:f3":                               # @"fn7:f3"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 16(%rsp)
	testq	%rdi, %rdi
	je	.LBB11_1
# %bb.2:                                # %if_else
	movq	16(%rsp), %rdi
	decq	%rdi
	callq	"fn6:f2"@PLT
	jmp	.LBB11_3
.LBB11_1:
	movl	$2, %eax
.LBB11_3:                               # %if_merge
	movq	%rbx, 8(%r14)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end11:
	.size	"fn7:f3", .Lfunc_end11-"fn7:f3"
	.cfi_endproc
                                        # -- End function
	.globl	"fn8:f4"                        # -- Begin function fn8:f4
	.p2align	4, 0x90
	.type	"fn8:f4",@function
"fn8:f4":                               # @"fn8:f4"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 16(%rsp)
	callq	"fn9:f5"@PLT
	movq	%rax, %rdi
	callq	"fn8:f4"@PLT
	movq	%rbx, 8(%r14)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end12:
	.size	"fn8:f4", .Lfunc_end12-"fn8:f4"
	.cfi_endproc
                                        # -- End function
	.globl	"fn9:f5"                        # -- Begin function fn9:f5
	.p2align	4, 0x90
	.type	"fn9:f5",@function
"fn9:f5":                               # @"fn9:f5"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rdx
	leaq	-16(%rsp), %rax
	movq	%rax, 8(%rcx)
	movq	%rdi, -8(%rsp)
	movq	(%rcx), %rax
	movq	8(%rax), %rax
	movq	%rdx, 8(%rcx)
	retq
.Lfunc_end13:
	.size	"fn9:f5", .Lfunc_end13-"fn9:f5"
	.cfi_endproc
                                        # -- End function
	.globl	"fn10:tf1"                      # -- Begin function fn10:tf1
	.p2align	4, 0x90
	.type	"fn10:tf1",@function
"fn10:tf1":                             # @"fn10:tf1"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rdx
	leaq	-16(%rsp), %rsi
	movq	%rsi, 8(%rcx)
	movq	%rdi, %rax
	movq	%rdi, -8(%rsp)
	movq	(%rcx), %rsi
	addq	16(%rsi), %rax
	movq	%rdx, 8(%rcx)
	retq
.Lfunc_end14:
	.size	"fn10:tf1", .Lfunc_end14-"fn10:tf1"
	.cfi_endproc
                                        # -- End function
	.globl	"fn11:tf2"                      # -- Begin function fn11:tf2
	.p2align	4, 0x90
	.type	"fn11:tf2",@function
"fn11:tf2":                             # @"fn11:tf2"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rax
	movq	8(%rax), %rcx
	leaq	-8(%rsp), %rdx
	movq	%rdx, 8(%rax)
	andb	$1, %dil
	movb	%dil, -1(%rsp)
	movq	(%rax), %rdx
	movq	24(%rdx), %rdx
	movb	%dil, (%rdx)
	movq	%rcx, 8(%rax)
	xorl	%eax, %eax
	retq
.Lfunc_end15:
	.size	"fn11:tf2", .Lfunc_end15-"fn11:tf2"
	.cfi_endproc
                                        # -- End function
	.globl	"fn12:tf3"                      # -- Begin function fn12:tf3
	.p2align	4, 0x90
	.type	"fn12:tf3",@function
"fn12:tf3":                             # @"fn12:tf3"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -16
	movq	display_array@GOTPCREL(%rip), %rax
	movq	(%rax), %rdx
	movq	8(%rax), %rcx
	movq	%rsp, %rsi
	movq	%rsi, 8(%rax)
	movq	%rdi, 8(%rsp)
	xorl	%esi, %esi
	testb	%sil, %sil
	jne	.LBB16_2
# %bb.1:                                # %entry
	movq	32(%rdx), %rdx
	cmpq	$0, 8(%rdx)
	jle	.LBB16_2
# %bb.4:                                # %array_ref_bound_check_success
	movq	(%rdx), %rdx
	movq	8(%rsp), %rsi
	movq	%rsi, (%rdx)
	movq	%rcx, 8(%rax)
	xorl	%eax, %eax
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB16_2:                               # %array_ref_bound_check_failed.preheader
	.cfi_def_cfa_offset 32
	leaq	.Lstr.15(%rip), %rbx
	.p2align	4, 0x90
.LBB16_3:                               # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB16_3
.Lfunc_end16:
	.size	"fn12:tf3", .Lfunc_end16-"fn12:tf3"
	.cfi_endproc
                                        # -- End function
	.globl	"fn13:loop"                     # -- Begin function fn13:loop
	.p2align	4, 0x90
	.type	"fn13:loop",@function
"fn13:loop":                            # @"fn13:loop"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 16(%rsp)
	testq	%rdi, %rdi
	je	.LBB17_1
# %bb.2:                                # %if_else
	movl	$46, %edi
	callq	lla_print_char@PLT
	movq	16(%rsp), %rdi
	decq	%rdi
	callq	"fn13:loop"@PLT
                                        # kill: def $al killed $al def $eax
	jmp	.LBB17_3
.LBB17_1:
	xorl	%eax, %eax
.LBB17_3:                               # %if_merge
	movq	%rbx, 8(%r14)
                                        # kill: def $al killed $al killed $eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end17:
	.size	"fn13:loop", .Lfunc_end17-"fn13:loop"
	.cfi_endproc
                                        # -- End function
	.globl	"fn14:f6"                       # -- Begin function fn14:f6
	.p2align	4, 0x90
	.type	"fn14:f6",@function
"fn14:f6":                              # @"fn14:f6"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rdx
	leaq	-16(%rsp), %rax
	movq	%rax, 8(%rcx)
	movq	%rdi, -8(%rsp)
	movq	(%rdi), %rax
	movq	%rdx, 8(%rcx)
	retq
.Lfunc_end18:
	.size	"fn14:f6", .Lfunc_end18-"fn14:f6"
	.cfi_endproc
                                        # -- End function
	.globl	"fn15:f7"                       # -- Begin function fn15:f7
	.p2align	4, 0x90
	.type	"fn15:f7",@function
"fn15:f7":                              # @"fn15:f7"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -16
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rdx
	movq	%rsp, %rax
	movq	%rax, 8(%rcx)
	movq	%rdi, 8(%rsp)
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB19_4
# %bb.1:                                # %entry
	cmpq	$0, 8(%rdi)
	jle	.LBB19_4
# %bb.2:                                # %entry
	cmpq	$0, 16(%rdi)
	jle	.LBB19_4
# %bb.3:                                # %entry
	cmpq	$0, 24(%rdi)
	jle	.LBB19_4
# %bb.6:                                # %array_ref_bound_check_success
	movq	(%rdi), %rax
	movq	(%rax), %rax
	movq	%rdx, 8(%rcx)
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB19_4:                               # %array_ref_bound_check_failed.preheader
	.cfi_def_cfa_offset 32
	leaq	.Lstr.15(%rip), %rbx
	.p2align	4, 0x90
.LBB19_5:                               # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB19_5
.Lfunc_end19:
	.size	"fn15:f7", .Lfunc_end19-"fn15:f7"
	.cfi_endproc
                                        # -- End function
	.globl	"fn16:f8"                       # -- Begin function fn16:f8
	.p2align	4, 0x90
	.type	"fn16:f8",@function
"fn16:f8":                              # @"fn16:f8"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %r14
	leaq	8(%rsp), %rcx
	movq	%rcx, 8(%rbx)
	movq	%rdi, %rax
	movq	%rdi, 16(%rsp)
	movq	(%rbx), %rcx
	movzbl	2(%rcx), %esi
	movzbl	1(%rcx), %edi
	callq	*%rax
	movq	%r14, 8(%rbx)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end20:
	.size	"fn16:f8", .Lfunc_end20-"fn16:f8"
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2                               # -- Begin function fn17:f8_f
.LCPI21_0:
	.long	0x3f800000                      # float 1
	.text
	.globl	"fn17:f8_f"
	.p2align	4, 0x90
	.type	"fn17:f8_f",@function
"fn17:f8_f":                            # @"fn17:f8_f"
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
	leaq	16(%rsp), %rax
	movq	%rax, 8(%r15)
	movb	%dil, 15(%rsp)
	andl	$1, %esi
	movb	%sil, 14(%rsp)
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
	leaq	.Lstr.20(%rip), %rax
	movq	%rax, (%rbx)
	movq	$15, 8(%rbx)
	movq	%rbx, %rdi
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
	leaq	.Lstr.21(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	15(%rsp), %edi
	callq	lla_print_char@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.22(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movzbl	14(%rsp), %edi
	callq	lla_print_bool@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.23(%rip), %rax
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r12, 8(%r15)
	movss	.LCPI21_0(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
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
.Lfunc_end21:
	.size	"fn17:f8_f", .Lfunc_end21-"fn17:f8_f"
	.cfi_endproc
                                        # -- End function
	.globl	"_color:1_equality"             # -- Begin function _color:1_equality
	.p2align	4, 0x90
	.type	"_color:1_equality",@function
"_color:1_equality":                    # @"_color:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB22_5
# %bb.1:                                # %body
	cmpq	$1, %rax
	je	.LBB22_4
# %bb.2:                                # %body
	cmpq	$2, %rax
	je	.LBB22_4
# %bb.3:                                # %body
	cmpq	$3, %rax
	jne	.LBB22_7
.LBB22_4:                               # %"case_color:1:Red"
	movb	$1, %al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB22_5:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB22_7:
	.cfi_def_cfa_offset 16
	leaq	.Lstr.27(%rip), %rbx
	.p2align	4, 0x90
.LBB22_8:                               # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$86, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB22_8
.Lfunc_end22:
	.size	"_color:1_equality", .Lfunc_end22-"_color:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_number:1_equality"            # -- Begin function _number:1_equality
	.p2align	4, 0x90
	.type	"_number:1_equality",@function
"_number:1_equality":                   # @"_number:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB23_5
# %bb.1:                                # %body
	cmpq	$1, %rax
	je	.LBB23_7
# %bb.2:                                # %body
	cmpq	$2, %rax
	je	.LBB23_8
# %bb.3:                                # %body
	cmpq	$3, %rax
	jne	.LBB23_9
# %bb.4:                                # %"case_number:1:Complex"
	movss	8(%rdi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rdi), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rsi), %xmm0
	setnp	%cl
	sete	%dl
	ucomiss	12(%rsi), %xmm1
	setnp	%bl
	sete	%al
	andb	%bl, %al
	andb	%cl, %al
	andb	%dl, %al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB23_5:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB23_7:                               # %"case_number:1:Integer"
	.cfi_def_cfa_offset 16
	movq	8(%rdi), %rax
	cmpq	8(%rsi), %rax
	sete	%al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB23_8:                               # %"case_number:1:Real"
	.cfi_def_cfa_offset 16
	movss	8(%rsi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	cmpeqss	8(%rdi), %xmm0
	movd	%xmm0, %eax
	andl	$1, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB23_9:
	.cfi_def_cfa_offset 16
	leaq	.Lstr.28(%rip), %rbx
	.p2align	4, 0x90
.LBB23_10:                              # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$87, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB23_10
.Lfunc_end23:
	.size	"_number:1_equality", .Lfunc_end23-"_number:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_list:1_equality"              # -- Begin function _list:1_equality
	.p2align	4, 0x90
	.type	"_list:1_equality",@function
"_list:1_equality":                     # @"_list:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB24_4
# %bb.1:                                # %body
	cmpq	$1, %rax
	je	.LBB24_6
# %bb.2:                                # %body
	cmpq	$2, %rax
	jne	.LBB24_7
# %bb.3:                                # %"case_list:1:Cons"
	movq	16(%rsi), %rax
	movq	8(%rdi), %rcx
	movq	16(%rdi), %rdi
	cmpq	8(%rsi), %rcx
	sete	%bl
	movq	%rax, %rsi
	callq	"_list:1_equality"@PLT
                                        # kill: def $al killed $al def $eax
	andb	%bl, %al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB24_4:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB24_6:                               # %"case_list:1:Nil"
	.cfi_def_cfa_offset 16
	movb	$1, %al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB24_7:
	.cfi_def_cfa_offset 16
	leaq	.Lstr.29(%rip), %rbx
	.p2align	4, 0x90
.LBB24_8:                               # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$85, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB24_8
.Lfunc_end24:
	.size	"_list:1_equality", .Lfunc_end24-"_list:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_tree:1_equality"              # -- Begin function _tree:1_equality
	.p2align	4, 0x90
	.type	"_tree:1_equality",@function
"_tree:1_equality":                     # @"_tree:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB25_4
# %bb.1:                                # %body
	cmpq	$1, %rax
	je	.LBB25_6
# %bb.2:                                # %body
	cmpq	$2, %rax
	jne	.LBB25_7
# %bb.3:                                # %"case_tree:1:Node"
	movq	16(%rsi), %rax
	movq	8(%rdi), %rcx
	movq	16(%rdi), %rdi
	cmpq	8(%rsi), %rcx
	sete	%bl
	movq	%rax, %rsi
	callq	"_forest:1_equality"@PLT
                                        # kill: def $al killed $al def $eax
	andb	%bl, %al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB25_4:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB25_6:                               # %"case_tree:1:Leaf"
	.cfi_def_cfa_offset 16
	movb	$1, %al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB25_7:
	.cfi_def_cfa_offset 16
	leaq	.Lstr.30(%rip), %rbx
	.p2align	4, 0x90
.LBB25_8:                               # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$85, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB25_8
.Lfunc_end25:
	.size	"_tree:1_equality", .Lfunc_end25-"_tree:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_forest:1_equality"            # -- Begin function _forest:1_equality
	.p2align	4, 0x90
	.type	"_forest:1_equality",@function
"_forest:1_equality":                   # @"_forest:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB26_1
# %bb.2:                                # %body
	cmpq	$1, %rax
	je	.LBB26_6
# %bb.3:                                # %body
	cmpq	$2, %rax
	jne	.LBB26_4
# %bb.8:                                # %"case_forest:1:NonEmpty"
	movq	8(%rsi), %rax
	movq	16(%rsi), %r14
	movq	8(%rdi), %rcx
	movq	16(%rdi), %rbx
	movq	%rcx, %rdi
	movq	%rax, %rsi
	callq	"_tree:1_equality"@PLT
	movl	%eax, %ebp
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	"_forest:1_equality"@PLT
                                        # kill: def $al killed $al def $eax
	andb	%bpl, %al
	jmp	.LBB26_7
.LBB26_1:
	xorl	%eax, %eax
	jmp	.LBB26_7
.LBB26_6:                               # %"case_forest:1:Empty"
	movb	$1, %al
.LBB26_7:                               # %exit
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB26_4:
	.cfi_def_cfa_offset 32
	leaq	.Lstr.31(%rip), %rbx
	.p2align	4, 0x90
.LBB26_5:                               # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$87, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB26_5
.Lfunc_end26:
	.size	"_forest:1_equality", .Lfunc_end26-"_forest:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_a:1_equality"                 # -- Begin function _a:1_equality
	.p2align	4, 0x90
	.type	"_a:1_equality",@function
"_a:1_equality":                        # @"_a:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB27_3
# %bb.1:                                # %body
	cmpq	$1, %rax
	jne	.LBB27_5
# %bb.2:                                # %"case_a:1:A"
	movq	8(%rsi), %rsi
	movq	8(%rdi), %rdi
	callq	"_b:1_equality"@PLT
                                        # kill: def $al killed $al def $eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB27_3:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB27_5:
	.cfi_def_cfa_offset 16
	leaq	.Lstr.32(%rip), %rbx
	.p2align	4, 0x90
.LBB27_6:                               # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$82, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB27_6
.Lfunc_end27:
	.size	"_a:1_equality", .Lfunc_end27-"_a:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_b:1_equality"                 # -- Begin function _b:1_equality
	.p2align	4, 0x90
	.type	"_b:1_equality",@function
"_b:1_equality":                        # @"_b:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB28_3
# %bb.1:                                # %body
	cmpq	$1, %rax
	jne	.LBB28_5
# %bb.2:                                # %"case_b:1:B"
	movq	8(%rsi), %rsi
	movq	8(%rdi), %rdi
	callq	"_c:1_equality"@PLT
                                        # kill: def $al killed $al def $eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB28_3:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB28_5:
	.cfi_def_cfa_offset 16
	leaq	.Lstr.33(%rip), %rbx
	.p2align	4, 0x90
.LBB28_6:                               # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$82, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB28_6
.Lfunc_end28:
	.size	"_b:1_equality", .Lfunc_end28-"_b:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_c:1_equality"                 # -- Begin function _c:1_equality
	.p2align	4, 0x90
	.type	"_c:1_equality",@function
"_c:1_equality":                        # @"_c:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB29_3
# %bb.1:                                # %body
	cmpq	$1, %rax
	jne	.LBB29_5
# %bb.2:                                # %"case_c:1:C"
	movq	8(%rsi), %rsi
	movq	8(%rdi), %rdi
	callq	"_a:1_equality"@PLT
                                        # kill: def $al killed $al def $eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB29_3:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB29_5:
	.cfi_def_cfa_offset 16
	leaq	.Lstr.34(%rip), %rbx
	.p2align	4, 0x90
.LBB29_6:                               # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$82, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB29_6
.Lfunc_end29:
	.size	"_c:1_equality", .Lfunc_end29-"_c:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_opt:1_equality"               # -- Begin function _opt:1_equality
	.p2align	4, 0x90
	.type	"_opt:1_equality",@function
"_opt:1_equality":                      # @"_opt:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB30_4
# %bb.1:                                # %body
	cmpq	$1, %rax
	je	.LBB30_6
# %bb.2:                                # %body
	cmpq	$2, %rax
	jne	.LBB30_7
# %bb.3:                                # %"case_opt:1:B"
	movss	8(%rsi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	cmpeqss	8(%rdi), %xmm0
	movd	%xmm0, %eax
	andl	$1, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB30_4:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB30_6:                               # %"case_opt:1:A"
	.cfi_def_cfa_offset 16
	movq	8(%rdi), %rax
	cmpq	8(%rsi), %rax
	sete	%al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB30_7:
	.cfi_def_cfa_offset 16
	leaq	.Lstr.35(%rip), %rbx
	.p2align	4, 0x90
.LBB30_8:                               # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$84, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB30_8
.Lfunc_end30:
	.size	"_opt:1_equality", .Lfunc_end30-"_opt:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"fn18:p_color"                  # -- Begin function fn18:p_color
	.p2align	4, 0x90
	.type	"fn18:p_color",@function
"fn18:p_color":                         # @"fn18:p_color"
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
	jne	.LBB31_3
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
	leaq	.Lstr.36(%rip), %rax
	movq	%rax, (%rbx)
	movq	$4, 8(%rbx)
	jmp	.LBB31_2
.LBB31_3:                               # %match_check_2
	cmpq	$2, (%rdi)
	jne	.LBB31_5
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
	leaq	.Lstr.37(%rip), %rax
	movq	%rax, (%rbx)
	movq	$6, 8(%rbx)
	jmp	.LBB31_2
.LBB31_5:                               # %match_check_3
	cmpq	$3, (%rdi)
	jne	.LBB31_7
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
	leaq	.Lstr.38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
.LBB31_2:                               # %match_finished
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
.LBB31_7:                               # %match_failed.preheader
	.cfi_def_cfa_offset 48
	leaq	.Lstr.39(%rip), %rbx
	.p2align	4, 0x90
.LBB31_8:                               # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB31_8
.Lfunc_end31:
	.size	"fn18:p_color", .Lfunc_end31-"fn18:p_color"
	.cfi_endproc
                                        # -- End function
	.globl	"fn19:p_opt"                    # -- Begin function fn19:p_opt
	.p2align	4, 0x90
	.type	"fn19:p_opt",@function
"fn19:p_opt":                           # @"fn19:p_opt"
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
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %r15
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 24(%rsp)
	cmpq	$1, (%rdi)
	jne	.LBB32_2
# %bb.1:                                # %match_param_check_1
	movq	8(%rdi), %rax
	movq	%rax, 16(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.40(%rip), %rax
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rdi
	callq	lla_print_int@PLT
	jmp	.LBB32_4
.LBB32_2:                               # %match_check_2
	cmpq	$2, (%rdi)
	jne	.LBB32_5
# %bb.3:                                # %match_param_check_2
	movss	8(%rdi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, 12(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.41(%rip), %rax
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	12(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
.LBB32_4:                               # %match_finished
	movq	%r15, 8(%r14)
	addq	$32, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB32_5:                               # %match_failed.preheader
	.cfi_def_cfa_offset 64
	leaq	.Lstr.39(%rip), %rbx
	.p2align	4, 0x90
.LBB32_6:                               # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB32_6
.Lfunc_end32:
	.size	"fn19:p_opt", .Lfunc_end32-"fn19:p_opt"
	.cfi_endproc
                                        # -- End function
	.globl	"fn20:pmtype"                   # -- Begin function fn20:pmtype
	.p2align	4, 0x90
	.type	"fn20:pmtype",@function
"fn20:pmtype":                          # @"fn20:pmtype"
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
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %r15
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 40(%rsp)
	cmpq	$1, (%rdi)
	jne	.LBB33_2
# %bb.1:                                # %match_param_check_1
	movq	8(%rdi), %rax
	movq	%rax, 32(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.42(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	32(%rsp), %rdi
	callq	lla_print_int@PLT
	jmp	.LBB33_20
.LBB33_2:                               # %match_check_2
	cmpq	$2, (%rdi)
	jne	.LBB33_4
# %bb.3:                                # %match_param_check_2
	movss	8(%rdi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, 28(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.43(%rip), %rax
	movq	%rax, (%rbx)
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	28(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	jmp	.LBB33_19
.LBB33_4:                               # %match_check_3
	cmpq	$3, (%rdi)
	jne	.LBB33_8
# %bb.5:                                # %match_param_check_3
	movss	8(%rdi), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	movss	12(%rdi), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	movss	%xmm1, 24(%rsp)
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB33_8
# %bb.6:                                # %match_param_check_3
	xorps	%xmm1, %xmm1
	ucomiss	%xmm0, %xmm1
	jne	.LBB33_8
	jp	.LBB33_8
# %bb.7:                                # %match_success_3
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.44(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	24(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	jmp	.LBB33_19
.LBB33_8:                               # %match_check_4
	cmpq	$3, (%rdi)
	jne	.LBB33_12
# %bb.9:                                # %match_param_check_4
	movss	8(%rdi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rdi), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	movss	%xmm1, 20(%rsp)
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB33_12
# %bb.10:                               # %match_param_check_4
	xorps	%xmm1, %xmm1
	ucomiss	%xmm0, %xmm1
	jne	.LBB33_12
	jp	.LBB33_12
# %bb.11:                               # %match_success_4
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.45(%rip), %rax
	movq	%rax, (%rbx)
	movq	$10, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	20(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	jmp	.LBB33_19
.LBB33_12:                              # %match_check_5
	cmpq	$3, (%rdi)
	jne	.LBB33_13
# %bb.15:                               # %match_param_check_5
	movss	8(%rdi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rdi), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	movss	%xmm0, 16(%rsp)
	movss	%xmm1, 12(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.44(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	16(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	movss	12(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	xorps	%xmm1, %xmm1
	movl	$16, %edi
	ucomiss	%xmm1, %xmm0
	jbe	.LBB33_17
# %bb.16:                               # %if_then
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.46(%rip), %rax
	jmp	.LBB33_18
.LBB33_13:
	leaq	.Lstr.39(%rip), %rbx
	.p2align	4, 0x90
.LBB33_14:                              # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB33_14
.LBB33_17:                              # %if_else
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.47(%rip), %rax
.LBB33_18:                              # %if_merge
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	12(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	callq	lla_fabs@PLT
.LBB33_19:                              # %match_finished
	callq	lla_print_float@PLT
.LBB33_20:                              # %match_finished
	movq	%r15, 8(%r14)
	addq	$48, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end33:
	.size	"fn20:pmtype", .Lfunc_end33-"fn20:pmtype"
	.cfi_endproc
                                        # -- End function
	.globl	"fn21:pc_new"                   # -- Begin function fn21:pc_new
	.p2align	4, 0x90
	.type	"fn21:pc_new",@function
"fn21:pc_new":                          # @"fn21:pc_new"
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
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r15)
	andl	$1, %edi
	movb	%dil, 15(%rsp)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, 16(%rsp)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, (%rbx)
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
	leaq	.Lstr.48(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn18:p_color"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movq	16(%rsp), %rax
	movq	$0, (%rax)
	movq	16(%rsp), %rbx
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movq	%rax, (%rbx)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.49(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn18:p_color"@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movq	16(%rsp), %rax
	movq	$0, (%rax)
	movq	%r12, 8(%r15)
	xorl	%eax, %eax
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
.Lfunc_end34:
	.size	"fn21:pc_new", .Lfunc_end34-"fn21:pc_new"
	.cfi_endproc
                                        # -- End function
	.globl	"fn22:f9"                       # -- Begin function fn22:f9
	.p2align	4, 0x90
	.type	"fn22:f9",@function
"fn22:f9":                              # @"fn22:f9"
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
	movq	8(%r15), %r12
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r15)
	movq	%rdi, 24(%rsp)
	movl	$8, %edi
	callq	malloc@PLT
	movq	%rax, %r14
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	xorl	%r13d, %r13d
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, 16(%rsp)
	movq	%r14, (%rbx)
	movq	$1, 8(%rbx)
	movq	$1, 16(%rbx)
	testb	%r13b, %r13b
	jne	.LBB35_3
# %bb.1:                                # %entry
	movq	16(%rsp), %rax
	cmpq	$0, 8(%rax)
	jle	.LBB35_3
# %bb.2:                                # %entry
	cmpq	$0, 16(%rax)
	jle	.LBB35_3
# %bb.5:                                # %array_ref_bound_check_success
	movq	(%rax), %rax
	movq	24(%rsp), %rcx
	movq	%rcx, (%rax)
	movq	16(%rsp), %rax
	movq	%r12, 8(%r15)
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
.LBB35_3:                               # %array_ref_bound_check_failed.preheader
	.cfi_def_cfa_offset 80
	leaq	.Lstr.15(%rip), %rbx
	.p2align	4, 0x90
.LBB35_4:                               # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB35_4
.Lfunc_end35:
	.size	"fn22:f9", .Lfunc_end35-"fn22:f9"
	.cfi_endproc
                                        # -- End function
	.globl	"fn23:f"                        # -- Begin function fn23:f
	.p2align	4, 0x90
	.type	"fn23:f",@function
"fn23:f":                               # @"fn23:f"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rdx
	leaq	-16(%rsp), %rax
	movq	%rax, 8(%rcx)
	movq	%rdi, -8(%rsp)
	movq	16(%rdi), %rax
	movq	%rdx, 8(%rcx)
	retq
.Lfunc_end36:
	.size	"fn23:f", .Lfunc_end36-"fn23:f"
	.cfi_endproc
                                        # -- End function
	.globl	"fn24:f"                        # -- Begin function fn24:f
	.p2align	4, 0x90
	.type	"fn24:f",@function
"fn24:f":                               # @"fn24:f"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rax
	movq	8(%rax), %rcx
	leaq	-8(%rsp), %rdx
	movq	%rdx, 8(%rax)
	andb	$1, %dil
	movb	%dil, -1(%rsp)
	movq	%rcx, 8(%rax)
	movl	$1, %eax
	retq
.Lfunc_end37:
	.size	"fn24:f", .Lfunc_end37-"fn24:f"
	.cfi_endproc
                                        # -- End function
	.globl	"fn25:f10"                      # -- Begin function fn25:f10
	.p2align	4, 0x90
	.type	"fn25:f10",@function
"fn25:f10":                             # @"fn25:f10"
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
	movq	24(%rdi), %rax
	movq	%rax, 8(%rsp)
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
	leaq	.Lstr.64(%rip), %rax
	movq	%rax, (%rbx)
	movq	$16, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rdi
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
	leaq	.Lstr.4(%rip), %rax
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
.Lfunc_end38:
	.size	"fn25:f10", .Lfunc_end38-"fn25:f10"
	.cfi_endproc
                                        # -- End function
	.globl	"fn26:uif"                      # -- Begin function fn26:uif
	.p2align	4, 0x90
	.type	"fn26:uif",@function
"fn26:uif":                             # @"fn26:uif"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 16(%rsp)
	testq	%rdi, %rdi
	je	.LBB39_2
# %bb.1:
	xorl	%eax, %eax
	jmp	.LBB39_3
.LBB39_2:                               # %if_then
	movq	16(%rsp), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
                                        # kill: def $al killed $al def $eax
.LBB39_3:                               # %if_merge
	movq	%rbx, 8(%r14)
                                        # kill: def $al killed $al killed $eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end39:
	.size	"fn26:uif", .Lfunc_end39-"fn26:uif"
	.cfi_endproc
                                        # -- End function
	.globl	"fn27:while_test"               # -- Begin function fn27:while_test
	.p2align	4, 0x90
	.type	"fn27:while_test",@function
"fn27:while_test":                      # @"fn27:while_test"
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
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %r13
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r12)
	movq	%rdi, 24(%rsp)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 16(%rsp)
	movq	$0, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r14
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r15
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.67(%rip), %rax
	movq	%rax, (%r14)
	movq	$23, 8(%r14)
	movq	%r14, %rdi
	callq	lla_print_string@PLT
	leaq	.Lstr.4(%rip), %r14
	.p2align	4, 0x90
.LBB40_1:                               # %while_check
                                        # =>This Inner Loop Header: Depth=1
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	incq	%rcx
	cmpq	%rcx, (%rax)
	jge	.LBB40_3
# %bb.2:                                # %while_body
                                        #   in Loop: Header=BB40_1 Depth=1
	movq	16(%rsp), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r14, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rdi
	callq	lla_incr@PLT
	jmp	.LBB40_1
.LBB40_3:                               # %while_after
	movq	%r13, 8(%r12)
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
.Lfunc_end40:
	.size	"fn27:while_test", .Lfunc_end40-"fn27:while_test"
	.cfi_endproc
                                        # -- End function
	.globl	"fn28:for_test"                 # -- Begin function fn28:for_test
	.p2align	4, 0x90
	.type	"fn28:for_test",@function
"fn28:for_test":                        # @"fn28:for_test"
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
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rsp, %rax
	movq	%rax, 8(%rcx)
	movq	%rdi, 8(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r14
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r15
	xorl	%r12d, %r12d
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.68(%rip), %rax
	movq	%rax, (%r14)
	movq	$25, 8(%r14)
	movq	%r14, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rbp
	leaq	.Lstr.4(%rip), %r13
	.p2align	4, 0x90
.LBB41_1:                               # %for_check
                                        # =>This Inner Loop Header: Depth=1
	movq	%r12, 32(%rsp)
	cmpq	%rbp, %r12
	jg	.LBB41_3
# %bb.2:                                # %for_body
                                        #   in Loop: Header=BB41_1 Depth=1
	movq	32(%rsp), %rdi
	callq	lla_print_int@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r13, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	incq	%r12
	jmp	.LBB41_1
.LBB41_3:                               # %for_after
	movq	8(%rsp), %rbp
	decq	%rbp
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	.p2align	4, 0x90
.LBB41_4:                               # %for_check9
                                        # =>This Inner Loop Header: Depth=1
	movq	%rbp, 24(%rsp)
	testq	%rbp, %rbp
	js	.LBB41_6
# %bb.5:                                # %for_body10
                                        #   in Loop: Header=BB41_4 Depth=1
	movq	24(%rsp), %rdi
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
	decq	%rbp
	jmp	.LBB41_4
.LBB41_6:                               # %for_after11
	movq	display_array@GOTPCREL(%rip), %rax
	movq	16(%rsp), %rcx                  # 8-byte Reload
	movq	%rcx, 8(%rax)
	xorl	%eax, %eax
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
.Lfunc_end41:
	.size	"fn28:for_test", .Lfunc_end41-"fn28:for_test"
	.cfi_endproc
                                        # -- End function
	.globl	"fn29:if_while_for"             # -- Begin function fn29:if_while_for
	.p2align	4, 0x90
	.type	"fn29:if_while_for",@function
"fn29:if_while_for":                    # @"fn29:if_while_for"
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
	andb	$1, %dil
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %r14
	movq	%rsp, %rax
	movq	%rax, 8(%r15)
	movb	%dil, 7(%rsp)
	je	.LBB42_4
# %bb.1:                                # %if_then
	movl	$1, %ebx
	.p2align	4, 0x90
.LBB42_2:                               # %for_check
                                        # =>This Inner Loop Header: Depth=1
	movq	%rbx, 8(%rsp)
	cmpq	$3, %rbx
	jg	.LBB42_5
# %bb.3:                                # %for_body
                                        #   in Loop: Header=BB42_2 Depth=1
	movl	$46, %edi
	callq	lla_print_char@PLT
	incq	%rbx
	jmp	.LBB42_2
	.p2align	4, 0x90
.LBB42_4:                               # %while_check
                                        # =>This Inner Loop Header: Depth=1
	jmp	.LBB42_4
.LBB42_5:                               # %if_merge
	movq	%r14, 8(%r15)
	xorl	%eax, %eax
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end42:
	.size	"fn29:if_while_for", .Lfunc_end42-"fn29:if_while_for"
	.cfi_endproc
                                        # -- End function
	.globl	"fn30:f_nest0"                  # -- Begin function fn30:f_nest0
	.p2align	4, 0x90
	.type	"fn30:f_nest0",@function
"fn30:f_nest0":                         # @"fn30:f_nest0"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 16(%rsp)
	movq	$1, 8(%rsp)
	movl	$1, %esi
	callq	"fn32:f_nest2"@PLT
	movq	%rbx, 8(%r14)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end43:
	.size	"fn30:f_nest0", .Lfunc_end43-"fn30:f_nest0"
	.cfi_endproc
                                        # -- End function
	.globl	"fn31:f_nest1"                  # -- Begin function fn31:f_nest1
	.p2align	4, 0x90
	.type	"fn31:f_nest1",@function
"fn31:f_nest1":                         # @"fn31:f_nest1"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	16(%rcx), %rdx
	leaq	-16(%rsp), %rsi
	movq	%rsi, 16(%rcx)
	movq	%rdi, %rax
	movq	%rdi, -8(%rsp)
	incq	%rax
	movq	%rdx, 16(%rcx)
	retq
.Lfunc_end44:
	.size	"fn31:f_nest1", .Lfunc_end44-"fn31:f_nest1"
	.cfi_endproc
                                        # -- End function
	.globl	"fn32:f_nest2"                  # -- Begin function fn32:f_nest2
	.p2align	4, 0x90
	.type	"fn32:f_nest2",@function
"fn32:f_nest2":                         # @"fn32:f_nest2"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	16(%rbx), %r14
	leaq	8(%rsp), %rax
	movq	%rax, 16(%rbx)
	movq	%rdi, 8(%rsp)
	movq	%rsi, (%rsp)
	movq	8(%rbx), %rax
	movq	(%rax), %rax
	movq	16(%rbx), %rcx
	addq	(%rcx), %rax
	addq	%rsi, %rax
	movq	%rax, 8(%rcx)
	movq	8(%rbx), %rax
	movq	(%rax), %rdi
	callq	"fn33:f_nest3"@PLT
	movq	%r14, 16(%rbx)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end45:
	.size	"fn32:f_nest2", .Lfunc_end45-"fn32:f_nest2"
	.cfi_endproc
                                        # -- End function
	.globl	"fn33:f_nest3"                  # -- Begin function fn33:f_nest3
	.p2align	4, 0x90
	.type	"fn33:f_nest3",@function
"fn33:f_nest3":                         # @"fn33:f_nest3"
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
	movq	display_array@GOTPCREL(%rip), %r15
	movq	16(%r15), %rax
	movq	24(%r15), %r14
	movq	%rsp, %rcx
	movq	%rcx, 24(%r15)
	movq	%rdi, 8(%rsp)
	movq	(%rax), %rbx
	addq	8(%rax), %rbx
	callq	"fn31:f_nest1"@PLT
	addq	%rbx, %rax
	movq	%r14, 24(%r15)
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end46:
	.size	"fn33:f_nest3", .Lfunc_end46-"fn33:f_nest3"
	.cfi_endproc
                                        # -- End function
	.globl	"fn34:print_int"                # -- Begin function fn34:print_int
	.p2align	4, 0x90
	.type	"fn34:print_int",@function
"fn34:print_int":                       # @"fn34:print_int"
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
	callq	lla_print_string@PLT
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
	leaq	.Lstr.85(%rip), %rax
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rdi
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
	leaq	.Lstr.4(%rip), %rax
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
.Lfunc_end47:
	.size	"fn34:print_int", .Lfunc_end47-"fn34:print_int"
	.cfi_endproc
                                        # -- End function
	.globl	"fn35:f"                        # -- Begin function fn35:f
	.p2align	4, 0x90
	.type	"fn35:f",@function
"fn35:f":                               # @"fn35:f"
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
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %r14
	movq	%rsp, %rax
	movq	%rax, 8(%r15)
	movq	%rdi, (%rsp)
	movq	8(%r15), %r12
	movl	$1, %r13d
	jmp	.LBB48_1
	.p2align	4, 0x90
.LBB48_5:                               # %for_after6
                                        #   in Loop: Header=BB48_1 Depth=1
	incq	%r13
.LBB48_1:                               # %for_check
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB48_3 Depth 2
	movq	%r13, 8(%r12)
	cmpq	$3, %r13
	jg	.LBB48_6
# %bb.2:                                # %for_body
                                        #   in Loop: Header=BB48_1 Depth=1
	movq	8(%r15), %rbx
	movl	$1, %ebp
	.p2align	4, 0x90
.LBB48_3:                               # %for_check4
                                        #   Parent Loop BB48_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbp, 16(%rbx)
	cmpq	$3, %rbp
	jg	.LBB48_5
# %bb.4:                                # %for_body5
                                        #   in Loop: Header=BB48_3 Depth=2
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	incq	%rbp
	jmp	.LBB48_3
.LBB48_6:                               # %for_after
	movq	%r14, 8(%r15)
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
.Lfunc_end48:
	.size	"fn35:f", .Lfunc_end48-"fn35:f"
	.cfi_endproc
                                        # -- End function
	.globl	"fn36:g"                        # -- Begin function fn36:g
	.p2align	4, 0x90
	.type	"fn36:g",@function
"fn36:g":                               # @"fn36:g"
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
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %r15
	movq	16(%r15), %r12
	movq	%rsp, %rax
	movq	%rax, 16(%r15)
	andl	$1, %edi
	movb	%dil, 7(%rsp)
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
	leaq	.Lstr.86(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	8(%r15), %rax
	movq	8(%rax), %rsi
	movq	%rbx, %rdi
	callq	"fn34:print_int"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.87(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	8(%r15), %rax
	movq	16(%rax), %rsi
	movq	%rbx, %rdi
	callq	"fn34:print_int"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.88(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	8(%r15), %rax
	movq	(%rax), %rsi
	movq	%rbx, %rdi
	callq	"fn34:print_int"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.89(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	(%r15), %rax
	movq	40(%rax), %rsi
	movq	%rbx, %rdi
	callq	"fn34:print_int"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.90(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	(%r15), %rax
	movq	8(%r15), %rcx
	movq	8(%rcx), %rsi
	addq	16(%rcx), %rsi
	addq	(%rcx), %rsi
	addq	40(%rax), %rsi
	movq	%rbx, %rdi
	callq	"fn34:print_int"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.4(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r12, 16(%r15)
	addq	$8, %rsp
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
.Lfunc_end49:
	.size	"fn36:g", .Lfunc_end49-"fn36:g"
	.cfi_endproc
                                        # -- End function
	.globl	"_nstd:1_equality"              # -- Begin function _nstd:1_equality
	.p2align	4, 0x90
	.type	"_nstd:1_equality",@function
"_nstd:1_equality":                     # @"_nstd:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB50_4
# %bb.1:                                # %body
	cmpq	$1, %rax
	je	.LBB50_6
# %bb.2:                                # %body
	cmpq	$2, %rax
	jne	.LBB50_7
# %bb.3:                                # %"case_nstd:1:T2"
	movb	$1, %al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB50_4:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB50_6:                               # %"case_nstd:1:T1"
	.cfi_def_cfa_offset 16
	movq	8(%rdi), %rax
	cmpq	8(%rsi), %rax
	sete	%al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB50_7:
	.cfi_def_cfa_offset 16
	leaq	.Lstr.91(%rip), %rbx
	.p2align	4, 0x90
.LBB50_8:                               # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$85, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB50_8
.Lfunc_end50:
	.size	"_nstd:1_equality", .Lfunc_end50-"_nstd:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"fn37:f"                        # -- Begin function fn37:f
	.p2align	4, 0x90
	.type	"fn37:f",@function
"fn37:f":                               # @"fn37:f"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %r14
	leaq	16(%rsp), %rax
	movq	%rax, 8(%rbx)
	movq	%rdi, 8(%rsp)
	cmpq	$1, (%rdi)
	jne	.LBB51_2
# %bb.1:                                # %match_param_check_1
	movq	8(%rdi), %rax
	movq	8(%rbx), %rcx
	movq	%rax, (%rcx)
	xorl	%edi, %edi
	callq	"fn38:g"@PLT
                                        # kill: def $al killed $al def $eax
	jmp	.LBB51_4
.LBB51_2:                               # %match_check_2
	cmpq	$2, (%rdi)
	jne	.LBB51_5
# %bb.3:                                # %match_param_check_2
	xorl	%eax, %eax
.LBB51_4:                               # %match_finished
	movq	%r14, 8(%rbx)
                                        # kill: def $al killed $al killed $eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.LBB51_5:                               # %match_failed.preheader
	.cfi_def_cfa_offset 48
	leaq	.Lstr.39(%rip), %rbx
	.p2align	4, 0x90
.LBB51_6:                               # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB51_6
.Lfunc_end51:
	.size	"fn37:f", .Lfunc_end51-"fn37:f"
	.cfi_endproc
                                        # -- End function
	.globl	"fn38:g"                        # -- Begin function fn38:g
	.p2align	4, 0x90
	.type	"fn38:g",@function
"fn38:g":                               # @"fn38:g"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %rax
	movq	16(%rbx), %r14
	movq	%rsp, %rcx
	movq	%rcx, 16(%rbx)
	andl	$1, %edi
	movb	%dil, 7(%rsp)
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	xorl	%edi, %edi
	callq	"fn1:nl"@PLT
	movq	%r14, 16(%rbx)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end52:
	.size	"fn38:g", .Lfunc_end52-"fn38:g"
	.cfi_endproc
                                        # -- End function
	.globl	"fn39:g"                        # -- Begin function fn39:g
	.p2align	4, 0x90
	.type	"fn39:g",@function
"fn39:g":                               # @"fn39:g"
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
	movq	%rdi, %rax
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %r15
	movq	%rsp, %rcx
	movq	%rcx, 8(%r14)
	movq	%rdi, 8(%rsp)
	movl	$1, %edi
	callq	*%rax
	movq	%rax, %rdi
	callq	lla_print_int@PLT
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
	movq	$2, 8(%rbx)
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
.Lfunc_end53:
	.size	"fn39:g", .Lfunc_end53-"fn39:g"
	.cfi_endproc
                                        # -- End function
	.globl	"fn40:f1"                       # -- Begin function fn40:f1
	.p2align	4, 0x90
	.type	"fn40:f1",@function
"fn40:f1":                              # @"fn40:f1"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rdx
	leaq	-16(%rsp), %rsi
	movq	%rsi, 8(%rcx)
	movq	%rdi, %rax
	movq	%rdi, -8(%rsp)
	incq	%rax
	movq	%rdx, 8(%rcx)
	retq
.Lfunc_end54:
	.size	"fn40:f1", .Lfunc_end54-"fn40:f1"
	.cfi_endproc
                                        # -- End function
	.globl	"fn41:f2"                       # -- Begin function fn41:f2
	.p2align	4, 0x90
	.type	"fn41:f2",@function
"fn41:f2":                              # @"fn41:f2"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rdx
	leaq	-16(%rsp), %rsi
	movq	%rsi, 8(%rcx)
	movq	%rdi, %rax
	movq	%rdi, -8(%rsp)
	decq	%rax
	movq	%rdx, 8(%rcx)
	retq
.Lfunc_end55:
	.size	"fn41:f2", .Lfunc_end55-"fn41:f2"
	.cfi_endproc
                                        # -- End function
	.globl	"_t:1_equality"                 # -- Begin function _t:1_equality
	.p2align	4, 0x90
	.type	"_t:1_equality",@function
"_t:1_equality":                        # @"_t:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB56_4
# %bb.1:                                # %body
	cmpq	$1, %rax
	je	.LBB56_6
# %bb.2:                                # %body
	cmpq	$2, %rax
	jne	.LBB56_7
# %bb.3:                                # %"case_t:1:T2"
	movq	8(%rsi), %rsi
	movq	8(%rdi), %rdi
	callq	"_t:1_equality"@PLT
                                        # kill: def $al killed $al def $eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB56_4:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB56_6:                               # %"case_t:1:T1"
	.cfi_def_cfa_offset 16
	movb	$1, %al
                                        # kill: def $al killed $al killed $eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB56_7:
	.cfi_def_cfa_offset 16
	leaq	.Lstr.96(%rip), %rbx
	.p2align	4, 0x90
.LBB56_8:                               # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$82, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB56_8
.Lfunc_end56:
	.size	"_t:1_equality", .Lfunc_end56-"_t:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"fn42:pt"                       # -- Begin function fn42:pt
	.p2align	4, 0x90
	.type	"fn42:pt",@function
"fn42:pt":                              # @"fn42:pt"
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
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %r15
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 24(%rsp)
	cmpq	$1, (%rdi)
	jne	.LBB57_2
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
	leaq	.Lstr.97(%rip), %rax
	movq	%rax, (%rbx)
	movq	$4, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	jmp	.LBB57_4
.LBB57_2:                               # %match_check_2
	cmpq	$2, (%rdi)
	jne	.LBB57_5
# %bb.3:                                # %match_param_check_2
	movq	8(%rdi), %rax
	movq	%rax, 16(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.98(%rip), %rax
	movq	%rax, (%rbx)
	movq	$4, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rdi
	callq	"fn42:pt"@PLT
.LBB57_4:                               # %match_finished
	movq	%r15, 8(%r14)
	addq	$32, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB57_5:                               # %match_failed.preheader
	.cfi_def_cfa_offset 64
	leaq	.Lstr.39(%rip), %rbx
	.p2align	4, 0x90
.LBB57_6:                               # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB57_6
.Lfunc_end57:
	.size	"fn42:pt", .Lfunc_end57-"fn42:pt"
	.cfi_endproc
                                        # -- End function
	.globl	"fn43:gen"                      # -- Begin function fn43:gen
	.p2align	4, 0x90
	.type	"fn43:gen",@function
"fn43:gen":                             # @"fn43:gen"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	andl	$1, %edi
	movb	%dil, 7(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rbx, 8(%r14)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end58:
	.size	"fn43:gen", .Lfunc_end58-"fn43:gen"
	.cfi_endproc
                                        # -- End function
	.globl	"fn44:gen"                      # -- Begin function fn44:gen
	.p2align	4, 0x90
	.type	"fn44:gen",@function
"fn44:gen":                             # @"fn44:gen"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	andb	$1, %dil
	movb	%dil, 15(%rsp)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 16(%rsp)
	movq	%rbx, 8(%r14)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end59:
	.size	"fn44:gen", .Lfunc_end59-"fn44:gen"
	.cfi_endproc
                                        # -- End function
	.globl	"fn45:pp"                       # -- Begin function fn45:pp
	.p2align	4, 0x90
	.type	"fn45:pp",@function
"fn45:pp":                              # @"fn45:pp"
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
	movq	%rdi, %r14
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %r13
	movq	%rsp, %rax
	movq	%rax, 8(%r12)
	movq	%rdi, 8(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 8(%rbx)
	movq	%rbx, 8(%r15)
	movq	%r15, (%r14)
	movq	8(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn42:pt"@PLT
	movq	%r13, 8(%r12)
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
.Lfunc_end60:
	.size	"fn45:pp", .Lfunc_end60-"fn45:pp"
	.cfi_endproc
                                        # -- End function
	.globl	"fn46:gen"                      # -- Begin function fn46:gen
	.p2align	4, 0x90
	.type	"fn46:gen",@function
"fn46:gen":                             # @"fn46:gen"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	andb	$1, %dil
	movb	%dil, 15(%rsp)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 16(%rsp)
	movq	%rbx, 8(%r14)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end61:
	.size	"fn46:gen", .Lfunc_end61-"fn46:gen"
	.cfi_endproc
                                        # -- End function
	.globl	"fn47:pp"                       # -- Begin function fn47:pp
	.p2align	4, 0x90
	.type	"fn47:pp",@function
"fn47:pp":                              # @"fn47:pp"
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
	movq	%rdi, %r14
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %r13
	movq	%rsp, %rax
	movq	%rax, 8(%r12)
	movq	%rdi, 8(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 8(%rbx)
	movq	%rbx, 8(%r15)
	movq	%r15, (%r14)
	movq	8(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn42:pt"@PLT
	movq	%r13, 8(%r12)
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
.Lfunc_end62:
	.size	"fn47:pp", .Lfunc_end62-"fn47:pp"
	.cfi_endproc
                                        # -- End function
	.globl	"fn48:gen"                      # -- Begin function fn48:gen
	.p2align	4, 0x90
	.type	"fn48:gen",@function
"fn48:gen":                             # @"fn48:gen"
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
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r15)
	andl	$1, %edi
	movb	%dil, 15(%rsp)
	movl	$48, %edi
	callq	malloc@PLT
	movq	%rax, %r14
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, 16(%rsp)
	movq	%r14, (%rbx)
	movq	$1, 8(%rbx)
	movq	$2, 16(%rbx)
	movq	$3, 24(%rbx)
	movq	16(%rsp), %rax
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
.Lfunc_end63:
	.size	"fn48:gen", .Lfunc_end63-"fn48:gen"
	.cfi_endproc
                                        # -- End function
	.globl	"fn49:pp"                       # -- Begin function fn49:pp
	.p2align	4, 0x90
	.type	"fn49:pp",@function
"fn49:pp":                              # @"fn49:pp"
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
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %r12
	movq	%rsp, %rax
	movq	%rax, 8(%r15)
	movq	%rdi, 8(%rsp)
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB64_4
# %bb.1:                                # %entry
	cmpq	$0, 8(%rdi)
	jle	.LBB64_4
# %bb.2:                                # %entry
	cmpq	$0, 16(%rdi)
	jle	.LBB64_4
# %bb.3:                                # %entry
	cmpq	$0, 24(%rdi)
	jle	.LBB64_4
# %bb.6:                                # %array_ref_bound_check_success
	movq	(%rdi), %r13
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r14
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 8(%rbx)
	movq	%rbx, 8(%r14)
	movq	%r14, (%r13)
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB64_10
# %bb.7:                                # %array_ref_bound_check_success
	movq	8(%rsp), %rax
	cmpq	$0, 8(%rax)
	jle	.LBB64_10
# %bb.8:                                # %array_ref_bound_check_success
	cmpq	$0, 16(%rax)
	jle	.LBB64_10
# %bb.9:                                # %array_ref_bound_check_success
	cmpq	$0, 24(%rax)
	jle	.LBB64_10
# %bb.12:                               # %array_ref_bound_check_success21
	movq	(%rax), %rax
	movq	(%rax), %rdi
	callq	"fn42:pt"@PLT
	movq	%r12, 8(%r15)
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
.LBB64_4:                               # %array_ref_bound_check_failed.preheader
	.cfi_def_cfa_offset 64
	leaq	.Lstr.15(%rip), %rbx
	.p2align	4, 0x90
.LBB64_5:                               # %array_ref_bound_check_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB64_5
.LBB64_10:                              # %array_ref_bound_check_failed20.preheader
	leaq	.Lstr.15(%rip), %rbx
	.p2align	4, 0x90
.LBB64_11:                              # %array_ref_bound_check_failed20
                                        # =>This Inner Loop Header: Depth=1
	movl	$54, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB64_11
.Lfunc_end64:
	.size	"fn49:pp", .Lfunc_end64-"fn49:pp"
	.cfi_endproc
                                        # -- End function
	.type	display_array,@object           # @display_array
	.bss
	.globl	display_array
	.p2align	4
display_array:
	.zero	32
	.size	display_array, 32

	.type	.Lstr,@object                   # @str
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lstr:
	.asciz	"Runtime Error: Division by zero\n"
	.size	.Lstr, 33

	.type	.Lstr.1,@object                 # @str.1
.Lstr.1:
	.asciz	"abc"
	.size	.Lstr.1, 4

	.type	.Lstr.2,@object                 # @str.2
.Lstr.2:
	.asciz	"abcd"
	.size	.Lstr.2, 5

	.type	.Lstr.3,@object                 # @str.3
.Lstr.3:
	.asciz	"Runtime Error: Non positive dimension size on array declaration\n"
	.size	.Lstr.3, 65

	.type	.Lstr.4,@object                 # @str.4
.Lstr.4:
	.asciz	"\n"
	.size	.Lstr.4, 2

	.type	.Lstr.5,@object                 # @str.5
.Lstr.5:
	.asciz	"a_int = "
	.size	.Lstr.5, 9

	.type	.Lstr.6,@object                 # @str.6
.Lstr.6:
	.asciz	"a_char = "
	.size	.Lstr.6, 10

	.type	.Lstr.7,@object                 # @str.7
.Lstr.7:
	.asciz	"a_bool = "
	.size	.Lstr.7, 10

	.type	.Lstr.8,@object                 # @str.8
.Lstr.8:
	.asciz	"a_float = "
	.size	.Lstr.8, 11

	.type	.Lstr.9,@object                 # @str.9
.Lstr.9:
	.asciz	"a_string = "
	.size	.Lstr.9, 12

	.type	.Lstr.10,@object                # @str.10
.Lstr.10:
	.asciz	"b_string = "
	.size	.Lstr.10, 12

	.type	.Lstr.11,@object                # @str.11
.Lstr.11:
	.asciz	"c_string = "
	.size	.Lstr.11, 12

	.type	.Lstr.12,@object                # @str.12
.Lstr.12:
	.asciz	"0 = !a_ref = "
	.size	.Lstr.12, 14

	.type	.Lstr.13,@object                # @str.13
.Lstr.13:
	.asciz	"(incr a_ref) 1 = "
	.size	.Lstr.13, 18

	.type	.Lstr.14,@object                # @str.14
.Lstr.14:
	.asciz	"(decr a_ref) 0 = "
	.size	.Lstr.14, 18

	.type	.Lstr.15,@object                # @str.15
.Lstr.15:
	.asciz	"Runtime Error: Out of bounds error in array ref call\n"
	.size	.Lstr.15, 54

	.type	.Lstr.16,@object                # @str.16
.Lstr.16:
	.asciz	"421 = !a_array[4,2,1] = "
	.size	.Lstr.16, 25

	.type	.Lstr.17,@object                # @str.17
.Lstr.17:
	.asciz	"2 = tf1 1 = "
	.size	.Lstr.17, 13

	.type	.Lstr.18,@object                # @str.18
.Lstr.18:
	.asciz	"1 = ta1[0] = "
	.size	.Lstr.18, 14

	.type	.Lstr.19,@object                # @str.19
.Lstr.19:
	.asciz	".... = "
	.size	.Lstr.19, 8

	.type	.Lstr.20,@object                # @str.20
.Lstr.20:
	.asciz	"[inside f8_f: "
	.size	.Lstr.20, 15

	.type	.Lstr.21,@object                # @str.21
.Lstr.21:
	.asciz	"c = "
	.size	.Lstr.21, 5

	.type	.Lstr.22,@object                # @str.22
.Lstr.22:
	.asciz	", b = "
	.size	.Lstr.22, 7

	.type	.Lstr.23,@object                # @str.23
.Lstr.23:
	.asciz	"] "
	.size	.Lstr.23, 3

	.type	.Lstr.24,@object                # @str.24
.Lstr.24:
	.asciz	"42 = !a_ref = "
	.size	.Lstr.24, 15

	.type	.Lstr.25,@object                # @str.25
.Lstr.25:
	.asciz	"42 = !a_array[0,0,0] = "
	.size	.Lstr.25, 24

	.type	.Lstr.26,@object                # @str.26
.Lstr.26:
	.asciz	"1.0 = f8 f8_f = "
	.size	.Lstr.26, 17

	.type	.Lstr.27,@object                # @str.27
.Lstr.27:
	.asciz	"Runtime Error: Invalid constructor of type color encountered in comparison operation\n"
	.size	.Lstr.27, 86

	.type	.Lstr.28,@object                # @str.28
.Lstr.28:
	.asciz	"Runtime Error: Invalid constructor of type number encountered in comparison operation\n"
	.size	.Lstr.28, 87

	.type	.Lstr.29,@object                # @str.29
.Lstr.29:
	.asciz	"Runtime Error: Invalid constructor of type list encountered in comparison operation\n"
	.size	.Lstr.29, 85

	.type	.Lstr.30,@object                # @str.30
.Lstr.30:
	.asciz	"Runtime Error: Invalid constructor of type tree encountered in comparison operation\n"
	.size	.Lstr.30, 85

	.type	.Lstr.31,@object                # @str.31
.Lstr.31:
	.asciz	"Runtime Error: Invalid constructor of type forest encountered in comparison operation\n"
	.size	.Lstr.31, 87

	.type	.Lstr.32,@object                # @str.32
.Lstr.32:
	.asciz	"Runtime Error: Invalid constructor of type a encountered in comparison operation\n"
	.size	.Lstr.32, 82

	.type	.Lstr.33,@object                # @str.33
.Lstr.33:
	.asciz	"Runtime Error: Invalid constructor of type b encountered in comparison operation\n"
	.size	.Lstr.33, 82

	.type	.Lstr.34,@object                # @str.34
.Lstr.34:
	.asciz	"Runtime Error: Invalid constructor of type c encountered in comparison operation\n"
	.size	.Lstr.34, 82

	.type	.Lstr.35,@object                # @str.35
.Lstr.35:
	.asciz	"Runtime Error: Invalid constructor of type opt encountered in comparison operation\n"
	.size	.Lstr.35, 84

	.type	.Lstr.36,@object                # @str.36
.Lstr.36:
	.asciz	"Red"
	.size	.Lstr.36, 4

	.type	.Lstr.37,@object                # @str.37
.Lstr.37:
	.asciz	"Green"
	.size	.Lstr.37, 6

	.type	.Lstr.38,@object                # @str.38
.Lstr.38:
	.asciz	"Blue"
	.size	.Lstr.38, 5

	.type	.Lstr.39,@object                # @str.39
.Lstr.39:
	.asciz	"Runtime Error: Given expression could not be matched with some clause\n"
	.size	.Lstr.39, 71

	.type	.Lstr.40,@object                # @str.40
.Lstr.40:
	.asciz	"A "
	.size	.Lstr.40, 3

	.type	.Lstr.41,@object                # @str.41
.Lstr.41:
	.asciz	"B "
	.size	.Lstr.41, 3

	.type	.Lstr.42,@object                # @str.42
.Lstr.42:
	.asciz	"Integer "
	.size	.Lstr.42, 9

	.type	.Lstr.43,@object                # @str.43
.Lstr.43:
	.asciz	"Real "
	.size	.Lstr.43, 6

	.type	.Lstr.44,@object                # @str.44
.Lstr.44:
	.asciz	"Complex "
	.size	.Lstr.44, 9

	.type	.Lstr.45,@object                # @str.45
.Lstr.45:
	.asciz	"Complex j"
	.size	.Lstr.45, 10

	.type	.Lstr.46,@object                # @str.46
.Lstr.46:
	.asciz	"+j"
	.size	.Lstr.46, 3

	.type	.Lstr.47,@object                # @str.47
.Lstr.47:
	.asciz	"-j"
	.size	.Lstr.47, 3

	.type	.Lstr.48,@object                # @str.48
.Lstr.48:
	.asciz	"Red = "
	.size	.Lstr.48, 7

	.type	.Lstr.49,@object                # @str.49
.Lstr.49:
	.asciz	"Blue = "
	.size	.Lstr.49, 8

	.type	.Lstr.50,@object                # @str.50
.Lstr.50:
	.asciz	"A 1 = "
	.size	.Lstr.50, 7

	.type	.Lstr.51,@object                # @str.51
.Lstr.51:
	.asciz	"B 2.1 = "
	.size	.Lstr.51, 9

	.type	.Lstr.52,@object                # @str.52
.Lstr.52:
	.asciz	"pmtype test:\n"
	.size	.Lstr.52, 14

	.type	.Lstr.53,@object                # @str.53
.Lstr.53:
	.asciz	"Integer 2 = "
	.size	.Lstr.53, 13

	.type	.Lstr.54,@object                # @str.54
.Lstr.54:
	.asciz	"Real 1.2345 = "
	.size	.Lstr.54, 15

	.type	.Lstr.55,@object                # @str.55
.Lstr.55:
	.asciz	"Complex 1.11 = "
	.size	.Lstr.55, 16

	.type	.Lstr.56,@object                # @str.56
.Lstr.56:
	.asciz	"Complex j2.22 = "
	.size	.Lstr.56, 17

	.type	.Lstr.57,@object                # @str.57
.Lstr.57:
	.asciz	"Complex 3.33-j4.44 = "
	.size	.Lstr.57, 22

	.type	.Lstr.58,@object                # @str.58
.Lstr.58:
	.asciz	"nat equality:\n"
	.size	.Lstr.58, 15

	.type	.Lstr.59,@object                # @str.59
.Lstr.59:
	.asciz	"true = "
	.size	.Lstr.59, 8

	.type	.Lstr.60,@object                # @str.60
.Lstr.60:
	.asciz	"false = "
	.size	.Lstr.60, 9

	.type	.Lstr.61,@object                # @str.61
.Lstr.61:
	.asciz	"nat inequality:\n"
	.size	.Lstr.61, 17

	.type	.Lstr.62,@object                # @str.62
.Lstr.62:
	.asciz	"struct equality:\n"
	.size	.Lstr.62, 18

	.type	.Lstr.63,@object                # @str.63
.Lstr.63:
	.asciz	"struct inequality:\n"
	.size	.Lstr.63, 20

	.type	.Lstr.64,@object                # @str.64
.Lstr.64:
	.asciz	"1 = dim 3 ar = "
	.size	.Lstr.64, 16

	.type	.Lstr.65,@object                # @str.65
.Lstr.65:
	.asciz	"1 = !(f9 1) = "
	.size	.Lstr.65, 15

	.type	.Lstr.66,@object                # @str.66
.Lstr.66:
	.asciz	"1 = const2 = "
	.size	.Lstr.66, 14

	.type	.Lstr.67,@object                # @str.67
.Lstr.67:
	.asciz	"while loop: (0 -> 10)\n"
	.size	.Lstr.67, 23

	.type	.Lstr.68,@object                # @str.68
.Lstr.68:
	.asciz	"for loop: (0 -> 5 -> 0)\n"
	.size	.Lstr.68, 25

	.type	.Lstr.69,@object                # @str.69
.Lstr.69:
	.asciz	"... = "
	.size	.Lstr.69, 7

	.type	.Lstr.70,@object                # @str.70
.Lstr.70:
	.asciz	"unary operators:\n"
	.size	.Lstr.70, 18

	.type	.Lstr.71,@object                # @str.71
.Lstr.71:
	.asciz	"1 = "
	.size	.Lstr.71, 5

	.type	.Lstr.72,@object                # @str.72
.Lstr.72:
	.asciz	"-1 = "
	.size	.Lstr.72, 6

	.type	.Lstr.73,@object                # @str.73
.Lstr.73:
	.asciz	"1.0 = "
	.size	.Lstr.73, 7

	.type	.Lstr.74,@object                # @str.74
.Lstr.74:
	.asciz	"-1.0 = "
	.size	.Lstr.74, 8

	.type	.Lstr.75,@object                # @str.75
.Lstr.75:
	.asciz	"binary operators:\n"
	.size	.Lstr.75, 19

	.type	.Lstr.76,@object                # @str.76
.Lstr.76:
	.asciz	"3 = "
	.size	.Lstr.76, 5

	.type	.Lstr.77,@object                # @str.77
.Lstr.77:
	.asciz	"2 = "
	.size	.Lstr.77, 5

	.type	.Lstr.78,@object                # @str.78
.Lstr.78:
	.asciz	"3.0 = "
	.size	.Lstr.78, 7

	.type	.Lstr.79,@object                # @str.79
.Lstr.79:
	.asciz	"2.0 = "
	.size	.Lstr.79, 7

	.type	.Lstr.80,@object                # @str.80
.Lstr.80:
	.asciz	"2.5 = "
	.size	.Lstr.80, 7

	.type	.Lstr.81,@object                # @str.81
.Lstr.81:
	.asciz	"25.0 = "
	.size	.Lstr.81, 8

	.type	.Lstr.82,@object                # @str.82
.Lstr.82:
	.asciz	"escaping in nested function example:\n"
	.size	.Lstr.82, 38

	.type	.Lstr.83,@object                # @str.83
.Lstr.83:
	.asciz	"6 = "
	.size	.Lstr.83, 5

	.type	.Lstr.84,@object                # @str.84
.Lstr.84:
	.asciz	"escaping for loop example:\n"
	.size	.Lstr.84, 28

	.type	.Lstr.85,@object                # @str.85
.Lstr.85:
	.asciz	": "
	.size	.Lstr.85, 3

	.type	.Lstr.86,@object                # @str.86
.Lstr.86:
	.asciz	"i"
	.size	.Lstr.86, 2

	.type	.Lstr.87,@object                # @str.87
.Lstr.87:
	.asciz	"j"
	.size	.Lstr.87, 2

	.type	.Lstr.88,@object                # @str.88
.Lstr.88:
	.asciz	"x"
	.size	.Lstr.88, 2

	.type	.Lstr.89,@object                # @str.89
.Lstr.89:
	.asciz	"a"
	.size	.Lstr.89, 2

	.type	.Lstr.90,@object                # @str.90
.Lstr.90:
	.asciz	"i + j + x + a"
	.size	.Lstr.90, 14

	.type	.Lstr.91,@object                # @str.91
.Lstr.91:
	.asciz	"Runtime Error: Invalid constructor of type nstd encountered in comparison operation\n"
	.size	.Lstr.91, 85

	.type	.Lstr.92,@object                # @str.92
.Lstr.92:
	.asciz	"escaping pattern match variable:\n"
	.size	.Lstr.92, 34

	.type	.Lstr.93,@object                # @str.93
.Lstr.93:
	.asciz	"T1 3 = "
	.size	.Lstr.93, 8

	.type	.Lstr.94,@object                # @str.94
.Lstr.94:
	.asciz	"T2 = "
	.size	.Lstr.94, 6

	.type	.Lstr.95,@object                # @str.95
.Lstr.95:
	.asciz	"0 = "
	.size	.Lstr.95, 5

	.type	.Lstr.96,@object                # @str.96
.Lstr.96:
	.asciz	"Runtime Error: Invalid constructor of type t encountered in comparison operation\n"
	.size	.Lstr.96, 82

	.type	.Lstr.97,@object                # @str.97
.Lstr.97:
	.asciz	"T1\n"
	.size	.Lstr.97, 4

	.type	.Lstr.98,@object                # @str.98
.Lstr.98:
	.asciz	"T2 "
	.size	.Lstr.98, 4

	.type	.Lstr.99,@object                # @str.99
.Lstr.99:
	.asciz	"T1 = "
	.size	.Lstr.99, 6

	.type	.Lstr.100,@object               # @str.100
.Lstr.100:
	.asciz	"T2 T1 = "
	.size	.Lstr.100, 9

	.type	.Lstr.101,@object               # @str.101
.Lstr.101:
	.asciz	"T2 T2 T1 = "
	.size	.Lstr.101, 12

	.section	".note.GNU-stack","",@progbits
