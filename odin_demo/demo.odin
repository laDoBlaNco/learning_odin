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

the_basics :: proc() {
	fmt.println("\n# THE BASICS:")

	{ 	// The Basics
		fmt.println("Hellope")

		// LEXICAL ELEMENTS AND LITERALS:
		// This is a comment

		my_integer_variable: int // a comment for documentation

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

		some_string := "This is a string" // note the := which is two separate tokens. This is shortcut
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

		x: int = 1.0 // a float literal, but it can be represented by an integer without precision
		// loss. Constant literals are "untyped" which means that they can implicitly convert to
		// a type. 

		y: int // 'y' is typed of type 'int'
		y = 1 // 1 is untyped and in this case implicily converts to an int

		z: f64 // 'z' is a type f64
		z = 1 // This won't work in Go, but since 1 is untyped it can be implicily converted to f64
		// without precision loss. No need for any suffixes or decimal places like in other langs.
		// NOTE: the exception to this is negative zero, which must be given as -0.0.
		// CONSTANTS JUST WORK!!!!

		// ASSIGNMENT STATEMENTS:
		h: int = 123 // declares a new var 'h' with type 'int' and assigns a value to it
		h = 637 // assigns a new value to 'h'

		// = is the assignment operator

		// you can assign multiple vars with it as well:
		a, b := 1, "hello" // declaring 'a' and 'b' and infers the types of both from assignment
		fmt.println(a, b)
		b, a = "byte", 0
		fmt.println(a, b)

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
		X :: "what" // constant x has the untyped string value "what" -- untyped?

		// Constants can be explicitly typed like a var declaration as well
		Y: int : 123
		Z :: Y + 7 // constants computations are possible as long as they can be done at compile time

		_ = my_integer_variable
		_ = x
	}
}

