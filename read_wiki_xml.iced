
fs = require 'fs'
sax = require 'sax'

last = (array) ->
  array[array.length-1]

counter = 0

wantednodes =
  page: (p) ->
    counter += 1
    txt = p.childtags["revision"][0].childtags["text"][0].allText.join " "
    console.log p.childtags["title"][0].allText[0] + " #{txt.length}"

trim12 = (st) ->
  b = st.replace(/^\s\s*/, '')
  ws = /\s/
  i = b.length - 1
  while (/\s/.test(b.charAt(i)))
    i -= 1
  return b.slice(0, i)

createParser = (wantedNodes, strict) ->
  element = null
  interestingStack = []
  parser = sax.parser strict

  parser.onerror = (v) -> console.warn "sax parser error: #{v}"

  parser.onopentag = ({name, attributes}) ->
    if wantedNodes[name]? or element?
      parent = element
      element = {name, attributes, parent, allText : [], children: [], childtags: []}
      if parent?
        parent.children.push element
        if not parent.childtags[name]?
          parent.childtags[name] = new Array
        parent.childtags[name].push element
    if wantedNodes[name]?
      interestingStack.push name

  parser.onclosetag = (name) ->
    if name is last interestingStack
      interestingStack.pop()
      wantedNodes[name] element
    element = element?.parent

  parser.ontext = (text) ->
    text = trim12(text)
    if element?.parent? and text
      element.allText.push text

  parser

parser = createParser wantednodes, true

rs = fs.createReadStream process.argv[2], {encoding: 'utf8'}
rs.on('data', (data) -> parser.write data)














