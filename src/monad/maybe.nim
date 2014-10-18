# Copyright (c) 2014, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#
# An implementation of the Maybe monad for Nim
# This implements the traditional operations, bind(called chain)
# and return(called box) as well as a few useful operators for 
# cleaning up usage of the monad. Also implemented the functor
# operation fmap(called map) which allows a procedure to be called
# on a wrapped value

type
    Maybe*[T] = object
        case valid*: bool
        of true:    value* : T
        of false:   nil

# -------------------------------------------------
# ------- Operators -------------------------------
# -------------------------------------------------

# Shorthand operator for checking if a Maybe contains
# a valid value.
proc `?`*[T](m: Maybe[T]) : bool =
    m.valid

# Converts maybe value to a string.
proc `$`*[T](m: Maybe[T]) : string =
    if ?m:
        result = "Just " & $m.value
    else:
        result = "Nothing"

# Used for chaining monadic computations together.
#
# Analagous to bind(>>=) in Haskell.
proc `>>=`*[T,U](m: Maybe[U], p: proc(x:U): Maybe[T]) : Maybe[T] =
    if ?m:
        result = p(m.value)
    else:
        result = Maybe[T](valid: false)

# -------------------------------------------------
# ------- Monadic Operations ----------------------
# -------------------------------------------------

# Used to extract a value from a Maybe[T]
#
# Use unbox with caution, will cause a runtime exception
# if trying to unbox a Nothing value since we don't have
# proper pattern matching.
proc unbox*[T](m: Maybe[T]) =
    m.value

# Used to wrap a value in a Maybe
#
# Analagous to return() in Haskell
proc box*[T](val: T) : Maybe[T] =
    Maybe[T](valid: true, value: val)

# Used to chain monadic operations together.
#
# Analagous to bind(>>=) in Haskell
proc chain*[T,U](m: Maybe[U], p: proc(x:U): Maybe[T]) : Maybe[T] {. procvar .} =
    m >>= p

# Used to map a function over a boxed value.
#
# Equivalent to (Functor f) => fmap :: (a->b) -> f a -> f b in Haskell.
proc map*[T,U](m: Maybe[U], p: proc(x:U) : T) : Maybe[T] {. procvar .} =
    if ?m:
        result = Maybe[T](valid: true, value: p(m.value))
    else:
        result = Maybe[T](valid: false)
