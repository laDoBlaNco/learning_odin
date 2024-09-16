// Introduction
// This article is a basic tutoral for the programming language odin. This tutorial
// assumes a basic knowledge of programming concepts such as vars, statements, and 
// types. It is recommended to read the 'Getting started with Odin' guide.

// I will set this up as one long document with all imports at the top and a 
// main proc at the bottom to run all the neded code.

// Packages and Import statement - Odin programs consist of packages. A package is a directory
// of Odin code files, all of which have the same package declaration at the top. Execution starts
// in the package's 'main' proc

package main// all files with package main are in the same package; A directory cannot contain
// more than one package

// Packages may be thematically organized by placing them in subdirectories of another package
// for example: core:image/png and core:image/tga. Note: it does NOT imply dependency to the
// parent package. 

// The import statements import from different packages. Here we have the fmt and os packages
import "core:fmt"
import "core:os"
// if no prefix is present, the import will look relative to the current file.
// NOTE: By convention, the package name is the same as the last element in the import
// path, just like GO. So all files in "core:fmt" start with package fmt. But this isn't enforced
// by the compiler, which means the default name for the import name will be determined by the
// last element in the import path if possible.
// We can also add an "import name" like: import foo "core:fmt" then use foo.println()

// All declarations are exported by default. Unlike Go where the capital letter means export,
// in Odin its default export unless you add the 'private' attribute.
@(private)
my_variable: int // cannot be accessed outside this package. Also NOTE this must be package/file level
// I tried using @(private) in a function and it errors

// we can also make an entity private to the file instead of the default package above
@(private = "file")
another_variable: int // cannot be accessed outside this file.

hellope :: proc() {
	// Hellope - To begin this tour, lets start with a modified version of the famous
	// "hello world" program
  fmt.println("Hello World!")
	fmt.println("Hellope!")
}

comments :: proc() {
  fmt.println()
  fmt.println("Comments:")
	// comments can be anywhere outside of a string or character literal. Single
	// line comments begin with //, so pretty normal
	fmt.println("No comments ran") // single line comment

	// multi-line comments begin with /* and end with */ and can be nested
	/*
    We can have any text or code here and
    have it be commented.
    /*
      Note: comments can be nested
    */
  */
	fmt.println("Single comments with // and Multi-line nested with /*  /* */  */")

}

string_literals :: proc() {
  fmt.println()
  fmt.println("String Literals:")
	// String literals are enclosed by DOUBLE quotes (like Go) and character literals (runes)
	// in single quotes. Special chars are escaped with \ as normal.
	fmt.println("This is a string in double quotes")
	fmt.println("This is a char in single quotes:", 'A')
	fmt.println("Here's a newline escaped with a backslash:", '\n')
	fmt.println("Here's a path with backslashes:", "C:\\Windows\\notepad.exe")
	fmt.println(
		"Finally we have the same path as a row string literal wtih backquotes:",
		`C:\Windows\notepade.exe`,
	) // NOTE the extra comma on a multiline arg list just like Go

	// The length of a string can be found with the built-in 'len' proc:
	fmt.println("The length of: Foo - ", len("Foo"))
	fmt.println("The length of: Some other string - ", len("Some other string"))
	// If the string passed to len is a complile-time constant, than len will be a compile-time
	// constant as well.

}

numbers :: proc() {
  fmt.println()
  fmt.println("Numbers:")
	// Numerical literals are similar to most other langs. One thing Odin uses is the _ 
	// for better readability 1_000_000_000_000. if there's a . then its a floating point
	// literal 1.0e9 and if it has a suffix of 'i' then its imaginary 2i (2 multiply square root
	// of -1).

	// Binary literals are prefixed with 0b, octals 0o and hex 0x. In Odin if a number literal
	// can be represented by a type without precision loss, it'll be converted to that type
	// automatically.
	x: int = 1.0 // a float literal but it can be rep'd by an integer without precision loss

	// constant literals are untyped, meaning tehy can implicitly convert to a type
	y: int // 'y' is type as being an int
	y = 1 // '1' is an untyped integer literal which will implicitly convert to an int.
}

variables :: proc() {
  fmt.println()
  fmt.println("Variables:")
	// A variable declaration declares a new variable for the current scope
	x: int // declares 'x' to have type int
	y, z: int // declares 'y' and 'z' to have type 'int'

	// variables are initialized to zero by default (like Go) unless specified otherwise
	// NOTE: Declarations have to be unique to a scope
	// x := 10 // this will error as a 'redeclaration of 'x' in this scope
	// test, z := 20, 30 // 'test' works but 'z' will error as a redeclaration in this scope
	fmt.println(x, y, z) // print the zero default
}

