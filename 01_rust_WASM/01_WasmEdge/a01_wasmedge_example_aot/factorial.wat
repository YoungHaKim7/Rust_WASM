(module
	(func $fac (export "fac") (param i64) (result i64)
		local.get 0
		i64.const 1
		i64.lt_s
		if (result i64)
			i64.const 1
		else
			local.get 0
			local.get 0
			i64.const 1
			i64.sub
			call $fac
			i64.mul
			end
	)
)