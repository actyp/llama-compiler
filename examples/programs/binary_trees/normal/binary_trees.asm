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
	callq	GC_init@PLT
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	(%rbx), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	leaq	32(%rsp), %rax
	movq	%rax, (%rbx)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 32(%rsp)
	movq	(%rbx), %rax
	movq	(%rax), %rax
	movq	$65, (%rax)
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, 8(%rsp)
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%rax, (%rbx)
	movl	$1, %ebp
	.p2align	4, 0x90
.LBB4_1:                                # %for_check
                                        # =>This Inner Loop Header: Depth=1
	movq	%rbp, 48(%rsp)
	cmpq	$10, %rbp
	jg	.LBB4_3
# %bb.2:                                # %for_body
                                        #   in Loop: Header=BB4_1 Depth=1
	movq	8(%rsp), %rbx
	movq	(%rbx), %r14
	movl	$100, %edi
	callq	"fn7:random"@PLT
	movq	%r14, %rdi
	movq	%rax, %rsi
	callq	"fn1:treeInsert"@PLT
	movq	%rax, (%rbx)
	incq	%rbp
	jmp	.LBB4_1
.LBB4_3:                                # %for_after
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
	leaq	.Lstr.6(%rip), %rax
	movq	%rax, (%r14)
	movq	$15, 8(%r14)
	movq	%r14, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn4:treePrint"@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r14
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.7(%rip), %rax
	movq	%rax, (%r14)
	movq	$2, 8(%r14)
	movq	%r14, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn5:treeCount"@PLT
	movq	%rax, %r14
	movl	$1, %r13d
	leaq	.Lstr.8(%rip), %r12
	leaq	.Lstr.9(%rip), %rbp
	.p2align	4, 0x90
.LBB4_4:                                # %for_check22
                                        # =>This Inner Loop Header: Depth=1
	movq	%r13, 40(%rsp)
	cmpq	%r14, %r13
	jg	.LBB4_6
