#!/usr/bin/env python


from multiprocessing import Pool
import time
import sys

SLEEP_TIME = 0.5

d = {}

def f(x):
    time.sleep(SLEEP_TIME)
    return [x, x*x]

if __name__ == '__main__':

    rng = int(sys.argv[1])
    pool = Pool(processes=2)              # start 4 worker processes
#    result = pool.apply_async(f, [10])    # evaluate "f(10)" asynchronously
#    print result.get(timeout=1)           # prints "100" unless your computer is *very* slow
#    print "going to sleep"
#    time.sleep(1)
    print "ready? expect to take %f secs" % (SLEEP_TIME * rng / 2)
    t1 = time.time()
    r = pool.map(f, range(rng))          # should be "[0, 1, 4,..., 81]"
    r.wait()
    print "%s  , in %4f secs" % (d, time.time() - t1)
