# extract html generating teacup signatures for web site bamboosnow.com
#
_ = require 'underscore'
htmlparser = require 'htmlparser2'
halvalla = require 'halvalla'
htmlTags = require 'halvalla/lib/html-tags.js'
allTags = htmlTags.allTags

safeId = (id)->
 id.replace /-/g,'_' # ID's in html have - we convert to js legal _

stringLiteral = (html) ->
  hasNewline = !!html.match '\n'
  hasSingleQuotes = !!html.match "'"
  hasDoubleQuotes = !!html.match '"'
  trimmed=html.trim()
  html.replace /'/g,"\'" if hasSingleQuotes
  trimmed = ' ' if !trimmed
  
  if hasNewline || hasDoubleQuotes
    '"""\n' + trimmed + '\n"""'
  else
    '"' + trimmed + '"'
    
# for strings in comments that have executable code with unescaped quotes
stringLiteral2 = (html) ->
  hasSingleQuotes = !!html.match "'"
  trimmed=html.trim()
  html.replace /'/g,"\'" if hasSingleQuotes
  if !!html.match '\n'
    '"""\n' + "'"+html.trim()+"'" + '\n"""'
  else
    "'" + html.trim() + "'"

exports.convert = (html, stream, options, callback) ->
  emitting = true
  isEmitting = ->
    emitting
  #
  # printBaby is a hash of the IDs that are to be printed or skipped during this pass
  # 
  printBaby = {}
  #printNot is the expanded form of printThese
  printNot = []

  # internal curry to set parameters in standard order:
  #  (html,stream,callback) becomes (html,stream,{},callback)
  #  (html,stream,options) becomes (html,stream,options, ()-> return)
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
  export_ = safeId options.export || 'theStory'
  baseClass = options.baseClass 
  depth = 0

  emit = (code) ->
    stream.write Array(depth + 1).join('  ') + code + '\n' if isEmitting() 

  nest = (fn) ->
    depth++ if isEmitting()
    result = fn()
    depth-- if isEmitting()
    result

  # visit defines the tree walk and will start emitting when the node
  visit =
    # vector on node type
    node: (node) ->
      visit[node.type](node)

    # named with children is one with an ID tag name (real or virtual)
    # and emits a function definition with named ID
    namedWithChildren: (id,children) ->
      idSafe = id.replace /-/g,'_' # ID's in html have - we convert to js legal _
      emit idSafe + ': =>'  
      if children.type
        nest -> visit.tag children
      else
        nest -> visit.babies children

    babies: (children) ->
      if !children
        emit 'return'
        return
      for node in children
        visit.node node

    tag: (tag,debug = false) ->
      #accumulate emitted string in code variable
      # compute the signature, attributes, and children for
      # emitting and tree walk
      lineUp = []
      # the 'use' tag is a valid svg tag so don't use the intenal Teacup semantics
      # just ask for the explicit tag
      if tag.name != 'use' && allTags[tag.name]
        code = prefix + tag.name
      else
        code = prefix + "tag "
        lineUp.push "\"#{tag.name}\"" 
      signature = tag.name

      # Force attribute ordering of `id`, `class`, then others.
      attribs = []
      
      selector = ''
      if tag.attribs?
        tAttribs = {}
        for key,value of tag.attribs
          tAttribs[key] = value
        extractAttrib = (key) ->
          value = tAttribs[key]
          if value
            delete tAttribs[key]
          value
          
        id = extractAttrib 'id'
        cls = extractAttrib 'class'
        cl2 = extractAttrib 'className'
        if cls && cl2
          cls = [cls...,'jimbo', cl2...]
        if !cls && cl2
          cls = cl2
        if id or cls or selector
          selector += "##{id}" if id
          if cls
            # remove duplicate class names
            cls=_.chain(cls.split(' ')).sortBy().uniq().value().join ' '
            selector += ".#{cls.replace(/ /g, '.')}"
            signature += ".#{cls.replace(/ /g, '.')}"

          lineUp.push " \"#{selector}\""
        for key, value of tAttribs
          attribs.push [key, value]

      # collect meta attributes
      allMeta.push attribs if tag.name == 'meta'

      # Render attributes
      for [key, value] in attribs
        key = '"'+ key + '"' if key.match '-'
        lineUp.push " #{key}: #{stringLiteral value}"

      
      unless id 
        for e in options.expanders
          if signature.match e.search
            #console.log "new E",e, options.expanders,tag
            tag.attribs.id= id = e.repl+'_'+e.count
            printBaby[id] = options.doMe == e.repl
            options.doThese.push id
            e.count++
            break
          
      # Render content
      endTag = (suffix) =>
        lineUp.push suffix if suffix
        lineUp.push '()' if lineUp.length == 0
        emit code + lineUp.join ','
        return

      if id
        idSafe = id.replace /-/g,'_'
        if id != sectionName
          emit "@#{idSafe}()"
          sections[id] = tag
          toDo.push id
          #console.log "PUSHING",id, "Emitting = ",isEmitting()
          #pass the print enable on, unless this section is specifically optioned
          # in that case, we are already printing it, or we should not during this pass
          printBaby[id] = isEmitting() unless id in printNot
          return

      if (children = tag.children)?
        if children.length == 1 and children[0].type == 'text'
          child = children[0].data
          if tag.name == 'script'
            endTag " #{stringLiteral child.replace /"/g,'\\"'}"
          else
            endTag " => #{prefix}raw #{stringLiteral child}"
            htmlTitle = stringLiteral child if tag.name == 'title'
        else
          if children.length >0
            endTag ' =>'
            nest -> visit.babies children
          else
            endTag()
      else 
        endTag()

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
      for nope in noPrint.split ','
        #console.log "Not Printing",nope
        printBaby[nope] = false
        printNot.push nope
    # take all ID's in doMe and print them during this pass
    for printIt in options.doMe.split ','
      #console.log "Yes Printing",printIt
      printBaby[printIt]=true
    depth = 1
    #console.log "Printbaby",printBaby
    try
      while sectionName = toDo.pop()
        #console.log "Pass to print section",sectionName
        emitting=true
        emit "# "
        emit "# section #{sectionName}"
        emit "# "
        emitting = printBaby[sectionName]  # turn code emission on
        #console.log "SECTION",sectionName, printBaby[sectionName]
        visit.namedWithChildren sectionName, sections[sectionName]
          
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
