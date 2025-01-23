# Levenshtein

This program should benchmark a function that takes a sequence of strings as input and
returns a sequence of all
[levenshtein distances](https://en.wikipedia.org/wiki/Levenshtein_distance)
between any pairing of the words. The benchmark then reports the sum of these distances.
The words are provided from a file, given as an argument to the program. There is one
word per line in the file.

All implementations must use the [Wagner-Fischer algorithm](https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm), with a few of the performance enhancements allowed:

- Reduced space complexity from O(m*n) to O(min(m,n)) by using only two rows instead of building full matrix
- Always use the shorter string for column dimension to minimize space usage
- Reuse arrays instead of creating new ones

The code should follow the reference implementations as closely as possible:

* Clojure: [run.clj](clojure/run.clj)
* Java: [run.java](jvm/run.java)
* C: [run.c](c/run.c)
