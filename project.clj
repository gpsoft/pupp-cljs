(defproject pupp-cljs "0.0.1"
  :dependencies [[org.clojure/clojure "1.9.0"]
                 [org.clojure/clojurescript "1.10.439"]
                 [kitchen-async "0.1.0-SNAPSHOT"]]
  :plugins [[lein-cljsbuild "1.1.7"]]
  :cljsbuild {:builds
              [{:id "dev"
                :source-paths ["src"]
                :compiler {:main pupp-cljs.main
                           :output-dir "out/compiled"
                           :output-to "out/main.js"
                           :optimizations :none
                           :target :nodejs
                           :install-deps true
                           :npm-deps {:puppeteer "1.0.0"}}}]})
