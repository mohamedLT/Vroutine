import vroutine

fn main() {
	mut h := vroutine.new(f, voidptr(0))
	h.step()
	println('hi')
	h.step()
	println('hi')
	h.step()
	println('hi')
	h.step()
	println('hi')
	h.step()
}

fn f() {
	for i in 0 .. 100 {
		println(' $i')
		vroutine.yield()
	}
}
