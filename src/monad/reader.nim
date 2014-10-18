# Copyright (c) 2014, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#
# An implementation of the Reader monad for Nim
# This implements the traditional operations, bind(called chain)
# and return(called box) as well as a few useful operators for 
# cleaning up usage of the monad.

type
    Reader*[T,U] = object
        exec: proc(T) : U

# -------------------------------------------------
# ------- Operators -------------------------------
# -------------------------------------------------
proc `>>=`*[T,U](r: Reader[T,U], p: proc(x:U): Maybe[T]) : Maybe[T] =
    
# -------------------------------------------------
# ------- Monadic Operations ----------------------
# -------------------------------------------------
proc box*[T,U](p: proc(T): U) : Reader[T,U] =
    Reader[T,U](exec: p)

# proc chain*[T,U,V](r: Reader[T,U], p: proc(x:): Maybe[T]) : Maybe[T] {. procvar .} =

# proc map*[T,U](m: Maybe[U], p: proc(x:U) : T) : Maybe[T] {. procvar .} =
