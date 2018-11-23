FROM node:11.2.0-stretch

WORKDIR /root

# # rlwrap for clj command
# RUN apt-get update \
#     && apt-get install -y --no-install-recommends \
#         vim \
#         rlwrap \
#     && rm -rf /var/lib/apt/lists/*

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
