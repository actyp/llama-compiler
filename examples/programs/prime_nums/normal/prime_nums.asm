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
	callq	GC_init@PLT
	movq	display_array@GOTPCREL(%rip), %r15
	movq	(%r15), %r12
	leaq	8(%rsp), %rax
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
	leaq	.Lstr.1(%rip), %rax
	movq	%rax, (%rbx)
	movq	$31, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	xorl	%edi, %edi
	callq	lla_read_int@PLT
	movq	(%r15), %rcx
	movq	%rax, (%rcx)
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
	movq	$29, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r15), %rax
	movq	(%rax), %rdi
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
	leaq	.Lstr.3(%rip), %rax
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r15), %rbx
	movl	$8, %edi
	callq	GC_malloc@PLT
	movq	%rax, 8(%rbx)
	movq	(%r15), %rax
	movq	8(%rax), %rax
	movq	$0, (%rax)
	movq	(%r15), %rax
	cmpq	$2, (%rax)
	jl	.LBB4_2
# %bb.1:                                # %if_then
	movq	(%r15), %rax
	movq	8(%rax), %rdi
	callq	lla_incr@PLT
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
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
.LBB4_2:                                # %if_merge
	movq	(%r15), %rax
	cmpq	$3, (%rax)
	jl	.LBB4_4
# %bb.3:                                # %if_then39
	movq	(%r15), %rax
	movq	8(%rax), %rdi
	callq	lla_incr@PLT
	movl	$16, %edi
	callq	GC_malloc@PLT
	movq	%rax, %rbx
	movq	_free_array_of_malloc@GOTPCREL(%rip), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	GC_register_finalizer@PLT
	leaq	.Lstr.5(%rip), %rax
	movq	%rax, (%rbx)
	movq	$3, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
.LBB4_4:                                # %if_merge41
	movl	$6, %edi
	callq	"fn3:loop"@PLT
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
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	movq	(%r15), %rax
	movq	8(%rax), %rax
	movq	(%rax), %rdi
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
	leaq	.Lstr.7(%rip), %rax
	movq	%rax, (%rbx)
	movq	$30, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
	andb	$1, %al
	movb	%al, 7(%rsp)
	movq	%r12, (%r15)
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
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function
	.globl	"fn1:prime"                     # -- Begin function fn1:prime
	.p2align	4, 0x90
	.type	"fn1:prime",@function
"fn1:prime":                            # @"fn1:prime"
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
	movq	8(%rbx), %r14
	movq	%rsp, %rax
	movq	%rax, 8(%rbx)
	movq	%rdi, (%rsp)
	testq	%rdi, %rdi
	js	.LBB5_3
# %bb.1:                                # %if_else
	movq	8(%rbx), %rax
	cmpq	$2, (%rax)
	jge	.LBB5_4
.LBB5_2:
	xorl	%eax, %eax
	jmp	.LBB5_8
.LBB5_3:                                # %if_then
	movq	8(%rbx), %rax
	xorl	%edi, %edi
	subq	(%rax), %rdi
	callq	"fn1:prime"@PLT
	jmp	.LBB5_7
.LBB5_4:                                # %if_else10
	movq	8(%rbx), %rcx
	movb	$1, %al
	cmpq	$2, (%rcx)
	je	.LBB5_8
# %bb.5:                                # %if_else18
	movq	8(%rbx), %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	shrq	$63, %rcx
	addq	%rax, %rcx
	andq	$-2, %rcx
	cmpq	%rcx, %rax
	je	.LBB5_2
# %bb.6:                                # %if_else25
	movl	$3, %edi
	callq	"fn2:loop"@PLT
.LBB5_7:                                # %if_merge
                                        # kill: def $al killed $al def $eax
.LBB5_8:                                # %if_merge
	movq	%r14, 8(%rbx)
                                        # kill: def $al killed $al killed $eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	"fn1:prime", .Lfunc_end5-"fn1:prime"
	.cfi_endproc
                                        # -- End function
	.globl	"fn2:loop"                      # -- Begin function fn2:loop
	.p2align	4, 0x90
	.type	"fn2:loop",@function
"fn2:loop":                             # @"fn2:loop"
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
	movq	%rdi, %rbx
	movq	display_array@GOTPCREL(%rip), %r14
	movq	8(%r14), %rax
	movq	16(%r14), %r15
	movq	%rsp, %rcx
	movq	%rcx, 16(%r14)
	movq	%rdi, 8(%rsp)
	movq	(%rax), %rdi
	movl	$2, %esi
	callq	_binary_int_division@PLT
	movq	%rax, %rcx
	movb	$1, %al
	cmpq	%rcx, %rbx
	jg	.LBB6_4
