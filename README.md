# jq-jsonpointer

[![Build Status](https://travis-ci.org/nichtich/jq-jsonpointer.svg?branch=master)](https://travis-ci.org/nichtich/jq-jsonpointer)

> jq module implementing JSON Pointer (RFC 6901)

This git repository contains an implementation of JSON Pointer ([RFC 6901](https://tools.ietf.org/html/rfc6901)) as module for the [jq data transformation language](https://stedolan.github.io/jq/).

## Table of Contents

* [Install](#install)
* [Usage](#usage)
* [API](#api)
  * [pointer](#pointerjson_pointer)
  * [pointer_get](#pointer_gettokens)
  * [pointer_tokens](#pointer_tokens)
* [Contributing](#contributing)
* [License](#license)

## Install

Installation requires [jq](https://stedolan.github.io/jq/) version 1.5 or newer.

Put `jsonpointer.jq` to a place where jq can [find it as module](https://stedolan.github.io/jq/manual/#Modules).

One way to do so is to download the current version of the file:

~~~sh
mkdir -p ~/.jq && git clone https://github.com/nichtich/jq-jsonpointer.git ~/.jq/jsonpointer
~~~

Or check out this repository to directory `~/.jq/jsonpointer/`:

~~~sh
mkdir -p ~/.jq && wget -N https://github.com/nichtich/jsonpointer/raw/master/jsonpointer.jq
~~~

## Usage

See [jq manual](https://stedolan.github.io/jq/manual/#Modules) how to use jq modules in general and API description below how to use this module.

## API

### pointer(json_pointer)

Returns a filter compiled from a given JSON Pointer. For instance given a JSON file `input.json`:

~~~json
{"foo":[{"/":42}]}
~~~

The value `42` can be accessed with JSON Pointer syntax like this:

~~~sh
$ jq 'include "jsonpointer"; pointer("/foo/0/~1")' input.json
42
~~~

Character `-` to index the (nonexisting) member after the last array element is
not supported. If the JSON Pointer does not correspond to an existing element,
the filter returns `null` instead of throwing an error.

### pointer_get(tokens)

Same as [pointer](#pointerjson_pointer) but expects the JSON Pointer given as array of tokens:

~~~sh
$ jq 'include "jsonpointer"; pointer_get(["foo","0","/"]")' input.json
42
~~~

### pointer_tokens

Maps a JSON Pointer string to its tokens as array of strings.

~~~sh
$ jq -n 'include "jsonpointer"; "/foo/0/~1" | pointer_tokens'
[
  "foo",
  "0",
  "/"
]
~~~

## Contributing

The source code is hosted at <https://github.com/nichtich/jq-jsonpointer>.

Bug reports and feature requests [are welcome](https://github.com/nichtich/jq-jsonpointer/issues/new)!

## License

Made available under the MIT License by Jakob Voß.

