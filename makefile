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

# Start development
.PHONY: dev attach stop
dev:
	xhost +local:$(USER)
	docker run --rm -it \
		--env="DISPLAY=:1" \
		--env="QT_X11_NO_MITSHM=1" \
		--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
		--env NPM_CONFIG_PREFIX=/home/$(USER)/.npm-global \
		--env HOST_USER=$(USER) \
		--env HOST_GID=`id -g` \
		--env HOST_UID=`id -u` \
		--volume $(shell pwd):/home/$(USER)/proj \
		--volume ~/.m2:/home/$(USER)/.m2 \
		--volume ~/.npm-global:/home/$(USER)/.npm-global \
		--publish 8080:8080 \
		--publish 3000:3000 \
		--publish 3449:3449 \
		--publish 3575:3575 \
		--hostname $(CONTAINERNAME) \
		--name $(CONTAINERNAME) \
		--workdir /home/$(USER)/proj \
		$(IMAGENAME) bash

# Attach to the running container.
attach:
	docker exec -it \
		--user $(USER) \
		$(CONTAINERNAME) bash

# Stop development
stop:
	xhost -local:$(USER)

.SILENT:
%:
	@:

