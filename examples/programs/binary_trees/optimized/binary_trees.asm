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
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	callq	GC_init@PLT
	movq	display_array@GOTPCREL(%rip), %r12
	movq	(%r12), %rax
	movq	%rax, 64(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, (%r12)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 56(%rsp)
	movq	(%r12), %rax
	movq	(%rax), %rax
	movq	$65, (%rax)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, 8(%rsp)
	movq	%rax, 16(%rsp)
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, 72(%rsp)
	movq	$1, (%rax)
	movq	%rax, (%rbx)
	movq	%rsp, %r14
	movq	%r14, 88(%rsp)
	movq	%r14, 96(%rsp)
	movq	72(%rsp), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 24(%rsp)
	movabsq	$1898629604128915555, %r15      # imm = 0x1A594990CA250063
	movabsq	$-6640827866535438581, %r13     # imm = 0xA3D70A3D70A3D70B
	.p2align	4, 0x90
.LBB4_1:                                # =>This Inner Loop Header: Depth=1
	movq	24(%rsp), %rbp
	movq	32(%rsp), %rdi
	movq	(%r12), %rax
	movq	8(%r12), %rbx
	movq	%r14, 8(%r12)
	movq	(%rax), %rsi
	imulq	$4241, (%rsi), %rcx             # imm = 0x1091
	addq	$22, %rcx
	movq	%rcx, %rax
	imulq	%r15
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$10, %rdx
	addq	%rax, %rdx
	imulq	$9949, %rdx, %rax               # imm = 0x26DD
	subq	%rax, %rcx
	movq	%rcx, (%rsi)
	movq	(%r12), %rax
	movq	(%rax), %rax
	movq	(%rax), %rsi
	movq	%rsi, %rax
	imulq	%r13
	addq	%rsi, %rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$6, %rdx
	addq	%rax, %rdx
	imulq	$100, %rdx, %rax
	subq	%rax, %rsi
	movq	%rbx, 8(%r12)
	callq	"fn1:treeInsert"@PLT
	movq	%rax, 80(%rsp)
	movq	8(%rsp), %rcx
	movq	%rax, (%rcx)
	incq	%rbp
	movq	%rbp, 104(%rsp)
	cmpq	$10, %rbp
	ja	.LBB4_3
# %bb.2:                                # %._crit_edge61
                                        #   in Loop: Header=BB4_1 Depth=1
	movq	80(%rsp), %rax
	movq	%rax, 32(%rsp)
	movq	%rbp, 24(%rsp)
	jmp	.LBB4_1
.LBB4_3:
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
	movq	$15, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn4:treePrint"@PLT
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn5:treeCount"@PLT
	movq	%rax, 48(%rsp)
	testq	%rax, %rax
	jle	.LBB4_8
# %bb.4:                                # %.lr.ph
	movq	8(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn8:choose"@PLT
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
	leaq	.L__unnamed_4(%rip), %rax
	movq	%rax, (%rbx)
	movq	$10, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r15, %rdi
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
	leaq	.L__unnamed_5(%rip), %r13
	movq	%r13, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rdi
	movq	%r15, %rsi
	callq	"fn3:treeDelete"@PLT
	movq	8(%rsp), %rcx
	movq	%rax, (%rcx)
	movq	16(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn4:treePrint"@PLT
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	cmpq	$2, 48(%rsp)
	jge	.LBB4_5
.LBB4_8:
	movq	64(%rsp), %rax
	movq	%rax, (%r12)
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
.LBB4_5:                                # %.peel.next
	.cfi_def_cfa_offset 176
	movq	$2, 40(%rsp)
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	.p2align	4, 0x90
.LBB4_6:                                # =>This Inner Loop Header: Depth=1
	movq	40(%rsp), %rbp
	movq	16(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn8:choose"@PLT
	movq	%rax, %r15
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
	movq	$10, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r15, %rdi
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
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rax
	movq	(%rax), %rdi
	movq	%r15, %rsi
	callq	"fn3:treeDelete"@PLT
	movq	16(%rsp), %rcx
	movq	%rax, (%rcx)
	movq	16(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn4:treePrint"@PLT
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	incq	%rbp
	movq	%rbp, 112(%rsp)
	cmpq	48(%rsp), %rbp
	jg	.LBB4_8
# %bb.7:                                # %._crit_edge63
                                        #   in Loop: Header=BB4_6 Depth=1
	movq	%rbp, 40(%rsp)
	jmp	.LBB4_6
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
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
	subq	$64, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -16
	movq	%rsi, 16(%rsp)
	movq	%rdi, 8(%rsp)
	movb	$1, 4(%rsp)
	.p2align	4, 0x90
.LBB5_1:                                # %tailrecurse
                                        # =>This Inner Loop Header: Depth=1
	movzbl	4(%rsp), %ecx
	movq	8(%rsp), %rdx
	movq	16(%rsp), %rax
	movb	%cl, 6(%rsp)
	movq	%rdx, 24(%rsp)
	movq	%rax, 48(%rsp)
	movq	(%rdx), %rcx
	movq	%rcx, 56(%rsp)
	cmpq	(%rax), %rcx
	jne	.LBB5_2
# %bb.3:                                # %NodeBlock
                                        #   in Loop: Header=BB5_1 Depth=1
	cmpq	$2, %rcx
	jl	.LBB5_6
# %bb.4:                                # %LeafBlock18
                                        #   in Loop: Header=BB5_1 Depth=1
	jne	.LBB5_9
# %bb.5:                                #   in Loop: Header=BB5_1 Depth=1
	movq	24(%rsp), %rcx
	movq	8(%rcx), %rdx
	movq	16(%rcx), %rdi
	movq	16(%rax), %rsi
	movq	24(%rax), %rbx
	cmpq	8(%rax), %rdx
	movq	%rbx, 32(%rsp)
	movq	24(%rcx), %rax
	movq	%rax, 40(%rsp)
	sete	%bl
	callq	"_tree:1_equality"@PLT
	andb	%bl, %al
	andb	6(%rsp), %al
	movb	%al, 7(%rsp)
	movq	40(%rsp), %rcx
	movq	32(%rsp), %rdx
	movq	%rdx, 16(%rsp)
	movq	%rcx, 8(%rsp)
	movb	%al, 4(%rsp)
	jmp	.LBB5_1
.LBB5_2:                                # %tailrecurse._crit_edge
	movb	$0, 5(%rsp)
	jmp	.LBB5_8
.LBB5_6:                                # %LeafBlock
	cmpq	$1, %rcx
	jne	.LBB5_9
# %bb.7:                                # %LeafBlock._crit_edge
	movb	$1, 5(%rsp)
.LBB5_8:
	movb	5(%rsp), %al
	andb	6(%rsp), %al
	addq	$64, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
	.p2align	4, 0x90
.LBB5_9:                                # =>This Inner Loop Header: Depth=1
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
	leaq	.L__unnamed_6(%rip), %rax
	movq	%rax, (%rbx)
	movq	$85, 8(%rbx)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	lla_exit_with_error@PLT
	jmp	.LBB5_9
.Lfunc_end5:
	.size	"_tree:1_equality", .Lfunc_end5-"_tree:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"fn1:treeInsert"                # -- Begin function fn1:treeInsert
	.p2align	4, 0x90
	.type	"fn1:treeInsert",@function
"fn1:treeInsert":                       # @"fn1:treeInsert"
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
	subq	$88, %rsp
	.cfi_def_cfa_offset 128
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rsi, %r14
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %rax
	movq	%rax, 48(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r12)
	movq	(%rdi), %rax
	movq	%rax, 80(%rsp)
	cmpq	$1, %rax
	jne	.LBB6_2
# %bb.1:
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, 56(%rsp)
	movq	$2, (%rax)
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r15
	movq	$1, (%rax)
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%r14, 8(%rbx)
	movq	%r15, 16(%rbx)
	movq	%rax, 24(%rbx)
	movq	56(%rsp), %rax
.LBB6_10:
	movq	%rax, 16(%rsp)
.LBB6_11:
	movq	16(%rsp), %rax
	movq	48(%rsp), %rcx
	movq	%rcx, 8(%r12)
	addq	$88, %rsp
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
.LBB6_2:
	.cfi_def_cfa_offset 128
	cmpq	$2, %rax
	jne	.LBB6_3
# %bb.5:
	movq	8(%rdi), %rax
	movq	%rax, 24(%rsp)
	movq	16(%rdi), %rcx
	movq	%rcx, 32(%rsp)
	movq	24(%rdi), %rcx
	movq	%rcx, 40(%rsp)
	cmpq	%r14, %rax
	jle	.LBB6_7
# %bb.6:
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, 64(%rsp)
	movq	$2, (%rax)
	movq	32(%rsp), %rdi
	movq	%r14, %rsi
	callq	"fn1:treeInsert"@PLT
	movq	24(%rsp), %rcx
	movq	%rcx, 8(%rbx)
	movq	%rax, 16(%rbx)
	movq	40(%rsp), %rax
	movq	%rax, 24(%rbx)
	movq	64(%rsp), %rax
	jmp	.LBB6_10
.LBB6_3:
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_7(%rip), %r15
	.p2align	4, 0x90
.LBB6_4:                                # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB6_4
.LBB6_7:
	jge	.LBB6_8
# %bb.9:
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, 72(%rsp)
	movq	$2, (%rax)
	movq	40(%rsp), %rdi
	movq	%r14, %rsi
	callq	"fn1:treeInsert"@PLT
	movq	24(%rsp), %rcx
	movq	%rcx, 8(%rbx)
	movq	32(%rsp), %rcx
	movq	%rcx, 16(%rbx)
	movq	%rax, 24(%rbx)
	movq	72(%rsp), %rax
	jmp	.LBB6_10
.LBB6_8:                                # %._crit_edge
	movq	%rdi, 16(%rsp)
	jmp	.LBB6_11
.Lfunc_end6:
	.size	"fn1:treeInsert", .Lfunc_end6-"fn1:treeInsert"
	.cfi_endproc
                                        # -- End function
	.globl	"fn2:treeMerge"                 # -- Begin function fn2:treeMerge
	.p2align	4, 0x90
	.type	"fn2:treeMerge",@function
"fn2:treeMerge":                        # @"fn2:treeMerge"
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r15
	movq	display_array@GOTPCREL(%rip), %r12
	movq	8(%r12), %rax
	movq	%rax, 16(%rsp)
	movq	%rsp, %rax
	movq	%rax, 8(%r12)
	movq	(%rdi), %rax
	movq	%rax, 32(%rsp)
	cmpq	$1, %rax
	jne	.LBB7_2
# %bb.1:                                # %._crit_edge
	movq	%r15, 8(%rsp)
	jmp	.LBB7_6
.LBB7_2:
	cmpq	$2, %rax
	jne	.LBB7_3
# %bb.5:
	movq	8(%rdi), %r13
	movq	16(%rdi), %rbp
	movq	24(%rdi), %r14
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, 24(%rsp)
	movq	$2, (%rax)
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	"fn2:treeMerge"@PLT
	movq	%r13, 8(%rbx)
	movq	%rbp, 16(%rbx)
	movq	%rax, 24(%rbx)
	movq	24(%rsp), %rax
	movq	%rax, 8(%rsp)
.LBB7_6:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rcx, 8(%r12)
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
.LBB7_3:
	.cfi_def_cfa_offset 96
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_7(%rip), %r15
	.p2align	4, 0x90
.LBB7_4:                                # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB7_4
.Lfunc_end7:
	.size	"fn2:treeMerge", .Lfunc_end7-"fn2:treeMerge"
	.cfi_endproc
                                        # -- End function
	.globl	"fn3:treeDelete"                # -- Begin function fn3:treeDelete
	.p2align	4, 0x90
	.type	"fn3:treeDelete",@function
"fn3:treeDelete":                       # @"fn3:treeDelete"
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
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %rax
	movq	%rax, 40(%rsp)
	movq	%rsp, %rax
	movq	%rax, 8(%r15)
	movq	(%rdi), %rax
	movq	%rax, 64(%rsp)
	cmpq	$1, %rax
	jne	.LBB8_2
# %bb.1:                                # %._crit_edge
	movq	%rdi, 8(%rsp)
	jmp	.LBB8_11
.LBB8_2:
	cmpq	$2, %rax
	jne	.LBB8_3
# %bb.5:
	movq	%rsi, %rbx
	movq	8(%rdi), %rax
	movq	%rax, 24(%rsp)
	movq	16(%rdi), %rcx
	movq	%rcx, 16(%rsp)
	movq	24(%rdi), %rsi
	movq	%rsi, 32(%rsp)
	cmpq	%rbx, %rax
	jle	.LBB8_7
# %bb.6:
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r14
	movq	%rax, 48(%rsp)
	movq	$2, (%rax)
	movq	16(%rsp), %rdi
	movq	%rbx, %rsi
	callq	"fn3:treeDelete"@PLT
	movq	24(%rsp), %rcx
	movq	%rcx, 8(%r14)
	movq	%rax, 16(%r14)
	movq	32(%rsp), %rax
	movq	%rax, 24(%r14)
	movq	48(%rsp), %rax
	jmp	.LBB8_10
.LBB8_3:
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_7(%rip), %r15
	.p2align	4, 0x90
.LBB8_4:                                # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB8_4
.LBB8_7:
	jge	.LBB8_9
# %bb.8:
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r14
	movq	%rax, 56(%rsp)
	movq	$2, (%rax)
	movq	32(%rsp), %rdi
	movq	%rbx, %rsi
	callq	"fn3:treeDelete"@PLT
	movq	24(%rsp), %rcx
	movq	%rcx, 8(%r14)
	movq	16(%rsp), %rcx
	movq	%rcx, 16(%r14)
	movq	%rax, 24(%r14)
	movq	56(%rsp), %rax
	jmp	.LBB8_10
.LBB8_9:
	movq	16(%rsp), %rdi
	callq	"fn2:treeMerge"@PLT
	movq	%rax, 72(%rsp)
.LBB8_10:
	movq	%rax, 8(%rsp)
.LBB8_11:
	movq	8(%rsp), %rax
	movq	40(%rsp), %rcx
	movq	%rcx, 8(%r15)
	addq	$80, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end8:
	.size	"fn3:treeDelete", .Lfunc_end8-"fn3:treeDelete"
	.cfi_endproc
                                        # -- End function
	.globl	"fn4:treePrint"                 # -- Begin function fn4:treePrint
	.p2align	4, 0x90
	.type	"fn4:treePrint",@function
"fn4:treePrint":                        # @"fn4:treePrint"
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
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %r13
	movq	8(%r13), %rax
	movq	%rax, 16(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%r13)
	movq	(%rdi), %rax
	movq	%rax, 24(%rsp)
	cmpq	$1, %rax
	jne	.LBB9_2
# %bb.1:                                # %._crit_edge
	movb	$0, 7(%rsp)
	jmp	.LBB9_6
.LBB9_2:
	cmpq	$2, %rax
	jne	.LBB9_3
# %bb.5:
	movq	8(%rdi), %rax
	movq	16(%rdi), %r12
	movq	24(%rdi), %r14
	movq	%rax, %rdi
	callq	lla_print_int@PLT
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r12, %rdi
	callq	"fn4:treePrint"@PLT
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	%r14, %rdi
	callq	"fn4:treePrint"@PLT
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
	andb	$1, %al
	movb	%al, 15(%rsp)
	movb	%al, 7(%rsp)
.LBB9_6:
	movq	16(%rsp), %rax
	movq	%rax, 8(%r13)
	movb	7(%rsp), %al
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
.LBB9_3:
	.cfi_def_cfa_offset 80
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_7(%rip), %r15
	.p2align	4, 0x90
.LBB9_4:                                # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB9_4
.Lfunc_end9:
	.size	"fn4:treePrint", .Lfunc_end9-"fn4:treePrint"
	.cfi_endproc
                                        # -- End function
	.globl	"fn5:treeCount"                 # -- Begin function fn5:treeCount
	.p2align	4, 0x90
	.type	"fn5:treeCount",@function
"fn5:treeCount":                        # @"fn5:treeCount"
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
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %rax
	movq	%rax, 24(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 8(%rbx)
	movq	(%rdi), %rax
	movq	%rax, 32(%rsp)
	cmpq	$1, %rax
	jne	.LBB10_2
# %bb.1:                                # %._crit_edge
	movq	$0, 16(%rsp)
	jmp	.LBB10_6
.LBB10_2:
	cmpq	$2, %rax
	jne	.LBB10_3
# %bb.5:
	movq	16(%rdi), %rax
	movq	24(%rdi), %r14
	movq	%rax, %rdi
	callq	"fn5:treeCount"@PLT
	movq	%rax, %r15
	movq	%r14, %rdi
	callq	"fn5:treeCount"@PLT
	leaq	1(%r15,%rax), %rax
	movq	%rax, 40(%rsp)
	movq	%rax, 16(%rsp)
.LBB10_6:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	%rcx, 8(%rbx)
	addq	$48, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB10_3:
	.cfi_def_cfa_offset 80
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_7(%rip), %r15
	.p2align	4, 0x90
.LBB10_4:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB10_4
.Lfunc_end10:
	.size	"fn5:treeCount", .Lfunc_end10-"fn5:treeCount"
	.cfi_endproc
                                        # -- End function
	.globl	"fn6:next"                      # -- Begin function fn6:next
	.p2align	4, 0x90
	.type	"fn6:next",@function
"fn6:next":                             # @"fn6:next"
# %bb.0:
	movq	display_array@GOTPCREL(%rip), %rsi
	movq	(%rsi), %rax
	movq	8(%rsi), %r8
	leaq	-8(%rsp), %rcx
	movq	%rcx, 8(%rsi)
	movq	(%rax), %rdi
	imulq	$4241, (%rdi), %rcx             # imm = 0x1091
	addq	$22, %rcx
	movabsq	$1898629604128915555, %rdx      # imm = 0x1A594990CA250063
	movq	%rcx, %rax
	imulq	%rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$10, %rdx
	addq	%rax, %rdx
	imulq	$9949, %rdx, %rax               # imm = 0x26DD
	subq	%rax, %rcx
	movq	%rcx, (%rdi)
	movq	(%rsi), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movq	%r8, 8(%rsi)
	retq
.Lfunc_end11:
	.size	"fn6:next", .Lfunc_end11-"fn6:next"
                                        # -- End function
	.globl	"fn7:random"                    # -- Begin function fn7:random
	.p2align	4, 0x90
	.type	"fn7:random",@function
"fn7:random":                           # @"fn7:random"
# %bb.0:
	movq	display_array@GOTPCREL(%rip), %r9
	movq	(%r9), %rax
	movq	8(%r9), %r8
	leaq	-8(%rsp), %rcx
	movq	%rcx, 8(%r9)
	movq	(%rax), %rsi
	imulq	$4241, (%rsi), %rcx             # imm = 0x1091
	addq	$22, %rcx
	movabsq	$1898629604128915555, %rdx      # imm = 0x1A594990CA250063
	movq	%rcx, %rax
	imulq	%rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$10, %rdx
	addq	%rax, %rdx
	imulq	$9949, %rdx, %rax               # imm = 0x26DD
	subq	%rax, %rcx
	movq	%rcx, (%rsi)
	movq	(%r9), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	cqto
	idivq	%rdi
	movq	%rdx, %rax
	movq	%r8, 8(%r9)
	retq
.Lfunc_end12:
	.size	"fn7:random", .Lfunc_end12-"fn7:random"
                                        # -- End function
	.globl	"fn8:choose"                    # -- Begin function fn8:choose
	.p2align	4, 0x90
	.type	"fn8:choose",@function
"fn8:choose":                           # @"fn8:choose"
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
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %rax
	movq	%rax, 32(%rsp)
	movq	%rsp, %r14
	movq	%r14, 8(%rbx)
	cmpq	$2, (%rdi)
	jne	.LBB13_1
# %bb.3:
	movq	8(%rdi), %rax
	movq	%rax, 40(%rsp)
	movq	16(%rdi), %rax
	movq	%rax, 48(%rsp)
	movq	24(%rdi), %rcx
	movq	%rcx, 16(%rsp)
	movq	%rax, %rdi
	callq	"fn5:treeCount"@PLT
	movq	%rax, 24(%rsp)
	movq	16(%rsp), %rdi
	callq	"fn5:treeCount"@PLT
	movq	24(%rsp), %rcx
	leaq	1(%rcx,%rax), %rsi
	movq	(%rbx), %rax
	movq	8(%rbx), %r8
	movq	%r14, 8(%rbx)
	movq	(%rax), %rdi
	imulq	$4241, (%rdi), %rcx             # imm = 0x1091
	addq	$22, %rcx
	movabsq	$1898629604128915555, %rdx      # imm = 0x1A594990CA250063
	movq	%rcx, %rax
	imulq	%rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$10, %rdx
	addq	%rax, %rdx
	imulq	$9949, %rdx, %rax               # imm = 0x26DD
	subq	%rax, %rcx
	movq	%rcx, (%rdi)
	movq	(%rbx), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	cqto
	idivq	%rsi
	movq	%rdx, 56(%rsp)
	movq	%r8, 8(%rbx)
	testq	%rdx, %rdx
	je	.LBB13_4
# %bb.5:
	cmpq	24(%rsp), %rdx
	jle	.LBB13_6
# %bb.7:
	movq	16(%rsp), %rdi
	callq	"fn8:choose"@PLT
	movq	%rax, 72(%rsp)
	jmp	.LBB13_8
.LBB13_1:
	movq	_free_array_of_malloc@GOTPCREL(%rip), %r14
	leaq	.L__unnamed_7(%rip), %r15
	.p2align	4, 0x90
.LBB13_2:                               # =>This Inner Loop Header: Depth=1
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
	jmp	.LBB13_2
.LBB13_4:                               # %._crit_edge
	movq	40(%rsp), %rax
	jmp	.LBB13_8
.LBB13_6:
	movq	48(%rsp), %rdi
	callq	"fn8:choose"@PLT
	movq	%rax, 64(%rsp)
.LBB13_8:
	movq	%rax, 8(%rsp)
	movq	8(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	%rcx, 8(%rbx)
	addq	$80, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end13:
	.size	"fn8:choose", .Lfunc_end13-"fn8:choose"
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

	.type	.L__unnamed_6,@object           # @1
.L__unnamed_6:
	.asciz	"Runtime Error: Invalid constructor of type tree encountered in comparison operation\n"
	.size	.L__unnamed_6, 85

	.type	.L__unnamed_7,@object           # @2
.L__unnamed_7:
	.asciz	"Runtime Error: Given expression could not be matched with some clause\n"
	.size	.L__unnamed_7, 71

	.type	.L__unnamed_8,@object           # @3
.L__unnamed_8:
	.asciz	"("
	.size	.L__unnamed_8, 2

	.type	.L__unnamed_9,@object           # @4
.L__unnamed_9:
	.asciz	"|"
	.size	.L__unnamed_9, 2

	.type	.L__unnamed_10,@object          # @5
.L__unnamed_10:
	.asciz	")"
	.size	.L__unnamed_10, 2

	.type	.L__unnamed_2,@object           # @6
.L__unnamed_2:
	.asciz	"Initial tree: "
	.size	.L__unnamed_2, 15

	.type	.L__unnamed_3,@object           # @7
.L__unnamed_3:
	.asciz	"\n"
	.size	.L__unnamed_3, 2

	.type	.L__unnamed_4,@object           # @8
.L__unnamed_4:
	.asciz	"Deleting "
	.size	.L__unnamed_4, 10

	.type	.L__unnamed_5,@object           # @9
.L__unnamed_5:
	.asciz	": "
	.size	.L__unnamed_5, 3

	.section	".note.GNU-stack","",@progbits