control_flow :: proc() {
	fmt.println("\n# CONTROL FLOW:")

	{ 	// CONTROL FLOW:
		// FOR LOOP:
		// odin ha only one loop just like Go, the for loop

		// Basic for loop
		for i := 0; i < 10; i += 1 { 	// there is no i++ in odin, I think that's similar to python maybe
			fmt.println(i)
		}

		// NOTE: Unlike other languages like c, there are no ()s around the 3 components
		// Braces {} or a 'do' are always required. the 'do' is for single line statements
		for i := 0; i < 10; i += 2 do fmt.print(i)
		fmt.println()

		// the initial and post components are optional which allows us to change this to a 
		// while statment
		i := 0
		for i < 10 {
			i += 1
			fmt.print(i)
			fmt.print(" ")
		}
		fmt.println()

		// take away the cond altogether and you have an infinite loop which would work for 
		// an event loop and need to break out of 
		for {
			break
		}

		// We also have the range based for, which a like better than Go's version of the same
		// though internally I believe they do the exact same thing, especially with strings
		// and runes vs bytes. 
		for j in 0 ..< 10 {
			fmt.print(j)
			fmt.print(" ")
		}
		fmt.println()

		for j in 0 ..= 10 { 	// NOTE: the diff in ..= and ..< the first being inclusive and the last exclusive
			fmt.print(j)
			fmt.print(" ")
		}
		fmt.println()

		// We can also iterate over certain built-in types as one would imagine.
		some_string := "Hello, u4e16u754c"
		for char in some_string { 	// Strings are assumed to be UTF-8, meaning like go, we iterate
			// runes instead of bytes
			fmt.println(char)
		}

		some_array := [3]int{1, 4, 9} // a fixed array
		for val in some_array {
			fmt.println(val)
		}

		some_slice := []int{1, 4, 9} // a slice, just like Go, a window into an underlying fixed array
		for value in some_slice { 	// I also like that we don't have to do _,val like in Go
			fmt.println(value)
		}

		some_dyn_array := [dynamic]int{1, 4, 9} // my understanding here is that this is different from
		// a slice in that its an ACTUAL array that allocates and changes depending on what's appended
		// but under that seems to be the same workings as a slice, so not sure
		defer delete(some_dyn_array) // first look at defer for mem management
		for value in some_dyn_array {
			fmt.println(value)
		}

		some_map := map[string]int {
			"A" = 1,
			"C" = 9,
			"B" = 4,
		} // similar to Go except we use the '=' assignment
		// operator which really is more consitent with the lang rather than tradition. ;0)
		defer delete(some_map) // I guess we are deleting these since they are really pointers and
		// thus might be using heap memory
		for key in some_map {
			fmt.println(key)
		}

		// odins method of using the index is simply saying that we can use a second var for the
		// index value, but its not required. This is better than Go I think becasuse usually we
		// are iterating through the specific items rather than using some_array[i], so it makes
		// sense to use that val,index instead of index,val 
		for char, idx in some_string {
			fmt.println(idx, char)
		}
		for val, idx in some_array {
			fmt.println(idx, val)
		}
		for val, idx in some_slice {
			fmt.println(idx, val)
		}
		for val, idx in some_dyn_array {
			fmt.println(idx, val)
		}
		for k, v in some_map {
			fmt.printf("%s => %d\n", k, v) // NOTE: first time using printf and figured it out
			// very similar to C and Go versions seems
		}

		// NOTE: The iterated values are copies and cannot be written to. So basically can't
		// make inline changes without a couple adjustments
		for val, idx in some_slice {
			some_slice[idx] = (idx + 1) * (idx + 2) // tricky example cuz the result is the same. 
			// let me change it up a bit
		}
		fmt.println(some_slice) // now we see the inline change ;0)


		// IF STATEMENTS:
		// They seem pretty similar to the Go variants with same line declaration and branch scopes
		x := 123
		if x >= 0 {
			fmt.println("x is positive")
		}
		if y := -34; y < 0 {
			fmt.println("y is negative")
		}
		if y := 123; y < 0 {
			fmt.println("y is negative")
		} else if y == 0 {
			fmt.println("y is zero")
		} else {
			fmt.println("y is positive")
		}

		// SWITCH STATEMENTS
		// a switch statement is another way to write a seq of if-else statements
		// in odin, the default case is denoted as a case with no expression attached
		#partial switch arch := ODIN_ARCH; arch { 	// NOTE: the 'partial' preproc allows the switch to work without covering
		// all possible options
		case .i386:
			fmt.println("32-bit") // NOTE: .i386 as a type selector? I don't understand 100%
		// or maybe a union selector
		case .amd64:
			fmt.println("64-bit")
		case:
			fmt.println("Unsupported architecture") // case: default
		}

		// odin's switch is line one in c/c++, except like Go odin only runs the selected case.
		// This means that there is no 'break' statement needed at the end of each case.
		// Another important diff is that the case values need not be ints nor constants.

		// To get the c-like fall through you use the explicit keyword 'fallthrough' just like Go
		one_angry_dwarf :: proc() -> int { 	// proc in a proc? My first proc with a return val NOTE: ->
			fmt.println("one_angry_dwarf was called")
			return 1
		}

		switch j := 1; j {
		case 0:
		case one_angry_dwarf(): // note that the case is a func and it runs when found. So rather
		// cases with instructions, the actual cases can be functions that do things
		}

		// a switch statement without a cond is the same as 'switch true' (same as Go) This can
		// be used to write a clean and long if-else chain and have the ability to break 
		// if needed
		switch {
		case x < 0:
			fmt.println("x is negative")
		case x == 0:
			fmt.println("x is zero")
		case:
			fmt.println("x is positive")
		}

		// a switch statement can also use ranges like a range-based loop:
		switch c := 'j'; c {
		case 'A' ..= 'Z', 'a' ..= 'z', '0' ..= '9':
			// Go aint got nothing like this that I know of
			fmt.println("c is alphanumeric")
		}

		switch x := 66; x {
		case 0 ..< 10:
			fmt.println("units")
		case 10 ..< 13:
			fmt.println("pre-teens")
		case 13 ..< 20:
			fmt.println("teens")
		case 20 ..< 30:
			fmt.println("twenties")
		case 30 ..< 50:
			fmt.println("nice and mature")
		case 66:
			fmt.println("age ain't nothing but a number...MM's fav.")
		case:
			fmt.println("eewwwwww!")
		}

	}

	{ 	// DEFER STATEMENT:
		// a defer statement defers the execution of a statement until the end of the SCOPE
		// it is in. This is different from Go which is end of the function. This way is
		// more versatile and thus more powerful.

		// the following should print 4 then 234
		{
			x := 123 // x is 123 in this scope
			defer fmt.println(x) // defer the print of x till end of this current scope
			{
				defer x = 4 // defer the setting of x to 4 in this scope
				x = 2 // setting x to 2, but as this scope ends it'll be changed to 4
			}
			fmt.println(x) // print 4 from deferred setting of previous scope
			x = 234 // set set to 234 

			// and at the end of this scope the first deferred print will now run with x being 234
		}

		// You can defer an entire block as well if you needed to
		{
			bar :: proc() {}

			defer {
				fmt.println("1")
				fmt.println("2")
			}

			cond := false
			defer if cond {
				bar()
			}
		}
		fmt.println()
		// Like in go, defer statements are put on their own stack and run in reverse order
		{
			defer fmt.println("1")
			defer fmt.println("2")
			defer fmt.println("3")
		}
		// a more common use for defer as its used in Go
		if false {
			f, err := os.open("my-file.txt")
			if err != 0 { 	// NOTE: there is a 'nil' in odin, so interested in knowing how this works and
				// why they did it this way to handle your error
			}
			defer os.close(f) // idomatic to defer close right away as in Go
			// rest of your code. NOTE: also good to note here that odin doesn't have methods. That's
			// why we say os.close(f) and not f.close() or anything like that.
		}

	}

	{ 	// WHEN STATEMENTS:
		/*
			The when statement is almost identical to the if statement but with some diffs:
			-- Each condition must be a constant expression as 'when' statements are evaluated
				at compile time.
			-- The statements within a branch do not create a new scope
			-- The compiler checks the semantics and code only for statements that belong to
				the first condition that is true
			-- An initial statement is not allowed in a when statement as we see in if
				'if x:=0;x{...}' is not allowed.
			-- when statements are allowed at file scope
		*/

		// Example
		when ODIN_ARCH == .i386 {
			fmt.println("32 bit")
		} else when ODIN_ARCH == .amd64 {
			fmt.println("64 bit")
		} else {
			fmt.println("Unknown Architecture")
		}
		// The when statement is very useful for writing platform specific code. This
		// is akin to the #if construct in C's preprocessor however, in odin, it is
		// type checked, so its BETTER
	}

	{ 	// BRANCH STATEMENTS:
		cond, cond1, cond2 := false, false, false
		one_step :: proc() {fmt.println("one_step")}
		beyond :: proc() {fmt.println("beyond")}

		// Break statement
		for cond {
			switch {
			case:
				if cond {
					break // break out of the 'switch' statement
				}
			}
			break // this breaks out of the for scope
		}

		loop: for cond1 {
			for cond2 {
				break loop // this leaves both scopes since we can tell odin how far to break out
				// with the label 'loop:'
			}
		}

		// Continue statement - I see ti works as expected
		for cond {
			if cond2 {
				continue
			}
			fmt.println("hellope")
		}

		// Fallthrough statement:
		// fallthrough can be use to explicitly tell odin to fall through to the case block:
		switch i := 0; i {
		case 0:
			one_step()
			fallthrough
		case 1:
			beyond()
		}
	}
}


