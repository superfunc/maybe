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

  # Should probably consider not providing unsafeUnwrap.
  assert maybe.unsafeUnwrap(a) == 10
  assert maybe.unsafeUnwrap(b) == 8
  assert c.valid == false

testBasic()
