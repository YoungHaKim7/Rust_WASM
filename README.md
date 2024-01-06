<p align="center">
  <img width=120px src="https://user-images.githubusercontent.com/67513038/228839577-3c3be948-d204-4245-b2a7-1cc96b18230b.svg" />
  <img width=130px src="https://user-images.githubusercontent.com/67513038/213436632-820a1675-98d9-4626-979d-be63c60cdcb7.png" />
</p>

# Docker run

```

docker run -i -t --name first-ubuntu ubuntu /bin/bash
```

https://lucas-owner.tistory.com/61

<hr>

# Rust Game dev(godot)
- https://godot-rust.github.io/dev/godot-rust-2023-review/
- tutirial book https://godot-rust.github.io/book/toolchain/export-web.html

# Rust_WASM

eBook https://docs.wasmtime.dev/

- Examples https://github.com/bytecodealliance/wasmtime/tree/main/examples

- wasmtime install
  - https://github.com/bytecodealliance/wasmtime

- build
```
cargo build --target wasm32-wasi --release
```

- install
```
rustup target add wasm32-wasi
```

- https://stackoverflow.com/questions/74968490/the-wasm32-wasi-target-may-not-be-installed-while-it-is-installed


- C++로 만든거 wasm실행하기
  - eBook1 https://wasmedge.org/docs/start/overview
    - eBook https://wasmedge.org/docs/category/build-wasmedge-from-source/

- C++로 만든거 https://github.com/WebAssembly/wabt

- WASM 최적화 시키기 인터프리터 모드에서 더 빠르게 최적화
  - https://wasmedge.org/docs/start/build-and-run/cli#call-a-webassembly-function-compiled-from-rust

# Call a WebAssembly function compiled from Rust

The add program is written in Rust and contains an exported add() function. You can compile it into WebAssembly and use wasmedge to call the add() function. In this example, you will see how it is done from the CLI. It is often used when you embed WasmEdge into another host application, and need to call a WASM function from the host.

You will need to have the Rust compiler installed, and then use the following command to build the WASM bytecode file from the Rust source code.

```
cargo build --target wasm32-wasi --release
```

You can execute wasmedge in reactor mode to invoke the add() function with two i32 integer input parameters.

```
wasmedge --reactor add.wasm add 2 2
```

- https://wasmedge.org/docs/start/build-and-run/cli#call-a-webassembly-function-compiled-from-rust

<hr>

# Rust_WASM

https://developer.mozilla.org/en-US/docs/WebAssembly/Rust_to_wasm

# WebAssembly

- ebAssembly (abbreviated Wasm) is a binary instruction format for a stack-based virtual machine. Wasm is designed as a portable compilation target for programming languages, enabling deployment on the web for client and server applications.

https://webassembly.org/

  - https://developer.mozilla.org/en-US/docs/WebAssembly

<br>

<hr>

# What is WASI

https://blog.yoshuawuyts.com/what-is-wasi/


# WASI | The WebAssembly System Interface

https://wasi.dev/

# WASI-documents

https://github.com/bytecodealliance/wasmtime/blob/main/docs/WASI-documents.md


<hr>

<br>

<br>

<hr>

<hr>

<p align="center">
	<img src="https://bytecodealliance.org/images/bytecode-alliance-logo.svg" />
</p>

#  A fast and secure runtime for WebAssembly

- https://github.com/bytecodealliance/

- https://wasmtime.dev/

- https://github.com/bytecodealliance/wasmtime
- tutorial Book https://docs.wasmtime.dev/

- Rust로 Wasmtime으로 어셈블리 연습하기
  - https://docs.wasmtime.dev/lang-rust.html

## Hello.wat & hello.rs

- hello.wat

```wat
(module
  (func $hello (import "" "hello"))
  (func (export "run") (call $hello))
)
```

- hello.rs


