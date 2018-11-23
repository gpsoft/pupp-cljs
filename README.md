http://wiki.ros.org/docker/Tutorials/GUI
https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md




host $ make image
host $ make test
container $ npm install
container $ node index.js



container $ npm install -g lumo-cljs
container $ npm install -g module-deps




for kernel 4.19.1 or 4.19.2
host $ echo N |sudo tee /sys/module/overlay/parameters/metacopy


container $ lein cljsbuild once
container $ node out/main.js

