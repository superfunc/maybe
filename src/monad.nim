# A basic implementation of some monads in Nimrod
# I plan on expanding this out over the next couple
# of weeks
# Supports return
#        var boxed       : T = box(val)
# Supports Bind/Chain
#        var chainedProc : T = chain(m,fn)
#  var chainedComp : T = chain(T, proc(int) : T)
#
#  TODO: State, IO and List Monad
#  need to figure out why this won't typecheck
#  Crazy TODO: try to implement do notation as a macro
#
type
    Monad[U]* = generic m
        var boxed : m = box[U](U)

type 
    Dummy*[T] = object
        val*: T

proc box*[T](something: T) : Dummy[T] =
    Dummy[T](val: something)
