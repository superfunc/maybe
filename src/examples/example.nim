# Copyright (c) 2014-2017, Josh Filstrup
# Licensed under BSD3(see license.md file for details)

import ../maybe/maybe

# -------------------------------------------
# The maybe type 
# -------------------------------------------

# A simple adding function to use with our monads
proc adder(x: int) : Maybe[int] =
    return maybe.just(x+x)

# Initialize two maybe values
var 
    maybe1 = maybe.just(5) 
    maybe2 = maybe.nothing[int]() 

# Create two results, of type Maybe[int]
# based on a chain of computations
var 
    maybeResult1 = maybe1 >>= adder >>= adder >>= adder
    maybeResult2 = maybe2 >>= adder >>= adder >>= adder
    
    # We specify the type here as the call to box() could be for any
    # soon-to-be monadic value
    maybeResult3 = maybe.just(5) >>= adder >>= adder >>= adder

# Test the resultant values of our computations
echo($maybeResult1) # Outputs 'Just 40'
echo($maybeResult2) # Outputs 'Nothing'
echo($maybeResult3)

# Here are some simpler results showing how to use it as a functor
proc add5(x : int) : int =
  x + 5

var 
    value1 = maybe.fmap(maybe.just(10), add5)
    value2 = maybe.fmap(maybe.nothing[int](), add5)
    
# Here we see that maybe handles the optional-ness for us, so
# we can go along applying functions and obfuscate that detail
echo($value1)
echo($value2)

var m = maybe.just(4)

# macro usage
maybeCase m:
  just x:
    var y = 3
    echo $(x+y)
  nothing:
    echo "no value"

var nada = maybe.nothing[int]()
maybeCase nada:
  just foo:
    echo "hi this is a value we cant print" & $foo
  nothing:
    echo "nope no value, nice try with your invalid access"

