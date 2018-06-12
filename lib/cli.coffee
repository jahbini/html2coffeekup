#!/usr/bin/env coffee

path = require 'path'
fs = require 'fs'
{convert} = require './convert'


exports.main = ->
  [interpreter, script, args...] = process.argv

  usage = ->
    console.log """
      Usage:
        #{path.basename(script)} [options] <html-file>

        --prefix=<string>   Prepends a string to each element function call
        --no-prefix         Disables prefix (default)
        --export[=<name>]   Wraps the output in a Node.js style export
        --no-export         Disables wrapping the output in an export (default)
        --extends=<name>    sets base class or extends base class
        --b=name            breakout subsection as new class, may be repeated
        --m=string          matches exact text in source tag to add --b ID to tag
        --e='tagname.*\.class.*.next-class'    regular expression that generates multiple labels
        --s=slug            name the output directory
        --selfTest          append code to render the halvalla template for test
    """
    process.exit 1

  prefix = 'T.'
  export_ = null
  sourceFile = null
  matchers = []
  expanders = []
  baseClass = ""
  doThese = ['html']
  slug = 'subdirectory'
  selfTest = false

  for arg in args
    match = arg.match(/^--([a-z-]+)(=(.+))?$/i)
    if match
      key = match[1]
      value = match[3]
      rejectValue = ->
        if value
          console.log "Unexpected value for boolean flag #{key}"
          process.exit 1
      requireValue = ->
        unless value
          console.log "Expected value for switch #{key}"
          process.exit 1
      switch key
        when 'selfTest'
          selfTest = true
        when 's'
          requireValue()
          slug = value
        when 'b'
          requireValue()
          doThese.push value
        # search and replace in source html with #id from last 'b' break
        when 'm'
          requireValue()
          matchers.push search: value, repl: doThese[doThese.length-1]
        when 'e'
          requireValue()
          expanders.push search: value, repl: doThese[doThese.length-1], count:0
        when 'prefix'
          requireValue()
          prefix = value
        when 'extends'
          baseClass = value
        when 'slug'
          requireValue()
          directoryName = value
        when 'export'
          export_ = value ? true
        when 'no-export'
          rejectValue()
          export_ = false
        else
          console.log "Unknown switch #{key}"
          process.exit 1
    else if sourceFile
      usage()
    else
      sourceFile = arg

  unless sourceFile?
    usage()

  html = fs.readFileSync sourceFile, 'utf8'
  for replacer in matchers
    html = html.replace replacer.search, "#{replacer.search} id=#{replacer.repl}" 
  options = {prefix, expanders,  export: export_, doThese, baseClass, slug: slug }
  if options.slug
    try
      fs.mkdirSync options.slug
    catch badDog
      #console.error "BADDOG",badDog
  outputStream = null
  options.baseClass = ""
  for itemIn in doThese
    for e in options.expanders
      e.count = 0
    options.doMe = itemIn
    options.export = "C_#{itemIn}"
    outputStream.end() if outputStream != null
    outputStream = fs.createWriteStream "./#{options.slug}/#{itemIn}.coffee"
    convert html, outputStream, options, (err) ->
      console.error err if err
    options.baseClass = options.export
  outputStream.write "allMeta = #{JSON.stringify options.allMeta}\n"
  outputStream.write "htmlTitle = #{options.htmlTitle}\n"
  if selfTest
    outputStream.write "page = new module.exports\n"
    outputStream.write "console.log T.render page.html"
  outputStream.end()
  