assignment :: proc() {
  fmt.println()
  fmt.println("Assignments:")
	// The assignment statement assigns a new value to a variable/location
	x: int = 123 // declares a new variable 'x' with type 'int' and assigns '123' to it
	x = 637 // assigns a new value to 'x'

	// we an also assign multiple values with one '='
	y, z := 1, "hello" // declares 'x' and 'y' and infers the type
	z, x = "bye", 5

	// Note that := is really two tokens, : and =. Its literally x:int=123 without the type
	// x:=123
	fmt.println(x, y, z)
}

// Control flow statements
for_loop :: proc() {
  fmt.println()
  fmt.println("For Loops:")
	// like Go, Odin only has one loop construct, for. But it has more uses for it
	// The basic for loop same as Go
	for i := 0; i < 10; i += 1 { 	// there is no i++ in Odin
		fmt.println(i)
	}
	fmt.println()

	// As with Go, no ()s needed, but {} or a 'do' are always required.
	for i := 0; i < 10; i += 1 do fmt.println(i) // or
	for i := 0; i < 10; i += 1 {fmt.println(i)}
	fmt.println()

	// The first and second statements are optional, like Go, turning it into a while loop
	i := 0
	for i < 10 {i += 1}
	fmt.println(i)
	fmt.println()

	// finally we can also do an infinite loop like in Go with just for{}

	// Range based loops - similar to Go but with a more intuitive syntax
	for i in 0 ..< 10 do fmt.println(i) // NOTE the use of 'do' for single line loops again
	fmt.println()
	for i in 0 ..= 10 do fmt.println(i) // ..<10 and ..=10 mean closed and half-open intervals
	// basically =10 is inclusive of 10 and <10 is exclusive of 10.
	fmt.println()

	// certain types can be iterated over as expected.
	some_string := "Hello, 世界" // mmm that seems stolen from Go 
	for char in some_string do fmt.println(char)
	fmt.println()

	some_array := [3]int{1, 4, 9} // Go arrays? anyone
	for value in some_array do fmt.println(value)
	fmt.println()

	some_slice := []int{1, 4, 9} // slices seem just like Go
	for value in some_slice do fmt.println(value)
	fmt.println()

	some_dynamic_array := [dynamic]int{1, 4, 9} // I dont' remember this from Go. Slices are dynamic arrays
	defer delete(some_dynamic_array)
	for value in some_dynamic_array do fmt.println(value)
	fmt.println()

	some_map := map[string]int {
		"a" = 1,
		"c" = 9,
		"b" = 4,
	}
	defer delete(some_map)
	for key in some_map do fmt.println(key)
	fmt.println()

	// Alternatively a second index value can be added just like in Go as well.
	for char, index in some_string do fmt.println(index, char)
	fmt.println()

	for val, index in some_array do fmt.println(index, val)
	fmt.println()

	for val, index in some_slice do fmt.println(index, val)
	fmt.println()

	for val, index in some_dynamic_array do fmt.println(index, val)
	fmt.println()

	for key, value in some_map do fmt.println(key, value)
	fmt.println()

	// Iterated values are copies and can't be written to. Just like Go, when iterating, 
	// Oden will assume the string is UTF-8 and chars will be runes not bytes
	str: string = "Some text"
	for char in str {
		assert(type_of(char) == rune)
		fmt.println(char)
	}
	fmt.println()

	// we can actually right iterated values, but using a reference operator & (pointer syntax)
	// I don't know if Go can do this one
	for &val in some_array do val = 6
	fmt.println(some_array)
	fmt.println()

	// Map values can be iterated by reference as well, but their keys are immutable
	for key, &value in some_map do value += 1
	fmt.println(some_map["a"])
	fmt.println(some_map["c"])
	fmt.println(some_map["b"])
	fmt.println()

	// since strings are immutable, we can iterate a string by reference

	// we also have a #reverse directive with 'for' to make range-based loops iterate backwards
	// definitely not in Go
	array := [?]int{10, 20, 30, 40, 50}
	#reverse for x in array do fmt.println(x)

}

if_statement :: proc() {
  fmt.println()
  fmt.println("If Statements:")
	// The if statement in Odin is just like the one from Go. No need for ()s but
	// {}s are necessary, or 'do' for one liners.
	if true do fmt.println("Go can't do this")

	x := 66
	if x >= 0 do fmt.println("x is positive")

	// like 'for', the 'if' statement can start with an initial statement to 
	// execute the condition, just like Go. Variables declared by the inital 
	// statement are only in the scope of that if statement.
  if x:=-15;x<0 do fmt.println("X is negative")

  // vars declared inside an if statement are also available to any of the 'else' blocks
  // just like in Go
  if x:=66;x<0{
    fmt.println("x is negative")
  }else if x==0{
    fmt.println("x is zero")
  }else{
    fmt.println("x is positive")
  }
};

switch_statment::proc(){
  fmt.println()
  fmt.println("Switch Statements:")
  // A switch statement is another way to write a seq of if-else statements. in Odin, the default
  // case is denoted as a case without any expression
  switch arch:=ODIN_ARCH;arch{
    // this is very similar if not exactly like Go
    case .i386,.wasm32,.arm32:fmt.println("32 bit")
    case .amd64,.wasm64p32,.arm64:fmt.println("64 bit")
    case .Unknown:fmt.println("Unknown architecture") 
  }

  // Odin's switch is like the one in C or C++, except that Odin, like Go, only runs the selected
  // case. This means that a break statement is not needed at the end of each case. Another
  // important difference is that the case values need not be integers nor constants. 

  // To achieve the C-like fall-through into the next case block, the keyword fallthrough can
  // be used.

  // switch cases are evaluated from top to bottom, stopping when the case succeeds. 
  i:=0
  switch i{
    case 0:
    case :fmt.println("We never  get to this")
  }
  
  // A switch statement without a condition is the same as 'switch true', meaning we can 
  // write a clean and long if..else chain and have the ability to break if needed
  x:=66
  switch{
    case x<0:fmt.println("x is negative")
    case x==0:fmt.println("x is zero")
    case:fmt.println("x is positive")
  }

  // A switch statement can also use ranges like a range-based loop:
  // I'm not sure if Go can also do this, but I don't think so. Point for G Bill
  c:=7
  x=17

  switch c{
    case 'A'..='Z','a'..='z','0'..='9':fmt.println("c is alphanumeric")
  }

  switch x{
    case 0..<10:fmt.println("units")
    case 10..<13:fmt.println("pre-teens")
    case 13..<20:fmt.println("teens")
    case 20..<30:fmt.println("twenties")
  }

}

partial_switch::proc(){
  fmt.println()
  fmt.println("Partial Switches:")
  // @partial switch with enum values:
  Foo::enum{
    A,
    B,
    C,
    D,
  }

  f:=Foo.A
  switch f{
    case .A:fmt.println("A")
    case .B:fmt.println("B")
    case .C:fmt.println("C")
    case .D:fmt.println("D")
    case:fmt.println("?") 
  }

  // ok so with the *partial switch we don't get an error for not covering all the possible
  // cases as we would in the one above, if we left out one of the .Cs
  #partial switch f{
    case .A:fmt.println("A")
    case .B:fmt.println("B") 
  }

  // With union types (see Type switch statement (which is another Go reference) which we'll
  // see later in this overvierw)
  Bar::union{int,bool}
  g:Bar = 123  // note again this is the long typing version of g:=123 which is the inferred version
  switch _ in g{
    case int:fmt.println("int")
    case bool:fmt.println("bool") 
    case:
  }

  // again with the #partial switch we don't have to use all the cases
  #partial switch _ in g{
    case bool:fmt.println("bool") 
  }
}


defer_statement::proc(){
  fmt.println()
  fmt.println("Defer Statement:")
  // A defer statement defers the execution of a statement until the end of the scope it is
  // in. 
  // NOTE: I learned yesterday (9/13/24) in the morning that this is different from Go in that 
  //       Go defers execution to the end of a function only, but here in Odin its scope.
  //       A subtle but important difference and yet another point for G Bill.
  x:=123
  defer fmt.println(x)

  {
    defer x = 4  // here the assignment is deferred to the end of this inner-scope after x=2
    x = 2
  }
  fmt.println(x)  // so here it prints 4 because it was set to 4 at the end of the inner-scope

  x = 234 // after this is set to 234 the very first deferred print is happening.

  // You can defer an entire block as well if you need too:
  // Meaning we can defer functions in blocks or if statement blocks as well to the end of the
  // parent scope.

  // Just like with Go, Defer statements are executed in reverse order due to the stack they
  // are sent to.
  defer fmt.println("1")
  defer fmt.println("2")
  defer fmt.println("3") 

  // Note that due to the way I'm running these procedures, even my printing of 234 from the 
  // beginning of the procedure is done last, since it was first on the stack of this scope.

  // A real use case would be opening a file and deferring its closing in the next line of code
  // although it won't happen till the end of that scope. In this case it acts akin to an explicit
  // c++ destructor however, the error handling is basic control flow.

  // NOTE: The defer construct in Odin differs from Go's defer, which is function-exit and relies
  // on a closure stack system. 
}

