package main

import "core:fmt"

// a var is declared as new to the scope with a variable declaration
main::proc(){
	
	x:int // declares x to have type int
	y,z:int // declares ya and z to have type int - initialized to  zero default like Go
	fmt.println(x,y,z)
	
	// Assignment
	a:int=123 // declares a new var a with type int and assigns the value 123
	fmt.println(a)
	a = 637 // assigns a new value to a
	fmt.println(a)
	
	b,c := 1,"hello" // declares b and c and INFERS the types from the assignments
	fmt.println(b,c)
	c,b = "bye",5
	fmt.println(b,c) 
	
	// NOTE: := is two tokens, : and = a combination of the explicit typing version
	d:int=123
	e:=123 // type inferred
	fmt.println(d)
	fmt.println(e) 
	
	// constant declarations
	// Constant value can't be changed and must be able to be evaluated at compile time.
	i::"what" // constant i hast the untyped string value 'what' - not that 'main' is then a const
	fmt.println(i)
	
	// They can also be explicitly typed. note the similitudes to := being two tokens
	j:int:123
	k::j+7 // constant computations are also possible.
	fmt.println(j,k) 
}
