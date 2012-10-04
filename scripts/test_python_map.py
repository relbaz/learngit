import time

REPETITIONS = 20000000
MODU = 983

map1 = {}
map2 = {}

print "starting - %d repetitions" % REPETITIONS
time1 = time.time()
for i in range(REPETITIONS):
    val = i % MODU
    try:
        cnt = map1[val]
    except:
        cnt = 0
    cnt += 1
    map1[val] = cnt
print "loop 1 (exception-based) took %s secs" % (time.time() - time1)
map1 = {}

time2 = time.time()
for i in range(REPETITIONS):
    val = i % MODU
    if val in map2:
        cnt = map2[val]
    else:
        cnt = 0
    cnt += 1
    map2[val] = cnt
print "loop 2 (existence check) took %s secs" % (time.time() - time2)



