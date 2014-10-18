# Copyright (c) 2014, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#
# A sample file to demonstrate usage of the four monads
# created for this library

import maybe
import state
import io
import reader
import writer

# -------------------------------------------
# The maybe monad ---------------------------
# -------------------------------------------

# A simple adding function to use with our monads
proc adder(x: int) : Maybe[int] =
    return Maybe[int](valid: true, value: x+x)

# Initialize two maybe values
var m1 = Maybe[int](valid: true, value: 5)
var m2 = Maybe[int](valid: false)

# Create two results, of type Maybe[int]
# based on a chain of computations
var 
    r1 = m1 >>= adder >>= adder >>= adder
    r2 = m2 >>= adder >>= adder >>= adder

# Test the resultant values of our computations
echo($r1) # Outputs 'Just 40'
echo($r2) # Outputs 'Nothing'

# The writer monad


# The reader monad


# The state monad


# The IO monad
