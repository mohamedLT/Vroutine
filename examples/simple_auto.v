import mohamedlt.vroutine

fn main() {
	mut s := vroutine.Scheduler{}
	s.add_f(f1, 0)
	s.add_f(f2, 0)
	s.run()
}

fn f1() {
	for i in 0 .. 100 {
		println('f1 $i')
		vroutine.yield()
	}
}

fn f2() {
	for i in 0 .. 2 {
		println('f2 $i')
		vroutine.yield()
	}
}
