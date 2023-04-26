// Control Flow - for statements
package main

// just like Go and V, we only have one loop statement in odin

import f "core:fmt"

main::proc(){
	
	// basic for is as expected like the 'c' version, just like Go
	for i:=0;i<10;i+=1{ // except there is no ++
		f.println(i)
	}
	
	f.println("===============")
	
	// we can also do a single statement, sameline with a 'do'
	for i:=0;i<10;i+=1 do f.println(i)
	f.println("===============")
	
	// just like in Go the initial and post elements are optional and can be place in other parts
	// of the program. This  allows us to create both while and infinite loops
	i:=0
	for i<10{
		i+=1
		f.println(i)
	}
	f.println("==============") 
	
	// the infinite loop
	i=0
	for{
		f.println(i)
		if i>=10{break}
		
		i+=2
	}
	f.println("==============") 
	
	// Ranges are a little different in odin:
	for i in 0..<10{ // NOTE: the <10 which means a half-open interval o sea non-inclusive
		f.println(i)
	}
	f.println("==============") 

	for i in 0..=10{ // NOTE: the  =10 which means a closed interval, meaning inclusive
		f.println(i) 
	}
	f.println("==============") 
	
	// we can also iterate over certain builtin types (strings, arrays, slices, dyn_arrays, maps, etc)
	for char in "This is a string 💓💓💓"{
		f.println(char) 
	}
	f.println("==============") 
	
	// we can also add a second var for the index 
	for char,i in "This is a string 💓💓💓"{
		f.println(i,char) 
	}
	f.println("==============") 
	
	// NOTE: when iterating a string, the chars will be runes, not bytes. for..in assumes
	// utf-8 though the byte count is different
	a_string:="This is a string 💓💓💓 💪🏾💪🏾💪🏾"
	l_index := 0
	for char,i in a_string{ // NOTE: the differences between the indexes, how it jumps
		f.println("Index:",i,"Rune:",char)
	}
		
	// NOTE: Finally the iterated values are copies. If you want to write to them in a by-ref
	// manner, then you can do 'some_slice[i] = something' in the body of the loop

}
