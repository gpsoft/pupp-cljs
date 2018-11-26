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
