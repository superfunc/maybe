maybe 
--
[![Build Status](https://travis-ci.org/superfunc/maybe.svg?branch=master)](https://travis-ci.org/superfunc/maybe)

An implementation of the maybe type, also 
known as option or optional in other languages. 

The benefit provided by such a type is the ability to
encapsulate otherwise tedious chain of if/else checks,
for a concrete example of this, see the following 
[sample code](src/examples/example.nim).

Module documentation is available [here](doc/maybe.html).

*Why Not Just use Option[T]?*: The standard option in Nim throws exceptions when invalid access is detected. This library
prevents much of that through 
[variant types](https://nim-lang.org/docs/tut2.html#object-oriented-programming-object-variants). 
I find this to be a stronger and simpler solution. 

## Installation
Should be installed via [nimble](http://github.com/nimrod-code/nimble)

``` nimble install maybe ```

## License Info
> Copyright (c) Josh Filstrup 2014-2017
Licensed under BSD3 (see license.md for details)
