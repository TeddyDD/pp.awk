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

On the other hand you can't reference any variables in verbatim text. HTML
[example](https://www.mkws.sh/pp.html) from pp's site won't work in pp.awk.

Instead you have to write:

```
<!doctype html>
<title>pp.awk example</title>
<ul>
#!
i=1
while test $i -le 10
do
	if test $((i % 2)) -eq 0
	then
		echo "	<li class=even>$i</li>"
	else
		echo "	<li class=odd>$i</li>"
	fi
	i=$((i + 1))
done
#!
</ul>
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
