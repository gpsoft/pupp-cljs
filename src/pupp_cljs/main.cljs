(ns pupp-cljs.main
  (:require [kitchen-async.promise :as p]
            puppeteer))

(defn main []
  (p/let [browser (puppeteer/launch (clj->js {:args ["--no-sandbox" "--disable-setuid-sandbox"]}))
          page (.newPage browser)]
    (.goto page "https://www.google.com")
    (.screenshot page #js{:path "screenshot.png"})
    (.close browser)))

(comment

  ;; Without kitchen-async, you have to write something like:

  (defn main []
    (-> (puppeteer/launch)
        (.then (fn [browser]
                 (-> (.newPage browser)
                     (.then (fn [page]
                              (.then (.goto page "https://www.google.com")
                                     #(.screenshot page #js{:path "screenshot.png"}))))
                     (.then #(.close browser)))))))

  )

(set! *main-cli-fn* main)
