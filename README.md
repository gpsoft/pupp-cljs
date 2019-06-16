# pupp-cljs

ClojureScriptでPuppeteerを使う。環境はDockerコンテナに入れる。ホストはLinux。以下、参考サイト。

- [Puppeteer(https://github.com/GoogleChrome/puppeteer)](https://github.com/GoogleChrome/puppeteer)
- [Dockerコンテナ上でGUIプログラムを動かす方法(http://wiki.ros.org/docker/Tutorials/GUI)](http://wiki.ros.org/docker/Tutorials/GUI)
- [Puppeteerが起動しないとき(https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md)](https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md)
- [Promiseを多用するJSライブラリをClojureScriptから使う(https://github.com/athos/kitchen-async)](https://github.com/athos/kitchen-async)

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

ヤフーのトップページのスクリーンショットが`yahoo.png`へ保存されてる。

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

## Dockerイメージをビルドできない

カーネル4.19.2でDockerイメージのビルドに失敗。https://github.com/docker/for-linux/issues/480

```
host $ echo N |sudo tee /sys/module/overlay/parameters/metacopy
```

## Chromeのウィンドウがホスト側に出ない

`openjdk-8-jdk`を入れると、headlessオフのChromeがうまくいかない。無地の矩形が出るが、その先に進まない感じ。GUIが全滅というわけじゃなくて、`dclock`とかはちゃんと出る。

## cljsからChromeを起動できない

Puppeteerの1.10.0だと、ダメみたい。

```
(node:915) UnhandledPromiseRejectionWarning: TypeError: Cannot read property '_launcher' of null
    at launch (/home/maru/proj/node_modules/puppeteer/lib/Puppeteer.js:36:17)
    at /home/maru/proj/out/compiled/pupp_cljs/main.js:8:89
    at process._tickCallback (internal/process/next_tick.js:43:7)
    at Function.Module.runMain (internal/modules/cjs/loader.js:778:11)
    at startup (internal/bootstrap/node.js:300:19)
    at bootstrapNodeJSCore (internal/bootstrap/node.js:826:3)
```

1.0.0ならOK。