# %bb.5:                                # %for_body23
                                        #   in Loop: Header=BB4_4 Depth=1
	movq	8(%rsp), %rax
	movq	(%rax), %rdi
	callq	"fn8:choose"@PLT
	movq	%rax, 16(%rsp)
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	movq	%r12, (%rbx)
	movq	$10, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rdi
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
	movq	%rbp, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rbx
	movq	(%rbx), %rdi
	movq	16(%rsp), %rsi
	callq	"fn3:treeDelete"@PLT
	movq	%rax, (%rbx)
	movq	8(%rsp), %rax
	movq	(%rax), %rdi
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
	leaq	.Lstr.7(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	incq	%r13
	jmp	.LBB4_4
.LBB4_6:                                # %for_after24
	movb	$0, 7(%rsp)
	movq	display_array@GOTPCREL(%rip), %rax
	movq	24(%rsp), %rcx                  # 8-byte Reload
	movq	%rcx, (%rax)
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
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function
	.globl	"_tree:1_equality"              # -- Begin function _tree:1_equality
	.p2align	4, 0x90
	.type	"_tree:1_equality",@function
"_tree:1_equality":                     # @"_tree:1_equality"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	jne	.LBB5_1
# %bb.2:                                # %body
	cmpq	$1, %rax
	je	.LBB5_6
# %bb.3:                                # %body
	cmpq	$2, %rax
	jne	.LBB5_4
# %bb.8:                                # %"case_tree:1:Node"
	movq	8(%rdi), %rdx
	movq	16(%rdi), %rax
	movq	16(%rsi), %rcx
	movq	24(%rsi), %r14
	movq	24(%rdi), %r15
	cmpq	8(%rsi), %rdx
	sete	%bpl
	movq	%rax, %rdi
	movq	%rcx, %rsi
	callq	"_tree:1_equality"@PLT
	movl	%eax, %ebx
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	"_tree:1_equality"@PLT
                                        # kill: def $al killed $al def $eax
	andb	%bl, %al
	andb	%bpl, %al
	jmp	.LBB5_7
.LBB5_1:
	xorl	%eax, %eax
	jmp	.LBB5_7
.LBB5_6:                                # %"case_tree:1:Nil"
	movb	$1, %al
.LBB5_7:                                # %exit
                                        # kill: def $al killed $al killed $eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB5_4:
	.cfi_def_cfa_offset 48
	leaq	.Lstr.1(%rip), %rbx
	.p2align	4, 0x90
.LBB5_5:                                # %error
                                        # =>This Inner Loop Header: Depth=1
	movl	$85, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB5_5
.Lfunc_end5:
	.size	"_tree:1_equality", .Lfunc_end5-"_tree:1_equality"
	.cfi_endproc
                                        # -- End function
	.globl	"fn1:treeInsert"                # -- Begin function fn1:treeInsert
	.p2align	4, 0x90
	.type	"fn1:treeInsert",@function
"fn1:treeInsert":                       # @"fn1:treeInsert"
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
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %r12
	movq	%rsp, %rax
	movq	%rax, 8(%r15)
	movq	%rdi, 40(%rsp)
	movq	%rsi, 8(%rsp)
	cmpq	$1, (%rdi)
	jne	.LBB6_4
# %bb.1:                                # %match_param_check_1
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movq	8(%rsp), %r13
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %r14
	movq	$1, (%rax)
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	$1, (%rax)
	movq	%r13, 8(%rbx)
	movq	%r14, 16(%rbx)
.LBB6_2:                                # %match_finished
	movq	%rax, 24(%rbx)
.LBB6_3:                                # %match_finished
	movq	%r12, 8(%r15)
	movq	%rbx, %rax
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
.LBB6_4:                                # %match_check_2
	.cfi_def_cfa_offset 96
	cmpq	$2, (%rdi)
	jne	.LBB6_7
# %bb.5:                                # %match_param_check_2
	movq	8(%rdi), %rax
	movq	16(%rdi), %rcx
	movq	24(%rdi), %rdx
	movq	%rax, 16(%rsp)
	movq	%rcx, 32(%rsp)
	movq	%rdx, 24(%rsp)
	cmpq	%rax, 8(%rsp)
	jge	.LBB6_9
# %bb.6:                                # %if_then
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movq	16(%rsp), %r14
	movq	32(%rsp), %rdi
	movq	8(%rsp), %rsi
	callq	"fn1:treeInsert"@PLT
	movq	24(%rsp), %rcx
	movq	%r14, 8(%rbx)
	movq	%rax, 16(%rbx)
	movq	%rcx, 24(%rbx)
	jmp	.LBB6_3
.LBB6_7:
	leaq	.Lstr.2(%rip), %rbx
	.p2align	4, 0x90
.LBB6_8:                                # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB6_8
.LBB6_9:                                # %if_else
	movq	8(%rsp), %rax
	cmpq	16(%rsp), %rax
	jle	.LBB6_11
# %bb.10:                               # %if_then30
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movq	16(%rsp), %r14
	movq	32(%rsp), %r13
	movq	24(%rsp), %rdi
	movq	8(%rsp), %rsi
	callq	"fn1:treeInsert"@PLT
	movq	%r14, 8(%rbx)
	movq	%r13, 16(%rbx)
	jmp	.LBB6_2
.LBB6_11:                               # %if_else31
	movq	40(%rsp), %rbx
	jmp	.LBB6_3
.Lfunc_end6:
	.size	"fn1:treeInsert", .Lfunc_end6-"fn1:treeInsert"
	.cfi_endproc
                                        # -- End function
	.globl	"fn2:treeMerge"                 # -- Begin function fn2:treeMerge
	.p2align	4, 0x90
	.type	"fn2:treeMerge",@function
"fn2:treeMerge":                        # @"fn2:treeMerge"
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
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %r15
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 40(%rsp)
	movq	%rsi, 8(%rsp)
	cmpq	$1, (%rdi)
	jne	.LBB7_2
# %bb.1:                                # %match_param_check_1
	movq	8(%rsp), %rbx
	jmp	.LBB7_4
.LBB7_2:                                # %match_check_2
	cmpq	$2, (%rdi)
	jne	.LBB7_5
# %bb.3:                                # %match_param_check_2
	movq	8(%rdi), %rax
	movq	16(%rdi), %rcx
	movq	24(%rdi), %rdx
	movq	%rax, 32(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%rdx, 16(%rsp)
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movq	32(%rsp), %r12
	movq	24(%rsp), %r13
	movq	16(%rsp), %rdi
	movq	8(%rsp), %rsi
	callq	"fn2:treeMerge"@PLT
	movq	%r12, 8(%rbx)
	movq	%r13, 16(%rbx)
	movq	%rax, 24(%rbx)
.LBB7_4:                                # %match_finished
	movq	%r15, 8(%r14)
	movq	%rbx, %rax
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
.LBB7_5:                                # %match_failed.preheader
	.cfi_def_cfa_offset 96
	leaq	.Lstr.2(%rip), %rbx
	.p2align	4, 0x90
.LBB7_6:                                # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB7_6
.Lfunc_end7:
	.size	"fn2:treeMerge", .Lfunc_end7-"fn2:treeMerge"
	.cfi_endproc
                                        # -- End function
	.globl	"fn3:treeDelete"                # -- Begin function fn3:treeDelete
	.p2align	4, 0x90
	.type	"fn3:treeDelete",@function
"fn3:treeDelete":                       # @"fn3:treeDelete"
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
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %r15
	movq	%rsp, %rax
	movq	%rax, 8(%r14)
	movq	%rdi, 40(%rsp)
	movq	%rsi, 8(%rsp)
	cmpq	$1, (%rdi)
	jne	.LBB8_2
# %bb.1:                                # %match_param_check_1
	movq	40(%rsp), %rbx
.LBB8_10:                               # %match_finished
	movq	%r15, 8(%r14)
	movq	%rbx, %rax
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
.LBB8_2:                                # %match_check_2
	.cfi_def_cfa_offset 96
	cmpq	$2, (%rdi)
	jne	.LBB8_3
# %bb.5:                                # %match_param_check_2
	movq	8(%rdi), %rax
	movq	16(%rdi), %rcx
	movq	24(%rdi), %rdx
	movq	%rax, 32(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%rdx, 16(%rsp)
	cmpq	%rax, 8(%rsp)
	jge	.LBB8_7
# %bb.6:                                # %if_then
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movq	32(%rsp), %r12
	movq	24(%rsp), %rdi
	movq	8(%rsp), %rsi
	callq	"fn3:treeDelete"@PLT
	movq	16(%rsp), %rcx
	movq	%r12, 8(%rbx)
	movq	%rax, 16(%rbx)
	movq	%rcx, 24(%rbx)
	jmp	.LBB8_10
.LBB8_3:
	leaq	.Lstr.2(%rip), %rbx
	.p2align	4, 0x90
.LBB8_4:                                # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB8_4
.LBB8_7:                                # %if_else
	movq	8(%rsp), %rax
	cmpq	32(%rsp), %rax
	jle	.LBB8_9
# %bb.8:                                # %if_then18
	movl	$32, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	$2, (%rax)
	movq	32(%rsp), %r12
	movq	24(%rsp), %r13
	movq	16(%rsp), %rdi
	movq	8(%rsp), %rsi
	callq	"fn3:treeDelete"@PLT
	movq	%r12, 8(%rbx)
	movq	%r13, 16(%rbx)
	movq	%rax, 24(%rbx)
	jmp	.LBB8_10
.LBB8_9:                                # %if_else19
	movq	24(%rsp), %rdi
	movq	16(%rsp), %rsi
	callq	"fn2:treeMerge"@PLT
	movq	%rax, %rbx
	jmp	.LBB8_10
.Lfunc_end8:
	.size	"fn3:treeDelete", .Lfunc_end8-"fn3:treeDelete"
	.cfi_endproc
                                        # -- End function
	.globl	"fn4:treePrint"                 # -- Begin function fn4:treePrint
	.p2align	4, 0x90
	.type	"fn4:treePrint",@function
"fn4:treePrint":                        # @"fn4:treePrint"
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
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	display_array@GOTPCREL(%rip), %r15
	movq	8(%r15), %r12
	movq	%rsp, %rax
	movq	%rax, 8(%r15)
	movq	%rdi, 32(%rsp)
	cmpq	$1, (%rdi)
	jne	.LBB9_2
# %bb.1:                                # %match_param_check_1
	xorl	%eax, %eax
	jmp	.LBB9_4
.LBB9_2:                                # %match_check_2
	cmpq	$2, (%rdi)
	jne	.LBB9_5
# %bb.3:                                # %match_param_check_2
	movq	8(%rdi), %rax
	movq	16(%rdi), %rcx
	movq	24(%rdi), %rdx
	movq	%rax, 24(%rsp)
	movq	%rcx, 16(%rsp)
	movq	%rdx, 8(%rsp)
	movq	%rax, %rdi
	callq	lla_print_int@PLT
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
	leaq	.Lstr.3(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	16(%rsp), %rdi
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
	leaq	.Lstr.4(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	8(%rsp), %rdi
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
	leaq	.Lstr.5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
                                        # kill: def $al killed $al def $eax
.LBB9_4:                                # %match_finished
	movq	%r12, 8(%r15)
                                        # kill: def $al killed $al killed $eax
	addq	$40, %rsp
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
.LBB9_5:                                # %match_failed.preheader
	.cfi_def_cfa_offset 80
	leaq	.Lstr.2(%rip), %rbx
	.p2align	4, 0x90
.LBB9_6:                                # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB9_6
.Lfunc_end9:
	.size	"fn4:treePrint", .Lfunc_end9-"fn4:treePrint"
	.cfi_endproc
                                        # -- End function
	.globl	"fn5:treeCount"                 # -- Begin function fn5:treeCount
	.p2align	4, 0x90
	.type	"fn5:treeCount",@function
"fn5:treeCount":                        # @"fn5:treeCount"
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
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %r15
	leaq	8(%rsp), %rax
	movq	%rax, 8(%rbx)
	movq	%rdi, 40(%rsp)
	cmpq	$1, (%rdi)
	jne	.LBB10_2
# %bb.1:                                # %match_param_check_1
	xorl	%eax, %eax
	jmp	.LBB10_4
.LBB10_2:                               # %match_check_2
	cmpq	$2, (%rdi)
	jne	.LBB10_5
# %bb.3:                                # %match_param_check_2
	movq	8(%rdi), %rcx
	movq	16(%rdi), %rax
	movq	24(%rdi), %rdx
	movq	%rcx, 32(%rsp)
	movq	%rax, 24(%rsp)
	movq	%rdx, 16(%rsp)
	movq	%rax, %rdi
	callq	"fn5:treeCount"@PLT
	movq	%rax, %r14
	movq	16(%rsp), %rdi
	callq	"fn5:treeCount"@PLT
	leaq	1(%r14,%rax), %rax
.LBB10_4:                               # %match_finished
	movq	%r15, 8(%rbx)
	addq	$48, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.LBB10_5:                               # %match_failed.preheader
	.cfi_def_cfa_offset 80
	leaq	.Lstr.2(%rip), %rbx
	.p2align	4, 0x90
.LBB10_6:                               # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB10_6
.Lfunc_end10:
	.size	"fn5:treeCount", .Lfunc_end10-"fn5:treeCount"
	.cfi_endproc
                                        # -- End function
	.globl	"fn6:next"                      # -- Begin function fn6:next
	.p2align	4, 0x90
	.type	"fn6:next",@function
"fn6:next":                             # @"fn6:next"
	.cfi_startproc
# %bb.0:                                # %entry
	movq	display_array@GOTPCREL(%rip), %rsi
	movq	(%rsi), %rax
	movq	8(%rsi), %r8
	leaq	-8(%rsp), %rcx
	movq	%rcx, 8(%rsi)
	andl	$1, %edi
	movb	%dil, -1(%rsp)
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
	.cfi_endproc
                                        # -- End function
	.globl	"fn7:random"                    # -- Begin function fn7:random
	.p2align	4, 0x90
	.type	"fn7:random",@function
"fn7:random":                           # @"fn7:random"
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
	xorl	%edi, %edi
	callq	"fn6:next"@PLT
	cqto
	idivq	16(%rsp)
	movq	%rdx, %rax
	movq	%rbx, 8(%r14)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end12:
	.size	"fn7:random", .Lfunc_end12-"fn7:random"
	.cfi_endproc
                                        # -- End function
	.globl	"fn8:choose"                    # -- Begin function fn8:choose
	.p2align	4, 0x90
	.type	"fn8:choose",@function
"fn8:choose":                           # @"fn8:choose"
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$72, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	display_array@GOTPCREL(%rip), %rbx
	movq	8(%rbx), %r14
	leaq	8(%rsp), %rax
	movq	%rax, 8(%rbx)
	movq	%rdi, 64(%rsp)
	cmpq	$2, (%rdi)
	jne	.LBB13_1
# %bb.3:                                # %match_param_check_1
	movq	8(%rdi), %rcx
	movq	16(%rdi), %rax
	movq	24(%rdi), %rdx
	movq	%rcx, 48(%rsp)
	movq	%rax, 40(%rsp)
	movq	%rdx, 24(%rsp)
	movq	%rax, %rdi
	callq	"fn5:treeCount"@PLT
	movq	%rax, 16(%rsp)
	movq	24(%rsp), %rdi
	callq	"fn5:treeCount"@PLT
	movq	%rax, 56(%rsp)
	movq	16(%rsp), %rcx
	leaq	1(%rcx,%rax), %rdi
	callq	"fn7:random"@PLT
	movq	%rax, 32(%rsp)
	testq	%rax, %rax
	je	.LBB13_4
# %bb.5:                                # %if_else
	movq	32(%rsp), %rax
	cmpq	16(%rsp), %rax
	jg	.LBB13_7
# %bb.6:                                # %if_then14
	movq	40(%rsp), %rdi
	jmp	.LBB13_8
.LBB13_1:
	leaq	.Lstr.2(%rip), %rbx
	.p2align	4, 0x90
.LBB13_2:                               # %match_failed
                                        # =>This Inner Loop Header: Depth=1
	movl	$71, %esi
	movq	%rbx, %rdi
	callq	_runtime_error@PLT
	jmp	.LBB13_2
.LBB13_4:                               # %if_then
	movq	48(%rsp), %rax
	jmp	.LBB13_9
.LBB13_7:                               # %if_else15
	movq	24(%rsp), %rdi
.LBB13_8:                               # %if_merge
	callq	"fn8:choose"@PLT
.LBB13_9:                               # %if_merge
	movq	%r14, 8(%rbx)
	addq	$72, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
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

	.type	.Lstr,@object                   # @str
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lstr:
	.asciz	"Runtime Error: Division by zero\n"
	.size	.Lstr, 33

	.type	.Lstr.1,@object                 # @str.1
.Lstr.1:
	.asciz	"Runtime Error: Invalid constructor of type tree encountered in comparison operation\n"
	.size	.Lstr.1, 85

	.type	.Lstr.2,@object                 # @str.2
.Lstr.2:
	.asciz	"Runtime Error: Given expression could not be matched with some clause\n"
	.size	.Lstr.2, 71

	.type	.Lstr.3,@object                 # @str.3
.Lstr.3:
	.asciz	"("
	.size	.Lstr.3, 2

	.type	.Lstr.4,@object                 # @str.4
.Lstr.4:
	.asciz	"|"
	.size	.Lstr.4, 2

	.type	.Lstr.5,@object                 # @str.5
.Lstr.5:
	.asciz	")"
	.size	.Lstr.5, 2

	.type	.Lstr.6,@object                 # @str.6
.Lstr.6:
	.asciz	"Initial tree: "
	.size	.Lstr.6, 15

	.type	.Lstr.7,@object                 # @str.7
.Lstr.7:
	.asciz	"\n"
	.size	.Lstr.7, 2

	.type	.Lstr.8,@object                 # @str.8
.Lstr.8:
	.asciz	"Deleting "
	.size	.Lstr.8, 10

	.type	.Lstr.9,@object                 # @str.9
.Lstr.9:
	.asciz	": "
	.size	.Lstr.9, 3

	.section	".note.GNU-stack","",@progbits
