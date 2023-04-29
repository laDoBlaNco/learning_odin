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
	fmt.println("\n# THE BASICS:")
	
	{ // The Basics
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
		h:int=123 // declares a new var 'h' with type 'int' and assigns a value to it
		h = 637 // assigns a new value to 'h'
		
		// = is the assignment operator
		
		// you can assign multiple vars with it as well:
		a,b := 1,"hello" // declaring 'a' and 'b' and infers the types of both from assignment
		fmt.println(a,b)
		b,a="byte",0
		fmt.println(a,b)
		
		// NOTE: := is two tokens as I've mentioned before and it easier to think of that way
		// its = and : The following are equivalent
		/*
			i: int = 123
			i:     = 123 the type int is inferred from the 123 so its left out
			i:=123 
		
		*/
		
		// CONSTANT DECLARATIONS:
		// Constants are entities (symbols) which have an assigned value
		// The constant's value cannot be changed
		// The constant's value must be able to be evaluated at compile time:
		X::"what" // constant x has the untyped string value "what" -- untyped?
		
		// Constants can be explicitly typed like a var declaration as well
		Y:int:123
		Z::Y+7 // constants computations are possible as long as they can be done at compile time
		
		_ = my_integer_variable
		_ = x
	}
}

control_flow::proc(){
	fmt.println("\n# CONTROL FLOW:")
	
	{	// CONTROL FLOW:
		// FOR LOOP:
		// odin ha only one loop just like Go, the for loop
		
		// Basic for loop
		for i:=0;i<10;i+=1{ // there is no i++ in odin, I think that's similar to python maybe
			fmt.println(i)
		}
		
		// NOTE: Unlike other languages like c, there are no ()s around the 3 components
		// Braces {} or a 'do' are always required. the 'do' is for single line statements
		for i:=0;i<10;i+=2 do fmt.print(i)
		fmt.println()
		
		// the initial and post components are optional which allows us to change this to a 
		// while statment
		i:=0
		for i<10{
			i+=1
			fmt.print(i)
			fmt.print(" ")
		}
		fmt.println()
		
		// take away the cond altogether and you have an infinite loop which would work for 
		// an event loop and need to break out of 
		for{
			break
		}
		
		// We also have the range based for, which a like better than Go's version of the same
		// though internally I believe they do the exact same thing, especially with strings
		// and runes vs bytes. 
		for j in 0..<10{
			fmt.print(j)
			fmt.print(" ") 
		}
		fmt.println()
		
		for j in 0..=10{ // NOTE: the diff in ..= and ..< the first being inclusive and the last exclusive
			fmt.print(j)
			fmt.print(" ")
		}
		fmt.println()
		
		// We can also iterate over certain built-in types as one would imagine.
		some_string:="Hello, 世界"
		for char in some_string{ // Strings are assumed to be UTF-8, meaning like go, we iterate
		// runes instead of bytes
			fmt.println(char)			
		}
		
		some_array:=[3]int{1,4,9} // a fixed array
		for val in some_array{
			fmt.println(val)
		}
		
		some_slice:=[]int{1,4,9} // a slice, just like Go, a window into an underlying fixed array
		for value in some_slice{ // I also like that we don't have to do _,val like in Go
			fmt.println(value)
		}
		
		some_dyn_array:=[dynamic]int{1,4,9} // my understanding here is that this is different from
		// a slice in that its an ACTUAL array that allocates and changes depending on what's appended
		// but under that seems to be the same workings as a slice, so not sure
		defer delete(some_dyn_array) // first look at defer for mem management
		for value in some_dyn_array{
			fmt.println(value) 
		}
		
		some_map:=map[string]int{"A"=1,"C"=9,"B"=4} // similar to Go except we use the '=' assignment
		// operator which really is more consitent with the lang rather than tradition. ;0)
		defer delete(some_map) // I guess we are deleting these since they are really pointers and
		// thus might be using heap memory
		for key in some_map{
			fmt.println(key) 
		}
		
		// odins method of using the index is simply saying that we can use a second var for the
		// index value, but its not required. This is better than Go I think becasuse usually we
		// are iterating through the specific items rather than using some_array[i], so it makes
		// sense to use that val,index instead of index,val 
		
		
	}
}





main::proc(){
	
	/*
		This demo contains examples of how certain things can be accomplished in idiomatic
		odin, allowing you to learn its semantics, as well as how to use parts of the core
		and vendor package collections. As always the best way to learn to code is by 
		reading code.
	*/
	
	the_basics()
	control_flow()
		
}

