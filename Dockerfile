FROM node:11.2.0-stretch

WORKDIR /root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libx11-xcb-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libxtst6 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libnss3 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libxss1 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libasound2 \
    && rm -rf /var/lib/apt/lists/*

# https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#chrome-headless-doesnt-launch
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gconf-service \
        libasound2 \
        libatk1.0-0 \
        libatk-bridge2.0-0 \
        libc6 \
        libcairo2 \
        libcups2 \
        libdbus-1-3 \
        libexpat1 \
        libfontconfig1 \
        libgcc1 \
        libgconf-2-4 \
        libgdk-pixbuf2.0-0 \
        libglib2.0-0 \
        libgtk-3-0 \
        libnspr4 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libstdc++6 \
        libx11-6 \
        libx11-xcb1 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        libxss1 \
        libxtst6 \
        ca-certificates \
        fonts-liberation \
        libappindicator1 \
        libnss3 \
        lsb-release \
        xdg-utils \
        wget \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        fonts-takao-gothic \
    && rm -rf /var/lib/apt/lists/*

# # leiningen
# ENV LEIN_ROOT=1
# RUN wget -q https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
#     && chmod 755 lein \
#     && mv lein /usr/local/bin \
#     && lein self-install

# # boot
# ENV BOOT_AS_ROOT=yes
# RUN wget -q https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh \
#     && chmod 755 boot.sh \
#     && mv boot.sh /usr/local/bin/boot \
#     && boot --update

# # clojure cli tools
# RUN wget -q -O install.sh https://download.clojure.org/install/linux-install-1.9.0.381.sh \
#     && bash install.sh -p /usr/local \
#     && rm install.sh

# # port for web, figwheel, and nrepl
# EXPOSE 8080
# EXPOSE 3000
# EXPOSE 3449
# EXPOSE 3575

# for convenience
COPY ./.bashrc /root/

# startup script
COPY ./dev.sh /root/
RUN chmod 755 /root/dev.sh

RUN deluser --remove-home node

# clojure tooling environment
# COPY profiles.clj /root/.lein/
# COPY profile.boot /root/.boot/
# COPY deps.edn /root/.clojure/
