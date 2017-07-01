# Copyright (c) 2014-2017, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#
# An implementation of the Maybe monad for Nim
# This implements the traditional operations, bind(called chain)
# and return(called box) as well as a few useful operators for 
# cleaning up usage of the monad. Also implemented the functor
# operation fmap(called map) which allows a procedure to be called
# on a wrapped value

import future

type
    Maybe*[T] = object
        case valid*: bool
        of true:    value* : T
        of false:   nil

proc nothing*[T]() : Maybe[T] =
  Maybe[T](valid: false)

proc just*[T](val: T) : Maybe[T] =
  Maybe[T](valid: true, value: val)

# Converts maybe value to a string.
proc `$`*[T](m: Maybe[T]) : string =
  if m.valid:
    result = "Just " & $m.value
  else:
    result = "Nothing"

# -------------------------------------------------
# Functor operations
# -------------------------------------------------

# Used to map a function over a boxed value.
#
# Equivalent to (Functor f) => fmap :: (a->b) -> f a -> f b in Haskell.
proc fmap*[T,U](m: Maybe[U], p: (U -> T) ) : Maybe[T] {. procvar .} =
  if m.valid:
    result = Maybe[T](valid: true, value: p(m.value))
  else:
    result = Maybe[T](valid: false)

# -------------------------------------------------
# Monad Operations
# -------------------------------------------------

# Used for chaining monadic computations together.
#
# Analagous to bind(>>=) in Haskell.
proc `>>=`*[T,U](m: Maybe[U], p: (U -> Maybe[T]) ) : Maybe[T] =
    if m.valid:
        result = p(m.value)
    else:
        result = Maybe[T](valid: false)

# Used to wrap a value in a Maybe
#
# Analagous to pure/return() in Haskell
proc pure*[T](val: T) : Maybe[T] =
  Maybe[T](valid: true, value: val)

# Used to extract a value from a Maybe[T]
#
# Use unbox with caution, will cause a runtime exception
# if trying to unbox a Nothing value since we don't have
# proper pattern matching.
proc unsafeUnwrap*[T](m: Maybe[T]) : T =
    return m.value
