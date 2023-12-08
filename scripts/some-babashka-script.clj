#!/usr/bin/env bb

(println "1+2+3 is" (+ 1 2 3))

(require '[babashka.fs :as fs])
(println "does . exists?" (fs/exists? "."))
(println "does ./foo exists?" (fs/exists? "./foo"))

(require '[clojure.string :refer [upper-case]])
(println "uppercase ciao is" (upper-case "ciao"))

(require '[babashka.classpath :refer [get-classpath split-classpath]])

(println "=== CLASSPATH BEGIN ===")
(prn (split-classpath (get-classpath)))
(println "=== CLASSPATH END ===")