nameed_proc_return_parameters :: proc() {
	fmt.println("\n# NAMED PROCE RETURN PARAMETERS")

	foo0 :: proc() -> int { 	// procedure foo returns an int
		return 123
	}
	foo1 :: proc() -> (a: int) { 	// named return values just like Go's naked return construct
		a = 123
		return // since its named, there's no necesity to say 'return a' though you can if you want
	}
	foo2 :: proc() -> (a, b: int) {
		// Named return values act like vars within the scope
		a = 321
		b = 566
		return
	}
	fmt.println("foo0 =", foo0())
	fmt.println("foo1 =", foo1())
	fmt.println("foo2 =", foo2())

}

explicit_procedure_overloading :: proc() {
	fmt.println("\n# EXPLICIT PROCEDURE OVERLOADING")

	add_ints :: proc(a, b: int) -> int {
		x := a + b
		fmt.println("add_ints:", x) // here we have both side effects and return values
		return x
	}
	add_floats :: proc(a, b: f32) -> f32 {
		x := a + b
		fmt.println("add_floats:", x)
		return x
	}
	add_numbers :: proc(a: int, b: f32, c: u8) -> int {
		x := int(a) + int(b) + int(c)
		fmt.println("add_numbers:", x)
		return x
	}
	// now we get to the interesting stuff. This reminds
	// me of generics in Go. one func working witih multiple types
	add :: proc {
		add_ints,
		add_floats,
		add_numbers,
	} // this reminds me of Go generics but instead of
	// creating an interface with list of methods, its a func with a list of funcs
	add(int(1), int(2))
	add(f32(1), f32(2))
	add(int(1), f32(2), u8(3))

	add(1, 2) // untyped ints coerce to int tighter than f32
	add(1.0, 2.0) // untyped floats coerce to f32 tighter than int
	add(1, 2, 3) // three parameters

	// Ambiguous answers
	//add(1.0,2) //  Ambiguous procedure group call 'add' that match with the given arguments
	//add(1,2.0) // ok so seems that in cases where odin can't tell what types fall where in your
	// overloaded procs, then it'll require a type	
}

