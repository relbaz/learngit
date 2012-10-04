argv_helper     = require './argv_helper'

## ---------------------------------------------------------------------------
print_processed_args = (processed) ->
  for i of processed
    if i != "unnamed"
      if processed[i] != ""
        console.log "#{i} = #{processed[i]}"
      else
        console.log i
  if processed["unnamed"]?
    for i in processed["unnamed"]
      console.log "#{i}"

## ---------------------------------------------------------------------------
args = process.argv[2..]
processed = argv_helper.read_argv(args)
if Object.keys(processed).length > 0
  print_processed_args(processed)
