package main

import "core:fmt"

// very Go like with the boilerplate, but still very simple.
main::proc(){
	
	// A line comment
	
	my_integer_variable:int // a comment for documentation
	
	/*
		Muliline comments are done this way in odin.
		You can have any text or code here and have it be commented out.
		/*
			NOTE: Comments can be nested! Not like in C
		*/
	
	*/
	
	// String and char literals
	// strings are enclosed in "" and chars in ''. special chars escaped with \ - normal
	some_string:="This is a string"
	a_char:rune = 'A' // name : type = 
	a_special_char:rune = '\n' // this is a rune not a string
	a_escaped_string:="C:\\Windows\\notepade.exe" // type inferred with := which is : and = from prev
	
	// then we have raw string - all of this just like Go
	a_raw_string:string=`C:\windows\notepade.exe`
	
	fmt.println(len("Foo"))
	fmt.println(len(some_string)) 
	
	// Escape characters
	fmt.println('\a') 
	
	
}
