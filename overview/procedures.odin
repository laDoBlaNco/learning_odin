package main

import "core:fmt"

procedures :: proc() {
	fmt.println("\n----PROCEDURES----")

	// in odin, a procedure is something that can do work, its the work horse of the lang.
	// Some langs call them functions, funcs, subroutines, or methods, but these are all technically
	// incorrect in some cases. Functions shoudln't change state and should always return a value.
	// subroutines can change state and shouldn't return anything since its the side-effects you
	// want. Func and fn are short for Function. methods are associative functions and therefore
	// fall into the same renglon as Functions, but regardless, odin doesn't have the concept of
	// a method anyways. 

	// Procedures by definiation fall right in between Functions and Subroutines and are expected
	// to do all of the above. A procedure literal in odin is defined with 'proc' as in our main
	// proc below.

	fibonacci :: proc(n: int) -> int { 	// take in an int and return an int
		// NOTE: by the semantics procs are constants 'name::value'. 

		/*  :: are two different operators : and :. The are used for constant declarations:
	
		X :: 123
		X :   : 123

		Y : int : 123
		Y :: int(123)

		Z :: proc() {}
		Z : proc() : proc() {} // Redundant type declaration - 'proc()' is a type just like the
		func type in Go.	
	
	*/

		// Also note that I can declare procs inside of other procs with no issue. This can't be 
		// done in Go, you have to use anony funcs
		switch {
		case n < 1:
			return 0
		case n == 1:
			return 1
		}
		return fibonacci(n - 1) + fibonacci(n - 2)

	}

	fmt.println(fibonacci(10))
}

parameters :: proc() {
	fmt.println("\n----PARAMETERS----")

	// procs can take zero or many params. The following exaample is a basic proc that multiples 
	// two ints together
	multiply :: proc(x, y: int) -> int {
		return x * y
	}
	fmt.println(multiply(137, 432))

	// When two or more consecutive params share a type, you can omit the other types from
	// the previous names, as seen above. 

	/*
		Just like other C langs, everything in odin is passed by value, or in other words is a
		copy just like in Go. Odin however differs in that all proc params are IMMUTABLE values. 
		This allows for numerous optimizations with the odin calling conventions 'odin' and 'contextless'
		which wouldn't be possible with the original c tradition
		
		Passing a pointer value makes copy of a pointer as well, not the data it points to. Slices
		dynamic arrays, and maps behave like pointers just like in Go (internally they are structures
		that contain values, which include pointers, and the "structure" is passed by value.)
	*/

	// If we need to mutate the proc param (like in C or Go), and explicit copy is required inside
	// the proce. This can be done simply by shadowing the variable declaration. Interestingly while
	// taking Elliot Forbes Go training, he always stated that you should always make an explicit
	// copy of values in for loops, especially if you are mutating the arg. This may be related??
	foo :: proc(x: int) {
		x := x // explicit copy for mutation. If I comment this line out I get this error:
		//  Cannot assign to 'x' which is a procedure parameter  x-=1
		for x > 0 {
			fmt.println(x)
			x -= 1 // there is no x-- or x++
		}
	}
	foo(10)

	// procs can also be variadic with its params. NOTE the diffs between this and Go syntax
	sum :: proc(nums: ..int) -> (result: int) { 	// also NOTE the named return values here and the naked return 
		for n in nums {
			result += n
		}
		return // naked return since we have the named return values in the signature
	}
	fmt.println()
	fmt.println(sum())
	fmt.println(sum(1, 2))
	fmt.println(sum(1, 2, 3, 4, 5))

	odds := []int{1, 3, 5}
	fmt.println(sum(..odds)) // notice that unlike Go, when we pass a slice we use the same ..Type
	// syntax rather than Type.. Also its .. instead of ...

}

multiple_results :: proc() {
	fmt.println("\n----MULTIPLE RESULTS----")

	// a proc in odin (just like in Go) can return multiple results
	swap :: proc(x, y: int) -> (int, int) {
		return y, x
	}
	a, b := swap(1, 2)
	fmt.println(a, b)

}

named_results :: proc() {
	fmt.println("\n----NAMED RESULTS----")

	// Return values in odin may be named. If so, they are treated as vars defined at the top of
	// the proc scope, just like input params. A 'return' statement without args returns the
	// named return value(s). 'naked' returns should only be used in short procs as it reduces
	// clarity when reading.
	do_math :: proc(input: int) -> (x, y: int) {
		x = 2 * input + 1
		y = 3 * input / 5
		return x, y
	}
	do_math_with_naked_return :: proc(input: int) -> (x, y: int) {
		x = 2 * input + 1
		y = 3 * input / 5
		return
	}
	fmt.println(do_math(6))
	fmt.println(do_math_with_naked_return(6))

}

named_arguments :: proc() {
	fmt.println("\n----NAMED ARGUMENTS----")
	// When calling a proc, at times it is not clear in which order parameters might appear. 
	// Therefore, the args can be named, like a struct literal, to make it clear which arg
	// a param is for.

	// create_window::proc(title:string,x,y:int,width,height:int,monitor:^Monitor)->(^Window,Window_Error){} 

	// window,err:=create_window(title="Hellope Title",monitor=nil,width=854,height=480,x=0,y=0) 
	//NOTE: Currently mixing named and non-named args is not allowed. This is subject to change if
	// we see fit.


}

default_values :: proc() {
	fmt.println("\n----DEFAULT VALUES----")
	// create_window :: proc(title: string, x := 0, y := 0, width := 854, height := 480, monitor: ^Monitor = nil) -> (^Window, Window_Error) {...}

	// window1, err1 := create_window("Title1")
	// window2, err2 := create_window(title="Title1", width=640, height=360)
	// NOTE: These default values must be compile time known values, such as a constant value
	// or nil (if the type supports it) 
}

explicit_proc_overloading::proc(){
	fmt.println("\n----EXPLICIT PROCEDURE OVERLOADING----") 
	// Unlike other langs, odin provides the ability to explicitly overload procedures:
	bool_to_string::proc(b:bool)->string{return ""} 
	int_to_string::proc(i:int)->string{return ""} 
	
	to_string::proc{bool_to_string,int_to_string} // so explicit overloading is mainly creating
	// a procedure set.
	
	// Rationale behind explicit overloading
	// The design goals of odin were explicitness and simplicity. Implicit proc overloading
	// complicates the scoping system. In c++, you can't next procedures within procedures,
	// so all procedure look-ups are done at the global scope. In Odin, procedures can be nested
	// within procedures and, as a result, determining which procedure should be used, in the
	// case of implicit overloading, is complex.
	
	// Explicit overloading has many advantages:
		// Explicitness of what is overloaded
		// Able to refer to the specific procedure if needed
		// Clear which scope the entity name belongs to
		// Ability to specialize parametric polymorphic procedures if necessary, which have 
		// ...the same parameter but different bounds 
	foo_bar::proc(){}
	foo_baz::proc(){}
	foo_baz2::proc(){}
	another_thing_entirely::proc(){}
	
	foo::proc{
		foo_bar,
		foo_baz,
		foo_baz2,
		another_thing_entirely,
	} 
	
	
	
}


main :: proc() {
	procedures()
	parameters()
	multiple_results()
	named_results()
	named_arguments()
	default_values()
	explicit_proc_overloading() 
}
