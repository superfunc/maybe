# Copyright (c) 2017, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#
# A script used by travis to verify a build, including:
# - Build the code
# - Run examples
# - Run tests
# - Generate docs(and diff them against the installed copy)
import os
import system

var 
  NIMCC = paramStr(1) 
  ROOTDIR = getCurrentDir() 

proc runCmd(rawCmd: string, redirOutput: bool = true) =
  var cmd = rawCmd

  if redirOutput:
    cmd = cmd & " >> " & ROOTDIR & "/build_log.txt 2>&1"

  if execShellCmd(cmd) == 0:
    echo("✓ " & cmd)
  else:
    echo("✗ " & cmd)
    quit(QuitFailure)

proc banner(msg : string) =
  echo("-------------------------------------")
  echo(msg)
  echo("-------------------------------------")

proc runNimCC(fname : string) =
  runCmd(NIMCC & " c " & fname)

runCmd("which " & NIMCC)
banner("Nim compiler found!")

setCurrentDir("src/maybe")
echo(getCurrentDir())
runNimCC("maybe.nim")
setCurrentDir("../examples/")
runNimCC("example.nim")
setCurrentDir("../tests/")
runNimCC("basic.nim")
banner("Compilation ran successfully!")

setCurrentDir("../examples")
runCmd("./example")
banner("Examples ran successfully!")

setCurrentDir("../tests/")
runCmd("./basic")
banner("Tests ran successfully!")

setCurrentDir("../maybe/")
# Clear out the timestamp lines
runCmd(NIMCC & " doc maybe.nim")
runCmd("sed \"/Generated:/d\" maybe.html > maybe_.html", false)
runCmd("diff maybe_.html ../../docs/index.html")
banner("Docgen ran successfully!")

# Cleanup, mostly useful for local runs
setCurrentDir("../../")
runCmd("rm ./src/tests/basic")
runCmd("rm ./src/examples/example")
runCmd("rm ./src/maybe/maybe")
runCmd("rm ./src/maybe/maybe.html")
runCmd("rm ./src/maybe/maybe_.html")
banner("Cleanup ran successfully!")

