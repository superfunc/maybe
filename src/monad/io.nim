# Copyright (c) 2014, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#
# An implementation of the IO monad for Nim
# This implements the traditional operations, bind(called chain)
# and return(called box) as well as a few useful operators for 
# cleaning up usage of the monad.

type
    IO*[T] = object
        effect: proc(): T

# -------------------------------------------------
# ------- Operators -------------------------------
# -------------------------------------------------
proc `>>=`*[T,U](i: IO[U], p: proc(x:U): IO[T]) : IO[T] =
    p(i.effect())

# -------------------------------------------------
# ------- Monadic Operations ----------------------
# -------------------------------------------------

# TODO box and unbox


# Used to chain monadic operations together.
#
# Analagous to bind(>>=) in Haskell
proc chain*[T,U](i: IO[U], p: proc(x:U): IO[T]) : IO[T] {. procvar .} =
    i >>= p
