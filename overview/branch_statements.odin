package main

import "core:fmt"


break_statement :: proc() {
	fmt.println("\n----BREAK STATEMENT----")
	fmt.println("If everything worked, there shouldn't be anything here U0001f913")
	cond, cond1, cond2 := true, true, true // if these breaks didn't work I would get an infinite loop
	// below.
	// BREAK STATEMENT:
	// A for loop or a switch statement can be left prematurely with a 'break' statement. It
	// leaves the INNERMOST CONSTRUCT, unless 'label' of a construct is given, then it'll leave
	// the labeled one.
	for cond {
		switch {
		case:
			if cond {
				break // this will break out of the 'switch' statement
			}
		}
		break // this will break out of the 'for' statement
	}

	loop: for cond1 {
		for cond2 {
			break loop // this will leave both statements as its following the label.
		}
	}
}

continue_statement :: proc() {
	// CONTINUE STATEMENT:
	// As in many langs, a continue statement starts the next iteration of a loop prematurely.
	fmt.println("\n----CONTINUE STATEMENTS----")
	fmt.println("Skipping even numbers with 'continue'")

	for i in 1 ..= 10 {
		if i % 2 == 0 {
			continue
		}
		fmt.println(i)
	}

}

fallthrough_statement :: proc() {
	fmt.println("\n----FALLTHROUGH STATEMENT----")
	// odin's switch statement is similar to the one in c/c++, except that in odin (like Go)
	// we only run the selected case. This means that a break statement isn't needed at the 
	// end of each case. Another important NOTE is that the case values need not be integers nor
	// constants

	// 'fallthrough' can be used to explicily fall through into the next case block
	i := 0
	switch i {
	case 0:
		fmt.println("first case run")
		fallthrough
	case 1:
		fmt.println("second case run too")
	}
}


main :: proc() {

	break_statement()
	continue_statement()
	fallthrough_statement()
}
