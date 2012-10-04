# This should get actual args (ie process.argv[2..])
# splits args to named key-values and unnamed, which are kept in order
# example: iced test.coffee --path "/home/user/src" --verbose 10 100 1000
# process.argv is ["iced", "test.coffee", "--path", "/home/user/src", "--verbose", "10", "100", "1000"]
# call read_argv with process.argv[2..] and get back
# {
#   "--path"    :   "/home/user/src",
#   "--verbose" :   "",
#   "unnamed"   :   ["10", "100", "1000"]
# }

exports.read_argv = (argv) ->
  named = {}
  unnamed = []
  while argv.length > 0
    p = argv.shift()
    if p.length > 1 and p[0..1] == "--"
      if argv.length == 0 or argv[0].length < 2 or argv[0][0..1] == "--"
        named[p] = ""
      else
        q = argv.shift()
        named[p] = q
    else
      unnamed.push p
  named["unnamed"] = unnamed
  return named

