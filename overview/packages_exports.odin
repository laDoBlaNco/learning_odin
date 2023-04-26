// all odin programs are made up of packages. programs begin running in the package main
package main



import "core:fmt" // 'core' tells odin where to look for the import. pkg name will be 'fmt' unless
import o "core:os" // we give it another name as I've done with 'os'

// Everything is exportable by default. If we want something private we put a @(private) on any
// entity.

main::proc(){
	
	@(private) // this is actually the same as @(private=package) 
	my_variable:int // cannot be accessed outside this package
	
	// also we can say:
	@(private="file")
	my_variable_2:int // can't be accessed outside of this file.
	
}
