// Reading console input with odin
package read_console_input

import "core:fmt"
import "core:os"

main::proc(){
	buf:[256]byte
	fmt.println("Please enter some text:")
	
	n,err := os.read(os.stdin,buf[:]) // returns errors just like Go with multiple return values
	if err<0{ // < 0? interesting take on the Go syntax
		// handle error
		return
	}
	str:=string(buf[:n]) // n = number of bytes written just like a Go io.Reader
	fmt.println("Outputted text:",str) 
}
