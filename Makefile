NAME:=gitsrv
DOCKER_REPOSITORY:=fluxcd
DOCKER_IMAGE_NAME:=$(DOCKER_REPOSITORY)/$(NAME)
VERSION:=$(shell grep 'newTag' deploy/kustomization.yaml | awk '{ print $$2 }' | tr -d '"')

.PHONY: build
build:
	docker build -t $(DOCKER_IMAGE_NAME):$(VERSION) .

.PHONY: release
release:
	git tag "$(VERSION)"
	git push origin "$(VERSION)"