struct_type :: proc() {
	fmt.println("\n# STRUCT TYPE:")

	// A struct is a record type in odin, and really everywhere else. Hence in Go they speak of 
	// keeping all of our configurations and or storing our state in structs. It is a collection
	// of fields. Struct fields are accessed by using a dot.
	{
		Vector2 :: struct {
			x: f32, // NOTE: we need commas when declaring a struct in odin not Go
			y: f32,
		}
		v := Vector2{1, 2}
		v.x = 4
		fmt.println(v.x) // 4.000 since that field is of type f32

		// Struct fields can be accessed through a struct pointer when we need to change state
		// of our structure, this is same as Go (referencing what I know here)
		v = Vector2{1, 2}
		p := &v // p is a pointer to v
		p.x = 1335
		fmt.println(v)

		// we could write p^.x, however, it is nice to abstract the ability to not
		// explicitly dereference the pointer. this is very useful when refactoring
		// code to use a pointer rather than a value and vice and versa.
	}
	{
		// A struct literal can be denoted by providing the struct's type followed by
		// {}. A struct literal must either provide all the arguments, or none.
		Vector3 :: struct {
			x, y, z: f32,
		}
		v: Vector3
		v = Vector3{} // default zero values
		fmt.println(v)
		v = Vector3{1, 4, 9}
		fmt.println(v)
		// if you specify the fields by name you can assign some and let others default zero
		v = Vector3 {
			z = 1,
			y = 2,
		}
		fmt.println(v)
	}
	{
		// structs can also be tagged with different memory layouts and alignment requirements
		a :: struct #align 4 {} // align to 4 bytes
		b :: struct #packed {} // remove padding between fields
		c :: struct #raw_union {} // all fields share the same offset (0), this is the same as C's union
	}
}

union_type :: proc() {
	fmt.println("\n# UNION TYPES:")

	// so for me, again, union types fall into the interface & generics category of Go. It looks
	// like the gist of it is creating type sets or a union of types and then anything that falls
	// into that set can be used or held by that variable (interchangeably)
	{
		fmt.println("Unions:")
		val: union {
			int,
			bool,
		} // so 'val' is now both an int and a bool
		val = 137
		if i, ok := val.(int); ok { 	// this is a direct copy of Go syntax here. 'comma,ok', though the
			// type assertion I believe is a little different, but may be the same as well
			fmt.println(i)
		}
		val = true // now its a bool
		fmt.println(val)

		val = 66

		switch v in val { 	// note the slight  diff from goes type switch. Here we say 'v in val' so
		// its almost a merge on the syntax of a 'for..in' statement and a 'switch' statement.
		case int:
			fmt.println("int", v)
		case bool:
			fmt.println("bool", v)
		case:
			fmt.println("nil")
		}
	}
	{
		// There is duality between 'any' and 'union'
		// An 'any' has a pointer to the data and allows for any type (open)
		// A 'union' has a binary blob to store the d ata and allows only certain
		// types (closed). The following code is with 'any' but has the same syntax.
		fmt.println("\nAny:")
		val: any // so 'val' is now open to use any type. This is just like Go's any it seems
		val = 137
		if i, ok := val.(int); ok { 	// this is a direct copy of Go syntax here. 'comma,ok', though the
			// type assertion I believe is a little different, but may be the same as well
			fmt.println(i)
		}
		val = true // now its a bool
		fmt.println(val)

		val = 66

		switch v in val { 	// note the slight  diff from goes type switch. Here we say 'v in val' so
		// its almost a merge on the syntax of a 'for..in' statement and a 'switch' statement.
		case int:
			fmt.println("int", v)
		case bool:
			fmt.println("bool", v)
		case:
			fmt.println("nil")
		}

	}

	Vector3 :: distinct [3]f32
	Quaternion :: distinct quaternion128

	// Some more realistic examples:
	{
		// NOTE: For the above basic examples, you may not have any particular use for it.
		// However, my main use for them is not for these simple cases. My main use is for
		// hierarchical types. Many prefer subtyping, embedding the base data into derived
		// types. Below is an example of this for a basic game entity.
		Entity :: struct {
			id:          u64,
			name:        string,
			position:    Vector3,
			orientation: Quaternion,
			derived:     any,
		}

		Frog :: struct {
			using entity: Entity,
			jump_height:  f32,
		}

		Monster :: struct {
			using entity: Entity,
			is_robot:     bool,
			is_zombie:    bool,
		}

		// We'll see the details of this in the 'parametric_polymorphism' proc below
		new_entity :: proc($T: typeid) -> ^Entity { 	// so I know $ is generic typing so I guess 'typeid'
			// just means means its whatever type of T. 
			t := new(T)
			t.derived = t^
			return t
		}
		entity := new_entity(Monster)

		switch e in entity.derived {
		case Frog:
			fmt.println("Ribbit")
		case Monster:
			if e.is_robot {fmt.println("Robotic")}
			if e.is_zombie {fmt.println("Grrr!")}
			fmt.println("I'm a monster")
		}
	}

	{
		// NOTE: A union can be used to achieve something similar. Instead
		// of embedding the base data into the derived types, the derived data 
		// is embedded into the base type. Below is th esame example of the 
		// basic game Entity but using an union.

		Entity :: struct {
			id:          u64,
			name:        string,
			position:    Vector3,
			orientation: Quaternion,
			derived:     union {
				Frog,
				Monster,
			},
		}

		Frog :: struct {
			using entity: ^Entity,
			jump_height:  f32,
		}

		Monster :: struct {
			using entity: ^Entity,
			is_robot:     bool,
			is_zombie:    bool,
		}

		new_entity :: proc($T: typeid) -> ^Entity {
			t := new(Entity)
			t.derived = T {
				entity = t,
			}
			return t
		}

		entity := new_entity(Monster)

		switch e in entity.derived {
		case Frog:
			fmt.println("Ribbit")
		case Monster:
			if e.is_robot {fmt.println("Robotic")}
			if e.is_zombie {fmt.println("Grrrr!")}
		}

		// NOTE: As you can see, the usage code has not changed, only itst memory
		// layout. Both approaches have their own advantages but they can be used
		// toghether to achieve different results. The subtyping approach can allow
		// for a greater control of the memory layout and memory allocation, e.g. storing
		// the derivatives together. However, this is also it disadvantage. You must
		// either preallocate arrays for each derivative separation (which can be easily missed)
		// or preallocate a bunch of raw memory; determining the mas size of the derived
		// types would require the aid of metaprogramming. Unions solve this particular
		// problem as the data is stored with the base data. Therefore, it is possible
		// to preallocate, e.g. [100]Entity

		// It should be noted that the union approach can have the same memory layout
		// as the 'any' and with the same type restrictions by using a pointer type for
		// the deriviatives.


	}
}

