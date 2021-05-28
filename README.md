# pp.awk - yet another shell based preprocessor

A simple preprocessor inspired by [adi's](https://adi.tilde.institute/) `pp(1)`.

The basic idea is to use `sh(1)` for templating.  `pp.awk` reads template from
stdin and outputs sh script that can be executed to generate final document.

Everything between `^#!\n` tokens is treated as shell script and will be executed.
Rest of text will be displayed verbatim.

## Usage

### Basic

foo.pp:

```
hello world
#!
date
#!
```

```sh
pp.awk ./foo.pp
echo 'hello world'
date

pp.awk ./foo.pp | sh
hello world
Fri 28 May 2021 01:44:27 PM CEST
```

### Escaping charaters

In contrary to adi's pp you don't have to escape any characters in verbatim text:

```sh
cat hello.pp
Hello
world
' '' " ""
\' \'\' \" \"\"

pp.awk hello.pp
echo 'Hello
world
'"'"' '"'"''"'"' " ""
\'"'"' \'"'"'\'"'"' \" \"\"'
```

### Parameters

You can pass parameters to template as follows

```
cat hello.pp
#!
echo $1 $2
#!
pp.awk ./hello.pp | sh -s - foo bar
foo bar
```
