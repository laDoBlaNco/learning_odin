package main

import "core:fmt"

// in odin, a proc is what does the work. other langs call them funcs or methods. 
fibonacci::proc(n:int)->int{ // note the '::' for the proc name and the '->' for the return val
	switch{
	case n<1:return 0
	case n==1:return 1 
	}
	return fibonacci(n-1)+fibonacci(n-2)	
}

// Parameters:
// procs can take zero  or many params. 
multiply::proc(x:int,y:int)->int{
	return x*y
}
multiply2::proc(x,y:int)->int{
	return x*y
}

// like the c family, EVERYTHING IN ODIN IS PASSED BY VALUE not pointer, just like Go and v
// The difference though is that all params are immutable. Passing a pointer value makes a copy
// of a pointer, not the data it points to. Slices, dynamic arrays, and maps behave like pointers
// Internally, like go, they are just structures that contain values, which include pointers, and
// that is passed by value

// so to mutate a proc param you have to create an explicit copy, this can be done through
// shadowing

foo::proc(x:int){
	x:=x // EXPLICIT MUTATION - without this odin will complain that we are trying to assign to
	// a proc param, which again are immutable.
	for x > 0{
		fmt.println(x)
		x-=1
	}
}

// procs can also be VARIADIC just like v and Go. let's note the odin syntax for this
sum::proc(nums:..int)->(result:int){ // note the named return value which allows for naked returning
	for n in nums{
		result+=n
	}
	return
}

// MULTIPLE RESULTS
// a proc in odin, just like Go, can return a number of results. 
swap::proc(x,y:int)->(int,int){
	return y,x
}

// We saw this earlier, but let's talk about NAMED RESULTS. Return values can be named and if they
// are then they are treated as vars defined at the top of the proc. A return statement without
// args returns the named values. These should only be used on short procs where its absolutely
// clear as to what's going on and why.
do_math::proc(input:int)->(x,y:int){
	x=2*input+1
	y=3*input/5
	return x,y
}
do_math_with_naked_return::proc(input:int)->(x,y:int){
	x=2*input+1
	y=3*input/5
	return
	
}

// We talked about named results, but now let's talk about NAMED ARGS
// so when we don't know the order that the params might come in, we can name the args, just like
// a struct literal:
// create_window::proc(title:string,x,y:int,width,height:int,monitor:^Monitor)->(^Window,Window_Error){
	
// }
// We can also use DEFAULT PARAMS above as would be expected.

// One last thing to discuss with procs in odin is that odin does something, unlike other langs
// EXPLICIT PROC OVERLOADING:
// This basically means that we can have procs do different things depending on the params its 
// given.

// The main idea behind this is, to keep everything explicit and simple. Implicit overloading would
// make things too complex down the road. In C++ you can't nest procs, so all of them are done
// at the global scope. In odin we can nest procs and due to that, determining when a proc should
// be used, with implicit overloading, would be too complex.

bool_to_string::proc(b:bool)->string{
	return ""
}
int_to_string::proc(i:int)->string{
	return ""
}
to_string::proc{bool_to_string,int_to_string} // note the syntax 'name::proc{...}'


main::proc(){

	fmt.println(fibonacci(3)) 
	fmt.println(multiply(137,432)) 
	fmt.println(multiply2(137,432)) 
	foo(10)
	fmt.println(sum(1,2,3,4,5))
	fmt.println(sum(1,2))
	
	odds:=[]int{1,3,5}
	fmt.println(sum(..odds)) // unlike Go we stay on the same side of param and type and only use '..'
	
	a,b:=swap(1,2)
	fmt.println(a,b) 
	
	fmt.println(do_math(20))
	fmt.println(do_math_with_naked_return(20))
	
	
	
	
}
