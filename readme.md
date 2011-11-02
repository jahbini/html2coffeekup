Not fully complete, but still a huge time saver. Tested on dozens of files that only needed minor touch ups after conversion.

# Installation

```
npm install -g html2coffeekup
```

# Command Line Usage

```
html2coffeekup test/simple.html
```

# Example Output (for above usage)

```
doctype TODO
html ->
  head ->
    title 'A simple test page'
    style type: 'text/css', '.foo {\n        color: red\n      }'
  body '.awesome', ->
    div '#root.super.special', ->
      comment 'This page is rapidly becoming not-so-simple'
      h1 'A simple test page'
      p ->
        text 'With some awesome text, and a'
        a href: 'http://www.google.com', 'link'
        text '.'
      p '#paragraph_2', ->
        text 'And here is an image:'
        img src: 'fake/source', title: 'not really'
        text 'As well as a disabled select:'
        select disabled: 'disabled', ->
          option 'Oh boy!'
      script type: 'text/javascript', 'console.log("Hello there");\n        console.log("How\'s it going?");'
      span()
```

# Public API

`convert(html, stream, [options], [callback])`

`html` must be a string.

`stream` is a "Writable Stream".

`options` is an optional hash.

> Supported options:
> 
>  `prefix` prepends a string to the begining of each element functional call. (default: `''`)
>
>  For example, using the prefix `@` would result in `@body ->`.
> 
>  `selectors` is a boolean to toggle emitting classes and ids as a first argument to element functions as a selector string (default: true).
>
>  For example, when true you get `div '#id.cls1.cls2`. When false you get `div id: "id", class: "cls1 cls2"`

`callback` is optional and passed `(error)` if something goes wrong.

# Example REPL Session

```
coffee> {convert} = require('html2coffeekup')
{ convert: [Function] }
coffee> convert '<a href="http://www.github.com">Github</a>', process.stdout, -> console.log 'done!'
a href: 'http://www.github.com', 'Github'
done!
```
