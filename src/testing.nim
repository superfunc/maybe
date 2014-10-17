import maybe
import monad

proc adder(x: int) : Maybe[int] =
    return Maybe[int](valid: true, value: x+x)


proc print(m: Monad) =
    nil

var m1 = Maybe[int](valid: true, value: 5)
var m2 = Maybe[int](valid: false)

var r = m1 >>= adder >>= adder >>= adder
echo($r)

var d : Dummy[int] = box(5)
print(d)
