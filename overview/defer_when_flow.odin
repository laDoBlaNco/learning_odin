// Control Flow - defer & When

package main

import "core:fmt"
//import "core:os" // so I didn't need OS to read ODIN_ARCH, interesting.

main::proc(){
	
	x:=123
	defer fmt.println(x)
	{
		defer x=4 // defer execution till the END OF THE SCOPE not the function
		x=2 // so after this, x is then assigned the value of 4 and that's printed.
	}
	fmt.println(x)
	
	x=234 // then x is given the value of 234 and the first defer is then executed at the end of main
	
	// we can also defer entire blocks 'defer {}' or 'defer if cond{}' 
	
	// just like Go they are executed in LIFO manner
	defer fmt.println(1)
	defer fmt.println(2)
	defer fmt.println(3) 
	
	// NOTE: the defer construct differs from Go in that Go uses function-exit and relies on
	// a closure stack system

	// When statement is almost identical to if except for the following: (just like v)
		// Each cond must be a constant expression as these are evaluated  on compile time
		// the statement in the branch doesn't create new scope
		// the compiler checks the semantics and code only for statements that belong to the
		// ...first true condition
		// An initial statement is not allowed in a when statement 'if var:=69;var{}'
		// 'when' stattements are allowed at file scope, unlike 'if' statements


	// I tried at file level and got an error???
	when ODIN_ARCH == .i386{
		fmt.println("32 bit")
	}else when ODIN_ARCH == .amd64{
		fmt.println("64 bit")
	}else{
		fmt.println("Unsupported architecture") 
	}
}



