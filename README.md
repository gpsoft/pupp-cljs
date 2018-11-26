# pupp-cljs

ClojureScriptでPuppeteerを使う。環境はDockerコンテナに入れる。ホストはLinux。以下、参考サイト。

- [Puppeteer(https://github.com/GoogleChrome/puppeteer)](https://github.com/GoogleChrome/puppeteer)
- [Dockerコンテナ上でGUIプログラムを動かす方法(http://wiki.ros.org/docker/Tutorials/GUI)](http://wiki.ros.org/docker/Tutorials/GUI)
- [Puppeteerが起動しないとき(https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md)](https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md)

# Usage

## Dockerコンテナを作る

```
$ git clone https://github.com/gpsoft/pupp-cljs.git
$ cd pupp-cljs
$ make image
```

## コンテナ起動

```
$ make dev
```

この先は、コンテナの中。`lein`、`boot`、`clj`、`npm`、`node`は既に使える状態。

`lumo`を入れる。

```
$ npm install -g lumo-cljs
```

## Puppeteerサンプル

Puppeteerのサンプルプログラム`index.js`を動かす。

```
$ npm install
$ node index.js
$ ll yahoo.png
```

ヤフーのトップページのスクリーンショットが`yahoo.png`へ保存される。

## ClojureScriptバージョン

```
$ lein cljsbuild once
$ node out/main.js
$ ll google.png
```

## lumoで

```
$ lumo -D kitchen-async:0.1.0-SNAPSHOT
cljs.user=> (require '[kitchen-async.promise :as p])
nil
cljs.user=> (require 'puppeteer)
nil
cljs.user=> (p/let [opts {:args ["--no-sandbox"
       #_=>                        "--disable-setuid-sandbox"]}
       #_=>           browser (puppeteer/launch (clj->js opts))
       #_=>           page (.newPage browser)]
       #_=>     (.goto page "https://www.google.com")
       #_=>     (.screenshot page #js {:path "google.png"})
       #_=>     (.close browser))
#object[Promise [object Promise]]
cljs.user=>
```

# memo

カーネル4.19.2でDockerイメージのビルドに失敗。https://github.com/docker/for-linux/issues/480

```
host $ echo N |sudo tee /sys/module/overlay/parameters/metacopy
```
