(ns pupp-cljs.main
  (:require [kitchen-async.promise :as p]
            [pupp-cljs.pupp :as pupp]))

(defn- dump
  [prms]
  (p/let [v prms]
    (prn v)))

(defn- take-ss-on-google
  [fpath]
  (pupp/with-page
    (fn [page]
      (p/do
        (pupp/goto "https://www.google.com")
        (pupp/take-ss fpath)))))

(defn- testing []
  (pupp/with-page
    (fn [page]
      (p/do
        (pupp/goto "https://www.google.com")
        (dump (pupp/attr "input[type=submit]" "value"))
        (dump (pupp/inp-val "input[type=submit]"))
        (dump (pupp/content "div.FPdoLc"))
        ))))

(defn main []
  #_(take-ss-on-google "fuga.png")
  (testing)
  )

(set! *main-cli-fn* main)
