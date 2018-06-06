# extract html generating teacup signatures for web site bamboosnow.com
#
_ = require 'underscore'
htmlparser = require 'htmlparser'

stringLiteral = (html) ->
  hasNewline = !!html.match '\n'
  hasSingleQuotes = !!html.match "'"
  hasDoubleQuotes = !!html.match '"'
  
  if hasNewline || hasDoubleQuotes || hasSingleQuotes
    '"""\n' + html.trim() + '\n"""'
  else
    '"' + html.trim() + '"'
    
# for strings in comments that have executable code with unescaped quotes
stringLiteral2 = (html) ->
  if !!html.match '\n'
    '"""\n' + "'"+html.trim()+"'" + '\n"""'
  else
    "'" + html.trim() + "'"

exports.convert = (html, stream, options, callback) ->
  emitting = true
  isEmitting = ->
    emitting
    
  printBaby = {}

  if typeof options == 'function'
    [options, callback] = [{}, options]
  if not callback
    callback = (->)

  allMeta = []
  htmlTitle = '""'
  sectionName = ""
  sections = {}
  toDo = []
  prefix = options.prefix ? 'T.'
  selectors = options.selectors ? true
  export_ = options.export ? 'theStory'
  baseClass = options.baseClass 

  depth = 0

  emit = (code) ->
    stream.write Array(depth + 1).join('  ') + code + '\n' if isEmitting() 

  nest = (fn) ->
    depth++ if isEmitting()
    result = fn()
    depth-- if isEmitting()
    result

  visit =

    node: (node) ->
      visit[node.type](node)

    namedArray: (id,array) ->
      emit id + ': =>'
      if array.type
        nest -> visit.tag array
      else
        nest -> visit.array array

    array: (array) ->
      if !array
        emit 'return'
        return
      for node in array
        visit.node node

    tag: (tag,debug = false) ->
      code = prefix + tag.name
      called = false

      # Force attribute ordering of `id`, `class`, then others.
      attribs = []
      
      if tag.attribs?
        tAttribs = {}
        for key,value of tag.attribs
          tAttribs[key] = value
        extractAttrib = (key) ->
          value = tAttribs[key]
          if value
            attribs.push [key, value] unless selectors
            delete tAttribs[key]
          value
        id = extractAttrib 'id'
        cls = extractAttrib 'class'
        if selectors and (id or cls)
          selector = ''
          selector += "##{id}" if id
          if cls
            # remove duplicate class names
            cls=_(cls.split(' ')).uniq().join ' '
            selector += ".#{cls.replace(/ /g, '.')}"
          code += " \"#{selector}\""
          called = true
        for key, value of tAttribs
          attribs.push [key, value]

      # collect meta attributes
      allMeta.push attribs if tag.name == 'meta'

      # Render attributes
      attribs = for [key, value] in attribs
        key = '"'+ key + '"' if key.match '-'
        " #{key}: #{stringLiteral value}"

      code += ',' if selector && attribs.length > 0 
      code += attribs.join(',')
      called ||= attribs.length > 0
      
      # Render content
      endTag = (suffix) =>
        if suffix
          code += ',' if called
          code += suffix
        emit code
      if id
        id = id.replace /-/g,'_'
        if id != sectionName
          emit "@#{id}()"
          sections[id] = tag
          toDo.push id
          #console.log "PUSHING",id, "Emitting = ",isEmitting()
          #pass the print enable on, unless this section is specifically optioned
          # in that case, we are already printing it, or we should not during this pass
          printBaby[id] = isEmitting() unless id in options.doThese
          return

      if (children = tag.children)?
        if children.length == 1 and children[0].type == 'text'
          child = children[0].data
          if tag.name == 'script'
            endTag " #{stringLiteral child.replace /"/g,'\\"'}"
          else
            endTag " => T.raw #{stringLiteral child}"
            htmlTitle = stringLiteral child if tag.name == 'title'
        else
          endTag ' =>'
          nest -> visit.array children
      else if called
        endTag()
      else
        endTag('()')

    text: (text) ->
      return if text.data.match /^\s*$/
      emit "#{prefix}raw #{stringLiteral text.data}"

    directive: (directive) ->
      if directive.name.toLowerCase() == '!doctype'
        emit "#{prefix}doctype '#{(directive.data.split ' ')[1]}'" #TODO: Extract doctype
      else
        console.error "Unknown directive: #{directive.name}"

    comment: (comment) ->
      emit "#{prefix}comment #{stringLiteral2 comment.data}"

    script: (script) ->
      visit.tag script #TODO: Something better

    style: (style) ->
      visit.tag style #TODO: Something better

  handler = new htmlparser.DefaultHandler (err, dom) =>
    return callback err if err
    sections['html'] = dom
    toDo.push 'html'
    emit "# "
    if !baseClass
      emit "T = require 'halvalla'"
      emit "module.exports = class #{export_}"
      emit "  #pass the db entry into the class so that the classes have access to it"
      emit "  constructor: (@db,@allDB)->"
      emit "    return"
      emit ""
    else
      # assume the concatenation of coffee-script input so baseClass is defined
      emit "renderer = class #{export_} extends #{baseClass}"
    for noPrint in options.doThese
      printBaby[noPrint] = false
    printBaby[options.doMe]=true
    depth = 1
    try
      while sectionName = toDo.pop()
        emitting=true
        emit "# "
        emit "# section #{sectionName}"
        emit "# "
        emitting = printBaby[sectionName]  # turn code emission on
        #console.log "SECTION",sectionName, printBaby
        visit.namedArray sectionName, sections[sectionName]
          
      #wrap up
      emitting = true
      #emit "allMeta = #{JSON.stringify allMeta}"
      #emit "htmlTitle = #{htmlTitle}"
      options.allMeta = allMeta
      options.htmlTitle = htmlTitle
      depth = 0
    catch exception
      err = exception
    callback err
    return

  try
    parser = new htmlparser.Parser(handler)
    parser.parseComplete(html)
  catch exception
    callback exception
