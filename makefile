IMAGENAME ?= pupp-cljsi
CONTAINERNAME ?= pupp-cljs
USER ?= $(USERNAME)

all:
	@echo Usage:
	@echo make image
	@echo make dev
	@echo make attach
	@echo make stop

# Build a docker image.
image:
	docker build --tag=$(IMAGENAME) .

test:
	xhost +local:$(USER)
	docker run --rm -it \
		--env="DISPLAY" \
		--env="QT_X11_NO_MITSHM=1" \
		--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
		--env NPM_CONFIG_PREFIX=/home/$(USER)/.npm-global \
		--env HOST_USER=$(USER) \
		--env HOST_GID=`id -g` \
		--env HOST_UID=`id -u` \
		--volume $(shell pwd):/home/$(USER)/proj \
		--volume ~/.m2:/home/$(USER)/.m2 \
		--hostname $(CONTAINERNAME) \
		--name $(CONTAINERNAME) \
		--workdir /home/$(USER)/proj \
		$(IMAGENAME) /root/dev.sh

# Start development
.PHONY: dev attach
dev:
	docker run --rm -it \
		--env HOST_USER=$(USER) \
		--env HOST_GID=`id -g` \
		--env HOST_UID=`id -u` \
		--volume $(shell pwd):/home/$(USER)/proj \
		--volume ~/.m2:/home/$(USER)/.m2 \
		--publish 8080:8080 \
		--publish 3000:3000 \
		--publish 3449:3449 \
		--publish 3575:3575 \
		--hostname $(CONTAINERNAME) \
		--name $(CONTAINERNAME) \
		--workdir /home/$(USER)/proj \
		$(IMAGENAME) /root/dev.sh

# Attach to the running container.
attach:
	docker exec -it \
		--user $(USER) \
		$(CONTAINERNAME) bash

stop:
	xhost -local:$(USER)

.SILENT:
%:
	@:

