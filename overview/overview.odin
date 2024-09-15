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
	fmt.println("Hellope!")
}

comments :: proc() {
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
	fmt.println()

}

if_statement :: proc() {
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

  fmt.println()
};

switch_statment::proc(){
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

  fmt.println()

}

partial_switch::proc(){
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
  fmt.println()
}


defer_statement::proc(){
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


}
