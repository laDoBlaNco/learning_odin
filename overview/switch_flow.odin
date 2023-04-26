// Control Flow: Switch statetments
package main

import "core:fmt"
import "core:os"

p::fmt.println

main::proc(){
	// just like most, switch is anothe way to write multple if statements
	// same basic syntax as Go, but I think it has uniones just like v so its able to use the 
	// .amd64 switches
	switch arch:=ODIN_ARCH;arch{
	case .i386,.wasm32,.arm32:p("32 bit")
	case .amd64,.wasm64,.arm64:p("64 bit")
	case .Unknown:p("Uknown architecture") 
	}	
	// NOTE: I got a warning kinda like with GO when you don't cover all the possibilities and was
	// missing .arm32, then asked if I meant it to be #partial, which we'll touch on next.
	
	// just like Go, there is no need for break since odin switch stops on the condition it runs.
	// If all cases are constants and the compiler doesn't have to evaluate them, then it may optimize
	// and create a jump table like in 'c'. Also an empty switch evaluates to true, turning this 
	// into a simple if-else checking which case is true. Finally instead of 'default' I just see
	// case:
	x:=69
	switch{
	case x<0:p("x is negative")
	case x==0:p("x is zero")
	case:p("x is positive") 
	}
	
	// I believe this is true in v, not Go, but we can also use ranges 
	c:='c'
	switch c{
	case 'A'..='Z','a'..='z','0'..='9':p("c is alphanumeric")
	}
	
	switch x{
	case 0..<10:p("units")
	case 10..<13:p("pre-teens")
	case 13..<20:p("teens")
	case 20..<30:p("twenties")
	case 69:p("not my age, MJM, its what I want to do")
	}
	
	// and now the #partial switch
	f:=Foo.A
	switch f{
	case .A:p("A")
	case .B:p("B")
	case .C:p("C")
	case .D:p("D")
	case:p("?") 
	}
	
	// now partial - meaning, its not covering all the possibilities
	#partial switch f{ // maybe I'm only interested in these two
	case .A:p("A")
	case .D:p("D")
	}
	
	// with union types - type switch statement in Go
	u:FooU = false
	switch in u{ // NOTE: 'in' as in switch into the underlying type of u
	case int: p("int")
	case bool:p("bool") 
	}
}

Foo::enum{ // first time working with enums in odin
	A,
	B,
	C,
	D,
}

FooU::union{int,bool} // now with union types - type switches
