// Introduction
// This article is a basic tutoral for the programming language odin. This tutorial
// assumes a basic knowledge of programming concepts such as vars, statements, and 
// types. It is recommended to read the 'Getting started with Odin' guide.

// I will set this up as one long document with all imports at the top and a 
// main proc at the bottom to run all the neded code.

package main

import "core:fmt"


hellope::proc(){
  // Hellope - To begin this tour, lets start with a modified version of the famous
  // "hello world" program
  fmt.println("Hellope!")
}

comments::proc(){
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




//===================== Main Process to Run

main::proc(){
  hellope()
  comments()
}