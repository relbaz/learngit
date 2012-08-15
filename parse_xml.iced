
fs = require "fs"
sax = require 'sax'

last = (array) -> array[array.length-1]

walkElements = (e, pfx) ->
  s = ""
  if e.allText.length > 0
    s = " : " + e.allText
  console.log "#{pfx}#{e.name} >> has #{e.children.length} children, #{e.childtags.length} tags, and #{e.allText.length} texts#{s}"
  for c in e.children
    walkElements c, pfx + e.name + " >> "

wantednodes =
  page: (p) ->
#    walkElements p, ""
    txt = p.childtags["revision"][0].childtags["text"][0].allText.join " "
    console.log "\n**closed '#{p.name}' " + p.childtags["title"]?[0]?.allText + " (text length: #{txt.length} : [#{txt}])"
#    console.log "    revision text = " + p.childtags["revision"][0].childtags["text"][0].allText
#    console.log "    title text = " + p.childtags["title"][0].allText

createParser = (cbError, cbFinished, wantedNodes, strict) ->
  element = null
  interestingStack = []
  parser = sax.parser strict

  parser.onerror = cbError
  parser.onend = cbFinished

  parser.onopentag = ({name, attributes}) ->
    if wantedNodes[name]? or element?
      parent = element
      element = {parent, name, attributes, allText : [], children: [], childtags: []}
      if parent?
        parent.children.push element
        if not parent.childtags[name]?
          parent.childtags[name] = new Array
        console.log "Parent #{parent.name} of element #{element.name} now adding childtags[#{name}]"
        parent.childtags[name].push element
    if wantedNodes[name]?
      console.log "opened #{name}"
      interestingStack.push name

  parser.onclosetag = (name) ->
    if name is last interestingStack
      interestingStack.pop()
      wantedNodes[name] element
    element = element?.parent

  parser.ontext = (text) ->
    if element?.parent? and text.trim()
      console.log "pushing text for #{element.name} : [#{text}]"
      element.allText.push text

  parser

parser = createParser ferror, fend, wantednodes, true

ferror = (v) =>
  console.log "== error #{v}"

fend = (v) =>
  console.log "== finished #{v}"

await fs.readFile process.argv[2], defer err, data
if err
  console.error "Could not open file: %s", err
else
  parser.write data.toString()







