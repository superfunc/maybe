maybe 
--
[![Build Status](https://travis-ci.org/superfunc/maybe.svg?branch=master)](https://travis-ci.org/superfunc/maybe) || <a href="https://nimble.directory/pkg/maybe">
<img src="https://raw.githubusercontent.com/yglukhov/nimble-tag/master/nimble.png" width="80">
</a> || **[Docs](https://superfunc.github.io/maybe/)**

> Note 1: ~There is a [chance](https://github.com/nim-lang/Nim/pull/8358) 
> the main macro(maybeCase) may get merged into the standard library.
> If this happens I'll recommend people use that, but will accept bugfixes 
> and reports on this library going forward, just no new features.~

> Note 2: The PR was not accepted, so maybe lives on!

An implementation of a maybe type, also known as option(al) in other languages. 

**Why Not Just use Option[T] from the standard library?**: In short, this library doesn't throw
exceptions. It achieves this by using a macro to provide a safe pattern 
in which a maybe object can't be invalidly accessed, see `maybeCase` in the
docs for further details. For a small example:

```nim
var m = maybe.just(4)
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

Note that trying to access our local binding(`x` and `foo`)
outside of the `just` blocks will result in a compile time error.
This is how we achieve safe access.

## Installation
Should be installed via [nimble](http://github.com/nimrod-code/nimble)

``` nimble install maybe ```

## License Info
> Copyright (c) Josh Filstrup 2014-2018
Licensed under BSD3 (see license.md for details)