```rs
//! Small example of how to instantiate a wasm module that imports one function,
//! showing how you can fill in host functionality for a wasm module.

// You can execute this example with `cargo run --example hello`

use anyhow::Result;
use wasmtime::*;

struct MyState {
    name: String,
    count: usize,
}

fn main() -> Result<()> {
    // First the wasm module needs to be compiled. This is done with a global
    // "compilation environment" within an `Engine`. Note that engines can be
    // further configured through `Config` if desired instead of using the
    // default like this is here.
    println!("Compiling module...");
    let engine = Engine::default();
    let module = Module::from_file(&engine, "examples/hello.wat")?;

    // After a module is compiled we create a `Store` which will contain
    // instantiated modules and other items like host functions. A Store
    // contains an arbitrary piece of host information, and we use `MyState`
    // here.
    println!("Initializing...");
    let mut store = Store::new(
        &engine,
        MyState {
            name: "hello, world!".to_string(),
            count: 0,
        },
    );

    // Our wasm module we'll be instantiating requires one imported function.
    // the function takes no parameters and returns no results. We create a host
    // implementation of that function here, and the `caller` parameter here is
    // used to get access to our original `MyState` value.
    println!("Creating callback...");
    let hello_func = Func::wrap(&mut store, |mut caller: Caller<'_, MyState>| {
        println!("Calling back...");
        println!("> {}", caller.data().name);
        caller.data_mut().count += 1;
    });

    // Once we've got that all set up we can then move to the instantiation
    // phase, pairing together a compiled module as well as a set of imports.
    // Note that this is where the wasm `start` function, if any, would run.
    println!("Instantiating module...");
    let imports = [hello_func.into()];
    let instance = Instance::new(&mut store, &module, &imports)?;

    // Next we poke around a bit to extract the `run` function from the module.
    println!("Extracting export...");
    let run = instance.get_typed_func::<(), ()>(&mut store, "run")?;

    // And last but not least we can call it!
    println!("Calling export...");
    run.call(&mut store, ())?;

    println!("Done.");
    Ok(())
}
```

출처: https://docs.wasmtime.dev/examples-rust-hello-world.html

<hr>

<hr>

<hr>

<br>

<hr>

## https://github.com/WasmEdge/WasmEdge

-  WasmEdge is a lightweight, high-performance, and extensible WebAssembly runtime for cloud native, edge, and decentralized applications. It powers serverless apps, embedded functions, microservices, smart contracts, and IoT devices.

- https://wasmedge.org/

  - https://github.com/WasmEdge/WasmEdge

- https://github.com/WebAssembly/wabt
- https://wasmedge.org/docs/develop/rust/setup/
- https://wasmedge.org/docs/category/develop-wasm-apps-in-rust/
- eBook https://wasmedge.org/book/en/

## This small book describes how to use Rust and WebAssembly together.

https://rustwasm.github.io/docs/book/

- https://github.com/rustwasm/team
  - Rust로 WASM 연습
    - https://github.com/wasmerio/wasmer-rust-example
    - RUST to WASM 컴파일하기
      - https://velog.io/@motive05/RUST-to-wasm-%EC%BB%B4%ED%8C%8C%EC%9D%BC%ED%95%98%EA%B8%B0
   
    - Rust+WASM으로 이기종 Edge에서 빠르고 포터블한 Llama2 추론 실행하기 (secondstate.io)
      - Rust+WASM 스택이 AI추론에서 Python의 강력한 대체제가 될 수 있음
        파이썬과 비교해서 Rust+Wasm 앱은 크기가 1/100, 속도가 100배 빠르며, 바이너리 코드를 변경하지 않고도 전체 하드웨어 가속으로 모든 곳에서 안전하게 실행할 수 있음
        Rust는 AGI의 언어임
    LLama2 추론을 네이티브 속도로 실행하는 간단한 Rust 프로그램을 작성해보면
        Wasm 컴파일후 바이너리는 2MB에 불과하지만, 이기종 하드웨어 가속기에 완전히 이식 가능
        또한 Wasm 런타임(WasmEdge)은 클라우드 환경을 위한 안전한 보안 실행 환경을 제공. 컨테이너 도구와 원활하게 작동하여 다양한 기기에서 휴대용 애플리케이션을 오케스트레이션하고 실행할 수 있음

    - https://news.hada.io/topic?id=11847&utm_source=pytorchkr 
      - https://discuss.pytorch.kr/t/gn-rust-wasm-edge-llama2/2846
    - WASM + Docker를 이용한 Hello World 앱 만들기!
      - https://www.dak.so/rust-articles/wasm-docker-helloworld
    - Example Code for Blogpost on "Embedding Wasm in your Rust application"
      - https://github.com/schultyy/rust-wasm-intro



