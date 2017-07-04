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
  ## Maybe provides a type which encapsulates the concept
  ## of null-ness in a safe way. This allows one to perform function
  ## calls over the underlying object, without forgetting to check if
  ## it is in a valid state.
  Maybe*[T] = object
      case valid*: bool
      of true:    value* : T
      of false:   nil

proc nothing*[T]() : Maybe[T] =
  ## Construct a maybe instance in the invalid state.
  Maybe[T](valid: false)

proc just*[T](val: T) : Maybe[T] =
  ## Construct a maybe instance in the valid state.
  Maybe[T](valid: true, value: val)

proc `$`*[T](m: Maybe[T]) : string =
  ## Convert a maybe instance to a string.
  if m.valid:
    result = "Just " & $m.value
  else:
    result = "Nothing"

# -------------------------------------------------
# Functor operations
# -------------------------------------------------

proc fmap*[T,U](m: Maybe[U], p: (U -> T) ) : Maybe[T] {. procvar .} =
  ## Used to map a function over a boxed value.
  ##
  ## Equivalent to (Functor f) => fmap :: (a->b) -> f a -> f b in Haskell.
  if m.valid:
    result = Maybe[T](valid: true, value: p(m.value))
  else:
    result = Maybe[T](valid: false)

# -------------------------------------------------
# Monad Operations
# -------------------------------------------------

proc `>>=`*[T,U](m: Maybe[U], p: (U -> Maybe[T]) ) : Maybe[T] =
  ## Used for chaining monadic computations together.
  ##
  ## Analagous to bind(>>=) in Haskell.
  if m.valid:
      result = p(m.value)
  else:
      result = Maybe[T](valid: false)

proc pure*[T](val: T) : Maybe[T] =
  ## Used to wrap a value in a Maybe instance
  ##
  ## Analagous to pure/return() in Haskell
  Maybe[T](valid: true, value: val)

proc unsafeUnwrap*[T](m: Maybe[T]) : T =
  ## Used to extract a value from a Maybe instance
  ##
  ## Use unbox with caution, will cause a runtime exception
  ## if trying to unbox a Nothing value since we don't have
  ## proper pattern matching.
  return m.value
