module vroutine

import lazalong.minicoro

const time_out = 10

[inline]
pub fn get_data<T>() &T {
	return &T(minicoro.get_user_data(minicoro.running()))
}

pub struct Scheduler {
mut:
	coroutines []Handler
}

pub fn new(func_ptr voidptr, args voidptr) Handler {
	mut desc := minicoro.desc_init(func_ptr, 0)
	desc.user_data = args
	mut co := &minicoro.Coro{}
	minicoro.create(&co, &desc)
	return Handler{
		coroutine: co
	}
}

pub fn (mut s Scheduler) add_f(func_ptr voidptr, args voidptr) {
	s.coroutines << new(func_ptr, args)
}

pub fn (mut s Scheduler) add(hand Handler) {
	s.coroutines << hand
}

pub fn (mut s Scheduler) step() {
	for i in 0 .. s.coroutines.len {
		if s.coroutines[i].step() {
			s.coroutines.delete(i)
		}
	}
}

pub fn (mut s Scheduler) run() {
	for s.coroutines.len > 0 {
		s.step()
	}
}

[inline]
pub fn yield() {
	minicoro.yield(minicoro.running())
}

pub struct Handler {
	coroutine minicoro.Coro
	time_out  int = vroutine.time_out
mut:
	repeats    int 
	last_state minicoro.State = .suspended
}

pub fn (mut h Handler) step() bool {
	state := minicoro.status(h.coroutine)
	if state == .running && state == h.last_state {
		h.repeats++
	} else {
		h.repeats = 0
	}
	h.last_state = state
	if state == .dead || h.repeats >= h.time_out {
		if h.repeats >= h.time_out {
			eprintln('the coroutine has passed the allowed time out ')
		}
		return true
	} else if state == .suspended {
		res := minicoro.resume(h.coroutine)
		if res != .success {
			eprintln('error in coroutine  ERROR $res : ${minicoro.result_description(res)} ')
			return true
		}
	}
	return false
}
