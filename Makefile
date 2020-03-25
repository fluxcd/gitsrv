NAME:=gitsrv
DOCKER_REPOSITORY:=fluxcd
DOCKER_IMAGE_NAME:=$(DOCKER_REPOSITORY)/$(NAME)
VERSION:=latest

.PHONY: build
build:
	docker build -t $(DOCKER_IMAGE_NAME):$(VERSION) .

.PHONY: release
release:
	git tag "v$(VERSION)"
	git push origin "v$(VERSION)"

