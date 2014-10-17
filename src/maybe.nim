import Monad

type
    Maybe*[T] = object
        case valid*: bool
        of true:    value* : T
        of false:   nil

proc `?`*[T](m: Maybe[T]) : bool =
    return m.valid

proc `$`*[T](m: Maybe[T]) : string =
    if ?m:
        return "Just " & $m.value
    else:
        return "Nothing"

proc box*[T](val: T) : Maybe[T] =
    return Maybe[T](valid: true, value: val)

proc chain*[T,U](m: Maybe[U], p: proc(x:U): Maybe[T]) : Maybe[T] {. procvar .} =
    if ?m:
        return p(m.value)
    else:
        return Maybe[T](valid: false)

proc `>>=`*[T,U](m: Maybe[U], p: proc(x:U): Maybe[T]) : Maybe[T] =
    if ?m:
        return p(m.value)
    else:
        return Maybe[T](valid: false)

