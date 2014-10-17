# A basic implementation of some monads in Nimrod
# I plan on expanding this out over the next couple
# of weeks
# Supports return
#        var boxed       : T = box(val)
# Supports Bind/Chain
#        var chainedProc : T = chain(m,fn)
#  var chainedComp : T = chain(T, proc(int) : T)
type
    Monad[U]* = generic m
        var boxed : m = box(U)
