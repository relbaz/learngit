
console.log "starting"

rounds = 50000000
pi = 3.141592653589793

getbusy = (n) ->
  s = 0
  t1 = Date.now()
  for i in [0..n]
    s += Math.sin(pi*i/1000.0)
  t2 = Date.now()
  return [t2-t1,s]


t1 = Date.now()
[ft,s] = getbusy(rounds)
t2 = Date.now()
console.log "getbusy(#{rounds}) finished in #{t2-t1}ms, reported #{ft}ms, s = #{s}}"
#await setTimeout defer(),1000



