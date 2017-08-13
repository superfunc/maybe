maybe 
--
[![Build Status](https://travis-ci.org/superfunc/maybe.svg?branch=master)](https://travis-ci.org/superfunc/maybe)
[Docs](doc/maybe.html).

- An implementation of the maybe type, also 
known as option or optional in other languages. 

- The benefit provided by such a type is the ability to
encapsulate otherwise tedious chain of if/else checks,
for a concrete example of this, see the following 
[sample code](src/examples/example.nim).

- **Why Not Just use Option[T]?**: In short, this library doesn't throw
exceptions. It achieves this by using a macro to provide a safe  
pattern in which a valid can't be invalidly accessed, see `maybeCase` in the
docs for further details.

## Installation
Should be installed via [nimble](http://github.com/nimrod-code/nimble)

``` nimble install maybe ```

## License Info
> Copyright (c) Josh Filstrup 2014-2017
Licensed under BSD3 (see license.md for details)
