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

*Why Not Just use Option[T]?*: For a moment, I thought this library had
been made obsolete when option was added to Nim, but I just had an idea
for a very useful improvement. I plan to add a macro which will make it
impossible to misuse Maybe[T], giving it a key advantage over Option, which
can throw exceptions if improperly used.

## Installation
Should be installed via [nimble](http://github.com/nimrod-code/nimble)

``` nimble install maybe ```

## License Info
> Copyright (c) Josh Filstrup 2014-2017
Licensed under BSD3 (see license.md for details)
