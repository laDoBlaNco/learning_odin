// Now let's looke at control_flow with 'if'
package main

import "core:fmt"

pl::fmt.println

main::proc(){
	
	// similar to Go and the for loop. No ()s but need the {} or do for one liners
	x:=69
	if x>=0{
		pl("x is positive")
	}
	
	// also like Go you can put the initialization with the if statement
	if x:=-69;x<0{
		pl("x is negative") 
	}
	
	// and like Go again, they stay in scope in all the blocks
	if x:=69;x<0{
		pl("x is negative")
	}else if x==0{
		pl("x is zero")
	}else if x>0{
		pl("x is positive") 
	}
}