# A simple main app
The Hello World example is a standalone Rust application that can be executed by the WasmEdge CLI. The full source code for the Rust main.rs file is as follows. It echoes the command line arguments passed to this program at runtime.

```rs
fn main() {
  let s : &str = "Hello WasmEdge!";
  println!("{}", s);
}
```

Build the WASM bytecode:

```bash
cargo build --target wasm32-wasi --release
```

- We will use the wasmedge command to run the program.

```bash
$ wasmedge target/wasm32-wasi/release/hello.wasm
Hello WasmEdg
```

# wasmedge
- which wasmedge

```bash
/home/gyoung/.wasmedge/bin/wasmedge
```

- wasmedge
```bash
wasmedge
USAGE
	wasmedge [SUBCOMMANDS] [OPTIONS] [--] WASM_OR_SO [ARG ...]

SUBCOMMANDS
	compile
		Wasmedge compiler subcommand
	run
		Wasmedge runtime tool subcommand

OPTIONS
	
-h|--help
		Show this help messages
	
-v|--version
		Show version information
	
--reactor
		Enable reactor mode. Reactor mode calls `_initialize` if exported.
	
--dir
		Binding directories into WASI virtual filesystem. Each directory can be
		specified as --dir `host_path`. You can also map a guest directory to a host
		directory by --dir `guest_path:host_path`, where `guest_path` specifies the
		path that will correspond to `host_path` for calls like `fopen` in the
		guest.The default permission is `readwrite`, however, you can use --dir
		`guest_path:host_path:readonly` to make the mapping directory become a read
		only mode.
	
--env
		Environ variables. Each variable can be specified as --env `NAME=VALUE`.
	
--enable-instruction-count
		Enable generating code for counting Wasm instructions executed.
	
--enable-gas-measuring
		Enable generating code for counting gas burned during execution.
	
--enable-time-measuring
		Enable generating code for counting time during execution.
	
--enable-all-statistics
		Enable generating code for all statistics options include instruction
		counting, gas measuring, and execution time
	
--force-interpreter
		Forcibly run WASM in interpreter mode.
	
--disable-import-export-mut-globals
		Disable Import/Export of mutable globals proposal
	
--disable-non-trap-float-to-int
		Disable Non-trapping float-to-int conversions proposal
	
--disable-sign-extension-operators
		Disable Sign-extension operators proposal
	
--disable-multi-value
		Disable Multi-value proposal
	
--disable-bulk-memory
		Disable Bulk memory operations proposal
	
--disable-reference-types
		Disable Reference types proposal
	
--disable-simd
		Disable SIMD proposal
	
--allow-af-unix
		Enable UNIX domain sockets
	
--enable-multi-memory
		Enable Multiple memories proposal
	
--enable-tail-call
		Enable Tail-call proposal
	
--enable-extended-const
		Enable Extended-const proposal
	
--enable-threads
		Enable Threads proposal
	
--enable-all
		Enable all features
	
--time-limit
		Limitation of maximum time(in milliseconds) for execution, default value is 0
		for no limitations
	
--gas-limit
		Limitation of execution gas. Upper bound can be specified as --gas-limit
		`GAS_LIMIT`.
	
--memory-page-limit
		Limitation of pages(as size of 64 KiB) in every memory instance. Upper bound
		can be specified as --memory-page-limit `PAGE_COUNT`.
	
--forbidden-plugin
		List of plugins to ignore.
```

