Not fully complete, but still a huge time saver. Tested on dozens of files that only needed minor touch ups after conversion.

# Installation

```
npm install -g html2halvalla
```

# Command Line Synopsys

```
html2halvalla test/simple.html
```

# Example Output (for above usage)

```
T.doctype TODO
T.html ->
  T.head ->
    T.title 'A simple test page'
    T.style type: 'text/css', '.foo {\n        color: red\n      }'
  T.body '.awesome', ->
    T.div '#root.super.special', ->
      T.comment 'This page is rapidly becoming not-so-simple'
      T.h1 'A simple test page'
      T.p ->
        T.text 'With some awesome text, and a'
        T.a href: 'http://www.google.com', 'link'
        T.text '.'
      T.p '#paragraph_2', ->
        T.text 'And here is an image:'
        T.img src: 'fake/source', title: 'not really'
        T.text 'As well as a disabled select:'
        T.select disabled: 'disabled', ->
          T.option 'Oh boy!'
      T.script type: 'text/javascript', 'console.log("Hello there");\n        console.log("How\'s it going?");'
      T.span()
```

# Full Command Line Usage

```
html2halvalla [options] <html-file>

--prefix=<string>    Prepends a string to each element function call default 'T.'
--selectors          Output css-selectors for id and classes (default)
--no-selectors       Disables output of css-selectors for id and classes
--s=slug             creates output directory for contents
--b=breakoutId       break tag with id to separate havalla source
--m=matchtext        exact match for text in html -- inserts 'id="b-value' in html tag
--selfTest           append code to render the halvalla template for test
```
--

See "Supported options" below for additional details.

# internal API

`convert(html, stream, [options], [callback])`

`html` must be a string.

`stream` is a "Writable Stream".

`options` is an optional hash. See next section for details.

`callback` is optional and passed `(error)` if something goes wrong.

### Supported options:

* `prefix` prepends a string to the begining of each element functional call. (default: `'T.'`)

> For example, using the prefix `@` would result in `@body ->`.

*  `selectors` is a boolean to toggle emitting classes and ids as a first argument to element functions as a selector string (default: `true`).

> For example, when true you get `div '#id.cls1.cls2`. When false you get `div id: "id", class: "cls1 cls2"`

*  `b` is a string. The HTML tag with that id is directed to a new halvalla source class and file in the slug directory
> example '--b=bloviation' will direct a `<tag ID='bloviation' ...`
to a new file in the slug directory wrapped in a class statement

*  `m` is a string that matches the original html text and inserts an ID into a tag that can only be described by it's actual text of classnames.

# Example REPL Session
*  `bin/html2halvalla --b=header --m='<header' --b=footer --m='<footer' --b=bloviation --m='div class="large-8 columns"' --s=blov  test/bs.html`
*  will match the '<header' text in the html and replace it with `<header id="#{option b.value}" <header id=header
*  this will decode an html file into four separate files named html.coffee, header.coffee, footer.coffee and bloviation.coffee
*  If the id for 'bloviation' already exists in the html file, the '-m' option is not needed.

