# Copyright (c) 2014, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#
# A sample file to demonstrate usage of the four monads
# created for this library

import ../monad/maybe
import ../monad/writer

# -------------------------------------------
# The maybe monad ---------------------------
# -------------------------------------------

# A simple adding function to use with our monads
proc adder(x: int) : Maybe[int] =
    return Maybe[int](valid: true, value: x+x)

# Initialize two maybe values
var 
    maybe1 = Maybe[int](valid: true, value: 5)
    maybe2 = Maybe[int](valid: false)

# Create two results, of type Maybe[int]
# based on a chain of computations
var 
    maybeResult1 = maybe1 >>= adder >>= adder >>= adder
    maybeResult2 = maybe2 >>= adder >>= adder >>= adder
    
    # We specify the type here as the call to box() could be for any
    # soon-to-be monadic value
    maybeResult3 = maybe.box(5) >>= adder >>= adder >>= adder

# Test the resultant values of our computations
echo($maybeResult1) # Outputs 'Just 40'
echo($maybeResult2) # Outputs 'Nothing'
echo($maybeResult3)

# The writer monad
proc adderWithLogging(x: int) : Writer[int] =
    Writer[int](value: x+x, log: "I just added " & $x & " to itself") 

proc multWithLogging(x: int) : Writer[int] =
    var 
        lg = ""
        val = x*x
    
    lg = lg & "Here are some important logging notes"
    # some more work
    lg = lg & "Now that the work is done, lets have a cola"
    result = Writer[int](value: val, log: lg)

# Initialize a writer
var 
    writer1 = Writer[int](value: 5, log: "")
    writer2 = Writer[int](value: 5, log: "")

# Create a result based on a sequence of operations
var
    writerResult1 = writer1 >>= adderWithLogging >>= adderWithLogging
    writerResult2 = writer2 >>= multWithLogging >>= adderWithLogging >>= multWithLogging

# Print out the writer, including the value
echo($writerResult1)
echo($writerResult2)

# The reader monad


# The state monad


# The IO monad
