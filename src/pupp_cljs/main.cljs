(ns pupp-cljs.main
  (:require [kitchen-async.promise :as p]
            puppeteer))

(defn main []
  (p/let [opts {:args ["--no-sandbox"
                       "--disable-setuid-sandbox"]}
          browser (puppeteer/launch (clj->js opts))
          page (.newPage browser)]
    (.goto page "https://www.google.com")
    (.screenshot page #js {:path "google.png"})
    (.close browser)))

(set! *main-cli-fn* main)

(comment
  (defn- ss
  [page fpath]
  (.screenshot page #js {:path (str "ss/" fpath) :fullPage true}))

(defn- waitTransit
  [page sel]
  (.waitFor page sel #js {:timeout 10000}))

(defn- inp-val
  [page sel]
  (.$eval page sel #(.-value %)))

(defn- content
  [page sel]
  (.$eval page sel #(.-textContent %)))

(defn- attr
  [page sel attr-name]
  (.$eval page sel #(.getAttribute %1 %2) attr-name))
)
