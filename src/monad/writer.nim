# Copyright (c) 2014, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#
# An implementation of the Writer monad for Nim
# This implements the traditional operations, bind(called chain)
# and return(called box) as well as a few useful operators for 
# cleaning up usage of the monad.

type
    Writer*[T] = object
        value*: T
        log*  : string

# -------------------------------------------------
# ------- Operators -------------------------------
# -------------------------------------------------

# Returns the log as a string
proc `$`*[T](w: Writer[T]) : string =
    "Value: " & $w.value & "\n" & "Log: " & w.log & "\n"

# Chains monadic operations together, maintaining a log
# throughout the operations.
proc `>>=`*[T,U](w: Writer[U], p: proc(x:U): Writer[T]) : Writer[T] =
    let output = p(w.value)
    result = Writer[T](value: output.value, log: w.log & "\n" & output.log)

# -------------------------------------------------
# ------- Monadic Operations ----------------------
# -------------------------------------------------

# Wrap a plain value into a Writer for logging.
proc box*[T](val: T) : Writer[T] =
    Writer[T](value: T, log: "")

# Equivalent to (>>=) operation defined above.
proc chain*[T,U](w: Writer[U], p: proc(x:U): Writer[T]) : Writer[T] {. procvar .} =
    w >>= p

# Maps a plain funciton over a Writer's internal value.
proc map*[T,U](w: Writer[U], p: proc(x:U) : T) : Writer[T] {. procvar .} =
    let output = p(w.value)
    Writer[T](value: output.value, log: w.log)
