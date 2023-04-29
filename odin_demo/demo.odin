package main

import "core:fmt"
import "core:mem"
import "core:os"
import "core:thread"
import "core:time"
import "core:reflect"
import "core:runtime"
import "core:intrinsics"
import "core:math/big"

/*
	Odin is a general purpose programming language with distinct typing built
	for high performance (animation and games), modern systems and data-oriented programming.
	
	Odin is a C alternative for the  Joy of Programming.
	
*/

the_basics::proc(){
	fmt.println("Hellope")
	
	// LEXICAL ELEMENTS AND LITERALS:
	// This is a comment
	
	my_integer_variable:int // a comment for documentation
	
	// Multi-line comments begin with /* and end with */. Multi-line comments can
	// also be nested (unlike in C):
	/* 
		You can have any text or code here and
		have it be commented.
		/*
			NOTE: comments can be nested!
		*/
	
	*/
	
	// String literals are enclosed in double quotes and chars in single quotes.
	// Special chars are escaped with a backslash -- all normal stuff here.
	
	some_string:="This is a string" // note the := which is two separate tokens. This is shortcut
	// for 'some_string:string="this is a string"' - the type can be  explicit or inferred
	
	_ = 'A' // unicode codepoint literals with ''
	_ = '\n' // here we ahve a special char with \
	_ = "C:\\Windows\\notepad.exe" // also note the use of Go's '_' 
	// Raw string literals are same as Go with the back ticks
	_ = `C:\Windows\notepad.exe` 
	
	// The length of a string in bytes (not runes) can be found using the  same 'len' procedure
	_ = len("Foo") 
	_ = len(some_string) 
	
	// NUMBERS:
	
	// Numerical literals are written similar to most other programming languages. 
	// A useful feature in odin is that underscores are allowed for better readability:
	// 1_000_000_000_000 (1 trillion) .If a number literal is suffixed with 'i', its 
	// imaginary: 2i (2 multiply the square root of -1).
	
	// Binary literals are prefixed with 0b, octals 0o and hex 0x. A leading zero does
	// not produce an octal (unlike C)
	
	// in odin if an numeric constant can be represented by a type without precision loss
	// it will automatically be converted to that type. Thus before they are 'untyped'
	
	x:int=1.0 // a float literal, but it can be represented by an integer without precision
	// loss. Constant literals are "untyped" which means that they can implicitly convert to
	// a type. 
	
	y:int // 'y' is typed of type 'int'
	y=1 // 1 is untyped and in this case implicily converts to an int
	
	z:f64 // 'z' is a type f64
	z=1 // This won't work in Go, but since 1 is untyped it can be implicily converted to f64
	// without precision loss. No need for any suffixes or decimal places like in other langs.
	// NOTE: the exception to this is negative zero, which must be given as -0.0.
	// CONSTANTS JUST WORK!!!!
	
	// ASSIGNMENT STATEMENTS:
	
	
	 
}



main::proc(){
	
	/*
		This demo contains examples of how certain things can be accomplished in idiomatic
		odin, allowing you to learn its semantics, as well as how to use parts of the core
		and vendor package collections. As always the best way to learn to code is by 
		reading code.
	*/
	
	the_basics()
	
}

