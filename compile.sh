function compile {
  if [ -d ${2} ]; then
    echo ""
    echo "Compiling $1"
    eval "${3}"
    result=$?
    if [ $result -ne 0 ]; then
        echo "Failed to compile ${1} with command: ${3}"
    fi
  fi
}

# Please keep in language name alphabetic order
# run "Language name" "File that should exist" "Command line"
####### BEGIN The languages
compile 'C' 'c' 'gcc -O3 -I../lib/c -c ../lib/c/benchmark.c -o c/benchmark.o && gcc -O3 -I../lib/c c/benchmark.o c/run.c -o c/run -lm'
compile 'Clojure' 'clojure' '(cd clojure && mkdir -p classes && clojure -M -e "(compile (quote run))")'
compile 'Clojure Native' 'clojure-native-image' "(cd clojure-native-image ; clojure -M:native-image-run --pgo-instrument -march=native) ; ./clojure-native-image/run -XX:ProfilesDumpFile=clojure-native-image/run.iprof 10000 $(./check-output.sh -i) && (cd clojure-native-image ; clojure -M:native-image-run --pgo=run.iprof -march=native)"
compile 'Java' 'jvm' 'javac -cp ../lib/java jvm/run.java'
compile 'Java Native' 'java-native-image' "(cd java-native-image ; native-image -cp ..:../../lib/java --no-fallback -O3 --pgo-instrument -march=native jvm.run) && ./java-native-image/jvm.run -XX:ProfilesDumpFile=java-native-image/run.iprof 10000 $(./check-output.sh -i) && (cd java-native-image ; native-image -cp ..:../../lib/java -O3 --pgo=run.iprof -march=native jvm.run -o run)"
####### END The languages