using_statement :: proc() {
	fmt.println("\n# USING STATEMENT:")

	// using can be used to bring entities declared in a scope/namespace
	// into the current scope. This can be applied to import names, struct fields
	// procedure fields, and struct values. 
	Vector3 :: struct {
		x, y, z: f32,
	}
	{
		entity := &Entity{position = Vector3{1, 4, 9}}

		Entity :: struct {
			position:    Vector3,
			orientation: quaternion128,
		}

		// it can be used like this or...
		foo0 :: proc(entity: ^Entity) {
			fmt.println(entity.position.x, entity.position.y, entity.position.z)
		}

		// The entity members can be brought into the proc scope by using it like this:
		foo1 :: proc(entity: ^Entity) {
			using entity
			fmt.println(position.x, position.y, position.z)
		}

		// using can be applied to the parameter directly as well:
		foo2 :: proc(using entity: ^Entity) {
			fmt.println(position.x, position.y, position.z)
		}

		// It can also be applied to the subfields:
		foo3 :: proc(entity: ^Entity) {
			using entity.position
			fmt.println(x, y, z)
		}

		foo0(entity)
		foo1(entity)
		foo2(entity)
		foo3(entity)
	}
	{
		// We can also apply the using statement to the struct fields directly,
		// this is very powerful for customizing usage in different scopes. This makes
		// all the fields of position appear as if they are on Entity itself
		Entity :: struct {
			using position: Vector3,
			orientation:    quaternion128,
		}

		foo :: proc(entity: ^Entity) {
			fmt.println(entity.x, entity.y, entity.z)
		}

		foo(&Entity{}) // did it this way rather than going through the process above of creating
		// a new entity etc.


		// Subtype polymorphism
		// It is possible to get subtype polymorphism, similar to inheritance-lie funcationality
		// in C++, but without the requirement of vtables or unknown struct layouts.

		Colour :: struct {
			r, g, b, a: u8,
		}
		Frog :: struct {
			ribbit_volume: f32,
			using entity:  Entity,
			colour:        Colour,
		}
		// This seems like fancy words for Go's struct embedding
		frog: Frog
		foo(&frog.entity)
		foo(&frog)
		frog.x = 123
		foo(&frog)

		// NOTE: using can be applied to arbirarily many things, which allows the ability
		// to ahve multiple subtype polymorphism (but also has its issues)

		// NOTE: using'd fields can still be referred to by name.
	}
}

