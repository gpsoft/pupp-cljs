(ns pupp-cljs.pupp
  (:require [kitchen-async.promise :as p]
            puppeteer))

(def the-page (atom nil))

(defn goto
  [url]
  (when-let [page @the-page]
    (.goto page url)))

(defn take-ss
  [fpath]
  (when-let [page @the-page]
    (.screenshot page
                 #js {:path fpath
                      :fullPage true})))
(defn click
  [sel]
  (when-let [page @the-page]
    (.click page sel)))

(defn wait-transit
  [sel]
  (when-let [page @the-page]
    (.waitFor page
              sel
              #js {:timeout 10000})))

(defn type-in
  [sel s]
  (when-let [page @the-page]
    (.type page sel s)))

(defn select
  [sel v]
  (when-let [page @the-page]
    (.select page sel v)))

(defn inp-val
  [sel]
  (when-let [page @the-page]
    (.$eval page
            sel
            #(.-value %))))

(defn content
  [sel]
  (when-let [page @the-page]
    (.$eval page
            sel
            #(.-textContent %))))

(defn attr
  [sel attr-name]
  (when-let [page @the-page]
    (.$eval page sel #(.getAttribute %1 %2) attr-name)))

(defn on-dlg
  [f]
  (when-let [page @the-page]
    (.on page "dialog" f)))

(defn with-page
  ([f] (with-page false f))
  ([headful? f]
   (p/let [opts {:args ["--no-sandbox"
                        "--disable-setuid-sandbox"]
                 :headless (not headful?)}
           browser (puppeteer/launch (clj->js opts))
           page (.newPage browser)]
     (reset! the-page page)
     (f page)
     (.close browser))))
