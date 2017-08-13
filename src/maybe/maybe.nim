# Copyright (c) 2014-2017, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#
# An implementation of an exeptionless maybe type.

import future
import macros

type
  ## Maybe provides a type which encapsulates the concept
  ## of null-ness in a safe way. This allows one to perform function
  ## calls over the underlying object, without forgetting to check if
  ## it is in a valid state.
  Maybe*[T] = object
      case valid*: bool
      of true:    value : T
      of false:   nil

proc `==`*[T](m1: Maybe[T], m2: Maybe[T]) : bool =
  ## Equality for maybe objects
  if (m1.valid == false and m2.valid == false):
    return true
  elif (m1.valid == true and m2.valid == true):
    return m1.value == m2.value
  else:
    return false

proc nothing*[T]() : Maybe[T] =
  ## Construct a maybe instance in the invalid state.
  Maybe[T](valid: false)

proc just*[T](val: T) : Maybe[T] =
  ## Construct a maybe instance in the valid state.
  Maybe[T](valid: true, value: val)

macro maybeCase*[T](m : Maybe[T], body : untyped) : untyped =
  ## A macro which provides a safe access pattern to
  ## the maybe type. This avoids the need to have a get function
  ## which throws an exception when its used improperly.
  ##
  ## This makes the following conversion
  ##
  ## maybeCase m:
  ##    just x:
  ##      expr1 using x
  ##    nothing:
  ##      expr2 that does not use x(trying to refer
  ##      to x will not compile)
  ##
  ## converts to --->
  ##
  ## if m.isValid:
  ##  var x = m.value
  ##  eval expr using x
  ## else:
  ##  eval expr2
  ##
  assert body.len == 2
  var justHead = body[0][0]
  var nothingHead = body[1][0]

  assert justHead.ident == !"just",
    "\n\nFirst case must be of the form \njust ident: \n  body"
  assert nothingHead.ident == !"nothing",
    "\n\nSecond case must be of the form \nnothing: \n  body"

  var unboxedIdent = body[0][1]
  
  result = newNimNode(nnkStmtList) 

  var validExpr = newDotExpr(m, ident("valid"))
  var valueExpr = newDotExpr(m, ident("value"))

  var justClause = newNimNode(nnkStmtList)
  justClause.add(newNimNode(nnkVarSection).add(
    newIdentDefs(unboxedIdent, newEmptyNode(), valueExpr)))
  for i in 2..body[0].len-1:
    justClause.add(body[0][i])

  var nothingClause = newNimNode(nnkStmtList)
  for i in 1..body[1].len-1:
    nothingClause.add(body[1][i])
  
  var ifExpr = newNimNode(nnkIfExpr)
  ifExpr.add(newNimNode(nnkElifExpr).add(validExpr, justClause))
  ifExpr.add(newNimNode(nnkElseExpr).add(nothingClause))

  result = ifExpr

proc `$`*[T](m: Maybe[T]) : string =
  ## Convert a maybe instance to a string.
  if m.valid:
    result = "Just " & $m.value
  else:
    result = "Nothing"

proc fmap*[T,U](m: Maybe[U], p: (U -> T) ) : Maybe[T] {. procvar .} =
  ## Used to map a function over a boxed value.
  ##
  ## Equivalent to (Functor f) => fmap :: (a->b) -> f a -> f b in Haskell.
  if m.valid:
    result = Maybe[T](valid: true, value: p(m.value))
  else:
    result = Maybe[T](valid: false)

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