when_statement::proc(){
  fmt.println()
  fmt.println("When Statements:")

  // The 'when' statement is almost identical to the 'if' statement but with some differences:
    // Each condition MUST be a constant expression as a when statement is evaluated at compilation
    // The statements within a branch do not create a new scope
    // The compiler checks the semantics and code ONLY for statements that belong to the first 
    //    condition if its true
    // An initial statement is not allowed in a when statement
    // 'when' statements are allowed at file scope
    when ODIN_ARCH==.i386{
      fmt.println("32 bit")
    }else when ODIN_ARCH==.amd64{
      fmt.println("64 bit")
    }else{
      fmt.println("Unsupported architecture") 
    }

    // The 'when' statement is very useful for writing platform specific code. This is akin
    // to the #if construct in C's preprocessor. However, in Odin, it is type checked. 
}

branch_statements::proc(){
  fmt.println()
  fmt.println("Branch Statements:")

  // Break statement
  // a for loop or switch statement can be left prematurely with a break statement. It leaves
  // the innermost construct, unless a label of a construct is given. Pretty normal behavior here.

  /*
  Too much to make this example work so I'll just put the pseudo code to show how it works

  for cond {
    switch{
      case:
        if cond{
          break // this will break out of the 'switch' construct
        }
        break // this will break out of the 'for' loop.
    }
    loop: for cond1 {
            for cond2 {
              break loop  // leaves both loops because of going straight to the label
            }
    }
    exit: {
        if true{
          break exit // works with labled blocks too
        }
        fmt.println("This line will never print.")
    }
  }


  Continue statement
  As in many programming languages, a 'continue' statement starts the next iteration of
  a loop prematurely:

  for cond{
        if get_foo(){
          continue
        }
        fmt.println("Hellope")
  }


  fallthrough statement
  Odin's switch is like the one in C or C++, except that Odin only runs the selected case.
  This means that a break statement is not needed at the end of each case. Another important
  difference is that the case values need not be integers nor constants. 

  fallthrough can be used to explicitly fall through into the next case block.
  switch i{
    case 0:
      foo()
      fallthrough
    case 1:
      bar()
  }
  */
  fmt.println("Nothing to print")
}

procedures::proc(){
  fmt.println()
  fmt.println("Procedures:")

  // In odin, a procedure is something that can do work, which some languages call functions
  // or methods. A procedure literal in odin is defined with the 'proc' keyword:
  fibonnacci::proc(n:int)->int{
    switch{
      case n<1:return 0
      case n==1:return 1
    }
    return fibonnacci(n-1) + fibonnacci(n-2)
  }

  fmt.println(fibonnacci(3)) 
}

parameters::proc(){
  fmt.println()
  fmt.println("Parameters:")

  // Procedures can take zero or more params. the following example is a basic proc
  // that multiples two ints together.
  multipy::proc(x:int,y:int)->int{ // Note the sig is similar to Go but the return is '->int'
    return x*y
  }
  fmt.println(multipy(137,432))

  // when we have 2 or more consecutive params that share a type, we can omit the type
  // from the previous name (just like in Go), like other variable declarations. So
  // the above could also be 
  multiply::proc(x,y:int)->int{
    return x*y
  }
  fmt.println(multiply(137,432))

  // Continuing the C family traditions, everything in Odin is passed by value (like Go, 
  // so basically copies; rather than by reference, e.g. Fortran,Java,etc). However, Odin 
  // differs from the C/C++ tradition in that all procedure parameters in Odin are immutable
  // values. This allows for numerous optimizations with Odin calling conventions ('odin' and
  // 'contextless') which would not be possible with the original C tradition of always 
  // passing a copy of the thing that has been passed. 

  // Passing a pointer value makes a copy of the pointer, not the data it points to. Slices,
  // dynamic arrays, and maps behave like pointers in this case (just like Go, sounds like; 
  // internally they are structures that contain values, which include pointers, and the 
  // 'structure' is passed by value)

  // To mutate the procedure params like in C, an explicit copy is required. This can be
  // done through shadowing the variable declaration. Exactly what do in Go for certain
  // loop constructs prior to 1.23
  fmt.println()
  foo::proc(x:int){
    x:=x   // explicit mutation. Without this it won't compile
    for x>0{
      fmt.println(x)
      x-=1
    }
  }
  foo(3)

  // Procedures can be variadic as well which is pretty common 
  fmt.println()
  sum::proc(nums:..int)->(result:int){
    for n in nums{
      result+=n
    }
    return  // Another from Go, here we have the 'naked' return, since the return value is named
            // in the signature '->(result:int)'
            // Also note the spread syntax type is ..int, instead of ...int as we see in others
  }
  fmt.println(sum())
  fmt.println(sum(1,2))
  fmt.println(sum(1,2,3,4,5))

  odds:=[]int{1,3,5}
  fmt.println(sum(..odds)) // again a look at the spread operator, a slice as varargs
}

