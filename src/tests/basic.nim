# Copyright (c) 2017, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#

import ../maybe/maybe

proc add5(x : int) : int =
  return x + 5

proc testBasic() =
  var 
    a = maybe.pure(5)
    b = maybe.pure(3)
    c = maybe.nothing[int]()
    
  a = maybe.fmap(a, add5) 
  b = maybe.fmap(b, add5)
  c = maybe.fmap(c, add5)

  maybeCase a:
    just aInner:
      assert aInner == 10, "Value in 'a' should be 10"
      assert a.valid, "'a' should only be valid in this clause"
    nothing:
      assert false, "This clause should be unreachable" 

  maybeCase b:
    just bInner:
      assert bInner == 8, "Value in 'b' should be 8" 
      assert b.valid, "'b' shoud only be valid in this clause"
    nothing:
      assert false, "This clause should be unreachable" 

  maybeCase c:
    just cInner:
      assert false, "This clause should be unreachable" 
    nothing:
      assert c.valid == false, "'c' should only be invalid in this clause"

type Temp = enum
  VHot, Hot, Med, Cold, VCold

proc testCustomTypes() =
  var 
    a = maybe.pure(VHot)
    b = maybe.pure(Cold)
    c = maybe.nothing[Temp]()
    d = maybe.pure(VHot)
  
  # Using maybes eq operator
  assert a != b, "The inner values should not be equal"
  assert a == d, "These inner values should be equal"
  assert c != b, "The inner values should not be equal"

testBasic()
testCustomTypes()
