# Content

* [Thread VS Process](#Thread-VS-Process)
* [Lock And RLock](#Lock-VS-RLock)

# Thread VS Process

process is the container of thread, process acquire resource from the operation system which 
will be used by thread inside it. A thread can only use the resource inside the process. The 
difference is that threads run in the same memory space, while processes have separate memory. 
This makes it a bit harder to share objects between processes with multiprocessing. Since threads 
use the same memory, precautions have to be taken or two threads will write to the same memory 
at the same time. This is what the global interpreter lock is for. 

thread and process difference for dealing with http requests:

- a breakdown inside a connection will not affect other ones when use multi-processing to handle requests
- a single thread interrupt will make other threads inside the same process break down

python process and thread example:

<hr>

python threading:

``` python
# -*- coding: utf-8 -*-

from threading import  Thread                                                                                         
  
def thread_func():   
    print "thread in"  
    while True:  
        pass  
  
if __name__ == "__main__":  
    t1 = Thread(target = thread_func)  
    t1.start()  
  
    t2 = Thread(target = thread_func)  
    t2.start()  
      
    t1.join()  
    t2.join()  
```

python process:

``` python
# -*- coding: utf-8 -*-

import multiprocessing  
  
def thread_func():   
    print "thread in"  
    while True:  
        pass  
  
if __name__ == "__main__":  
    t1 = multiprocessing.Process(target = thread_func)  
    t1.start()  
  
    t2 = multiprocessing.Process(target = thread_func)  
    t2.start()  
      
    t1.join()  
    t2.join()  
```

# Lock VS RLock

A lock is used to control the single access of a important resource. Python support lock an rlock in threading programming.

The main difference is that([ref](http://stackoverflow.com/questions/22885775/what-is-the-difference-between-lock-and-rlock)):

- A Lock can only be acquired once. It cannot be acquired again, 
until it is released. (After it's been released, it can be re-acaquired by any thread).
- An RLock on the other hand, can be acquired multiple times, by the same thread. It needs 
to be released the same number of times in order to be "unlocked".
- An acquired Lock can be released by any thread, while an acquired 
RLock can only be released by the thread which acquired it.

<hr>

Here's an example demostrating why RLock is useful at times. Suppose you have:

``` python 
def f():
  g()
  h()

def g():
  h()
  do_something1()

def h():
  do_something2()
```

Let's say all of f, g, and h are public (i.e. can be called directly by an external caller), and 
all of them require syncronization.

Using a Lock, you can do something like:

``` python

lock = Lock()

def f():
  with lock:
    _g()
    _h()

def g():
  with lock:
    _g()

def _g():
  _h()
  do_something1()

def h():
  with lock:
    _h()

def _h():
  do_something2()

```

Basically, since f cannot call g after acquiring the lock, it needs to call 
a "raw" version of g (i.e. _g). So you end up with a "synced" version and a "raw" 
version of each function.

Using an RLock elegantly solves the problem:

``` python 
lock = RLock()

def f():
  with lock:
    g()
    h()

def g():
  with lock:
    h()
    do_something1()

def h():
  with lock:
    do_something2()
```
