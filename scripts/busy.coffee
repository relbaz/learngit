
console.log "starting"

s = 0
min = 999
max = -999
t1 = Date.now()
for i in [0..9000000]
  v = Math.sin(i*3.141/5000.0)
  if v < min
    min = v
  if v > max
    max = v
  s += v
t2 = Date.now()

console.log "finished in #{t2-t1}ms, s = #{s}, min,max = #{[min, max]}"




