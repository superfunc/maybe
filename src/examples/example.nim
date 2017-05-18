# Copyright (c) 2014, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#
# A sample file to demonstrate usage of the four monads
# created for this library

import ../monad/maybe

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
