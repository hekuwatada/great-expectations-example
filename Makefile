.ONESHELL:
SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -euc

DOCKER_IMAGE_TAG = 'ge-local'
PROJECT_DIR = 'ge'

##############################
# Docker
##############################
# build Docker image
.PHONY: docker/build
docker/build:
	@echo $@
	docker build -t $(DOCKER_IMAGE_TAG) .

# run Docker image mounting the current directory
.PHONY: docker/run
docker/run:
	@echo $@
	docker run -it --rm \
		--mount src="$$(pwd)",target=/workspaces,type=bind \
		--mount src="${HOME}/.config/gcloud",target=/root/.config/gcloud,type=bind \
		--workdir /workspaces/$(PROJECT_DIR) \
		--entrypoint /bin/bash \
		$(DOCKER_IMAGE_TAG)

.PHONY: docker/ge
docker/ge:
	@echo $@
	docker run -it --rm \
		--mount src="$$(pwd)",target=/workspaces,type=bind \
		--mount src="${HOME}/.config/gcloud",target=/root/.config/gcloud,type=bind \
		--workdir /workspaces/$(PROJECT_DIR) \
		$(DOCKER_IMAGE_TAG) \
		$(ARGS)

##############################
# Great Expectations
##############################
.PHONY: ge/version
ge/version:
	@echo $@
	$(MAKE) docker/ge ARGS='--version'

