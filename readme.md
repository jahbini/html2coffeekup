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
--s=slug             creates output directory for contents
--b=breakoutId       break tag with id to separate havalla source
--m=matchtext        exact match for text in html -- inserts 'id="b-value' in html tag
--e=extractList      extract repeated tags by tagname and classname RE -- inserts 'id=b-value_0123455'
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


*  `b` is a string for the breakoutId. "Break Out" this tag ID element and it's children as a separate file.  The HTML tag with that id is directed to a new halvalla source class and file in the slug directory
> example '--b=bloviation' will direct a `<tag ID='bloviation' ...`
to a new file in the slug directory wrapped in a class statement

*  `m` is a string that matches the original html text and inserts the breakoutId into a tag that can only be doescribed by it's actual text of classnames.
>  the output files `test/footer.coffee` and `test/header.coffee` are examples.

*  `e` is a RE of the form 'tagname.*\.class-to-find.*\.find-this-class-too' and inserts the matching
>  html elements into the Break Out file.  Matched classes will have unique tag names based on the breakoutId.
>  see the file `test/blov/dicey.coffee` for an example extracted from `test/bs.html`.
  
# Example REPL Session
*  `bin/html2halvalla --b=header --m='<header' --b=footer --m='<footer' --b=bloviation --m='div class="large-8 columns"' --s=blov  test/bs.html`
>  Matches the '<header' text in the html and replace it with `<header id="#{option b.value}" <header id=header
>
> And will decode an html file into four separate files named html.coffee, header.coffee, footer.coffee and bloviation.coffee
  (If the id for 'bloviation' already exists in the html file, the '-m' option is not needed.)

