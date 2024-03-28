#!/usr/bin/env bb

(require '[babashka.http-client :as http])
(require '[babashka.fs :as fs])
(require '[babashka.process :as process])

(defn download-url [url name]
  (println "Downloading" url "as" name)
  (->> (http/get url)
      :body
      (spit name)))

(def os "ubuntu")
(def os-version "latest")
(def arch "x86_64")
(def version "2024_03_13")
(def zip-url (str "https://github.com/marler8997/zigup/releases/download/v" version "/zigup." os "-" os-version "-" arch ".zip"))

(comment 
  (download-url zip-url "zigup.zip")
  (fs/unzip "zigup.zip")
  (process/shell "chmod u+x zigup")
  (fs/move "zigup" "/home/jack/bin/zigup"))