implicit_context_system :: proc() {
	fmt.println("\n# IMPLICIT CONTEXT SYSTEM:")

	// In each scope, there is an implicit value named context. This
	// context variable is local to each scope and is implicitly passed
	// by pointer to any proc call in that scope (if the proc has the odin
	// calling convention) 

	// The main purpose of the implicit context system is for the ability
	// to intercept third-party code and libraries and modify their
	// functionality. One such case is modifying how a library allocates
	// something or logs somethng. In C, this was usually achieved with
	// the library defining macros which could be overridden so that the
	// user could define what he wanted. However, not many libraries
	// supported this in many languages by default which meant intercepting
	// third-party code to see what it does and to change how it does it is
	// not possible.

	c := context // copy the current scope's context

	context.user_index = 456
	{
		context.allocator = my_custom_allocator()
		context.user_index = 123
		what_a_fool_believes() // the 'context' for this scope is implicitly passed to 'what_a_fool_believes'
	}

	// 'context' value is local to the scope it is in
	fmt.println(context.user_index == 456)

	what_a_fool_believes :: proc() {
		c := context // this 'context' is teh same as the parent proc that it was called from
		// From this example, context.user_index == 123
		// A context.allocator is assigned to the return value of 'my_custom_allocator()'
		fmt.println(context.user_index == 123)
		fmt.println(c)

		// The memory management proc use the 'context.allocator' by default
		// unless explicitly specified otherwise
		china_grove := new(int)
		free(china_grove)

		_ = c
	}

	my_custom_allocator :: mem.nil_allocator
	_ = c

	// By default the context value has default values for its parameters which is
	// decided in the package runtime. What the defaults are, are compiler specific.

	// To see what the implicit context value contains, please see the following
	// definition in package runtime.
}

parametric_polymorphism :: proc() {
	fmt.println("\n# PARAMETRIC POLYMORPHISM")

	print_value :: proc(value: $T) {
		fmt.printf("print_value: %T %v\n", value, value) // note the use of .printf and again its
		// same formatting verbs as Go with %T and %v
	}

	v1: int = 1
	v2: f32 = 2.1
	v3: f64 = 3.14
	v4: string = "message"

	print_value(v1) // print_value was generic with $T as an arg. Here it worked with 4 different
	print_value(v2) // types.
	print_value(v3)
	print_value(v4)

	fmt.println()

	add :: proc(p, q: $T) -> T {
		x: T = p + q
		return x
	}

	a := add(3, 4)
	fmt.printf("a: %T = %v\n", a, a)

	b := add(3.2, 4.3)
	fmt.printf("b: %T = %v\n", b, b) // again same func with two different types

	// So now with $T we can understand how 'new' is actually implemented. Also notice the diff
	// between generics in odin and in Go. Which is clearer and which is simpler?
	alloc_type :: proc($T: typeid) -> ^T { 	// there's a better explanation of what's happening here in
		// the odin overview. Which I'll be tackling after this.
		t := cast(^T)alloc(size_of(T), align_of(T))
		t^ = T{} // default init values
		return t
	}
	copy_slice :: proc(dst, src: []$T) -> int {
		n := min(len(dst), len(src)) // builtin 'min' and 'max' funcs
		if n > 0 {
			mem.copy(&dst[0], &src[0], n * size_of(T))
		}
		return n
	}

	double_params :: proc(a: $A, b: $B) -> A {
		return a + A(b)
	}

	fmt.println(double_params(12, 1.345))

	//NOTE: I'm leaving it here with polymorphic types and type specialization. We are getting
	// into some of the more complex pieces of odin and I need the extra detail given in the 
	// overview, to understand everything from this point on.

}


main :: proc() {

	/*
		This demo contains examples of how certain things can be accomplished in idiomatic
		odin, allowing you to learn its semantics, as well as how to use parts of the core
		and vendor package collections. As always the best way to learn to code is by 
		reading code.
	*/

	the_basics()
	control_flow()
	nameed_proc_return_parameters()
	explicit_procedure_overloading()
	struct_type()
	union_type()
	using_statement()
	implicit_context_system()
	parametric_polymorphism()

}
