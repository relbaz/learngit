from multiprocessing import Process, Queue
import time

def f(q, worked_id, *names):
    n = names[0]
    print "worker %s starting.. got %d names" % (worked_id, len(n))
    time.sleep((6-worked_id)/5.0)
    q.put(n[0])
    print "worker %s done" % (worked_id)

LEN = 5
def myrange(c):
    r = range(LEN)
    return [i + c*LEN for i in r]

if __name__ == '__main__':
    queues = []
    for c in range(5):
        q = Queue()
        queues.append(q)
        names = myrange(c)
        names = ["ariel %d" % i for i in names]
        p = Process(target=f, args=(q,c, names))
        p.start()

    ret = []
    for c in range(5):
        ret.append(queues[c].get())
        p.join()
    print ret
