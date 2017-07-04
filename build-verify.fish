# Copyright (c) 2017, Josh Filstrup
# Licensed under BSD3(see license.md file for details)
#
# A script used by travis to verify a build, including:
# - Build the code
# - Run examples
# - Run tests
# - Generate docs(and diff them against the installed copy)

function runcmd
    if eval $argv >> $ROOT/build_log.txt 2>&1
        echo '✓ ' $argv 
    else
        echo '✗ ' $argv
        exit 1 
    end
end

set NIMCC $argv
set ROOT (pwd)

runcmd "which $NIMCC"
echo '-------------------------------------'
echo 'Nim compiler found!'
echo '-------------------------------------'

runcmd "cd src/maybe/"
runcmd "$NIMCC c maybe.nim"
runcmd "cd ../examples/"
runcmd "$NIMCC c example.nim"
runcmd "cd ../tests/"
runcmd "$NIMCC c basic.nim"
echo '-------------------------------------'
echo 'Compilation ran successfully!'
echo '-------------------------------------'

runcmd "cd ../examples"
runcmd "./example"
echo '-------------------------------------'
echo 'Examples ran successfully!'
echo '-------------------------------------'

runcmd "cd ../tests/"
runcmd "./basic"
echo '-------------------------------------'
echo 'Tests ran successfully!'
echo '-------------------------------------'

runcmd "cd ../maybe/"
# Clear out the timestamp lines
runcmd "$NIMCC doc maybe.nim"
runcmd "sed \"/Generated:/d\" maybe.html >> maybe_.html"
runcmd "diff maybe_.html ../../doc/maybe.html"
echo '-------------------------------------'
echo 'Docgen ran successfully!'
echo '-------------------------------------'

# Cleanup, mostly useful for local runs
runcmd "cd ../../"
runcmd "rm ./src/tests/basic"
runcmd "rm ./src/examples/example"
runcmd "rm ./src/maybe/maybe"
runcmd "rm ./src/maybe/maybe.html"
runcmd "rm ./src/maybe/maybe_.html"
echo '-------------------------------------'
echo 'Cleanup ran successfully!'
echo '-------------------------------------'


