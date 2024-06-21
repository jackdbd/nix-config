#!/usr/bin/env bb

(require '[babashka.fs :as fs])
(require '[babashka.process :refer [shell]])
(require '[clojure.string :as str])

(def R2_BUCKET_NAME "docs-backup")

(defn collect-files [dir]
  (let [files (atom [])]
    (fs/walk-file-tree
     dir
     {:visit-file (fn [unix-path _]
                    (let [components (iterator-seq (.iterator unix-path))
                          splits (mapv str components)]
                      (swap! files conj splits)
                      :continue))})
    @files))

(defn replace-white-spaces [s]
  (str/replace s " " "_"))

(defn splits->object-k [xs]
  (let [n (count xs)
        s0 (nth xs (- n 2))
        s1 (last xs)]
    (str/join "__" [(replace-white-spaces s0)
                    (replace-white-spaces s1)])))

(defn upload! [{:keys [k filepath]}]
  (prn "upload" filepath "to Cloudflare R2 bucket" k)
  (shell "wrangler" "r2" "object" "put" k "--file" filepath))

(comment
  (def filepaths-as-splits (collect-files "/home/jack/Documents/shared-documents/motorbikes"))
  (def n 10)
  (def filepath-as-splits (nth filepaths-as-splits n))
  (def r2-object-key (splits->object-k filepath-as-splits))

  (upload! {:k (str R2_BUCKET_NAME "/" r2-object-key)
            :filepath (str "/" (str/join "/" filepath-as-splits))})
  )