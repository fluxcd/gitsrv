NAME:=gitsrv
DOCKER_REPOSITORY:=stefanprodan
DOCKER_IMAGE_NAME:=$(DOCKER_REPOSITORY)/$(NAME)
VERSION:=0.1.3

.PHONY: build
build:
	docker build -t $(DOCKER_IMAGE_NAME):$(VERSION) .

.PHONY: push
push:
	docker push $(DOCKER_IMAGE_NAME):$(VERSION)

.PHONY: check-version
check-version:
	@curl --silent -f -lSL "https://hub.docker.com/v2/repositories/$(DOCKER_IMAGE_NAME)/tags/$(VERSION)" &> /dev/null && { echo "$(VERSION) already exists on DockerHub"; exit 1; } || exit 0