<hr>

<div align="right">

  [中文](README-zh.md) | [正體中文](README-zh-TW.md)

</div>

<div align="center">


![WasmEdge Logo](https://github.com/WasmEdge/WasmEdge/blob/master/docs/wasmedge-runtime-logo.png)

# [🤩 WasmEdge is the easiest and fastest way to run LLMs on your own devices. 🤩](https://www.secondstate.io/articles/wasm-runtime-agi/)

WasmEdge is a lightweight, high-performance, and extensible WebAssembly runtime. It is [the fastest Wasm VM](https://ieeexplore.ieee.org/document/9214403) today. WasmEdge is an official sandbox project hosted by the [CNCF](https://www.cncf.io/). Its [use cases](https://wasmedge.org/book/en/use_cases.html) include modern web application architectures (Isomorphic & Jamstack applications), microservices on the edge cloud, serverless SaaS APIs, embedded functions, smart contracts, and smart devices.

![build](https://github.com/WasmEdge/WasmEdge/workflows/build/badge.svg)
[![codecov](https://codecov.io/gh/WasmEdge/WasmEdge/branch/master/graph/badge.svg)](https://codecov.io/gh/WasmEdge/WasmEdge)
[![CodeQL](https://github.com/WasmEdge/WasmEdge/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/WasmEdge/WasmEdge/actions/workflows/codeql-analysis.yml)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2FWasmEdge%2FWasmEdge.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2FWasmEdge%2FWasmEdge?ref=badge_shield)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/5059/badge)](https://bestpractices.coreinfrastructure.org/projects/5059)

</div>

# Quick start guides

🚀 [Install](https://wasmedge.org/docs/start/install) WasmEdge \
🤖 [Build](https://wasmedge.org/docs/category/build-wasmedge-from-source) and [contribute to](https://wasmedge.org/docs/contribute/) WasmEdge \
⌨️ [Run](https://wasmedge.org/docs/category/running-with-wasmedge) a standalone Wasm program or a [JavaScript program](https://wasmedge.org/docs/category/develop-wasm-apps-in-javascript) from CLI or [Docker](https://wasmedge.org/docs/start/getting-started/quick_start_docker) \
🔌 Embed a Wasm function in your [Go](https://wasmedge.org/docs/category/go-sdk-for-embedding-wasmedge), [Rust](https://wasmedge.org/docs/category/rust-sdk-for-embedding-wasmedge), or [C](https://wasmedge.org/docs/category/c-sdk-for-embedding-wasmedge) app \
🛠 Manage and orchestrate Wasm runtimes using [Kubernetes](https://wasmedge.org/docs/category/deploy-wasmedge-apps-in-kubernetes), [data streaming frameworks](https://wasmedge.org/docs/embed/use-case/yomo), and [blockchains](https://medium.com/ethereum-on-steroids/running-ethereum-smart-contracts-in-a-substrate-blockchain-56fbc27fc95a) \
📚 **[Check out our official documentation](https://wasmedge.org/docs/)**

# Introduction

The WasmEdge Runtime provides a well-defined execution sandbox for its contained WebAssembly bytecode program. The runtime offers isolation and protection for operating system resources (e.g., file system, sockets, environment variables, processes) and memory space. The most important use case for WasmEdge is to safely execute user-defined or community-contributed code as plug-ins in a software product (e.g., SaaS, software-defined vehicles, edge nodes, or even blockchain nodes). It enables third-party developers, vendors, suppliers, and community members to extend and customize the software product. **[Learn more here](https://wasmedge.org/docs/contribute/users)**

## Performance

* [A Lightweight Design for High-performance Serverless Computing](https://arxiv.org/abs/2010.07115), published on IEEE Software, Jan 2021. [https://arxiv.org/abs/2010.07115](https://arxiv.org/abs/2010.07115)
* [Performance Analysis for Arm vs. x86 CPUs in the Cloud](https://www.infoq.com/articles/arm-vs-x86-cloud-performance/), published on infoQ.com, Jan 2021. [https://www.infoq.com/articles/arm-vs-x86-cloud-performance/](https://www.infoq.com/articles/arm-vs-x86-cloud-performance/)
* [WasmEdge is the fastest WebAssembly Runtime in Suborbital Reactr test suite](https://blog.suborbital.dev/suborbital-wasmedge), Dec 2021

## Features

WasmEdge can run standard WebAssembly bytecode programs compiled from C/C++, Rust, Swift, AssemblyScript, or Kotlin source code. It [runs JavaScript](https://wasmedge.org/docs/category/develop-wasm-apps-in-javascript), including 3rd party ES6, CJS, and NPM modules, in a secure, fast, lightweight, portable, and containerized sandbox. It also supports mixing of those languages (e.g., to [use Rust to implement a JavaScript API](https://wasmedge.org/docs/develop/javascript/rust)), the [Fetch](https://wasmedge.org/docs/develop/javascript/networking#fetch-client) API, and [Server-side Rendering (SSR)](https://wasmedge.org/docs/develop/javascript/ssr) functions on edge servers.

WasmEdge supports [all standard WebAssembly features and many proposed extensions](https://wasmedge.org/docs/start/wasmedge/extensions/proposals). It also supports a number of extensions tailored for cloud-native and edge computing uses (e.g., the [WasmEdge network sockets](https://wasmedge.org/docs/category/socket-networking),[Postgres and MySQL-based database driver](https://wasmedge.org/docs/category/database-drivers), and the [WasmEdge AI extension](https://wasmedge.org/docs/category/ai-inference)).

 **Learn more about [technical highlights](https://wasmedge.org/docs/start/wasmedge/features) of WasmEdge.**

## Integrations and management

WasmEdge and its contained wasm program can be started from the [CLI](https://wasmedge.org/docs/category/running-with-wasmedge) as a new process, or from a existing process. If started from an existing process (e.g., from a running [Go](https://wasmedge.org/docs/category/go-sdk-for-embedding-wasmedge) or [Rust](https://wasmedge.org/docs/category/rust-sdk-for-embedding-wasmedge) program), WasmEdge will simply run inside the process as a function. Currently, WasmEdge is not yet thread-safe. In order to use WasmEdge in your own application or cloud-native frameworks, please refer to the guides below.

* [Embed WasmEdge into a host application](https://wasmedge.org/docs/embed/overview)
* [Orchestrate and manage WasmEdge instances using container tools](https://wasmedge.org/docs/category/deploy-wasmedge-apps-in-kubernetes)
* [Run a WasmEdge app as a Dapr microservice](https://wasmedge.org/docs/develop/rust/dapr)
=

# Community

## Contributing

If you would like to contribute to the WasmEdge project, please refer to our [CONTRIBUTING](https://wasmedge.org/docs/contribute/overview) document for details. If you are looking for ideas, checkout our ["help wanted" issues](https://github.com/WasmEdge/WasmEdge/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22)!

## Roadmap

Check out our [project roadmap](https://github.com/WasmEdge/WasmEdge/blob/master/docs/ROADMAP.md) to see the upcoming features and plans for WasmEdge.

## Contact

If you have any questions, feel free to open a GitHub issue on a related project or to join the following channels:

* Mailing list: Send an email to [WasmEdge@googlegroups.com](https://groups.google.com/g/wasmedge/)
* Discord: Join the [WasmEdge Discord server](https://discord.gg/h4KDyB8XTt)!
* Slack: Join the #WasmEdge channel on the [CNCF Slack](https://slack.cncf.io/)
* Twitter: Follow @realwasmedge on [Twitter](https://twitter.com/realwasmedge)



<hr>

