maybe 
--
[![Build Status](https://travis-ci.org/superfunc/maybe.svg?branch=master)](https://travis-ci.org/superfunc/maybe) || **[Docs](doc/maybe.html)**.

An implementation of a maybe type, also known as option(al) in other languages. 

**Why Not Just use Option[T] from the standard library?**: In short, this library doesn't throw
exceptions. It achieves this by using a macro to provide a safe pattern 
in which a valid can't be invalidly accessed, see `maybeCase` in the
docs for further details. For a small example:

```nim
var m = maybe.pure(4)
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
    
## This prints out:
## >> 7
## >> nope no value, nice try with your invalid access
```

Note that, in the second case, trying to access our local binding
`foo` outside of the `just` block will result in a compile time error.
This is how we achieve safe access.

## Installation
Should be installed via [nimble](http://github.com/nimrod-code/nimble)

``` nimble install maybe ```

## License Info
> Copyright (c) Josh Filstrup 2014-2017
Licensed under BSD3 (see license.md for details)