multiple_results::proc(){
  fmt.println()
  fmt.println("Multiple Results:") 

  // A procedure in Odin can return any number of results
  swap::proc(x,y:int)->(int,int){
    return y,x
  }
  fmt.println(1,2)
  fmt.println(swap(1,2))

  // Named Results
  // This is what I referred to in a previous section as coming from Go. 
  // Return values in Odin may be named. If so, they are treated as variables defined at the top
  // of the proc, like input params. A return statement without args will return the named return
  // values. 'Naked' return statements should only be used in short and very simple procs, as it
  // reducees readability.
  fmt.println()
  do_math::proc(input:int)->(x,y:int){
    x=2*input+1
    y=3*input/5
    return x,y
  }
  fmt.println(do_math(66))

  do_math_with_naked_return::proc(input:int)->(x,y:int){
    x=2*input+1
    y=3*input/5
    return  // Naked return
  }
  fmt.println(do_math_with_naked_return(66))
}

named_arguments::proc(){
  fmt.println()
  fmt.println("Named Arguments:")

  // When caling a procedure, it is not always clear in which order params might appear.
  // Therefore, the arguments can be named, like a struct literal, to make it clear which
  // arg a parameter is for

  // For example:
  // create_window::proc(title:string,x,y:int,width,height:int,monitor:^Monitor)->(^Window,Window_Error){
  //   ... 
  // }

  // window, err := create_windoow(title="Hellop Title",monitor=nil,width=854,height=480,x=0,y=0)

  // As of dev-2023-07 release, mixing named and position args is allowed. This is often useful
  // when a proc has a lot of arguments or you want to customize default values. 
  // NOTE: Positional args are NOT ALLOWED AFTER named arguments.

  // foo::proc(value:int,name:string,x:bool,y:f32,z:=0){...} // note the last one is a default
  // foo(134,"hellope",x=true,y=4.5)

  // Let's talk about default values now:
  // Its really the same we just give the vars values to infer type, rather than the type name
  // create_window::proc(title:string, x:=0,y:=0,width:=854,height:=480,monitor:^Monitor=nil)->(^Window,Window_Error){...}
  // Note above the last arg has both Type and default, so we use var:T=value instead of var:=val
  // Note also that these default values must be compile time known values, such as a constant 
  // value or nil (if the type supports it)


  // Finally for this section, Explicit procedure overloading:
  // Unlike other languages, Odin provides the ability to explicitly overload procedures. 
  bool_to_string::proc(b:bool)->string{
    if b {return "true"}
    return "false"
  }
  int_to_string::proc(i:int)->string{
    return "I'm a string now"
  }

  to_string::proc{bool_to_string,int_to_string} 
  fmt.println(to_string(66))
  fmt.println(to_string(false))
  fmt.println(to_string(true))
  // That is very cool, and super intuitive. another point for G Bill

  /*
  Rationale for explicit overloading:
  The design goals of odin were explicitness and simplicity. Implicit procedure overloading 
  complicates the scoping system. In C++, you can't nest procedures within procedures, so all
  procedure look-ups are done at the global scope. In Odin, procedures can be nested within
  procedures and, as a result, determining which procedure should be used, in the case of 
  implicit overloading, is very complex. 

  What are the advantages:
    -- Explicitness of what is overloaded
    -- Able to refer to the specific procedure if needed
    -- Clear which scope the entiry name belongs to
    -- Ability to specialize parametric polymorphic procedures if necessary, wich have the same
       parameter, but different bounds (see where clauses)

    foo::proc{
      foo_bar,
      foo_baz,
      foo_baz2,
      something_entirely_different,
    }
      ...and it'll all work



  */

}




//===================== Main Process to Run

main :: proc() {
	hellope()
	comments()
	string_literals()
	numbers()
	variables()
	assignment()
	for_loop()
	if_statement()
  switch_statment()
  partial_switch()
  defer_statement()
  when_statement()
  branch_statements()
  procedures()
  parameters()
  multiple_results()
  named_arguments()

}
