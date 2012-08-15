fs       = require 'fs'
countfiles = (path, cb) ->
  await fs.readdir path, defer err, files
  if err
    cb -1
  cb files.length


path = "/home/ariel/src/8lt/var/pending_uploads"
await countfiles path, defer n
console.log "#{path} has #{n} files"
