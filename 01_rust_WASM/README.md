# Understanding WebAssembly text format

https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format

<hr>

# WasmEdge

- https://github.com/WasmEdge/WasmEdge/tree/master/examples

# WasmTime

- https://github.com/bytecodealliance/wasmtime/tree/main/examples

<br>


<hr>

# cargo asm print

```bash
$ cargo rustc -- --emit asm=asssembly.s
```
# cargo asm

- https://github.com/pacak/cargo-show-asm


# cargo asm

- ```cargo asm```

- ```cargo asm "a01_rust_assembly::main"```


```bash
$ cargo asm
   Compiling a01_rust_assembly v0.1.0 (/home/my_project/Rust_WASM/01_rust_WASM/a01_rust_assembly)
    Finished release [optimized] target(s) in 0.11s

Try one of those by name or a sequence number
0 "a01_rust_assembly::main" [28]
1 "core::ops::function::FnOnce::call_once{{vtable.shim}}" [20]
2 "core::ptr::drop_in_place<std::rt::lang_start<()>::{{closure}}>" [7]
3 "main" [10]
4 "std::rt::lang_start" [28]
5 "std::rt::lang_start::{{closure}}" [19]
6 "std::sys_common::backtrace::__rust_begin_short_backtrace" [22]


$ cargo asm --lib
error: no library targets found in package `a01_rust_assembly`

Cargo failed with exit status: 101


$ cargo asm "a01_rust_assembly::main"
    Finished release [optimized] target(s) in 0.00s

.section .text.a01_rust_assembly::main,"ax",@progbits
	.p2align	4, 0x90
	.type	a01_rust_assembly::main,@function
a01_rust_assembly::main:
	.cfi_startproc
	sub rsp, 56
	.cfi_def_cfa_offset 64
	lea rax, [rip + .L__unnamed_2]
	mov qword ptr [rsp + 8], rax
	mov qword ptr [rsp + 16], 1
	lea rax, [rip + .L__unnamed_3]
	mov qword ptr [rsp + 24], rax
	xorps xmm0, xmm0
	movups xmmword ptr [rsp + 32], xmm0
	lea rdi, [rsp + 8]
	call qword ptr [rip + std::io::stdio::_print@GOTPCREL]
	add rsp, 56
	.cfi_def_cfa_offset 8
	ret

```
