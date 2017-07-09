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

*Why Not Just use Option[T]?*: After reading more thoroughly through the Option[T] implementation, I actually
think that they are mostly equivalent, so I would defer to it for most uses. When I wrote this library in 2014, 
back when the language was called Nimrod, it didn't have an Option type available. I will leave this
package up, and keep it maintained in case anyone uses it nonetheless. 

## Installation
Should be installed via [nimble](http://github.com/nimrod-code/nimble)

``` nimble install maybe ```

## License Info
> Copyright (c) Josh Filstrup 2014-2017
Licensed under BSD3 (see license.md for details)
