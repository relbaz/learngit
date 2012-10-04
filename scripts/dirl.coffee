fs            =   require 'fs'
argv_helper   =   require './argv_helper'

## ---------------------------------------------------------------------------

countfiles = (path, cb) ->
  await fs.readdir path, defer err, files
  if err
    cb -1
  cb files.length

## ---------------------------------------------------------------------------

args = process.argv[2..]
processed = argv_helper.read_argv(args)

if processed["--path"]?
  path = processed["--path"]
  await countfiles path, defer n
  console.log "#{path} has #{n} files"
else
  console.error "usage: #{process.argv[1]} --path \"some\\path\\to\\count\""