# %bb.1:                                # %if_then
	movq	8(%r14), %rax
	movq	(%rax), %rax
	cqto
	idivq	8(%rsp)
	testq	%rdx, %rdx
	je	.LBB6_2
# %bb.3:                                # %if_else4
	movq	8(%rsp), %rdi
	addq	$2, %rdi
	callq	"fn2:loop"@PLT
                                        # kill: def $al killed $al def $eax
	jmp	.LBB6_4
.LBB6_2:
	xorl	%eax, %eax
.LBB6_4:                                # %if_merge
	movq	%r15, 16(%r14)
                                        # kill: def $al killed $al killed $eax
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	"fn2:loop", .Lfunc_end6-"fn2:loop"
	.cfi_endproc
                                        # -- End function
	.globl	"fn3:loop"                      # -- Begin function fn3:loop
	.p2align	4, 0x90
	.type	"fn3:loop",@function
"fn3:loop":                             # @"fn3:loop"
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
	movq	(%r14), %rax
	movq	8(%r14), %r15
	movq	%rsp, %rcx
	movq	%rcx, 8(%r14)
	movq	%rdi, 8(%rsp)
	cmpq	(%rax), %rdi
	jg	.LBB7_1
# %bb.2:                                # %if_then
	movq	8(%rsp), %rdi
	decq	%rdi
	callq	"fn1:prime"@PLT
	testb	$1, %al
	je	.LBB7_4
# %bb.3:                                # %if_then3
	movq	(%r14), %rax
	movq	8(%rax), %rdi
	callq	lla_incr@PLT
	movq	8(%rsp), %rdi
	decq	%rdi
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
	leaq	.Lstr.6(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
.LBB7_4:                                # %if_merge5
	movq	8(%rsp), %rax
	movq	(%r14), %rcx
	cmpq	(%rcx), %rax
	setne	%bl
	jne	.LBB7_9
# %bb.5:
	xorl	%ebx, %ebx
	jmp	.LBB7_10
.LBB7_1:
	xorl	%eax, %eax
	jmp	.LBB7_8
.LBB7_9:                                # %logical_non_short_circuit
	movq	8(%rsp), %rdi
	incq	%rdi
	callq	"fn1:prime"@PLT
	andb	%al, %bl
.LBB7_10:                               # %logical_continue
	testb	%bl, %bl
	je	.LBB7_7
# %bb.6:                                # %if_then16
	movq	(%r14), %rax
	movq	8(%rax), %rdi
	callq	lla_incr@PLT
	movq	8(%rsp), %rdi
	incq	%rdi
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
	leaq	.Lstr.6(%rip), %rax
	movq	%rax, (%rbx)
	movq	$2, 8(%rbx)
	movq	%rbx, %rdi
	callq	lla_print_string@PLT
.LBB7_7:                                # %if_merge18
	movq	8(%rsp), %rdi
	addq	$6, %rdi
	callq	"fn3:loop"@PLT
                                        # kill: def $al killed $al def $eax
.LBB7_8:                                # %if_merge
	movq	%r15, 8(%r14)
                                        # kill: def $al killed $al killed $eax
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	"fn3:loop", .Lfunc_end7-"fn3:loop"
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
	.asciz	"Please, give the upper limit: "
	.size	.Lstr.1, 31

	.type	.Lstr.2,@object                 # @str.2
.Lstr.2:
	.asciz	"Prime numbers between 0 and "
	.size	.Lstr.2, 29

	.type	.Lstr.3,@object                 # @str.3
.Lstr.3:
	.asciz	"\n\n"
	.size	.Lstr.3, 3

	.type	.Lstr.4,@object                 # @str.4
.Lstr.4:
	.asciz	"2\n"
	.size	.Lstr.4, 3

	.type	.Lstr.5,@object                 # @str.5
.Lstr.5:
	.asciz	"3\n"
	.size	.Lstr.5, 3

	.type	.Lstr.6,@object                 # @str.6
.Lstr.6:
	.asciz	"\n"
	.size	.Lstr.6, 2

	.type	.Lstr.7,@object                 # @str.7
.Lstr.7:
	.asciz	" prime number(s) were found.\n"
	.size	.Lstr.7, 30

	.section	".note.GNU-stack","",@progbits
