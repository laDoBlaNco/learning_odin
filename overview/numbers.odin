package main

import "core:fmt"

// Numbers act pretty normal. we have real and imaginary '2' & '2i' 
// all the binary, octal, and hex we would think about 0b,0o,0x

// in odin a number will be converted to a type if it can be done without losing the
// any precision. 
main::proc(){
	
	x:int=1.0 // a float literal but it can be rep'd by an integer without precision loss
	
	// constant literals are untyped which means that they can implicitly convert to a type
	y:int // y is typed to int
	y = 1 // 1 is untyped but will be converted to the type of y
	
	fmt.println(x,y) 
}
