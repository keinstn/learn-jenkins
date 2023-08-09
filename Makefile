REMOTE_REPO =

IMAGE_NAME = jenkins/master
SHORT_COMMIT_ID = $(shell git rev-parse --short HEAD)
ifdef USE_GITTAG
TAG_NAME = $(SHORT_COMMIT_ID)
else
TAG_NAME = latest
endif

LOCAL_IMAGE = ${IMAGE_NAME}:${TAG_NAME}
REMOTE_IMAGE = ${REMOTE_REPO}/${IMAGE_NAME}:${TAG_NAME}

.PHONY: about
.PHONY: build push


about:
	@echo "Usage:"
	@echo "    make build		  build docker image"
	@echo "    make push		  push docker image to remote registory"
	@echo "    make run           run docker container"

build:
	docker build \
	-f Dockerfile \
	-t ${LOCAL_IMAGE} \
	.

push:
	docker tag ${LOCAL_IMAGE} ${REMOTE_IMAGE}
	docker push ${REMOTE_IMAGE}
	docker rmi ${REMOTE_IMAGE}
