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
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2                               # -- Begin function main
.LCPI4_0:
	.long	0x4048f5c3                      # float 3.1400001
.LCPI4_1:
	.long	0x40a00000                      # float 5
.LCPI4_2:
	.long	0x40000000                      # float 2
.LCPI4_3:
	.long	0x3f800000                      # float 1
.LCPI4_4:
	.long	0xbf800000                      # float -1
.LCPI4_5:
	.long	0x40400000                      # float 3
.LCPI4_6:
	.long	0x40200000                      # float 2.5
.LCPI4_7:
	.long	0x40866666                      # float 4.19999981
.LCPI4_8:
	.long	0xc0866666                      # float -4.19999981
.LCPI4_9:
	.long	0x44dc8000                      # float 1764
.LCPI4_10:
	.long	0x42280000                      # float 42
.LCPI4_11:
	.long	0x40900000                      # float 4.5
	.text
	.globl	main
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
	subq	$600, %rsp                      # imm = 0x258
	.cfi_def_cfa_offset 656
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	callq	GC_init@PLT
	movq	display_array@GOTPCREL(%rip), %r13
	movq	(%r13), %rax
	movq	%rax, 208(%rsp)
	leaq	552(%rsp), %rax
	movq	%rax, (%r13)
	movw	$24832, 552(%rsp)               # imm = 0x6100
	movb	$1, 554(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_2(%rip), %rbx
	movq	%rbp, 192(%rsp)                 # 8-byte Spill
	movq	%rbx, (%rbp)
	movq	$4, 8(%rbp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbp, 200(%rsp)                 # 8-byte Spill
	movq	%rbx, (%rbp)
	movq	$4, 8(%rbp)
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
	movq	%rbx, 128(%rsp)                 # 8-byte Spill
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 56(%rsp)
	movl	$240, %edi
	callq	malloc@PLT
	movq	%rax, %rbx
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbp, 144(%rsp)
	movq	%rbx, (%rbp)
	movq	$5, 8(%rbp)
	movq	$3, 16(%rbp)
	movq	$2, 24(%rbp)
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_int@PLT
	movq	8(%r13), %rbp
	movq	%rsp, %r12
	movq	%r12, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r15
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_6(%rip), %rax
	movq	%rax, (%rbx)
	movq	$10, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r13), %rax
	movzbl	1(%rax), %edi
	callq	lla_print_char@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_7(%rip), %rax
	movq	%rax, (%rbx)
	movq	$10, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r13), %rax
	movzbl	2(%rax), %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
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
	movq	$11, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_0(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_9(%rip), %rax
	movq	%rax, (%rbx)
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	192(%rsp), %rdi                 # 8-byte Reload
	callq	lla_print_string@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, (%rbx)
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	200(%rsp), %rdi                 # 8-byte Reload
	callq	lla_print_string@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_11(%rip), %rax
	movq	%rax, (%rbx)
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	128(%rsp), %rdi                 # 8-byte Reload
	callq	lla_print_string@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movq	56(%rsp), %rax
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
	leaq	.L__unnamed_12(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	56(%rsp), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movq	56(%rsp), %rdi
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
	leaq	.L__unnamed_13(%rip), %rax
	movq	%rax, (%rbx)
	movq	$18, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	56(%rsp), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movq	56(%rsp), %rdi
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
	leaq	.L__unnamed_14(%rip), %rax
	movq	%rax, (%rbx)
	movq	$18, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	56(%rsp), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movq	144(%rsp), %rcx
	leaq	8(%rcx), %rax
	movq	%rax, 216(%rsp)
	movq	8(%rcx), %rdx
	leaq	16(%rcx), %rax
	movq	%rax, 224(%rsp)
	movq	16(%rcx), %rax
	movq	%rax, 360(%rsp)
	leaq	24(%rcx), %rsi
	movq	%rsi, 232(%rsp)
	movq	24(%rcx), %rcx
	movq	%rcx, 368(%rsp)
	cmpq	$5, %rdx
	jl	.LBB4_3
# %bb.1:
	cmpq	$3, %rax
	jl	.LBB4_3
# %bb.2:
	cmpq	$1, %rcx
	jle	.LBB4_3
# %bb.5:
	addq	%rcx, %rcx
	leaq	(%rcx,%rax,4), %rax
	movq	144(%rsp), %rcx
	movq	%rcx, 240(%rsp)
	movq	(%rcx), %rcx
	movq	$421, 8(%rcx,%rax,8)            # imm = 0x1A5
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_15(%rip), %rax
	movq	%rax, (%rbx)
	movq	$25, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	216(%rsp), %rax
	movq	(%rax), %rdx
	movq	224(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 376(%rsp)
	movq	232(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	%rcx, 384(%rsp)
	cmpq	$5, %rdx
	jl	.LBB4_8
# %bb.6:
	cmpq	$3, %rax
	jl	.LBB4_8
# %bb.7:
	cmpq	$1, %rcx
	jle	.LBB4_8
# %bb.10:
	addq	%rcx, %rcx
	leaq	(%rcx,%rax,4), %rax
	movq	240(%rsp), %rcx
	movq	(%rcx), %rcx
	movq	8(%rcx,%rax,8), %rdi
	callq	lla_print_int@PLT
	movq	8(%r13), %rbx
	movq	%r12, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbp)
	movq	$2, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, 8(%r13)
	movl	$3, %edi
	callq	"fn5:f1"@PLT
	movq	(%r13), %rax
	movq	$2, 8(%rax)
	movq	(%r13), %rbx
	movq	$1, 16(%rbx)
	movl	$1, %edi
	callq	GC_malloc@PLT
	movq	%rax, 24(%rbx)
	movq	(%r13), %r15
	movl	$8, %edi
	callq	malloc@PLT
	movq	%rax, %rbp
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, 32(%r15)
	movq	%rbp, (%rbx)
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
	leaq	.L__unnamed_16(%rip), %rax
	movq	%rax, (%rbx)
	movq	$13, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r13), %rax
	movq	8(%r13), %rcx
	movq	%r12, 8(%r13)
	movq	16(%rax), %rdi
	incq	%rdi
	movq	%rcx, 8(%r13)
	callq	lla_print_int@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_17(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r12, 392(%rsp)
	movq	(%r13), %rax
	movq	8(%r13), %rcx
	movq	%rcx, 248(%rsp)
	movq	%r12, 8(%r13)
	movq	32(%rax), %rax
	movq	%rax, 400(%rsp)
	cmpq	$0, 8(%rax)
	jle	.LBB4_11
# %bb.13:
	movq	(%rax), %rax
	movq	$1, (%rax)
	movq	248(%rsp), %rax
	movq	%rax, 8(%r13)
	movq	(%r13), %rax
	movq	32(%rax), %rax
	movq	%rax, 408(%rsp)
	cmpq	$0, 8(%rax)
	jle	.LBB4_14
# %bb.16:
	movq	(%rax), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	movq	8(%r13), %rbx
	movq	%r12, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r15
	movq	%r15, (%rbp)
	movq	$2, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_18(%rip), %rax
	movq	%rax, (%rbp)
	movq	$8, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movl	$4, %edi
	callq	"fn13:loop"@PLT
	movq	8(%r13), %rbx
	movq	%r12, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbp)
	movq	$2, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, 8(%r13)
	movq	56(%rsp), %rax
	movq	$42, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_19(%rip), %rax
	movq	%rax, (%rbp)
	movq	$15, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	8(%r13), %rax
	movq	%r12, 8(%r13)
	movq	56(%rsp), %rcx
	movq	(%rcx), %rdi
	movq	%rax, 8(%r13)
	callq	lla_print_int@PLT
	movq	8(%r13), %rbx
	movq	%r12, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbp)
	movq	$2, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, 8(%r13)
	movq	144(%rsp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, 256(%rsp)
	leaq	16(%rax), %rcx
	leaq	24(%rax), %rdx
	cmpq	$0, 8(%rax)
	movq	%rcx, 264(%rsp)
	movq	16(%rax), %rcx
	movq	%rdx, 272(%rsp)
	jle	.LBB4_19
# %bb.17:
	testq	%rcx, %rcx
	jle	.LBB4_19
# %bb.18:
	cmpq	$0, 24(%rax)
	jle	.LBB4_19
# %bb.21:
	movq	144(%rsp), %rax
	movq	%rax, 280(%rsp)
	movq	(%rax), %rax
	movq	$42, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_20(%rip), %rax
	movq	%rax, (%rbx)
	movq	$24, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r12, 416(%rsp)
	movq	8(%r13), %rax
	movq	%rax, 288(%rsp)
	movq	%r12, 8(%r13)
	movq	256(%rsp), %rax
	cmpq	$0, (%rax)
	jle	.LBB4_24
# %bb.22:
	movq	264(%rsp), %rax
	cmpq	$0, (%rax)
	jle	.LBB4_24
# %bb.23:
	movq	272(%rsp), %rax
	cmpq	$0, (%rax)
	jle	.LBB4_24
# %bb.26:                               # %NodeBlock3366
	movq	280(%rsp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rdi
	movq	288(%rsp), %rax
	movq	%rax, 8(%r13)
	callq	lla_print_int@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	%rax, %r15
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_21(%rip), %rax
	movq	%rax, (%rbx)
	movq	$17, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r13), %rax
	movq	8(%r13), %rbx
	movq	%r12, 8(%r13)
	movzbl	2(%rax), %esi
	movzbl	1(%rax), %edi
	callq	"fn17:f8_f"@PLT
	movq	%rbx, 8(%r13)
	callq	lla_print_float@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	$2, (%rax)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	$2, 8(%rbp)
	movq	%rax, 16(%rbp)
	movq	$1, 8(%rbx)
	movq	%rbp, 16(%rbx)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	$1, (%rax)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	$1, (%rax)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movq	$1, 8(%rax)
	movq	%rbp, 16(%rax)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r12
	movq	$2, (%rax)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	$2, (%rax)
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%r15, 8(%rbp)
	movq	%rax, 16(%rbp)
	movq	%rbx, 8(%r12)
	movq	%rbp, 16(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_22(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, %rdi
	callq	"fn18:p_color"@PLT
	movq	8(%r13), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r15
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_23(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movq	%rax, %rdi
	callq	"fn18:p_color"@PLT
	movq	8(%r13), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
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
	leaq	.L__unnamed_24(%rip), %rax
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
	movq	8(%r13), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_25(%rip), %rax
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
	movq	8(%r13), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_26(%rip), %rax
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
	leaq	.L__unnamed_27(%rip), %rax
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
	movq	8(%r13), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_28(%rip), %rax
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
	movq	8(%r13), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_29(%rip), %rax
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
	movq	8(%r13), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_30(%rip), %rax
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
	movq	8(%r13), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_31(%rip), %rax
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
	movq	8(%r13), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	$1, 8(%rax)
	movq	%rax, 16(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%r13, %r12
	movq	%rax, %r13
	movq	$2, (%rax)
	movl	$1066192077, 8(%rax)            # imm = 0x3F8CCCCD
	movq	%rax, 64(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	$1, 8(%rax)
	movq	%rax, 40(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movabsq	$4579260103035505869, %rbp      # imm = 0x3F8CCCCD3F8CCCCD
	movq	%rbp, 8(%rax)
	movq	%rax, 32(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movabsq	$4582862983596395725, %rcx      # imm = 0x3F99999A3F8CCCCD
	movq	%rcx, 8(%rax)
	movq	%rax, 48(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movq	%rbp, 8(%rax)
	movq	%rax, 72(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_32(%rip), %rax
	movq	%rax, (%rbp)
	movq	$15, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbp)
	movq	$8, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbx
	movq	%rsp, %rax
	movq	%rax, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbp)
	movq	$2, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbp)
	movq	$9, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	cmpq	%r13, 16(%rsp)
	movq	%r12, %r13
	movq	%rsp, %r12
	sete	%dil
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, %r12
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %r15
	movq	%r15, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	xorl	%edi, %edi
	cmpq	40(%rsp), %rax
	sete	%dil
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
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
	movq	%rbp, 8(%r13)
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
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	xorl	%edi, %edi
	cmpq	32(%rsp), %rax
	sete	%dil
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%rsp, %r15
	movq	%r15, 8(%r13)
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
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	xorl	%edi, %edi
	cmpq	48(%rsp), %rax
	sete	%dil
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r15, 8(%r13)
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
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_35(%rip), %rax
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
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%rsp, %r12
	movq	%r12, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r15
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	xorl	%edi, %edi
	cmpq	64(%rsp), %rax
	setne	%dil
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	movq	%r14, %r12
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %r14
	movq	%r14, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	xorl	%edi, %edi
	cmpq	40(%rsp), %rax
	setne	%dil
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%rsp, %r15
	movq	%r15, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r12, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r12, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r14, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	xorl	%edi, %edi
	cmpq	32(%rsp), %rax
	setne	%dil
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r15, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r12, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r12, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r14, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	xorl	%edi, %edi
	cmpq	48(%rsp), %rax
	setne	%dil
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r15, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r12, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r12, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_36(%rip), %rax
	movq	%rax, (%rbx)
	movq	$18, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r12, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r14, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	movq	%rax, 80(%rsp)
	movq	(%rax), %rax
	movq	%rax, 424(%rsp)
	cmpq	$2, %rax
	jge	.LBB4_27
# %bb.30:                               # %LeafBlock
	cmpq	$1, %rax
	jne	.LBB4_32
# %bb.31:                               # %LeafBlock._crit_edge
	movb	$1, 30(%rsp)
	jmp	.LBB4_35
.LBB4_3:                                # %.preheader3363
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_37(%rip), %rbx
	.p2align	4, 0x90
.LBB4_4:                                # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, (%rbp)
	movq	$54, 8(%rbp)
	movl	$1, %esi
	movq	%rbp, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_4
.LBB4_8:                                # %.preheader3362
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_37(%rip), %rbx
	.p2align	4, 0x90
.LBB4_9:                                # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, (%rbp)
	movq	$54, 8(%rbp)
	movl	$1, %esi
	movq	%rbp, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_9
.LBB4_11:                               # %.preheader3361
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_37(%rip), %rbx
	.p2align	4, 0x90
.LBB4_12:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, (%rbp)
	movq	$54, 8(%rbp)
	movl	$1, %esi
	movq	%rbp, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_12
.LBB4_14:                               # %.preheader3360
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_37(%rip), %rbx
	.p2align	4, 0x90
.LBB4_15:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, (%rbp)
	movq	$54, 8(%rbp)
	movl	$1, %esi
	movq	%rbp, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_15
.LBB4_19:                               # %.preheader3359
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_37(%rip), %rbx
	.p2align	4, 0x90
.LBB4_20:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, (%rbp)
	movq	$54, 8(%rbp)
	movl	$1, %esi
	movq	%rbp, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_20
.LBB4_24:                               # %.preheader3358
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_37(%rip), %rbx
	.p2align	4, 0x90
.LBB4_25:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, (%rbp)
	movq	$54, 8(%rbp)
	movl	$1, %esi
	movq	%rbp, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_25
.LBB4_27:                               # %NodeBlock
	cmpq	$3, %rax
	jge	.LBB4_28
# %bb.33:
	movq	16(%rsp), %rax
	movss	8(%rax), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm0, %xmm0
	setnp	94(%rsp)
	jmp	.LBB4_34
.LBB4_28:                               # %LeafBlock3364
	jne	.LBB4_32
# %bb.29:
	movq	16(%rsp), %rax
	movss	8(%rax), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	12(%rax), %xmm0
	setnp	95(%rsp)
.LBB4_34:
	setnp	30(%rsp)
.LBB4_35:
	movzbl	30(%rsp), %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%rsp, %r12
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	80(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 432(%rsp)
	movq	64(%rsp), %rcx
	movq	%rcx, 296(%rsp)
	cmpq	(%rcx), %rax
	jne	.LBB4_36
# %bb.37:                               # %NodeBlock3375
	cmpq	$2, %rax
	jge	.LBB4_38
# %bb.41:                               # %LeafBlock3369
	cmpq	$1, %rax
	jne	.LBB4_43
# %bb.42:
	movq	64(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	8(%rcx), %rcx
	cmpq	8(%rax), %rcx
	sete	96(%rsp)
	sete	6(%rsp)
	jmp	.LBB4_45
	.p2align	4, 0x90
.LBB4_32:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_32
.LBB4_36:                               # %._crit_edge
	movb	$0, 6(%rsp)
.LBB4_45:
	movzbl	6(%rsp), %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	80(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 440(%rsp)
	movq	40(%rsp), %rcx
	movq	%rcx, 304(%rsp)
	cmpq	(%rcx), %rax
	jne	.LBB4_46
# %bb.47:                               # %NodeBlock3384
	cmpq	$2, %rax
	jge	.LBB4_48
# %bb.51:                               # %LeafBlock3378
	cmpq	$1, %rax
	jne	.LBB4_53
# %bb.52:
	movq	40(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	8(%rcx), %rcx
	cmpq	8(%rax), %rcx
	sete	99(%rsp)
	sete	7(%rsp)
	jmp	.LBB4_55
.LBB4_46:                               # %._crit_edge3492
	movb	$0, 7(%rsp)
	jmp	.LBB4_55
.LBB4_38:                               # %NodeBlock3373
	cmpq	$3, %rax
	jge	.LBB4_39
# %bb.44:
	movq	64(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 97(%rsp)
	movb	%cl, 6(%rsp)
	jmp	.LBB4_45
.LBB4_48:                               # %NodeBlock3382
	cmpq	$3, %rax
	jge	.LBB4_49
# %bb.54:
	movq	40(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 100(%rsp)
	movb	%cl, 7(%rsp)
	jmp	.LBB4_55
.LBB4_39:                               # %LeafBlock3371
	jne	.LBB4_43
# %bb.40:
	movq	64(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rcx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%cl
	sete	%dl
	ucomiss	12(%rax), %xmm1
	setnp	%al
	sete	%bl
	andb	%al, %bl
	andb	%cl, %bl
	andb	%dl, %bl
	movb	%bl, 98(%rsp)
	movb	%bl, 6(%rsp)
	jmp	.LBB4_45
	.p2align	4, 0x90
.LBB4_43:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_43
.LBB4_49:                               # %LeafBlock3380
	jne	.LBB4_53
# %bb.50:
	movq	40(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rcx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%cl
	sete	%dl
	ucomiss	12(%rax), %xmm1
	setnp	%al
	sete	%bl
	andb	%al, %bl
	andb	%cl, %bl
	andb	%dl, %bl
	movb	%bl, 101(%rsp)
	movb	%bl, 7(%rsp)
.LBB4_55:
	movzbl	7(%rsp), %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	80(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 448(%rsp)
	movq	32(%rsp), %rcx
	movq	%rcx, 136(%rsp)
	cmpq	(%rcx), %rax
	jne	.LBB4_56
# %bb.57:                               # %NodeBlock3393
	cmpq	$2, %rax
	jge	.LBB4_58
# %bb.61:                               # %LeafBlock3387
	cmpq	$1, %rax
	jne	.LBB4_63
# %bb.62:
	movq	32(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	8(%rcx), %rcx
	cmpq	8(%rax), %rcx
	sete	102(%rsp)
	sete	8(%rsp)
	jmp	.LBB4_65
	.p2align	4, 0x90
.LBB4_53:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_53
.LBB4_56:                               # %._crit_edge3493
	movb	$0, 8(%rsp)
	jmp	.LBB4_65
.LBB4_58:                               # %NodeBlock3391
	cmpq	$3, %rax
	jge	.LBB4_59
# %bb.64:
	movq	32(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 103(%rsp)
	movb	%cl, 8(%rsp)
	jmp	.LBB4_65
.LBB4_59:                               # %LeafBlock3389
	jne	.LBB4_63
# %bb.60:
	movq	32(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rcx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%cl
	sete	%dl
	ucomiss	12(%rax), %xmm1
	setnp	%al
	sete	%bl
	andb	%al, %bl
	andb	%cl, %bl
	andb	%dl, %bl
	movb	%bl, 104(%rsp)
	movb	%bl, 8(%rsp)
.LBB4_65:
	movzbl	8(%rsp), %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	136(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 456(%rsp)
	movq	48(%rsp), %rcx
	movq	%rcx, 312(%rsp)
	cmpq	(%rcx), %rax
	jne	.LBB4_66
# %bb.67:                               # %NodeBlock3402
	cmpq	$2, %rax
	jge	.LBB4_68
# %bb.71:                               # %LeafBlock3396
	cmpq	$1, %rax
	jne	.LBB4_73
# %bb.72:
	movq	48(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	8(%rcx), %rcx
	cmpq	8(%rax), %rcx
	sete	105(%rsp)
	sete	9(%rsp)
	jmp	.LBB4_75
	.p2align	4, 0x90
.LBB4_63:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_63
.LBB4_66:                               # %._crit_edge3494
	movb	$0, 9(%rsp)
.LBB4_75:
	movzbl	9(%rsp), %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	136(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 464(%rsp)
	movq	72(%rsp), %rcx
	movq	%rcx, 320(%rsp)
	cmpq	(%rcx), %rax
	jne	.LBB4_76
# %bb.77:                               # %NodeBlock3411
	cmpq	$2, %rax
	jge	.LBB4_78
# %bb.81:                               # %LeafBlock3405
	cmpq	$1, %rax
	jne	.LBB4_83
# %bb.82:
	movq	72(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	8(%rcx), %rcx
	cmpq	8(%rax), %rcx
	sete	108(%rsp)
	sete	10(%rsp)
	jmp	.LBB4_85
.LBB4_76:                               # %._crit_edge3495
	movb	$0, 10(%rsp)
	jmp	.LBB4_85
.LBB4_68:                               # %NodeBlock3400
	cmpq	$3, %rax
	jge	.LBB4_69
# %bb.74:
	movq	48(%rsp), %rax
	movq	32(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 106(%rsp)
	movb	%cl, 9(%rsp)
	jmp	.LBB4_75
.LBB4_78:                               # %NodeBlock3409
	cmpq	$3, %rax
	jge	.LBB4_79
# %bb.84:
	movq	72(%rsp), %rax
	movq	32(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 109(%rsp)
	movb	%cl, 10(%rsp)
	jmp	.LBB4_85
.LBB4_69:                               # %LeafBlock3398
	jne	.LBB4_73
# %bb.70:
	movq	48(%rsp), %rax
	movq	32(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rcx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%cl
	sete	%dl
	ucomiss	12(%rax), %xmm1
	setnp	%al
	sete	%bl
	andb	%al, %bl
	andb	%cl, %bl
	andb	%dl, %bl
	movb	%bl, 107(%rsp)
	movb	%bl, 9(%rsp)
	jmp	.LBB4_75
	.p2align	4, 0x90
.LBB4_73:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_73
.LBB4_79:                               # %LeafBlock3407
	jne	.LBB4_83
# %bb.80:
	movq	72(%rsp), %rax
	movq	32(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rcx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%cl
	sete	%dl
	ucomiss	12(%rax), %xmm1
	setnp	%al
	sete	%bl
	andb	%al, %bl
	andb	%cl, %bl
	andb	%dl, %bl
	movb	%bl, 110(%rsp)
	movb	%bl, 10(%rsp)
.LBB4_85:                               # %NodeBlock3420
	movzbl	10(%rsp), %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbx
	movq	%r12, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbp)
	movq	$2, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_39(%rip), %rax
	movq	%rax, (%rbp)
	movq	$20, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbp)
	movq	$9, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	80(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 472(%rsp)
	cmpq	$2, %rax
	jge	.LBB4_86
# %bb.89:                               # %LeafBlock3414
	cmpq	$1, %rax
	jne	.LBB4_91
# %bb.90:                               # %LeafBlock3414._crit_edge
	movb	$1, 31(%rsp)
	jmp	.LBB4_94
	.p2align	4, 0x90
.LBB4_83:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_83
.LBB4_86:                               # %NodeBlock3418
	cmpq	$3, %rax
	jge	.LBB4_87
# %bb.92:
	movq	16(%rsp), %rax
	movss	8(%rax), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	%xmm0, %xmm0
	setnp	111(%rsp)
	jmp	.LBB4_93
.LBB4_87:                               # %LeafBlock3416
	jne	.LBB4_91
# %bb.88:
	movq	16(%rsp), %rax
	movss	8(%rax), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	12(%rax), %xmm0
	setnp	112(%rsp)
.LBB4_93:
	setnp	31(%rsp)
.LBB4_94:
	movb	31(%rsp), %al
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	80(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 480(%rsp)
	movq	296(%rsp), %rcx
	cmpq	(%rcx), %rax
	jne	.LBB4_95
# %bb.96:                               # %NodeBlock3429
	cmpq	$2, %rax
	jge	.LBB4_97
# %bb.100:                              # %LeafBlock3423
	cmpq	$1, %rax
	jne	.LBB4_102
# %bb.101:
	movq	64(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	8(%rcx), %rcx
	cmpq	8(%rax), %rcx
	sete	113(%rsp)
	sete	11(%rsp)
	jmp	.LBB4_104
	.p2align	4, 0x90
.LBB4_91:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_91
.LBB4_95:                               # %._crit_edge3496
	movb	$0, 11(%rsp)
.LBB4_104:
	movb	11(%rsp), %al
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	80(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 488(%rsp)
	movq	304(%rsp), %rcx
	cmpq	(%rcx), %rax
	jne	.LBB4_105
# %bb.106:                              # %NodeBlock3438
	cmpq	$2, %rax
	jge	.LBB4_107
# %bb.110:                              # %LeafBlock3432
	cmpq	$1, %rax
	jne	.LBB4_112
# %bb.111:
	movq	40(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	8(%rcx), %rcx
	cmpq	8(%rax), %rcx
	sete	116(%rsp)
	sete	12(%rsp)
	jmp	.LBB4_114
.LBB4_105:                              # %._crit_edge3497
	movb	$0, 12(%rsp)
	jmp	.LBB4_114
.LBB4_97:                               # %NodeBlock3427
	cmpq	$3, %rax
	jge	.LBB4_98
# %bb.103:
	movq	64(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 114(%rsp)
	movb	%cl, 11(%rsp)
	jmp	.LBB4_104
.LBB4_107:                              # %NodeBlock3436
	cmpq	$3, %rax
	jge	.LBB4_108
# %bb.113:
	movq	40(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 117(%rsp)
	movb	%cl, 12(%rsp)
	jmp	.LBB4_114
.LBB4_98:                               # %LeafBlock3425
	jne	.LBB4_102
# %bb.99:
	movq	64(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rcx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%cl
	sete	%dl
	ucomiss	12(%rax), %xmm1
	setnp	%al
	sete	%bl
	andb	%al, %bl
	andb	%cl, %bl
	andb	%dl, %bl
	movb	%bl, 115(%rsp)
	movb	%bl, 11(%rsp)
	jmp	.LBB4_104
	.p2align	4, 0x90
.LBB4_102:                              # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_102
.LBB4_108:                              # %LeafBlock3434
	jne	.LBB4_112
# %bb.109:
	movq	40(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rcx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%cl
	sete	%dl
	ucomiss	12(%rax), %xmm1
	setnp	%al
	sete	%bl
	andb	%al, %bl
	andb	%cl, %bl
	andb	%dl, %bl
	movb	%bl, 118(%rsp)
	movb	%bl, 12(%rsp)
.LBB4_114:
	movb	12(%rsp), %al
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	80(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 496(%rsp)
	movq	136(%rsp), %rcx
	cmpq	(%rcx), %rax
	jne	.LBB4_115
# %bb.116:                              # %NodeBlock3447
	cmpq	$2, %rax
	jge	.LBB4_117
# %bb.120:                              # %LeafBlock3441
	cmpq	$1, %rax
	jne	.LBB4_122
# %bb.121:
	movq	32(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	8(%rcx), %rcx
	cmpq	8(%rax), %rcx
	sete	119(%rsp)
	sete	13(%rsp)
	jmp	.LBB4_124
	.p2align	4, 0x90
.LBB4_112:                              # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_112
.LBB4_115:                              # %._crit_edge3498
	movb	$0, 13(%rsp)
	jmp	.LBB4_124
.LBB4_117:                              # %NodeBlock3445
	cmpq	$3, %rax
	jge	.LBB4_118
# %bb.123:
	movq	32(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 120(%rsp)
	movb	%cl, 13(%rsp)
	jmp	.LBB4_124
.LBB4_118:                              # %LeafBlock3443
	jne	.LBB4_122
# %bb.119:
	movq	32(%rsp), %rax
	movq	16(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rcx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%cl
	sete	%dl
	ucomiss	12(%rax), %xmm1
	setnp	%al
	sete	%bl
	andb	%al, %bl
	andb	%cl, %bl
	andb	%dl, %bl
	movb	%bl, 121(%rsp)
	movb	%bl, 13(%rsp)
.LBB4_124:
	movb	13(%rsp), %al
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	136(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 504(%rsp)
	movq	312(%rsp), %rcx
	cmpq	(%rcx), %rax
	jne	.LBB4_125
# %bb.126:                              # %NodeBlock3456
	cmpq	$2, %rax
	jge	.LBB4_127
# %bb.130:                              # %LeafBlock3450
	cmpq	$1, %rax
	jne	.LBB4_132
# %bb.131:
	movq	48(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	8(%rcx), %rcx
	cmpq	8(%rax), %rcx
	sete	122(%rsp)
	sete	14(%rsp)
	jmp	.LBB4_134
	.p2align	4, 0x90
.LBB4_122:                              # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_122
.LBB4_125:                              # %._crit_edge3499
	movb	$0, 14(%rsp)
	jmp	.LBB4_134
.LBB4_127:                              # %NodeBlock3454
	cmpq	$3, %rax
	jge	.LBB4_128
# %bb.133:
	movq	48(%rsp), %rax
	movq	32(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 123(%rsp)
	movb	%cl, 14(%rsp)
	jmp	.LBB4_134
.LBB4_128:                              # %LeafBlock3452
	jne	.LBB4_132
# %bb.129:
	movq	48(%rsp), %rax
	movq	32(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rcx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%cl
	sete	%dl
	ucomiss	12(%rax), %xmm1
	setnp	%al
	sete	%bl
	andb	%al, %bl
	andb	%cl, %bl
	andb	%dl, %bl
	movb	%bl, 124(%rsp)
	movb	%bl, 14(%rsp)
.LBB4_134:
	movb	14(%rsp), %al
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	136(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 512(%rsp)
	movq	320(%rsp), %rcx
	cmpq	(%rcx), %rax
	jne	.LBB4_135
# %bb.136:                              # %NodeBlock3465
	cmpq	$2, %rax
	jge	.LBB4_137
# %bb.140:                              # %LeafBlock3459
	cmpq	$1, %rax
	jne	.LBB4_142
# %bb.141:
	movq	72(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	8(%rcx), %rcx
	cmpq	8(%rax), %rcx
	sete	125(%rsp)
	sete	15(%rsp)
	jmp	.LBB4_144
	.p2align	4, 0x90
.LBB4_132:                              # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_132
.LBB4_135:                              # %._crit_edge3500
	movb	$0, 15(%rsp)
	jmp	.LBB4_144
.LBB4_137:                              # %NodeBlock3463
	cmpq	$3, %rax
	jge	.LBB4_138
# %bb.143:
	movq	72(%rsp), %rax
	movq	32(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 126(%rsp)
	movb	%cl, 15(%rsp)
	jmp	.LBB4_144
.LBB4_138:                              # %LeafBlock3461
	jne	.LBB4_142
# %bb.139:
	movq	72(%rsp), %rax
	movq	32(%rsp), %rcx
	movss	8(%rcx), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rcx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rax), %xmm0
	setnp	%cl
	sete	%dl
	ucomiss	12(%rax), %xmm1
	setnp	%al
	sete	%bl
	andb	%al, %bl
	andb	%cl, %bl
	andb	%dl, %bl
	movb	%bl, 127(%rsp)
	movb	%bl, 15(%rsp)
.LBB4_144:
	movb	15(%rsp), %al
	xorb	$1, %al
	movzbl	%al, %edi
	callq	lla_print_bool@PLT
	movq	8(%r13), %rbx
	movq	%r12, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbp)
	movq	$2, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, 8(%r13)
	movl	$1, %edi
	callq	malloc@PLT
	movq	%rax, %rbp
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbp, (%rbx)
	movq	$1, 8(%rbx)
	movq	$1, 16(%rbx)
	movq	$1, 24(%rbx)
	movl	$8, %edi
	callq	malloc@PLT
	movq	%rax, %rbx
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, (%rbp)
	movq	$1, 8(%rbp)
	movq	$1, 16(%rbp)
	movq	"fn24:f"@GOTPCREL(%rip), %rax
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
	leaq	.L__unnamed_40(%rip), %rax
	movq	%rax, (%rbx)
	movq	$15, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	"fn22:f9"@PLT
	movq	%rax, 520(%rsp)
	cmpq	$0, 8(%rax)
	jle	.LBB4_146
# %bb.145:
	cmpq	$0, 16(%rax)
	jle	.LBB4_146
# %bb.148:                              # %.preheader3356
	movq	(%rax), %rax
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	%rax, %r14
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_41(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_int@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	%rbp, 8(%r13)
	movl	$1, %edi
	callq	malloc@PLT
	movq	%rax, %rbx
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, (%rbp)
	movq	$1, 8(%rbp)
	movq	$1, 16(%rbp)
	movq	$1, 24(%rbp)
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_42(%rip), %rax
	movq	%rax, (%rbx)
	movq	$16, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
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
	movq	%rbp, 8(%r13)
	movl	$10, %edi
	callq	"fn27:while_test"@PLT
	movl	$5, %edi
	callq	"fn28:for_test"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_43(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r12, 528(%rsp)
	movq	8(%r13), %rax
	movq	%rax, 184(%rsp)
	movq	%r12, 8(%r13)
	movl	$46, %edi
	callq	lla_print_char@PLT
	movl	$46, %edi
	callq	lla_print_char@PLT
	movl	$46, %edi
	callq	lla_print_char@PLT
	movq	184(%rsp), %rax
	movq	%rax, 8(%r13)
	movq	%r12, 8(%r13)
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
	movq	184(%rsp), %rax
	movq	%rax, 8(%r13)
	movl	$1, %edi
	callq	GC_malloc@PLT
	movb	$1, (%rax)
	movss	.LCPI4_1(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	movss	.LCPI4_2(%rip), %xmm1           # xmm1 = mem[0],zero,zero,zero
	callq	lla_pow@PLT
	movss	%xmm0, 128(%rsp)                # 4-byte Spill
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_44(%rip), %rax
	movq	%rax, (%rbx)
	movq	$18, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_45(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_int@PLT
	movq	8(%r13), %rbp
	movq	%r12, 8(%r13)
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
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r12, %r14
	movq	%r13, %r12
	leaq	.L__unnamed_46(%rip), %rax
	movq	%rax, (%rbx)
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	$-1, %rdi
	callq	lla_print_int@PLT
	movq	8(%r13), %rbp
	movq	%r14, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	movq	%r15, %r13
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_47(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_3(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movq	%r14, %r15
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	movq	%r13, %r14
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r13
	movq	%r13, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_48(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_4(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	movq	8(%r12), %rbp
	movq	%r15, 8(%r12)
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
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %r15
	movq	%r15, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %r15
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r13, (%rbx)
	movq	%r13, %r14
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %r13
	movq	%r13, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %r13
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r14, (%rbx)
	movq	%r14, %r15
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_49(%rip), %rax
	movq	%rax, (%rbx)
	movq	$19, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_50(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$3, %edi
	callq	lla_print_int@PLT
	movq	8(%r12), %rbp
	movq	%rsp, %r14
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_46(%rip), %rax
	movq	%rax, (%rbx)
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	$-1, %rdi
	callq	lla_print_int@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_51(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$2, %edi
	callq	lla_print_int@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_51(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$2, %edi
	callq	lla_print_int@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_52(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_5(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_48(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_4(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_53(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_2(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_54(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_6(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_45(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_int@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_55(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	128(%rsp), %xmm0                # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %r15
	movq	%r15, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r15
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	%r15, %r14
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%rsp, %r15
	movq	%r15, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r14, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%r15, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r14, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%r15, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r14, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%r15, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r14, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%r15, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r14, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_34(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%r15, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r14, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_33(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_bool@PLT
	movq	8(%r12), %rbp
	movq	%r15, 8(%r12)
	movq	%r15, %r14
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r15
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_45(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	lla_print_int@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_56(%rip), %rax
	movq	%rax, (%rbx)
	movq	$38, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_57(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%r12), %rax
	movq	16(%r12), %rcx
	leaq	544(%rsp), %rdx
	movq	%rdx, 8(%r12)
	leaq	336(%rsp), %r15
	movq	%r15, 16(%r12)
	movq	%rcx, 16(%r12)
	movq	%rax, 8(%r12)
	movl	$6, %edi
	callq	lla_print_int@PLT
	movq	8(%r12), %rbp
	movq	%r14, 8(%r12)
	movq	%r12, %r14
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movq	(%r12), %rax
	movq	$2, 40(%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_58(%rip), %rax
	movq	%rax, (%rbx)
	movq	$28, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r15, 536(%rsp)
	movq	8(%r12), %rax
	movq	%rax, 328(%rsp)
	movq	%r15, 8(%r12)
	movq	$1, 336(%rsp)
	leaq	344(%rsp), %rax
	movq	%rax, 152(%rsp)
	movq	$1, 344(%rsp)
	leaq	352(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	$1, 352(%rsp)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	160(%rsp), %rax
	movq	$2, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	160(%rsp), %rax
	movq	$3, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	160(%rsp), %rax
	movq	$4, (%rax)
	movq	152(%rsp), %rax
	movq	$2, (%rax)
	movq	8(%r12), %rax
	leaq	16(%rax), %rcx
	movq	%rcx, 168(%rsp)
	movq	$1, 16(%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	168(%rsp), %rax
	movq	$2, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	168(%rsp), %rax
	movq	$3, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	168(%rsp), %rax
	movq	$4, (%rax)
	movq	152(%rsp), %rax
	movq	$3, (%rax)
	movq	8(%r12), %rax
	leaq	16(%rax), %rcx
	movq	%rcx, 176(%rsp)
	movq	$1, 16(%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	176(%rsp), %rax
	movq	$2, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	176(%rsp), %rax
	movq	$3, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	176(%rsp), %rax
	movq	$4, (%rax)
	movq	152(%rsp), %rax
	movq	$4, (%rax)
	movq	328(%rsp), %rax
	movq	%rax, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %r15
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, (%rbx)
	movq	$34, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_60(%rip), %rax
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
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_61(%rip), %rax
	movq	%rax, (%rbx)
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$2, (%rax)
	movq	%rax, %rdi
	callq	"fn37:f"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_51(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%r12), %rbp
	movq	%rsp, %r12
	movq	%r12, 8(%r14)
	movl	$1, %edi
	callq	"fn40:f1"@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r13
	movq	%r13, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_62(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$1, %edi
	callq	"fn41:f2"@PLT
	movq	%rax, %rdi
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
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	movq	%r15, %r12
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_63(%rip), %rax
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
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_64(%rip), %rax
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
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_65(%rip), %rax
	movq	%rax, (%rbx)
	movq	%rax, %r13
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 8(%rbp)
	movq	%rbp, 8(%rbx)
	movq	%rbx, %rdi
	callq	"fn42:pt"@PLT
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
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	$2, (%rax)
	movq	8(%r14), %r15
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%r15, 8(%r14)
	movq	%rax, 8(%rbp)
	movq	%rbp, 8(%rbx)
	movq	%rbx, %rdi
	callq	"fn42:pt"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r12, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r13, (%rbx)
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%r14), %r13
	movq	%rsp, %r12
	movq	%r12, 8(%r14)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	%r13, 8(%r14)
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 8(%rbx)
	movq	%rbx, 8(%rbp)
	movq	%rbp, (%r15)
	movq	%rbp, %rdi
	callq	"fn42:pt"@PLT
	movq	%r13, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_65(%rip), %rax
	movq	%rax, (%rbx)
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%r14), %r13
	movq	%r12, 8(%r14)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	%r13, 8(%r14)
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 8(%rbx)
	movq	%rbx, 8(%rbp)
	movq	%rbp, (%r15)
	movq	%rbp, %rdi
	callq	"fn42:pt"@PLT
	movq	%r13, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r13
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_65(%rip), %rax
	movq	%rax, (%rbx)
	movq	$12, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	"fn48:gen"@PLT
	movq	%rax, %rdi
	callq	"fn49:pp"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_66(%rip), %rax
	movq	%rax, (%rbx)
	movq	$13, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_read_int@PLT
	movq	%rax, %rbx
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_67(%rip), %rax
	movq	%rax, (%rbp)
	movq	$15, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r15
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_read_bool@PLT
	movl	%eax, %ebx
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_69(%rip), %rax
	movq	%rax, (%rbp)
	movq	$16, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movzbl	%bl, %edi
	callq	lla_print_bool@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_70(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_read_char@PLT
	movl	%eax, %ebx
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_71(%rip), %rax
	movq	%rax, (%rbp)
	movq	$16, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movzbl	%bl, %edi
	callq	lla_print_char@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_72(%rip), %rax
	movq	%rax, (%rbx)
	movq	$15, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_read_float@PLT
	movss	%xmm0, 128(%rsp)                # 4-byte Spill
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_73(%rip), %rax
	movq	%rax, (%rbx)
	movq	$17, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	128(%rsp), %xmm0                # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_74(%rip), %rax
	movq	%rax, (%rbx)
	movq	$27, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$3, %edi
	callq	malloc@PLT
	movq	%rax, %rbp
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbp, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_read_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_75(%rip), %rax
	movq	%rax, (%rbp)
	movq	$18, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_76(%rip), %rax
	movq	%rax, (%rbx)
	movq	$16, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$42, %edi
	callq	lla_abs@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_77(%rip), %rax
	movq	%rax, (%rbx)
	movq	$17, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	$-42, %rdi
	callq	lla_abs@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_78(%rip), %rax
	movq	%rax, (%rbx)
	movq	$19, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_7(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_fabs@PLT
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_79(%rip), %rax
	movq	%rax, (%rbx)
	movq	$21, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_8(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_fabs@PLT
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_80(%rip), %rax
	movq	%rax, (%rbx)
	movq	$29, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_9(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_sqrt@PLT
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_81(%rip), %rax
	movq	%rax, (%rbx)
	movq	$34, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_10(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	callq	lla_sin@PLT
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_82(%rip), %rax
	movq	%rax, (%rbx)
	movq	$21, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_10(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	callq	lla_cos@PLT
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_83(%rip), %rax
	movq	%rax, (%rbx)
	movq	$21, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_10(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	callq	lla_tan@PLT
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_84(%rip), %rax
	movq	%rax, (%rbx)
	movq	$22, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_10(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	callq	lla_atan@PLT
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_85(%rip), %rax
	movq	%rax, (%rbx)
	movq	$20, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_7(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_exp@PLT
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_86(%rip), %rax
	movq	%rax, (%rbx)
	movq	$20, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_10(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	callq	lla_ln@PLT
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_87(%rip), %rax
	movq	%rax, (%rbx)
	movq	$17, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_pi@PLT
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_88(%rip), %rax
	movq	%rax, (%rbp)
	movq	$14, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	$0, (%r15)
	xorl	%edi, %edi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbx
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbp)
	movq	$2, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_89(%rip), %rax
	movq	%rax, (%rbp)
	movq	$16, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%r15, %rdi
	callq	lla_incr@PLT
	movq	(%r15), %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbx
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbp)
	movq	$2, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_90(%rip), %rax
	movq	%rax, (%rbp)
	movq	$16, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%r15, %rdi
	callq	lla_decr@PLT
	movq	(%r15), %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r15
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_91(%rip), %rax
	movq	%rax, (%rbx)
	movq	$26, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$42, %edi
	callq	lla_float_of_int@PLT
	callq	lla_print_float@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_92(%rip), %rax
	movq	%rax, (%rbx)
	movq	$26, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_10(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	callq	lla_int_of_float@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_93(%rip), %rax
	movq	%rax, (%rbx)
	movq	$17, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_7(%rip), %xmm0           # xmm0 = mem[0],zero,zero,zero
	callq	lla_round@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_94(%rip), %rax
	movq	%rax, (%rbx)
	movq	$17, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	.LCPI4_11(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
	callq	lla_round@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_95(%rip), %rax
	movq	%rax, (%rbx)
	movq	$24, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$97, %edi
	callq	lla_int_of_char@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_96(%rip), %rax
	movq	%rax, (%rbx)
	movq	$22, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$97, %edi
	callq	lla_char_of_int@PLT
	movzbl	%al, %edi
	callq	lla_print_char@PLT
	movq	8(%r14), %rbp
	movq	%r12, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	%r15, %r12
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_97(%rip), %rax
	movq	%rax, (%rbx)
	movq	$22, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_98(%rip), %r15
	movq	%r15, (%rbx)
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_strlen@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r12, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_99(%rip), %rax
	movq	%rax, (%rbx)
	movq	$30, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$6, 8(%rbx)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbp)
	movq	$6, 8(%rbp)
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	lla_strcmp@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r12, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_100(%rip), %rax
	movq	%rax, (%rbx)
	movq	$31, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$6, 8(%rbx)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_101(%rip), %r12
	movq	%r12, (%rbp)
	movq	$6, 8(%rbp)
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	lla_strcmp@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%rsp, %r15
	movq	%r15, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_102(%rip), %rax
	movq	%rax, (%rbx)
	movq	$31, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r12, (%rbx)
	movq	$6, 8(%rbx)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_98(%rip), %r12
	movq	%r12, (%rbp)
	movq	$6, 8(%rbp)
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	lla_strcmp@PLT
	movq	%rax, %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %rbp
	movq	%r15, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r15
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$6, %edi
	callq	malloc@PLT
	movq	%rax, %rbp
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbp, (%rbx)
	movq	$6, 8(%rbx)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_103(%rip), %rax
	movq	%rax, (%rbp)
	movq	$41, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r12, (%rbp)
	movq	$6, 8(%rbp)
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	lla_strcpy@PLT
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%r14), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_104(%rip), %rax
	movq	%rax, (%rbx)
	movq	$64, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$20, %edi
	callq	malloc@PLT
	movq	%rax, %rbp
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbp, (%rbx)
	movq	$20, 8(%rbx)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r12, (%rbp)
	movq	$6, 8(%rbp)
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	lla_strcpy@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_105(%rip), %rax
	movq	%rax, (%rbp)
	movq	$7, 8(%rbp)
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	lla_strcat@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_106(%rip), %rax
	movq	%rax, (%rbp)
	movq	$63, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%r14), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_107(%rip), %rax
	movq	%rax, (%rbx)
	movq	$65, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$1, %edi
	callq	malloc@PLT
	movq	%rax, %rbp
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbp, (%rbx)
	movq	$1, 8(%rbx)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r12, (%rbp)
	movq	$6, 8(%rbp)
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	lla_strcpy@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_105(%rip), %rax
	movq	%rax, (%rbp)
	movq	$7, 8(%rbp)
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	lla_strcat@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_108(%rip), %rax
	movq	%rax, (%rbp)
	movq	$62, 8(%rbp)
	movq	%rbp, %rdi
	callq	lla_print_string@PLT
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%r14), %rbp
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r14)
	movq	208(%rsp), %rax
	movq	%rax, (%r14)
	xorl	%eax, %eax
	addq	$600, %rsp                      # imm = 0x258
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
	.p2align	4, 0x90
.LBB4_142:                              # =>This Inner Loop Header: Depth=1
	.cfi_def_cfa_offset 656
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_142
.LBB4_146:                              # %.preheader3357
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_37(%rip), %rbx
	.p2align	4, 0x90
.LBB4_147:                              # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbp
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbx, (%rbp)
	movq	$54, 8(%rbp)
	movl	$1, %esi
	movq	%rbp, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB4_147
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function
	.globl	"fn1:nl"                        # -- Begin function fn1:nl
	.p2align	4, 0x90
	.type	"fn1:nl",@function
"fn1:nl":                               # @"fn1:nl"
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
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %r15
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
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
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %r14
	leaq	8(%rsp), %r15
	movq	%r15, 8(%rbx)
	movq	%rdi, 8(%rsp)
	movq	%rsp, %rax
	movq	%rax, 8(%rbx)
	movl	$1, %edi
	callq	"fn2:f1_1"@PLT
	movq	%r15, 8(%rbx)
	movq	8(%rsp), %rax
	movq	%r14, 8(%rbx)
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end6:
	.size	"fn2:f1_1", .Lfunc_end6-"fn2:f1_1"
                                        # -- End function
	.globl	"fn3:f2_1"                      # -- Begin function fn3:f2_1
	.p2align	4, 0x90
	.type	"fn3:f2_1",@function
"fn3:f2_1":                             # @"fn3:f2_1"
# %bb.0:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rbx
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	callq	"fn2:f1_1"@PLT
	movq	%rbx, 8(%r14)
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end7:
	.size	"fn3:f2_1", .Lfunc_end7-"fn3:f2_1"
                                        # -- End function
	.globl	"fn4:g"                         # -- Begin function fn4:g
	.p2align	4, 0x90
	.type	"fn4:g",@function
"fn4:g":                                # @"fn4:g"
# %bb.0:
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rax
	movq	16(%rcx), %rdx
	leaq	-8(%rsp), %rsi
	movq	%rsi, 16(%rcx)
	movq	(%rax), %rax
	movq	%rdx, 16(%rcx)
	retq
.Lfunc_end8:
	.size	"fn4:g", .Lfunc_end8-"fn4:g"
                                        # -- End function
	.globl	"fn5:f1"                        # -- Begin function fn5:f1
	.p2align	4, 0x90
	.type	"fn5:f1",@function
"fn5:f1":                               # @"fn5:f1"
# %bb.0:
	pushq	%rbx
	subq	$32, %rsp
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %rax
	movq	%rax, 24(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 8(%rbx)
	testq	%rdi, %rdi
	je	.LBB9_1
# %bb.2:
	decq	%rdi
	callq	"fn5:f1"@PLT
	andb	$1, %al
	movb	%al, 23(%rsp)
	jmp	.LBB9_3
.LBB9_1:
	movq	(%rbx), %rax
	movb	(%rax), %al
	movb	%al, 22(%rsp)
.LBB9_3:
	movb	%al, 15(%rsp)
	movq	24(%rsp), %rax
	movq	%rax, 8(%rbx)
	movb	15(%rsp), %al
	addq	$32, %rsp
	popq	%rbx
	retq
.Lfunc_end9:
	.size	"fn5:f1", .Lfunc_end9-"fn5:f1"
                                        # -- End function
	.globl	"fn6:f2"                        # -- Begin function fn6:f2
	.p2align	4, 0x90
	.type	"fn6:f2",@function
"fn6:f2":                               # @"fn6:f2"
# %bb.0:
	pushq	%rbx
	subq	$64, %rsp
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %rax
	movq	%rax, 32(%rsp)
	testq	%rdi, %rdi
	je	.LBB10_1
# %bb.2:
	leaq	8(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	%rax, 8(%rbx)
	cmpq	$1, %rdi
	jne	.LBB10_4
# %bb.3:                                # %._crit_edge2
	movq	$2, 16(%rsp)
	jmp	.LBB10_5
.LBB10_1:                               # %._crit_edge
	movq	$1, 24(%rsp)
	jmp	.LBB10_6
.LBB10_4:
	addq	$-2, %rdi
	callq	"fn6:f2"@PLT
	movq	%rax, 48(%rsp)
	movq	%rax, 16(%rsp)
.LBB10_5:
	movq	16(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	%rax, 24(%rsp)
.LBB10_6:
	movq	24(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	%rcx, 8(%rbx)
	addq	$64, %rsp
	popq	%rbx
	retq
.Lfunc_end10:
	.size	"fn6:f2", .Lfunc_end10-"fn6:f2"
                                        # -- End function
	.globl	"fn7:f3"                        # -- Begin function fn7:f3
	.p2align	4, 0x90
	.type	"fn7:f3",@function
"fn7:f3":                               # @"fn7:f3"
# %bb.0:
	pushq	%rbx
	subq	$32, %rsp
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %rax
	movq	%rax, 16(%rsp)
	movq	%rsp, %rax
	movq	%rax, 8(%rbx)
	testq	%rdi, %rdi
	je	.LBB11_1
# %bb.2:
	decq	%rdi
	callq	"fn6:f2"@PLT
	movq	%rax, 24(%rsp)
	movq	%rax, 8(%rsp)
	jmp	.LBB11_3
.LBB11_1:                               # %._crit_edge
	movq	$2, 8(%rsp)
.LBB11_3:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rcx, 8(%rbx)
	addq	$32, %rsp
	popq	%rbx
	retq
.Lfunc_end11:
	.size	"fn7:f3", .Lfunc_end11-"fn7:f3"
                                        # -- End function
	.globl	"fn8:f4"                        # -- Begin function fn8:f4
	.p2align	4, 0x90
	.type	"fn8:f4",@function
"fn8:f4":                               # @"fn8:f4"
# %bb.0:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	(%rbx), %rax
	movq	8(%rbx), %r14
	movq	%rsp, %rcx
	movq	%rcx, 8(%rbx)
	movq	8(%rax), %rdi
	movq	%rcx, 8(%rbx)
	callq	"fn8:f4"@PLT
	movq	%r14, 8(%rbx)
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end12:
	.size	"fn8:f4", .Lfunc_end12-"fn8:f4"
                                        # -- End function
	.globl	"fn9:f5"                        # -- Begin function fn9:f5
	.p2align	4, 0x90
	.type	"fn9:f5",@function
"fn9:f5":                               # @"fn9:f5"
# %bb.0:
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	8(%rcx), %rdx
	leaq	-8(%rsp), %rsi
	movq	%rsi, 8(%rcx)
	movq	8(%rax), %rax
	movq	%rdx, 8(%rcx)
	retq
.Lfunc_end13:
	.size	"fn9:f5", .Lfunc_end13-"fn9:f5"
                                        # -- End function
	.globl	"fn10:tf1"                      # -- Begin function fn10:tf1
	.p2align	4, 0x90
	.type	"fn10:tf1",@function
"fn10:tf1":                             # @"fn10:tf1"
# %bb.0:
	movq	%rdi, %rax
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rdx
	movq	8(%rcx), %rsi
	leaq	-8(%rsp), %rdi
	movq	%rdi, 8(%rcx)
	addq	16(%rdx), %rax
	movq	%rsi, 8(%rcx)
	retq
.Lfunc_end14:
	.size	"fn10:tf1", .Lfunc_end14-"fn10:tf1"
                                        # -- End function
	.globl	"fn11:tf2"                      # -- Begin function fn11:tf2
	.p2align	4, 0x90
	.type	"fn11:tf2",@function
"fn11:tf2":                             # @"fn11:tf2"
# %bb.0:
	movq	display_array@GOTPCREL(%rip), %rax
	movq	(%rax), %rcx
	movq	8(%rax), %rdx
	movq	24(%rcx), %rcx
	andl	$1, %edi
	movb	%dil, (%rcx)
	movq	%rdx, 8(%rax)
	xorl	%eax, %eax
	retq
.Lfunc_end15:
	.size	"fn11:tf2", .Lfunc_end15-"fn11:tf2"
                                        # -- End function
	.globl	"fn12:tf3"                      # -- Begin function fn12:tf3
	.p2align	4, 0x90
	.type	"fn12:tf3",@function
"fn12:tf3":                             # @"fn12:tf3"
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
	movq	display_array@GOTPCREL(%rip), %rax
	movq	(%rax), %rcx
	movq	8(%rax), %rdx
	movq	%rdx, 16(%rsp)
	leaq	8(%rsp), %rdx
	movq	%rdx, 8(%rax)
	movq	32(%rcx), %rcx
	movq	%rcx, 24(%rsp)
	cmpq	$0, 8(%rcx)
	jle	.LBB16_1
# %bb.3:
	movq	(%rcx), %rcx
	movq	%rdi, (%rcx)
	movq	16(%rsp), %rcx
	movq	%rcx, 8(%rax)
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
.LBB16_1:                               # %.preheader
	.cfi_def_cfa_offset 64
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_37(%rip), %r15
	.p2align	4, 0x90
.LBB16_2:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB16_2
.Lfunc_end16:
	.size	"fn12:tf3", .Lfunc_end16-"fn12:tf3"
	.cfi_endproc
                                        # -- End function
	.globl	"fn13:loop"                     # -- Begin function fn13:loop
	.p2align	4, 0x90
	.type	"fn13:loop",@function
"fn13:loop":                            # @"fn13:loop"
	.cfi_startproc
# %bb.0:
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rax
	movq	%rax, 16(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r14)
	testq	%rdi, %rdi
	je	.LBB17_2
# %bb.1:
	movq	%rdi, %rbx
	movl	$46, %edi
	callq	lla_print_char@PLT
	decq	%rbx
	movq	%rbx, %rdi
	callq	"fn13:loop"@PLT
.LBB17_2:
	movq	16(%rsp), %rax
	movq	%rax, 8(%r14)
	xorl	%eax, %eax
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
# %bb.0:
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rdx
	leaq	-8(%rsp), %rax
	movq	%rax, 8(%rcx)
	movq	(%rdi), %rax
	movq	%rdx, 8(%rcx)
	retq
.Lfunc_end18:
	.size	"fn14:f6", .Lfunc_end18-"fn14:f6"
                                        # -- End function
	.globl	"fn15:f7"                       # -- Begin function fn15:f7
	.p2align	4, 0x90
	.type	"fn15:f7",@function
"fn15:f7":                              # @"fn15:f7"
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
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rax
	movq	%rax, 8(%rsp)
	movq	%rsp, %rax
	movq	%rax, 8(%rcx)
	cmpq	$0, 8(%rdi)
	jle	.LBB19_3
# %bb.1:
	cmpq	$0, 16(%rdi)
	jle	.LBB19_3
# %bb.2:
	cmpq	$0, 24(%rdi)
	jle	.LBB19_3
# %bb.5:
	movq	(%rdi), %rax
	movq	(%rax), %rax
	movq	8(%rsp), %rdx
	movq	%rdx, 8(%rcx)
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB19_3:                               # %.preheader
	.cfi_def_cfa_offset 48
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_37(%rip), %r15
	.p2align	4, 0x90
.LBB19_4:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB19_4
.Lfunc_end19:
	.size	"fn15:f7", .Lfunc_end19-"fn15:f7"
	.cfi_endproc
                                        # -- End function
	.globl	"fn16:f8"                       # -- Begin function fn16:f8
	.p2align	4, 0x90
	.type	"fn16:f8",@function
"fn16:f8":                              # @"fn16:f8"
	.cfi_startproc
# %bb.0:
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rdi, %rax
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	(%rbx), %rcx
	movq	8(%rbx), %r14
	movq	%rsp, %rdx
	movq	%rdx, 8(%rbx)
	movzbl	2(%rcx), %esi
	movzbl	1(%rcx), %edi
	callq	*%rax
	movq	%r14, 8(%rbx)
	addq	$8, %rsp
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
	movl	%esi, %r14d
	movl	%edi, %ebp
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %r13
	movq	%rsp, %rax
	movq	%rax, 8(%r12)
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
	leaq	.L__unnamed_109(%rip), %rax
	movq	%rax, (%rbx)
	movq	$15, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_110(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	%ebp, %edi
	callq	lla_print_char@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_111(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movl	%r14d, %edi
	callq	lla_print_bool@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_112(%rip), %rax
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r13, 8(%r12)
	movss	.LCPI21_0(%rip), %xmm0          # xmm0 = mem[0],zero,zero,zero
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
.Lfunc_end21:
	.size	"fn17:f8_f", .Lfunc_end21-"fn17:f8_f"
	.cfi_endproc
                                        # -- End function
	.globl	"_color:1_equality"             # -- Begin function _color:1_equality
	.p2align	4, 0x90
	.type	"_color:1_equality",@function
"_color:1_equality":                    # @"_color:1_equality"
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
	jne	.LBB22_4
# %bb.1:
	movq	8(%rsp), %rax
	decq	%rax
	cmpq	$3, %rax
	jae	.LBB22_2
.LBB22_4:
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
.LBB22_2:                               # %.preheader
	.cfi_def_cfa_offset 48
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_113(%rip), %r15
	.p2align	4, 0x90
.LBB22_3:                               # =>This Inner Loop Header: Depth=1
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
	movq	$86, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB22_3
.Lfunc_end22:
	.size	"_color:1_equality", .Lfunc_end22-"_color:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_number:1_equality"            # -- Begin function _number:1_equality
	.p2align	4, 0x90
	.type	"_number:1_equality",@function
"_number:1_equality":                   # @"_number:1_equality"
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	movq	%rax, 8(%rsp)
	cmpq	(%rsi), %rax
	jne	.LBB23_1
# %bb.2:                                # %NodeBlock28
	cmpq	$2, %rax
	jge	.LBB23_3
# %bb.6:                                # %LeafBlock
	cmpq	$1, %rax
	jne	.LBB23_8
# %bb.7:
	movq	8(%rdi), %rax
	cmpq	8(%rsi), %rax
	sete	5(%rsp)
	sete	4(%rsp)
	jmp	.LBB23_10
.LBB23_1:                               # %._crit_edge
	movb	$0, 4(%rsp)
.LBB23_10:
	movb	4(%rsp), %al
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB23_3:                               # %NodeBlock
	.cfi_def_cfa_offset 32
	cmpq	$3, %rax
	jge	.LBB23_4
# %bb.9:
	movss	8(%rdi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rsi), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 6(%rsp)
	movb	%cl, 4(%rsp)
	jmp	.LBB23_10
.LBB23_4:                               # %LeafBlock26
	jne	.LBB23_8
# %bb.5:
	movss	8(%rdi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	12(%rdi), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	ucomiss	8(%rsi), %xmm0
	setnp	%al
	sete	%cl
	ucomiss	12(%rsi), %xmm1
	setnp	%dl
	sete	%bl
	andb	%dl, %bl
	andb	%al, %bl
	andb	%cl, %bl
	movb	%bl, 7(%rsp)
	movb	%bl, 4(%rsp)
	jmp	.LBB23_10
	.p2align	4, 0x90
.LBB23_8:                               # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_38(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB23_8
.Lfunc_end23:
	.size	"_number:1_equality", .Lfunc_end23-"_number:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_list:1_equality"              # -- Begin function _list:1_equality
	.p2align	4, 0x90
	.type	"_list:1_equality",@function
"_list:1_equality":                     # @"_list:1_equality"
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$64, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -16
	movq	%rsi, 16(%rsp)
	movq	%rdi, 8(%rsp)
	movb	$1, 4(%rsp)
	.p2align	4, 0x90
.LBB24_1:                               # %tailrecurse
                                        # =>This Inner Loop Header: Depth=1
	movzbl	4(%rsp), %ecx
	movq	8(%rsp), %rdx
	movq	16(%rsp), %rax
	movb	%cl, 6(%rsp)
	movq	%rdx, 24(%rsp)
	movq	%rax, 32(%rsp)
	movq	(%rdx), %rcx
	movq	%rcx, 40(%rsp)
	cmpq	(%rax), %rcx
	jne	.LBB24_2
# %bb.3:                                # %NodeBlock
                                        #   in Loop: Header=BB24_1 Depth=1
	cmpq	$2, %rcx
	jl	.LBB24_6
# %bb.4:                                # %LeafBlock12
                                        #   in Loop: Header=BB24_1 Depth=1
	jne	.LBB24_9
# %bb.5:                                #   in Loop: Header=BB24_1 Depth=1
	movq	24(%rsp), %rcx
	movq	8(%rcx), %rdx
	movq	16(%rax), %rsi
	cmpq	8(%rax), %rdx
	movq	%rsi, 48(%rsp)
	movq	16(%rcx), %rax
	movq	%rax, 56(%rsp)
	sete	%cl
	andb	6(%rsp), %cl
	movb	%cl, 7(%rsp)
	movq	%rsi, 16(%rsp)
	movq	%rax, 8(%rsp)
	movb	%cl, 4(%rsp)
	jmp	.LBB24_1
.LBB24_2:                               # %tailrecurse._crit_edge
	movb	$0, 5(%rsp)
	jmp	.LBB24_8
.LBB24_6:                               # %LeafBlock
	cmpq	$1, %rcx
	jne	.LBB24_9
# %bb.7:                                # %LeafBlock._crit_edge
	movb	$1, 5(%rsp)
.LBB24_8:
	movb	5(%rsp), %al
	andb	6(%rsp), %al
	addq	$64, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
	.p2align	4, 0x90
.LBB24_9:                               # =>This Inner Loop Header: Depth=1
	.cfi_def_cfa_offset 80
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_114(%rip), %rax
	movq	%rax, (%rbx)
	movq	$85, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB24_9
.Lfunc_end24:
	.size	"_list:1_equality", .Lfunc_end24-"_list:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_tree:1_equality"              # -- Begin function _tree:1_equality
	.p2align	4, 0x90
	.type	"_tree:1_equality",@function
"_tree:1_equality":                     # @"_tree:1_equality"
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	movq	%rax, 8(%rsp)
	cmpq	(%rsi), %rax
	jne	.LBB25_1
# %bb.2:                                # %NodeBlock
	cmpq	$2, %rax
	jge	.LBB25_3
# %bb.5:                                # %LeafBlock
	cmpq	$1, %rax
	jne	.LBB25_8
# %bb.6:                                # %LeafBlock._crit_edge
	movb	$1, 6(%rsp)
	jmp	.LBB25_7
.LBB25_1:                               # %._crit_edge
	movb	$0, 6(%rsp)
	jmp	.LBB25_7
.LBB25_3:                               # %LeafBlock12
	jne	.LBB25_8
# %bb.4:
	movq	16(%rsi), %rax
	movq	8(%rdi), %rcx
	movq	16(%rdi), %rdi
	cmpq	8(%rsi), %rcx
	sete	%bl
	movq	%rax, %rsi
	callq	"_forest:1_equality"@PLT
	andb	%bl, %al
	movb	%al, 7(%rsp)
	movb	%al, 6(%rsp)
.LBB25_7:
	movb	6(%rsp), %al
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
	.p2align	4, 0x90
.LBB25_8:                               # =>This Inner Loop Header: Depth=1
	.cfi_def_cfa_offset 32
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_115(%rip), %rax
	movq	%rax, (%rbx)
	movq	$85, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
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
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$96, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -16
	movq	%rsi, 24(%rsp)
	movq	%rdi, 16(%rsp)
	movb	$1, 11(%rsp)
	jmp	.LBB26_1
	.p2align	4, 0x90
.LBB26_7:                               # %._crit_edge
                                        #   in Loop: Header=BB26_1 Depth=1
	movb	$0, 10(%rsp)
.LBB26_15:                              #   in Loop: Header=BB26_1 Depth=1
	movzbl	10(%rsp), %eax
	andb	13(%rsp), %al
	andb	$1, %al
	movb	%al, 15(%rsp)
	movq	64(%rsp), %rcx
	movq	56(%rsp), %rdx
	movq	%rdx, 24(%rsp)
	movq	%rcx, 16(%rsp)
	movb	%al, 11(%rsp)
.LBB26_1:                               # %tailrecurse
                                        # =>This Inner Loop Header: Depth=1
	movzbl	11(%rsp), %ecx
	movq	16(%rsp), %rdx
	movq	24(%rsp), %rax
	movb	%cl, 13(%rsp)
	movq	%rdx, 32(%rsp)
	movq	%rax, 40(%rsp)
	movq	(%rdx), %rcx
	movq	%rcx, 72(%rsp)
	cmpq	(%rax), %rcx
	jne	.LBB26_2
# %bb.4:                                # %NodeBlock
                                        #   in Loop: Header=BB26_1 Depth=1
	cmpq	$2, %rcx
	jl	.LBB26_8
# %bb.5:                                # %LeafBlock14
                                        #   in Loop: Header=BB26_1 Depth=1
	jne	.LBB26_16
# %bb.6:                                #   in Loop: Header=BB26_1 Depth=1
	movq	8(%rax), %rax
	movq	%rax, 80(%rsp)
	movq	32(%rsp), %rcx
	movq	8(%rcx), %rdx
	movq	%rdx, 48(%rsp)
	movq	40(%rsp), %rsi
	movq	16(%rsi), %rsi
	movq	%rsi, 56(%rsp)
	movq	16(%rcx), %rcx
	movq	%rcx, 64(%rsp)
	movq	(%rdx), %rcx
	movq	%rcx, 88(%rsp)
	cmpq	(%rax), %rcx
	jne	.LBB26_7
# %bb.10:                               # %NodeBlock21
                                        #   in Loop: Header=BB26_1 Depth=1
	cmpq	$2, %rcx
	jge	.LBB26_11
# %bb.13:                               # %LeafBlock17
                                        #   in Loop: Header=BB26_1 Depth=1
	cmpq	$1, %rcx
	jne	.LBB26_17
# %bb.14:                               # %LeafBlock17._crit_edge
                                        #   in Loop: Header=BB26_1 Depth=1
	movb	$1, 10(%rsp)
	jmp	.LBB26_15
	.p2align	4, 0x90
.LBB26_11:                              # %LeafBlock19
                                        #   in Loop: Header=BB26_1 Depth=1
	jne	.LBB26_17
# %bb.12:                               #   in Loop: Header=BB26_1 Depth=1
	movq	48(%rsp), %rcx
	movq	16(%rax), %rsi
	movq	8(%rcx), %rdx
	movq	16(%rcx), %rdi
	cmpq	8(%rax), %rdx
	sete	%bl
	callq	"_forest:1_equality"@PLT
	andb	%bl, %al
	movb	%al, 14(%rsp)
	movb	%al, 10(%rsp)
	jmp	.LBB26_15
	.p2align	4, 0x90
.LBB26_17:                              # =>This Inner Loop Header: Depth=1
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_115(%rip), %rax
	movq	%rax, (%rbx)
	movq	$85, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB26_17
.LBB26_2:                               # %tailrecurse._crit_edge
	movb	$0, 12(%rsp)
	jmp	.LBB26_3
.LBB26_8:                               # %LeafBlock
	cmpq	$1, %rcx
	jne	.LBB26_16
# %bb.9:                                # %LeafBlock._crit_edge
	movb	$1, 12(%rsp)
.LBB26_3:
	movb	12(%rsp), %al
	andb	13(%rsp), %al
	addq	$96, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
	.p2align	4, 0x90
.LBB26_16:                              # =>This Inner Loop Header: Depth=1
	.cfi_def_cfa_offset 112
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_116(%rip), %rax
	movq	%rax, (%rbx)
	movq	$87, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB26_16
.Lfunc_end26:
	.size	"_forest:1_equality", .Lfunc_end26-"_forest:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_a:1_equality"                 # -- Begin function _a:1_equality
	.p2align	4, 0x90
	.type	"_a:1_equality",@function
"_a:1_equality":                        # @"_a:1_equality"
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$112, %rsp
	.cfi_def_cfa_offset 144
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movb	$0, 3(%rsp)
	movq	%rsi, 16(%rsp)
	movq	%rdi, 8(%rsp)
	.p2align	4, 0x90
.LBB27_1:                               # %tailrecurse
                                        # =>This Inner Loop Header: Depth=1
	movq	8(%rsp), %rcx
	movq	16(%rsp), %rax
	movzbl	6(%rsp), %edx
	movzbl	3(%rsp), %ebx
	movq	%rcx, 24(%rsp)
	movq	%rax, 48(%rsp)
	movb	%dl, 4(%rsp)
	movb	%bl, 5(%rsp)
	movq	(%rcx), %rcx
	movq	%rcx, 56(%rsp)
	cmpq	(%rax), %rcx
	jne	.LBB27_13
# %bb.2:                                #   in Loop: Header=BB27_1 Depth=1
	cmpq	$1, %rcx
	jne	.LBB27_3
# %bb.5:                                #   in Loop: Header=BB27_1 Depth=1
	movq	8(%rax), %rax
	movq	%rax, 64(%rsp)
	movq	24(%rsp), %rcx
	movq	8(%rcx), %rcx
	movq	%rcx, 32(%rsp)
	movq	(%rcx), %rcx
	movq	%rcx, 72(%rsp)
	cmpq	(%rax), %rcx
	jne	.LBB27_13
# %bb.6:                                #   in Loop: Header=BB27_1 Depth=1
	cmpq	$1, %rcx
	jne	.LBB27_7
# %bb.9:                                #   in Loop: Header=BB27_1 Depth=1
	movq	8(%rax), %rax
	movq	%rax, 80(%rsp)
	movq	32(%rsp), %rcx
	movq	8(%rcx), %rcx
	movq	%rcx, 40(%rsp)
	movq	(%rcx), %rcx
	movq	%rcx, 88(%rsp)
	cmpq	(%rax), %rcx
	jne	.LBB27_13
# %bb.10:                               #   in Loop: Header=BB27_1 Depth=1
	cmpq	$1, %rcx
	jne	.LBB27_11
# %bb.14:                               #   in Loop: Header=BB27_1 Depth=1
	movq	8(%rax), %rax
	movq	%rax, 96(%rsp)
	movq	40(%rsp), %rcx
	movq	8(%rcx), %rcx
	movq	%rcx, 104(%rsp)
	movzbl	5(%rsp), %edx
	andb	4(%rsp), %dl
	andb	$1, %dl
	movb	%dl, 7(%rsp)
	movb	$1, 3(%rsp)
	movb	%dl, 6(%rsp)
	movq	%rax, 16(%rsp)
	movq	%rcx, 8(%rsp)
	jmp	.LBB27_1
.LBB27_13:
	movb	5(%rsp), %al
	andb	4(%rsp), %al
	addq	$112, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB27_3:
	.cfi_def_cfa_offset 144
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_117(%rip), %r15
	.p2align	4, 0x90
.LBB27_4:                               # =>This Inner Loop Header: Depth=1
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
	movq	$82, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB27_4
.LBB27_7:
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_118(%rip), %r15
	.p2align	4, 0x90
.LBB27_8:                               # =>This Inner Loop Header: Depth=1
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
	movq	$82, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB27_8
.LBB27_11:
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_119(%rip), %r15
	.p2align	4, 0x90
.LBB27_12:                              # =>This Inner Loop Header: Depth=1
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
	movq	$82, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB27_12
.Lfunc_end27:
	.size	"_a:1_equality", .Lfunc_end27-"_a:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_b:1_equality"                 # -- Begin function _b:1_equality
	.p2align	4, 0x90
	.type	"_b:1_equality",@function
"_b:1_equality":                        # @"_b:1_equality"
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
	movq	(%rdi), %rax
	movq	%rax, 8(%rsp)
	cmpq	(%rsi), %rax
	jne	.LBB28_9
# %bb.1:
	cmpq	$1, %rax
	jne	.LBB28_2
# %bb.4:
	movq	8(%rsi), %rax
	movq	%rax, 16(%rsp)
	movq	8(%rdi), %rcx
	movq	%rcx, (%rsp)
	movq	(%rcx), %rcx
	movq	%rcx, 24(%rsp)
	cmpq	(%rax), %rcx
	jne	.LBB28_9
# %bb.5:
	cmpq	$1, %rcx
	jne	.LBB28_6
# %bb.8:
	movq	8(%rax), %rsi
	movq	(%rsp), %rax
	movq	8(%rax), %rdi
	callq	"_a:1_equality"@PLT
.LBB28_9:
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
.LBB28_2:
	.cfi_def_cfa_offset 64
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_118(%rip), %r15
	.p2align	4, 0x90
.LBB28_3:                               # =>This Inner Loop Header: Depth=1
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
	movq	$82, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB28_3
.LBB28_6:
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_119(%rip), %r15
	.p2align	4, 0x90
.LBB28_7:                               # =>This Inner Loop Header: Depth=1
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
	movq	$82, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB28_7
.Lfunc_end28:
	.size	"_b:1_equality", .Lfunc_end28-"_b:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_c:1_equality"                 # -- Begin function _c:1_equality
	.p2align	4, 0x90
	.type	"_c:1_equality",@function
"_c:1_equality":                        # @"_c:1_equality"
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
	jne	.LBB29_5
# %bb.1:
	cmpq	$1, %rax
	jne	.LBB29_2
# %bb.4:
	movq	8(%rsi), %rsi
	movq	8(%rdi), %rdi
	callq	"_a:1_equality"@PLT
.LBB29_5:
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
.LBB29_2:
	.cfi_def_cfa_offset 48
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_119(%rip), %r15
	.p2align	4, 0x90
.LBB29_3:                               # =>This Inner Loop Header: Depth=1
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
	movq	$82, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB29_3
.Lfunc_end29:
	.size	"_c:1_equality", .Lfunc_end29-"_c:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"_opt:1_equality"               # -- Begin function _opt:1_equality
	.p2align	4, 0x90
	.type	"_opt:1_equality",@function
"_opt:1_equality":                      # @"_opt:1_equality"
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	movq	%rax, 8(%rsp)
	cmpq	(%rsi), %rax
	jne	.LBB30_1
# %bb.2:                                # %NodeBlock
	cmpq	$2, %rax
	jge	.LBB30_3
# %bb.5:                                # %LeafBlock
	cmpq	$1, %rax
	jne	.LBB30_8
# %bb.6:
	movq	8(%rdi), %rax
	cmpq	8(%rsi), %rax
	sete	6(%rsp)
	sete	5(%rsp)
	jmp	.LBB30_7
.LBB30_1:                               # %._crit_edge
	movb	$0, 5(%rsp)
	jmp	.LBB30_7
.LBB30_3:                               # %LeafBlock12
	jne	.LBB30_8
# %bb.4:
	movss	8(%rdi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	ucomiss	8(%rsi), %xmm0
	setnp	%al
	sete	%cl
	andb	%al, %cl
	movb	%cl, 7(%rsp)
	movb	%cl, 5(%rsp)
.LBB30_7:
	movb	5(%rsp), %al
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
	.p2align	4, 0x90
.LBB30_8:                               # =>This Inner Loop Header: Depth=1
	.cfi_def_cfa_offset 32
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_120(%rip), %rax
	movq	%rax, (%rbx)
	movq	$84, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
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
	jne	.LBB31_2
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
	leaq	.L__unnamed_121(%rip), %rax
	movq	%rax, (%rbx)
	movq	$4, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	andb	$1, %al
	movb	%al, 13(%rsp)
	jmp	.LBB31_8
.LBB31_2:
	cmpq	$2, %rax
	jne	.LBB31_4
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
	leaq	.L__unnamed_122(%rip), %rax
	movq	%rax, (%rbx)
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	andb	$1, %al
	movb	%al, 14(%rsp)
	jmp	.LBB31_8
.LBB31_4:
	cmpq	$3, %rax
	jne	.LBB31_5
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
	leaq	.L__unnamed_123(%rip), %rax
	movq	%rax, (%rbx)
	movq	$5, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	andb	$1, %al
	movb	%al, 15(%rsp)
.LBB31_8:
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
.LBB31_5:
	.cfi_def_cfa_offset 64
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_124(%rip), %r15
	.p2align	4, 0x90
.LBB31_6:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB31_6
.Lfunc_end31:
	.size	"fn18:p_color", .Lfunc_end31-"fn18:p_color"
	.cfi_endproc
                                        # -- End function
	.globl	"fn19:p_opt"                    # -- Begin function fn19:p_opt
	.p2align	4, 0x90
	.type	"fn19:p_opt",@function
"fn19:p_opt":                           # @"fn19:p_opt"
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
	movq	8(%r15), %rax
	movq	%rax, 16(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r15)
	movq	(%rdi), %rax
	movq	%rax, 24(%rsp)
	cmpq	$1, %rax
	jne	.LBB32_2
# %bb.1:
	movq	8(%rdi), %r14
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_125(%rip), %rax
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r14, %rdi
	callq	lla_print_int@PLT
	andb	$1, %al
	movb	%al, 10(%rsp)
	jmp	.LBB32_6
.LBB32_2:
	cmpq	$2, %rax
	jne	.LBB32_3
# %bb.5:
	movss	8(%rdi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, 12(%rsp)                 # 4-byte Spill
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_126(%rip), %rax
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	12(%rsp), %xmm0                 # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	andb	$1, %al
	movb	%al, 11(%rsp)
.LBB32_6:
	movb	%al, 7(%rsp)
	movq	16(%rsp), %rax
	movq	%rax, 8(%r15)
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
.LBB32_3:
	.cfi_def_cfa_offset 64
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_124(%rip), %r15
	.p2align	4, 0x90
.LBB32_4:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB32_4
.Lfunc_end32:
	.size	"fn19:p_opt", .Lfunc_end32-"fn19:p_opt"
	.cfi_endproc
                                        # -- End function
	.globl	"fn20:pmtype"                   # -- Begin function fn20:pmtype
	.p2align	4, 0x90
	.type	"fn20:pmtype",@function
"fn20:pmtype":                          # @"fn20:pmtype"
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$64, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %rax
	movq	%rax, 48(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r15)
	movq	(%rdi), %rax
	movq	%rax, 56(%rsp)
	cmpq	$1, %rax
	jne	.LBB33_2
# %bb.1:
	movq	8(%rdi), %r14
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_127(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r14, %rdi
	callq	lla_print_int@PLT
	andb	$1, %al
	movb	%al, 15(%rsp)
	jmp	.LBB33_15
.LBB33_2:
	cmpq	$2, %rax
	jne	.LBB33_4
# %bb.3:
	movss	8(%rdi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, 4(%rsp)                  # 4-byte Spill
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_128(%rip), %rax
	movq	%rax, (%rbx)
	movq	$6, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	4(%rsp), %xmm0                  # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	andb	$1, %al
	movb	%al, 16(%rsp)
	jmp	.LBB33_15
.LBB33_4:
	cmpq	$3, %rax
	jne	.LBB33_5
# %bb.7:
	movss	12(%rdi), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	xorps	%xmm0, %xmm0
	ucomiss	%xmm0, %xmm1
	jne	.LBB33_9
	jp	.LBB33_9
# %bb.8:
	movss	8(%rdi), %xmm0                  # xmm0 = mem[0],zero,zero,zero
	movss	%xmm0, 4(%rsp)                  # 4-byte Spill
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_129(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	4(%rsp), %xmm0                  # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	andb	$1, %al
	movb	%al, 17(%rsp)
	jmp	.LBB33_15
.LBB33_5:
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_124(%rip), %r15
	.p2align	4, 0x90
.LBB33_6:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB33_6
.LBB33_9:
	movss	8(%rdi), %xmm2                  # xmm2 = mem[0],zero,zero,zero
	ucomiss	%xmm0, %xmm2
	jne	.LBB33_11
	jp	.LBB33_11
# %bb.10:
	movl	$16, %edi
	movss	%xmm1, 4(%rsp)                  # 4-byte Spill
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_130(%rip), %rax
	movq	%rax, (%rbx)
	movq	$10, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	4(%rsp), %xmm0                  # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	andb	$1, %al
	movb	%al, 18(%rsp)
	jmp	.LBB33_15
.LBB33_11:
	movss	%xmm1, 20(%rsp)
	movl	$16, %edi
	movss	%xmm2, 4(%rsp)                  # 4-byte Spill
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_129(%rip), %rax
	movq	%rax, (%rbx)
	movq	$9, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movss	4(%rsp), %xmm0                  # 4-byte Reload
                                        # xmm0 = mem[0],zero,zero,zero
	callq	lla_print_float@PLT
	movss	20(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	xorps	%xmm1, %xmm1
	movl	$16, %edi
	ucomiss	%xmm1, %xmm0
	jbe	.LBB33_13
# %bb.12:
	callq	GC_malloc@PLT
	movq	%rax, 24(%rsp)
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	24(%rsp), %rax
	leaq	.L__unnamed_131(%rip), %rcx
	movq	%rcx, (%rax)
	movq	24(%rsp), %rax
	movq	$3, 8(%rax)
	movq	24(%rsp), %rax
	jmp	.LBB33_14
.LBB33_13:
	callq	GC_malloc@PLT
	movq	%rax, 32(%rsp)
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	32(%rsp), %rax
	leaq	.L__unnamed_132(%rip), %rcx
	movq	%rcx, (%rax)
	movq	32(%rsp), %rax
	movq	$3, 8(%rax)
	movq	32(%rsp), %rax
.LBB33_14:
	movq	%rax, 40(%rsp)
	movq	40(%rsp), %rdi
	callq	lla_print_string@PLT
	movss	20(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	callq	lla_fabs@PLT
	callq	lla_print_float@PLT
	andb	$1, %al
	movb	%al, 19(%rsp)
.LBB33_15:
	movb	%al, 3(%rsp)
	movq	48(%rsp), %rax
	movq	%rax, 8(%r15)
	movb	3(%rsp), %al
	addq	$64, %rsp
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
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r12)
	movq	%rax, %r13
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
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
	leaq	.L__unnamed_22(%rip), %rax
	movq	%rax, (%rbx)
	movq	$7, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r15), %rdi
	callq	"fn18:p_color"@PLT
	movq	8(%r12), %rbp
	movq	%r13, 8(%r12)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_5(%rip), %r13
	movq	%r13, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%rbp, 8(%r12)
	movq	$0, (%r15)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	$3, (%rax)
	movq	%rax, (%r15)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_23(%rip), %rax
	movq	%rax, (%rbx)
	movq	$8, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r15), %rdi
	callq	"fn18:p_color"@PLT
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r12)
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
	movq	$0, (%r15)
	movq	16(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 8(%r12)
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
.Lfunc_end34:
	.size	"fn21:pc_new", .Lfunc_end34-"fn21:pc_new"
	.cfi_endproc
                                        # -- End function
	.globl	"fn22:f9"                       # -- Begin function fn22:f9
	.p2align	4, 0x90
	.type	"fn22:f9",@function
"fn22:f9":                              # @"fn22:f9"
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
	movq	%rdi, %r14
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %r13
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r12)
	movl	$8, %edi
	callq	malloc@PLT
	movq	%rax, %r15
	movl	$24, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r15, (%rbx)
	movq	$1, 8(%rbx)
	movq	$1, 16(%rbx)
	movq	%r14, (%r15)
	movq	%r13, 8(%r12)
	movq	%rbx, %rax
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
.Lfunc_end35:
	.size	"fn22:f9", .Lfunc_end35-"fn22:f9"
	.cfi_endproc
                                        # -- End function
	.globl	"fn23:f"                        # -- Begin function fn23:f
	.p2align	4, 0x90
	.type	"fn23:f",@function
"fn23:f":                               # @"fn23:f"
# %bb.0:
	movq	16(%rdi), %rax
	retq
.Lfunc_end36:
	.size	"fn23:f", .Lfunc_end36-"fn23:f"
                                        # -- End function
	.globl	"fn24:f"                        # -- Begin function fn24:f
	.p2align	4, 0x90
	.type	"fn24:f",@function
"fn24:f":                               # @"fn24:f"
# %bb.0:
	movl	$1, %eax
	retq
.Lfunc_end37:
	.size	"fn24:f", .Lfunc_end37-"fn24:f"
                                        # -- End function
	.globl	"fn25:f10"                      # -- Begin function fn25:f10
	.p2align	4, 0x90
	.type	"fn25:f10",@function
"fn25:f10":                             # @"fn25:f10"
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
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %r13
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r12)
	movq	24(%rdi), %r14
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
	leaq	.L__unnamed_42(%rip), %rax
	movq	%rax, (%rbx)
	movq	$16, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r14, %rdi
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
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
.Lfunc_end38:
	.size	"fn25:f10", .Lfunc_end38-"fn25:f10"
	.cfi_endproc
                                        # -- End function
	.globl	"fn26:uif"                      # -- Begin function fn26:uif
	.p2align	4, 0x90
	.type	"fn26:uif",@function
"fn26:uif":                             # @"fn26:uif"
	.cfi_startproc
# %bb.0:
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rax
	movq	%rax, 16(%rsp)
	leaq	8(%rsp), %rbx
	movq	%rbx, 8(%r14)
	testq	%rdi, %rdi
	je	.LBB39_2
# %bb.1:                                # %._crit_edge
	movb	$0, 7(%rsp)
	jmp	.LBB39_3
.LBB39_2:
	xorl	%edi, %edi
	callq	lla_print_int@PLT
	movq	%rbx, 8(%r14)
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
	andb	$1, %al
	movb	%al, 15(%rsp)
	movb	%al, 7(%rsp)
.LBB39_3:
	movq	16(%rsp), %rax
	movq	%rax, 8(%r14)
	movb	7(%rsp), %al
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
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, %r14
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %rax
	movq	%rax, 24(%rsp)
	movq	%rsp, %rax
	movq	%rax, 8(%r15)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 8(%rsp)
	movq	$0, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_133(%rip), %rax
	movq	%rax, (%rbx)
	movq	$23, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	incq	%r14
	movq	%r14, 32(%rsp)
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 40(%rsp)
	cmpq	%r14, %rax
	jge	.LBB40_4
# %bb.1:                                # %.lr.ph
	movq	%rax, 16(%rsp)
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_5(%rip), %r12
	.p2align	4, 0x90
.LBB40_2:                               # =>This Inner Loop Header: Depth=1
	movq	16(%rsp), %rdi
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
	movq	8(%rsp), %rdi
	callq	lla_incr@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, 48(%rsp)
	cmpq	32(%rsp), %rax
	jge	.LBB40_4
# %bb.3:                                # %._crit_edge16
                                        #   in Loop: Header=BB40_2 Depth=1
	movq	%rax, 16(%rsp)
	jmp	.LBB40_2
.LBB40_4:
	movq	24(%rsp), %rax
	movq	%rax, 8(%r15)
	xorl	%eax, %eax
	addq	$56, %rsp
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
.Lfunc_end40:
	.size	"fn27:while_test", .Lfunc_end40-"fn27:while_test"
	.cfi_endproc
                                        # -- End function
	.globl	"fn28:for_test"                 # -- Begin function fn28:for_test
	.p2align	4, 0x90
	.type	"fn28:for_test",@function
"fn28:for_test":                        # @"fn28:for_test"
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
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdi, %r15
	movq	display_array@GOTPCREL(%rip), %r13
	movq	8(%r13), %rax
	movq	%rax, 24(%rsp)
	movq	%rsp, %rax
	movq	%rax, 8(%r13)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_134(%rip), %rax
	movq	%rax, (%rbx)
	movq	$25, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	testq	%r15, %r15
	jns	.LBB41_1
.LBB41_4:
	decq	%r15
	movq	%r15, 40(%rsp)
	js	.LBB41_8
# %bb.5:                                # %.lr.ph
	movq	%r15, 16(%rsp)
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_5(%rip), %rbp
	.p2align	4, 0x90
.LBB41_6:                               # =>This Inner Loop Header: Depth=1
	movq	16(%rsp), %rbx
	movq	%rbx, %rdi
	callq	lla_print_int@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbp, (%r15)
	movq	$2, 8(%r15)
	movq	%r15, %rdi
	callq	lla_print_string@PLT
	decq	%rbx
	movq	%rbx, 48(%rsp)
	js	.LBB41_8
# %bb.7:                                # %._crit_edge30
                                        #   in Loop: Header=BB41_6 Depth=1
	movq	%rbx, 16(%rsp)
	jmp	.LBB41_6
.LBB41_8:
	movq	24(%rsp), %rax
	movq	%rax, 8(%r13)
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
.LBB41_1:                               # %.lr.ph25
	.cfi_def_cfa_offset 112
	movq	$0, 8(%rsp)
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_5(%rip), %rbp
	.p2align	4, 0x90
.LBB41_2:                               # =>This Inner Loop Header: Depth=1
	movq	8(%rsp), %rbx
	movq	%rbx, %rdi
	callq	lla_print_int@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r12
	movq	%rax, %rdi
	movq	%r14, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%rbp, (%r12)
	movq	$2, 8(%r12)
	movq	%r12, %rdi
	callq	lla_print_string@PLT
	incq	%rbx
	movq	%rbx, 32(%rsp)
	cmpq	%r15, %rbx
	jg	.LBB41_4
# %bb.3:                                # %._crit_edge28
                                        #   in Loop: Header=BB41_2 Depth=1
	movq	%rbx, 8(%rsp)
	jmp	.LBB41_2
.Lfunc_end41:
	.size	"fn28:for_test", .Lfunc_end41-"fn28:for_test"
	.cfi_endproc
                                        # -- End function
	.globl	"fn29:if_while_for"             # -- Begin function fn29:if_while_for
	.p2align	4, 0x90
	.type	"fn29:if_while_for",@function
"fn29:if_while_for":                    # @"fn29:if_while_for"
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -16
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %rax
	movq	%rax, 8(%rsp)
	movq	%rsp, %rax
	movq	%rax, 8(%rbx)
	testb	$1, %dil
	je	.LBB42_2
# %bb.1:                                # %.preheader
	movl	$46, %edi
	callq	lla_print_char@PLT
	movl	$46, %edi
	callq	lla_print_char@PLT
	movl	$46, %edi
	callq	lla_print_char@PLT
	movq	8(%rsp), %rax
	movq	%rax, 8(%rbx)
	xorl	%eax, %eax
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
	.p2align	4, 0x90
.LBB42_2:                               # =>This Inner Loop Header: Depth=1
	.cfi_def_cfa_offset 32
	jmp	.LBB42_2
.Lfunc_end42:
	.size	"fn29:if_while_for", .Lfunc_end42-"fn29:if_while_for"
	.cfi_endproc
                                        # -- End function
	.globl	"fn30:f_nest0"                  # -- Begin function fn30:f_nest0
	.p2align	4, 0x90
	.type	"fn30:f_nest0",@function
"fn30:f_nest0":                         # @"fn30:f_nest0"
# %bb.0:
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rdx
	movq	16(%rcx), %rsi
	leaq	-32(%rsp), %rax
	movq	%rax, 8(%rcx)
	movq	$1, -32(%rsp)
	leaq	-24(%rsp), %rax
	movq	%rax, 16(%rcx)
	leaq	4(%rdi,%rdi), %rax
	movq	%rsi, 16(%rcx)
	movq	%rdx, 8(%rcx)
	retq
.Lfunc_end43:
	.size	"fn30:f_nest0", .Lfunc_end43-"fn30:f_nest0"
                                        # -- End function
	.globl	"fn31:f_nest1"                  # -- Begin function fn31:f_nest1
	.p2align	4, 0x90
	.type	"fn31:f_nest1",@function
"fn31:f_nest1":                         # @"fn31:f_nest1"
# %bb.0:
	leaq	1(%rdi), %rax
	retq
.Lfunc_end44:
	.size	"fn31:f_nest1", .Lfunc_end44-"fn31:f_nest1"
                                        # -- End function
	.globl	"fn32:f_nest2"                  # -- Begin function fn32:f_nest2
	.p2align	4, 0x90
	.type	"fn32:f_nest2",@function
"fn32:f_nest2":                         # @"fn32:f_nest2"
# %bb.0:
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	8(%rcx), %rax
	movq	16(%rcx), %r8
	leaq	-24(%rsp), %rdx
	movq	%rdx, 16(%rcx)
	movq	%rdi, -24(%rsp)
	addq	%rdi, %rsi
	addq	(%rax), %rsi
	movq	%rsi, -16(%rsp)
	movq	(%rax), %rax
	addq	%rdi, %rsi
	leaq	1(%rax,%rsi), %rax
	movq	%r8, 16(%rcx)
	retq
.Lfunc_end45:
	.size	"fn32:f_nest2", .Lfunc_end45-"fn32:f_nest2"
                                        # -- End function
	.globl	"fn33:f_nest3"                  # -- Begin function fn33:f_nest3
	.p2align	4, 0x90
	.type	"fn33:f_nest3",@function
"fn33:f_nest3":                         # @"fn33:f_nest3"
# %bb.0:
	movq	display_array@GOTPCREL(%rip), %rcx
	movq	16(%rcx), %rax
	movq	24(%rcx), %rdx
	leaq	-8(%rsp), %rsi
	movq	%rsi, 24(%rcx)
	movq	8(%rax), %rsi
	addq	(%rax), %rdi
	leaq	1(%rsi,%rdi), %rax
	movq	%rdx, 24(%rcx)
	retq
.Lfunc_end46:
	.size	"fn33:f_nest3", .Lfunc_end46-"fn33:f_nest3"
                                        # -- End function
	.globl	"fn34:print_int"                # -- Begin function fn34:print_int
	.p2align	4, 0x90
	.type	"fn34:print_int",@function
"fn34:print_int":                       # @"fn34:print_int"
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
	movq	%rsi, %r14
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %r13
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r12)
	callq	lla_print_string@PLT
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
	leaq	.L__unnamed_135(%rip), %rax
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r14, %rdi
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
	leaq	.L__unnamed_5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
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
.Lfunc_end47:
	.size	"fn34:print_int", .Lfunc_end47-"fn34:print_int"
	.cfi_endproc
                                        # -- End function
	.globl	"fn35:f"                        # -- Begin function fn35:f
	.p2align	4, 0x90
	.type	"fn35:f",@function
"fn35:f":                               # @"fn35:f"
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$64, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -16
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %rax
	movq	%rax, 56(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 8(%rbx)
	movq	%rdi, 32(%rsp)
	leaq	40(%rsp), %rax
	movq	%rax, (%rsp)
	movq	$1, 40(%rsp)
	leaq	48(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	$1, 48(%rsp)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	8(%rsp), %rax
	movq	$2, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	8(%rsp), %rax
	movq	$3, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	8(%rsp), %rax
	movq	$4, (%rax)
	movq	(%rsp), %rax
	movq	$2, (%rax)
	movq	8(%rbx), %rax
	leaq	16(%rax), %rcx
	movq	%rcx, 16(%rsp)
	movq	$1, 16(%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	16(%rsp), %rax
	movq	$2, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	16(%rsp), %rax
	movq	$3, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	16(%rsp), %rax
	movq	$4, (%rax)
	movq	(%rsp), %rax
	movq	$3, (%rax)
	movq	8(%rbx), %rax
	leaq	16(%rax), %rcx
	movq	%rcx, 24(%rsp)
	movq	$1, 16(%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	24(%rsp), %rax
	movq	$2, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	24(%rsp), %rax
	movq	$3, (%rax)
	xorl	%edi, %edi
	callq	"fn36:g"@PLT
	movq	24(%rsp), %rax
	movq	$4, (%rax)
	movq	(%rsp), %rax
	movq	$4, (%rax)
	movq	56(%rsp), %rax
	movq	%rax, 8(%rbx)
	xorl	%eax, %eax
	addq	$64, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
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
# %bb.0:
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
	leaq	.L__unnamed_136(%rip), %rax
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
	leaq	.L__unnamed_137(%rip), %rax
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
	leaq	.L__unnamed_138(%rip), %rax
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
	leaq	.L__unnamed_139(%rip), %rax
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
	leaq	.L__unnamed_140(%rip), %rax
	movq	%rax, (%rbx)
	movq	$14, 8(%rbx)
	movq	(%r15), %rax
	movq	8(%r15), %rcx
	movq	16(%rcx), %rsi
	addq	8(%rcx), %rsi
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
	leaq	.L__unnamed_5(%rip), %rax
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
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -16
	movq	(%rdi), %rax
	movq	%rax, 8(%rsp)
	cmpq	(%rsi), %rax
	jne	.LBB50_1
# %bb.2:                                # %NodeBlock
	cmpq	$2, %rax
	jge	.LBB50_3
# %bb.5:                                # %LeafBlock
	cmpq	$1, %rax
	jne	.LBB50_8
# %bb.6:
	movq	8(%rdi), %rax
	cmpq	8(%rsi), %rax
	sete	7(%rsp)
	sete	6(%rsp)
	jmp	.LBB50_7
.LBB50_1:                               # %._crit_edge
	movb	$0, 6(%rsp)
	jmp	.LBB50_7
.LBB50_3:                               # %LeafBlock7
	jne	.LBB50_8
# %bb.4:                                # %LeafBlock7._crit_edge
	movb	$1, 6(%rsp)
.LBB50_7:
	movb	6(%rsp), %al
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
	.p2align	4, 0x90
.LBB50_8:                               # =>This Inner Loop Header: Depth=1
	.cfi_def_cfa_offset 32
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_141(%rip), %rax
	movq	%rax, (%rbx)
	movq	$85, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
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
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rax
	movq	%rax, 32(%rsp)
	leaq	24(%rsp), %rax
	movq	%rax, 8(%r14)
	movq	(%rdi), %rax
	movq	%rax, 40(%rsp)
	cmpq	$1, %rax
	jne	.LBB51_2
# %bb.1:
	movq	8(%rdi), %rdi
	movq	%rdi, 24(%rsp)
	movq	16(%r14), %r15
	leaq	16(%rsp), %rbx
	movq	%rbx, 16(%r14)
	callq	lla_print_int@PLT
	movq	%rbx, 8(%r14)
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
	andb	$1, %al
	movb	%al, 23(%rsp)
	movq	%r15, 16(%r14)
	movb	%al, 15(%rsp)
	jmp	.LBB51_4
.LBB51_2:
	cmpq	$2, %rax
	jne	.LBB51_5
# %bb.3:                                # %._crit_edge
	movb	$0, 15(%rsp)
.LBB51_4:
	movq	32(%rsp), %rax
	movq	%rax, 8(%r14)
	movb	15(%rsp), %al
	addq	$48, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB51_5:                               # %.preheader
	.cfi_def_cfa_offset 80
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_124(%rip), %r15
	.p2align	4, 0x90
.LBB51_6:                               # =>This Inner Loop Header: Depth=1
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
# %bb.0:
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
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rax
	movq	16(%r14), %r15
	movq	%rsp, %rbx
	movq	%rbx, 16(%r14)
	movq	(%rax), %rdi
	callq	lla_print_int@PLT
	movq	8(%r14), %r12
	movq	%rbx, 8(%r14)
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
	movq	%r12, 8(%r14)
	movq	%r15, 16(%r14)
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
.Lfunc_end52:
	.size	"fn38:g", .Lfunc_end52-"fn38:g"
	.cfi_endproc
                                        # -- End function
	.globl	"fn39:g"                        # -- Begin function fn39:g
	.p2align	4, 0x90
	.type	"fn39:g",@function
"fn39:g":                               # @"fn39:g"
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
	movq	%rdi, %rax
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %r15
	leaq	8(%rsp), %rcx
	movq	%rcx, 8(%r14)
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
	leaq	.L__unnamed_5(%rip), %rax
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
# %bb.0:
	leaq	1(%rdi), %rax
	retq
.Lfunc_end54:
	.size	"fn40:f1", .Lfunc_end54-"fn40:f1"
                                        # -- End function
	.globl	"fn41:f2"                       # -- Begin function fn41:f2
	.p2align	4, 0x90
	.type	"fn41:f2",@function
"fn41:f2":                              # @"fn41:f2"
# %bb.0:
	leaq	-1(%rdi), %rax
	retq
.Lfunc_end55:
	.size	"fn41:f2", .Lfunc_end55-"fn41:f2"
                                        # -- End function
	.globl	"_t:1_equality"                 # -- Begin function _t:1_equality
	.p2align	4, 0x90
	.type	"_t:1_equality",@function
"_t:1_equality":                        # @"_t:1_equality"
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$64, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -16
	movq	%rsi, 16(%rsp)
	movq	%rdi, 8(%rsp)
	.p2align	4, 0x90
.LBB56_1:                               # %tailrecurse
                                        # =>This Inner Loop Header: Depth=1
	movq	8(%rsp), %rcx
	movq	16(%rsp), %rax
	movq	%rcx, 24(%rsp)
	movq	%rax, 32(%rsp)
	movq	(%rcx), %rcx
	movq	%rcx, 40(%rsp)
	cmpq	(%rax), %rcx
	jne	.LBB56_2
# %bb.3:                                # %NodeBlock
                                        #   in Loop: Header=BB56_1 Depth=1
	cmpq	$2, %rcx
	jl	.LBB56_6
# %bb.4:                                # %LeafBlock7
                                        #   in Loop: Header=BB56_1 Depth=1
	jne	.LBB56_9
# %bb.5:                                #   in Loop: Header=BB56_1 Depth=1
	movq	8(%rax), %rax
	movq	%rax, 48(%rsp)
	movq	24(%rsp), %rcx
	movq	8(%rcx), %rcx
	movq	%rcx, 56(%rsp)
	movq	%rax, 16(%rsp)
	movq	%rcx, 8(%rsp)
	jmp	.LBB56_1
.LBB56_2:                               # %tailrecurse._crit_edge
	movb	$0, 7(%rsp)
	jmp	.LBB56_8
.LBB56_6:                               # %LeafBlock
	cmpq	$1, %rcx
	jne	.LBB56_9
# %bb.7:                                # %LeafBlock._crit_edge
	movb	$1, 7(%rsp)
.LBB56_8:
	movb	7(%rsp), %al
	addq	$64, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
	.p2align	4, 0x90
.LBB56_9:                               # =>This Inner Loop Header: Depth=1
	.cfi_def_cfa_offset 80
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_142(%rip), %rax
	movq	%rax, (%rbx)
	movq	$82, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB56_9
.Lfunc_end56:
	.size	"_t:1_equality", .Lfunc_end56-"_t:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"fn42:pt"                       # -- Begin function fn42:pt
	.p2align	4, 0x90
	.type	"fn42:pt",@function
"fn42:pt":                              # @"fn42:pt"
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
	movq	8(%r15), %rax
	movq	%rax, 16(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r15)
	movq	(%rdi), %rax
	movq	%rax, 24(%rsp)
	cmpq	$1, %rax
	jne	.LBB57_2
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
	leaq	.L__unnamed_143(%rip), %rax
	movq	%rax, (%rbx)
	movq	$4, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	andb	$1, %al
	movb	%al, 14(%rsp)
	jmp	.LBB57_6
.LBB57_2:
	cmpq	$2, %rax
	jne	.LBB57_3
# %bb.5:
	movq	8(%rdi), %r14
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.L__unnamed_144(%rip), %rax
	movq	%rax, (%rbx)
	movq	$4, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r14, %rdi
	callq	"fn42:pt"@PLT
	andb	$1, %al
	movb	%al, 15(%rsp)
.LBB57_6:
	movb	%al, 7(%rsp)
	movq	16(%rsp), %rax
	movq	%rax, 8(%r15)
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
.LBB57_3:
	.cfi_def_cfa_offset 64
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_124(%rip), %r15
	.p2align	4, 0x90
.LBB57_4:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB57_4
.Lfunc_end57:
	.size	"fn42:pt", .Lfunc_end57-"fn42:pt"
	.cfi_endproc
                                        # -- End function
	.globl	"fn43:gen"                      # -- Begin function fn43:gen
	.p2align	4, 0x90
	.type	"fn43:gen",@function
"fn43:gen":                             # @"fn43:gen"
	.cfi_startproc
# %bb.0:
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
# %bb.0:
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
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rbx, 8(%r14)
	addq	$8, %rsp
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
	movq	%rdi, %r14
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %r13
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r12)
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
	movq	%r15, %rdi
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
	.globl	"fn48:gen"                      # -- Begin function fn48:gen
	.p2align	4, 0x90
	.type	"fn48:gen",@function
"fn48:gen":                             # @"fn48:gen"
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
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %r12
	movq	%rsp, %rax
	movq	%rax, 8(%r15)
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
	movq	%r14, (%rbx)
	movq	$1, 8(%rbx)
	movq	$2, 16(%rbx)
	movq	$3, 24(%rbx)
	movq	%r12, 8(%r15)
	movq	%rbx, %rax
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
.Lfunc_end61:
	.size	"fn48:gen", .Lfunc_end61-"fn48:gen"
	.cfi_endproc
                                        # -- End function
	.globl	"fn49:pp"                       # -- Begin function fn49:pp
	.p2align	4, 0x90
	.type	"fn49:pp",@function
"fn49:pp":                              # @"fn49:pp"
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
	subq	$48, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %rax
	movq	%rax, 16(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r12)
	leaq	8(%rdi), %rax
	movq	%rax, 24(%rsp)
	leaq	16(%rdi), %rax
	leaq	24(%rdi), %rcx
	cmpq	$0, 8(%rdi)
	movq	%rax, 32(%rsp)
	movq	16(%rdi), %rax
	movq	%rcx, 40(%rsp)
	jle	.LBB62_3
# %bb.1:
	testq	%rax, %rax
	jle	.LBB62_3
# %bb.2:
	movq	%rdi, %rbx
	cmpq	$0, 24(%rdi)
	jle	.LBB62_3
# %bb.5:
	movq	(%rbx), %r13
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r14
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	$2, (%rax)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, 8(%r15)
	movq	%r15, 8(%r14)
	movq	%r14, (%r13)
	movq	24(%rsp), %rax
	cmpq	$0, (%rax)
	jle	.LBB62_8
# %bb.6:
	movq	32(%rsp), %rax
	cmpq	$0, (%rax)
	jle	.LBB62_8
# %bb.7:
	movq	40(%rsp), %rax
	cmpq	$0, (%rax)
	jle	.LBB62_8
# %bb.10:
	movq	(%rbx), %rax
	movq	(%rax), %rdi
	callq	"fn42:pt"@PLT
	movq	16(%rsp), %rcx
	movq	%rcx, 8(%r12)
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
.LBB62_3:                               # %.preheader47
	.cfi_def_cfa_offset 96
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_37(%rip), %r15
	.p2align	4, 0x90
.LBB62_4:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB62_4
.LBB62_8:                               # %.preheader
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_37(%rip), %r15
	.p2align	4, 0x90
.LBB62_9:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB62_9
.Lfunc_end62:
	.size	"fn49:pp", .Lfunc_end62-"fn49:pp"
	.cfi_endproc
                                        # -- End function
	.globl	"fn47:pp"                       # -- Begin function fn47:pp
	.p2align	4, 0x90
	.type	"fn47:pp",@function
"fn47:pp":                              # @"fn47:pp"
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
	movq	%rdi, %r14
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %r13
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r12)
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
	movq	%r15, %rdi
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
.Lfunc_end63:
	.size	"fn47:pp", .Lfunc_end63-"fn47:pp"
	.cfi_endproc
                                        # -- End function
	.globl	"fn46:gen"                      # -- Begin function fn46:gen
	.p2align	4, 0x90
	.type	"fn46:gen",@function
"fn46:gen":                             # @"fn46:gen"
	.cfi_startproc
# %bb.0:
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
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rbx, 8(%r14)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end64:
	.size	"fn46:gen", .Lfunc_end64-"fn46:gen"
	.cfi_endproc
                                        # -- End function
	.type	display_array,@object           # @display_array
	.bss
	.globl	display_array
	.p2align	4
display_array:
	.zero	32
	.size	display_array, 32

	.type	.L__unnamed_1,@object           # @0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__unnamed_1:
	.asciz	"Runtime Error: Division by zero\n"
	.size	.L__unnamed_1, 33

	.type	.L__unnamed_2,@object           # @1
.L__unnamed_2:
	.asciz	"abc"
	.size	.L__unnamed_2, 4

	.type	.L__unnamed_3,@object           # @2
.L__unnamed_3:
	.asciz	"abcd"
	.size	.L__unnamed_3, 5

	.type	.L__unnamed_5,@object           # @3
.L__unnamed_5:
	.asciz	"\n"
	.size	.L__unnamed_5, 2

	.type	.L__unnamed_4,@object           # @4
.L__unnamed_4:
	.asciz	"a_int = "
	.size	.L__unnamed_4, 9

	.type	.L__unnamed_6,@object           # @5
.L__unnamed_6:
	.asciz	"a_char = "
	.size	.L__unnamed_6, 10

	.type	.L__unnamed_7,@object           # @6
.L__unnamed_7:
	.asciz	"a_bool = "
	.size	.L__unnamed_7, 10

	.type	.L__unnamed_8,@object           # @7
.L__unnamed_8:
	.asciz	"a_float = "
	.size	.L__unnamed_8, 11

	.type	.L__unnamed_9,@object           # @8
.L__unnamed_9:
	.asciz	"a_string = "
	.size	.L__unnamed_9, 12

	.type	.L__unnamed_10,@object          # @9
.L__unnamed_10:
	.asciz	"b_string = "
	.size	.L__unnamed_10, 12

	.type	.L__unnamed_11,@object          # @10
.L__unnamed_11:
	.asciz	"c_string = "
	.size	.L__unnamed_11, 12

	.type	.L__unnamed_12,@object          # @11
.L__unnamed_12:
	.asciz	"0 = !a_ref = "
	.size	.L__unnamed_12, 14

	.type	.L__unnamed_13,@object          # @12
.L__unnamed_13:
	.asciz	"(incr a_ref) 1 = "
	.size	.L__unnamed_13, 18

	.type	.L__unnamed_14,@object          # @13
.L__unnamed_14:
	.asciz	"(decr a_ref) 0 = "
	.size	.L__unnamed_14, 18

	.type	.L__unnamed_37,@object          # @14
.L__unnamed_37:
	.asciz	"Runtime Error: Out of bounds error in array ref call\n"
	.size	.L__unnamed_37, 54

	.type	.L__unnamed_15,@object          # @15
.L__unnamed_15:
	.asciz	"421 = !a_array[4,2,1] = "
	.size	.L__unnamed_15, 25

	.type	.L__unnamed_16,@object          # @16
.L__unnamed_16:
	.asciz	"2 = tf1 1 = "
	.size	.L__unnamed_16, 13

	.type	.L__unnamed_17,@object          # @17
.L__unnamed_17:
	.asciz	"1 = ta1[0] = "
	.size	.L__unnamed_17, 14

	.type	.L__unnamed_18,@object          # @18
.L__unnamed_18:
	.asciz	".... = "
	.size	.L__unnamed_18, 8

	.type	.L__unnamed_109,@object         # @19
.L__unnamed_109:
	.asciz	"[inside f8_f: "
	.size	.L__unnamed_109, 15

	.type	.L__unnamed_110,@object         # @20
.L__unnamed_110:
	.asciz	"c = "
	.size	.L__unnamed_110, 5

	.type	.L__unnamed_111,@object         # @21
.L__unnamed_111:
	.asciz	", b = "
	.size	.L__unnamed_111, 7

	.type	.L__unnamed_112,@object         # @22
.L__unnamed_112:
	.asciz	"] "
	.size	.L__unnamed_112, 3

	.type	.L__unnamed_19,@object          # @23
.L__unnamed_19:
	.asciz	"42 = !a_ref = "
	.size	.L__unnamed_19, 15

	.type	.L__unnamed_20,@object          # @24
.L__unnamed_20:
	.asciz	"42 = !a_array[0,0,0] = "
	.size	.L__unnamed_20, 24

	.type	.L__unnamed_21,@object          # @25
.L__unnamed_21:
	.asciz	"1.0 = f8 f8_f = "
	.size	.L__unnamed_21, 17

	.type	.L__unnamed_113,@object         # @26
.L__unnamed_113:
	.asciz	"Runtime Error: Invalid constructor of type color encountered in comparison operation\n"
	.size	.L__unnamed_113, 86

	.type	.L__unnamed_38,@object          # @27
.L__unnamed_38:
	.asciz	"Runtime Error: Invalid constructor of type number encountered in comparison operation\n"
	.size	.L__unnamed_38, 87

	.type	.L__unnamed_114,@object         # @28
.L__unnamed_114:
	.asciz	"Runtime Error: Invalid constructor of type list encountered in comparison operation\n"
	.size	.L__unnamed_114, 85

	.type	.L__unnamed_115,@object         # @29
.L__unnamed_115:
	.asciz	"Runtime Error: Invalid constructor of type tree encountered in comparison operation\n"
	.size	.L__unnamed_115, 85

	.type	.L__unnamed_116,@object         # @30
.L__unnamed_116:
	.asciz	"Runtime Error: Invalid constructor of type forest encountered in comparison operation\n"
	.size	.L__unnamed_116, 87

	.type	.L__unnamed_117,@object         # @31
.L__unnamed_117:
	.asciz	"Runtime Error: Invalid constructor of type a encountered in comparison operation\n"
	.size	.L__unnamed_117, 82

	.type	.L__unnamed_118,@object         # @32
.L__unnamed_118:
	.asciz	"Runtime Error: Invalid constructor of type b encountered in comparison operation\n"
	.size	.L__unnamed_118, 82

	.type	.L__unnamed_119,@object         # @33
.L__unnamed_119:
	.asciz	"Runtime Error: Invalid constructor of type c encountered in comparison operation\n"
	.size	.L__unnamed_119, 82

	.type	.L__unnamed_120,@object         # @34
.L__unnamed_120:
	.asciz	"Runtime Error: Invalid constructor of type opt encountered in comparison operation\n"
	.size	.L__unnamed_120, 84

	.type	.L__unnamed_121,@object         # @35
.L__unnamed_121:
	.asciz	"Red"
	.size	.L__unnamed_121, 4

	.type	.L__unnamed_122,@object         # @36
.L__unnamed_122:
	.asciz	"Green"
	.size	.L__unnamed_122, 6

	.type	.L__unnamed_123,@object         # @37
.L__unnamed_123:
	.asciz	"Blue"
	.size	.L__unnamed_123, 5

	.type	.L__unnamed_124,@object         # @38
.L__unnamed_124:
	.asciz	"Runtime Error: Given expression could not be matched with some clause\n"
	.size	.L__unnamed_124, 71

	.type	.L__unnamed_125,@object         # @39
.L__unnamed_125:
	.asciz	"A "
	.size	.L__unnamed_125, 3

	.type	.L__unnamed_126,@object         # @40
.L__unnamed_126:
	.asciz	"B "
	.size	.L__unnamed_126, 3

	.type	.L__unnamed_127,@object         # @41
.L__unnamed_127:
	.asciz	"Integer "
	.size	.L__unnamed_127, 9

	.type	.L__unnamed_128,@object         # @42
.L__unnamed_128:
	.asciz	"Real "
	.size	.L__unnamed_128, 6

	.type	.L__unnamed_129,@object         # @43
.L__unnamed_129:
	.asciz	"Complex "
	.size	.L__unnamed_129, 9

	.type	.L__unnamed_130,@object         # @44
.L__unnamed_130:
	.asciz	"Complex j"
	.size	.L__unnamed_130, 10

	.type	.L__unnamed_131,@object         # @45
.L__unnamed_131:
	.asciz	"+j"
	.size	.L__unnamed_131, 3

	.type	.L__unnamed_132,@object         # @46
.L__unnamed_132:
	.asciz	"-j"
	.size	.L__unnamed_132, 3

	.type	.L__unnamed_22,@object          # @47
.L__unnamed_22:
	.asciz	"Red = "
	.size	.L__unnamed_22, 7

	.type	.L__unnamed_23,@object          # @48
.L__unnamed_23:
	.asciz	"Blue = "
	.size	.L__unnamed_23, 8

	.type	.L__unnamed_24,@object          # @49
.L__unnamed_24:
	.asciz	"A 1 = "
	.size	.L__unnamed_24, 7

	.type	.L__unnamed_25,@object          # @50
.L__unnamed_25:
	.asciz	"B 2.1 = "
	.size	.L__unnamed_25, 9

	.type	.L__unnamed_26,@object          # @51
.L__unnamed_26:
	.asciz	"pmtype test:\n"
	.size	.L__unnamed_26, 14

	.type	.L__unnamed_27,@object          # @52
.L__unnamed_27:
	.asciz	"Integer 2 = "
	.size	.L__unnamed_27, 13

	.type	.L__unnamed_28,@object          # @53
.L__unnamed_28:
	.asciz	"Real 1.2345 = "
	.size	.L__unnamed_28, 15

	.type	.L__unnamed_29,@object          # @54
.L__unnamed_29:
	.asciz	"Complex 1.11 = "
	.size	.L__unnamed_29, 16

	.type	.L__unnamed_30,@object          # @55
.L__unnamed_30:
	.asciz	"Complex j2.22 = "
	.size	.L__unnamed_30, 17

	.type	.L__unnamed_31,@object          # @56
.L__unnamed_31:
	.asciz	"Complex 3.33-j4.44 = "
	.size	.L__unnamed_31, 22

	.type	.L__unnamed_32,@object          # @57
.L__unnamed_32:
	.asciz	"nat equality:\n"
	.size	.L__unnamed_32, 15

	.type	.L__unnamed_33,@object          # @58
.L__unnamed_33:
	.asciz	"true = "
	.size	.L__unnamed_33, 8

	.type	.L__unnamed_34,@object          # @59
.L__unnamed_34:
	.asciz	"false = "
	.size	.L__unnamed_34, 9

	.type	.L__unnamed_35,@object          # @60
.L__unnamed_35:
	.asciz	"nat inequality:\n"
	.size	.L__unnamed_35, 17

	.type	.L__unnamed_36,@object          # @61
.L__unnamed_36:
	.asciz	"struct equality:\n"
	.size	.L__unnamed_36, 18

	.type	.L__unnamed_39,@object          # @62
.L__unnamed_39:
	.asciz	"struct inequality:\n"
	.size	.L__unnamed_39, 20

	.type	.L__unnamed_42,@object          # @63
.L__unnamed_42:
	.asciz	"1 = dim 3 ar = "
	.size	.L__unnamed_42, 16

	.type	.L__unnamed_40,@object          # @64
.L__unnamed_40:
	.asciz	"1 = !(f9 1) = "
	.size	.L__unnamed_40, 15

	.type	.L__unnamed_41,@object          # @65
.L__unnamed_41:
	.asciz	"1 = const2 = "
	.size	.L__unnamed_41, 14

	.type	.L__unnamed_133,@object         # @66
.L__unnamed_133:
	.asciz	"while loop: (0 -> 10)\n"
	.size	.L__unnamed_133, 23

	.type	.L__unnamed_134,@object         # @67
.L__unnamed_134:
	.asciz	"for loop: (0 -> 5 -> 0)\n"
	.size	.L__unnamed_134, 25

	.type	.L__unnamed_43,@object          # @68
.L__unnamed_43:
	.asciz	"... = "
	.size	.L__unnamed_43, 7

	.type	.L__unnamed_44,@object          # @69
.L__unnamed_44:
	.asciz	"unary operators:\n"
	.size	.L__unnamed_44, 18

	.type	.L__unnamed_45,@object          # @70
.L__unnamed_45:
	.asciz	"1 = "
	.size	.L__unnamed_45, 5

	.type	.L__unnamed_46,@object          # @71
.L__unnamed_46:
	.asciz	"-1 = "
	.size	.L__unnamed_46, 6

	.type	.L__unnamed_47,@object          # @72
.L__unnamed_47:
	.asciz	"1.0 = "
	.size	.L__unnamed_47, 7

	.type	.L__unnamed_48,@object          # @73
.L__unnamed_48:
	.asciz	"-1.0 = "
	.size	.L__unnamed_48, 8

	.type	.L__unnamed_49,@object          # @74
.L__unnamed_49:
	.asciz	"binary operators:\n"
	.size	.L__unnamed_49, 19

	.type	.L__unnamed_50,@object          # @75
.L__unnamed_50:
	.asciz	"3 = "
	.size	.L__unnamed_50, 5

	.type	.L__unnamed_51,@object          # @76
.L__unnamed_51:
	.asciz	"2 = "
	.size	.L__unnamed_51, 5

	.type	.L__unnamed_52,@object          # @77
.L__unnamed_52:
	.asciz	"3.0 = "
	.size	.L__unnamed_52, 7

	.type	.L__unnamed_53,@object          # @78
.L__unnamed_53:
	.asciz	"2.0 = "
	.size	.L__unnamed_53, 7

	.type	.L__unnamed_54,@object          # @79
.L__unnamed_54:
	.asciz	"2.5 = "
	.size	.L__unnamed_54, 7

	.type	.L__unnamed_55,@object          # @80
.L__unnamed_55:
	.asciz	"25.0 = "
	.size	.L__unnamed_55, 8

	.type	.L__unnamed_56,@object          # @81
.L__unnamed_56:
	.asciz	"escaping in nested function example:\n"
	.size	.L__unnamed_56, 38

	.type	.L__unnamed_57,@object          # @82
.L__unnamed_57:
	.asciz	"6 = "
	.size	.L__unnamed_57, 5

	.type	.L__unnamed_58,@object          # @83
.L__unnamed_58:
	.asciz	"escaping for loop example:\n"
	.size	.L__unnamed_58, 28

	.type	.L__unnamed_135,@object         # @84
.L__unnamed_135:
	.asciz	": "
	.size	.L__unnamed_135, 3

	.type	.L__unnamed_136,@object         # @85
.L__unnamed_136:
	.asciz	"i"
	.size	.L__unnamed_136, 2

	.type	.L__unnamed_137,@object         # @86
.L__unnamed_137:
	.asciz	"j"
	.size	.L__unnamed_137, 2

	.type	.L__unnamed_138,@object         # @87
.L__unnamed_138:
	.asciz	"x"
	.size	.L__unnamed_138, 2

	.type	.L__unnamed_139,@object         # @88
.L__unnamed_139:
	.asciz	"a"
	.size	.L__unnamed_139, 2

	.type	.L__unnamed_140,@object         # @89
.L__unnamed_140:
	.asciz	"i + j + x + a"
	.size	.L__unnamed_140, 14

	.type	.L__unnamed_141,@object         # @90
.L__unnamed_141:
	.asciz	"Runtime Error: Invalid constructor of type nstd encountered in comparison operation\n"
	.size	.L__unnamed_141, 85

	.type	.L__unnamed_59,@object          # @91
.L__unnamed_59:
	.asciz	"escaping pattern match variable:\n"
	.size	.L__unnamed_59, 34

	.type	.L__unnamed_60,@object          # @92
.L__unnamed_60:
	.asciz	"T1 3 = "
	.size	.L__unnamed_60, 8

	.type	.L__unnamed_61,@object          # @93
.L__unnamed_61:
	.asciz	"T2 = "
	.size	.L__unnamed_61, 6

	.type	.L__unnamed_62,@object          # @94
.L__unnamed_62:
	.asciz	"0 = "
	.size	.L__unnamed_62, 5

	.type	.L__unnamed_142,@object         # @95
.L__unnamed_142:
	.asciz	"Runtime Error: Invalid constructor of type t encountered in comparison operation\n"
	.size	.L__unnamed_142, 82

	.type	.L__unnamed_143,@object         # @96
.L__unnamed_143:
	.asciz	"T1\n"
	.size	.L__unnamed_143, 4

	.type	.L__unnamed_144,@object         # @97
.L__unnamed_144:
	.asciz	"T2 "
	.size	.L__unnamed_144, 4

	.type	.L__unnamed_63,@object          # @98
.L__unnamed_63:
	.asciz	"T1 = "
	.size	.L__unnamed_63, 6

	.type	.L__unnamed_64,@object          # @99
.L__unnamed_64:
	.asciz	"T2 T1 = "
	.size	.L__unnamed_64, 9

	.type	.L__unnamed_65,@object          # @100
.L__unnamed_65:
	.asciz	"T2 T2 T1 = "
	.size	.L__unnamed_65, 12

	.type	.L__unnamed_66,@object          # @101
.L__unnamed_66:
	.asciz	"Insert int: "
	.size	.L__unnamed_66, 13

	.type	.L__unnamed_67,@object          # @102
.L__unnamed_67:
	.asciz	"Inserted int: "
	.size	.L__unnamed_67, 15

	.type	.L__unnamed_68,@object          # @103
.L__unnamed_68:
	.asciz	"Insert bool: "
	.size	.L__unnamed_68, 14

	.type	.L__unnamed_69,@object          # @104
.L__unnamed_69:
	.asciz	"Inserted bool: "
	.size	.L__unnamed_69, 16

	.type	.L__unnamed_70,@object          # @105
.L__unnamed_70:
	.asciz	"Insert char: "
	.size	.L__unnamed_70, 14

	.type	.L__unnamed_71,@object          # @106
.L__unnamed_71:
	.asciz	"Inserted char: "
	.size	.L__unnamed_71, 16

	.type	.L__unnamed_72,@object          # @107
.L__unnamed_72:
	.asciz	"Insert float: "
	.size	.L__unnamed_72, 15

	.type	.L__unnamed_73,@object          # @108
.L__unnamed_73:
	.asciz	"Inserted float: "
	.size	.L__unnamed_73, 17

	.type	.L__unnamed_74,@object          # @109
.L__unnamed_74:
	.asciz	"Insert string of 3 chars: "
	.size	.L__unnamed_74, 27

	.type	.L__unnamed_75,@object          # @110
.L__unnamed_75:
	.asciz	"Inserted string: "
	.size	.L__unnamed_75, 18

	.type	.L__unnamed_76,@object          # @111
.L__unnamed_76:
	.asciz	"42 = abs(42) = "
	.size	.L__unnamed_76, 16

	.type	.L__unnamed_77,@object          # @112
.L__unnamed_77:
	.asciz	"42 = abs(-42) = "
	.size	.L__unnamed_77, 17

	.type	.L__unnamed_78,@object          # @113
.L__unnamed_78:
	.asciz	"4.2 = fabs(4.2) = "
	.size	.L__unnamed_78, 19

	.type	.L__unnamed_79,@object          # @114
.L__unnamed_79:
	.asciz	"4.2 = fabs(-.4.2) = "
	.size	.L__unnamed_79, 21

	.type	.L__unnamed_80,@object          # @115
.L__unnamed_80:
	.asciz	"42.0 = sqrt(42.0 *. 42.0) = "
	.size	.L__unnamed_80, 29

	.type	.L__unnamed_81,@object          # @116
.L__unnamed_81:
	.asciz	"-0.91 = sin(42.0 (in radians)) = "
	.size	.L__unnamed_81, 34

	.type	.L__unnamed_82,@object          # @117
.L__unnamed_82:
	.asciz	"-0.39 = cos(42.0) = "
	.size	.L__unnamed_82, 21

	.type	.L__unnamed_83,@object          # @118
.L__unnamed_83:
	.asciz	"2.291 = tan(42.0) = "
	.size	.L__unnamed_83, 21

	.type	.L__unnamed_84,@object          # @119
.L__unnamed_84:
	.asciz	"1.546 = atan(42.0) = "
	.size	.L__unnamed_84, 22

	.type	.L__unnamed_85,@object          # @120
.L__unnamed_85:
	.asciz	"66.68 = exp(4.2) = "
	.size	.L__unnamed_85, 20

	.type	.L__unnamed_86,@object          # @121
.L__unnamed_86:
	.asciz	"3.737 = ln(42.0) = "
	.size	.L__unnamed_86, 20

	.type	.L__unnamed_87,@object          # @122
.L__unnamed_87:
	.asciz	"3.1415 = pi() = "
	.size	.L__unnamed_87, 17

	.type	.L__unnamed_88,@object          # @123
.L__unnamed_88:
	.asciz	"Initial cnt: "
	.size	.L__unnamed_88, 14

	.type	.L__unnamed_89,@object          # @124
.L__unnamed_89:
	.asciz	"Increment cnt: "
	.size	.L__unnamed_89, 16

	.type	.L__unnamed_90,@object          # @125
.L__unnamed_90:
	.asciz	"Decrement cnt: "
	.size	.L__unnamed_90, 16

	.type	.L__unnamed_91,@object          # @126
.L__unnamed_91:
	.asciz	"42.0 = float_of_int 42 = "
	.size	.L__unnamed_91, 26

	.type	.L__unnamed_92,@object          # @127
.L__unnamed_92:
	.asciz	"42 = int_of_float 42.0 = "
	.size	.L__unnamed_92, 26

	.type	.L__unnamed_93,@object          # @128
.L__unnamed_93:
	.asciz	"4 = round 4.2 = "
	.size	.L__unnamed_93, 17

	.type	.L__unnamed_94,@object          # @129
.L__unnamed_94:
	.asciz	"5 = round 4.5 = "
	.size	.L__unnamed_94, 17

	.type	.L__unnamed_95,@object          # @130
.L__unnamed_95:
	.asciz	"97 = int_of_char 'a' = "
	.size	.L__unnamed_95, 24

	.type	.L__unnamed_96,@object          # @131
.L__unnamed_96:
	.asciz	"a = char_of_int 97 = "
	.size	.L__unnamed_96, 22

	.type	.L__unnamed_97,@object          # @132
.L__unnamed_97:
	.asciz	"5 = strlen \"hello\" = "
	.size	.L__unnamed_97, 22

	.type	.L__unnamed_98,@object          # @133
.L__unnamed_98:
	.asciz	"hello"
	.size	.L__unnamed_98, 6

	.type	.L__unnamed_99,@object          # @134
.L__unnamed_99:
	.asciz	"0 = strcmp \"hello\" \"hello\" = "
	.size	.L__unnamed_99, 30

	.type	.L__unnamed_100,@object         # @135
.L__unnamed_100:
	.asciz	"<0 = strcmp \"hello\" \"world\" = "
	.size	.L__unnamed_100, 31

	.type	.L__unnamed_101,@object         # @136
.L__unnamed_101:
	.asciz	"world"
	.size	.L__unnamed_101, 6

	.type	.L__unnamed_102,@object         # @137
.L__unnamed_102:
	.asciz	">0 = strcmp \"world\" \"hello\" = "
	.size	.L__unnamed_102, 31

	.type	.L__unnamed_103,@object         # @138
.L__unnamed_103:
	.asciz	"dest = \"\"; str_cpy dest \"hello\"; dest = "
	.size	.L__unnamed_103, 41

	.type	.L__unnamed_104,@object         # @139
.L__unnamed_104:
	.asciz	"normal behaviour of strcpy and strcat with enough buffer size:\n"
	.size	.L__unnamed_104, 64

	.type	.L__unnamed_105,@object         # @140
.L__unnamed_105:
	.asciz	" world"
	.size	.L__unnamed_105, 7

	.type	.L__unnamed_106,@object         # @141
.L__unnamed_106:
	.asciz	" dest [20], strcpy dest \"hello\", strcat dest \" world\", dest = "
	.size	.L__unnamed_106, 63

	.type	.L__unnamed_107,@object         # @142
.L__unnamed_107:
	.asciz	"undefined behaviour of strcpy and strcat with less buffer size:\n"
	.size	.L__unnamed_107, 65

	.type	.L__unnamed_108,@object         # @143
.L__unnamed_108:
	.asciz	" dest [1], strcpy dest \"hello\", strcat dest \" world\", dest = "
	.size	.L__unnamed_108, 62

	.section	".note.GNU-stack","",@progbits
