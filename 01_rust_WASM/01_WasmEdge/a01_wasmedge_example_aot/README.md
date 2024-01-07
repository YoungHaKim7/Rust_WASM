# Result

- add.wat

```bash

wat2wasm add.wat
➜  a01_wasmedge_example_aot git:(main) ✗ ls
Cargo.lock  Cargo.toml  README.md  add.wasm  ad.wat  factorial.wat  fibonacci.wat  src  target

# Run it in the interpreter mode
$ wasmedge add.wasm add 3 3
6


# Runt it in the AOT mode(Optimization)
$ wasmedge compile add.wasm add.aot.wasm

[2024-01-07 10:58:30.127] [info] compile start
[2024-01-07 10:58:30.127] [info] verify start
[2024-01-07 10:58:30.127] [info] optimize start
[2024-01-07 10:58:30.129] [info] codegen start
[2024-01-07 10:58:30.131] [info] output start
[2024-01-07 10:58:30.132] [info] compile done
[2024-01-07 10:58:30.132] [info] output start

$ wasmedge add.aot.wasm add 1 56
57
```


- fibonacci.wat

```bash
$ wat2wasm fibonacci.wat

$ ls
Cargo.lock  Cargo.toml  README.md  add.aot.wasm  add.wasm  ad.wat  factorial.wat  fibonacci.wasm  fibonacci.wat  src  target

$ wasmedge fibonacci.wasm fib 33
5702887

$ wasmedge compile fibonacci.wasm fibonacci.aot.wasm
[2024-01-07 11:01:26.989] [info] compile start
[2024-01-07 11:01:26.990] [info] verify start
[2024-01-07 11:01:26.990] [info] optimize start
[2024-01-07 11:01:26.994] [info] codegen start
[2024-01-07 11:01:26.996] [info] output start
[2024-01-07 11:01:26.998] [info] compile done
[2024-01-07 11:01:26.998] [info] output start


$ ls
Cargo.lock  README.md     add.wasm  factorial.wat       fibonacci.wasm  src
Cargo.toml  add.aot.wasm  add.wat   fibonacci.aot.wasm  fibonacci.wat   target


$ wasmedge fibonacci.aot.wasm fib 33
5702887

  
```

- fatorial.wat

```bash
$ wat2wasm factorial.wat

$ ls
Cargo.lock  README.md     add.wasm  factorial.wasm  fibonacci.aot.wasm  fibonacci.wat  target
Cargo.toml  add.aot.wasm  add.wat   factorial.wat   fibonacci.wasm      src

$ wasmedge factorial.wasm fac 50
15188249005818642432

➜  a01_wasmedge_example_aot git:(main) ✗ wasmedge compile factorial.wasm factorial.aot.wasm
[2024-01-07 11:04:08.855] [info] compile start
[2024-01-07 11:04:08.856] [info] verify start
[2024-01-07 11:04:08.856] [info] optimize start
[2024-01-07 11:04:08.860] [info] codegen start
[2024-01-07 11:04:08.864] [info] output start
[2024-01-07 11:04:08.865] [info] compile done
[2024-01-07 11:04:08.865] [info] output start

$ wasmedge factorial.aot.wasm fac 50
15188249005818642432

```
