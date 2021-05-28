pp.awk(1)

# NAME

pp.awk - shell based preprocessor

# SYNOPSIS

*pp.awk* < _input_

*pp.awk* < _input_ | sh -s - arg1 arg2

# DESCRIPTION

The pp.awk utility reads a template from the standard input and writes
*sh*(1) script to the standard output. Executing the script will produce
final document.

# SYNTAX

Text between _#!_ will be treated as shell code. Everything else will be
printed verbatim.

```
Hell world.
#!
echo today is $(date)
echo args $1 $2
#!
bye!
```

# SEE ALSO

*sh*(1)

# AUTHORS

Maintained by Daniel Lewan <vision360.daniel@gmail.com>. Up-to-date sources can be found at
https://github.com/teddydd/pp.awk.
