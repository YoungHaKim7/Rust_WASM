# Result

- https://wasmedge.org/docs/start/build-and-run/cli

```
$ wasmedge --enable-all-statistics rust_wasm_lib.wasm
[2024-01-06 15:15:04.681] [info] ====================  Statistics  ====================
[2024-01-06 15:15:04.681] [info]  Total execution time: 26997 ns
[2024-01-06 15:15:04.681] [info]  Wasm instructions execution time: 26997 ns
[2024-01-06 15:15:04.681] [info]  Host functions execution time: 0 ns
[2024-01-06 15:15:04.681] [info]  Executed wasm instructions count: 1622
[2024-01-06 15:15:04.681] [info]  Gas costs: 1622
[2024-01-06 15:15:04.681] [info]  Instructions per second: 60080749


$ wasmedge --enable-all-statistics --gas-limit 20 rust_wasm_lib.wasm
[2024-01-06 15:15:35.561] [error] Cost exceeded limit. Force terminate the execution.
[2024-01-06 15:15:35.561] [error]     In instruction: ref.func (0xd2) , Bytecode offset: 0x00000000
[2024-01-06 15:15:35.561] [error]     At AST node: expression
[2024-01-06 15:15:35.561] [error]     At AST node: element segment
[2024-01-06 15:15:35.561] [error]     At AST node: element section
[2024-01-06 15:15:35.561] [error]     At AST node: module
[2024-01-06 15:15:35.561] [info] ====================  Statistics  ====================
[2024-01-06 15:15:35.561] [info]  Total execution time: 0 ns
[2024-01-06 15:15:35.561] [info]  Wasm instructions execution time: 0 ns
[2024-01-06 15:15:35.561] [info]  Host functions execution time: 0 ns
[2024-01-06 15:15:35.561] [info]  Executed wasm instructions count: 21
[2024-01-06 15:15:35.561] [info]  Gas costs: 20
[2024-01-06 15:15:35.561] [info]  Instructions per second: 0
[2024-01-06 15:15:35.561] [info] =======================   End   ======================
```
