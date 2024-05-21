IMAGE_NAME=sineverba/vercel-cli
CONTAINER_NAME=vercel-cli
APP_VERSION=1.6.0-dev
NODE_VERSION=20.13.1
NPM_VERSION=10.8.0
VERCEL_CLI_VERSION=34.2.0
ALPINE_VERSION=3.19.1
BUILDX_VERSION=0.12.0
BINFMT_VERSION=qemu-v7.0.0-28

devbuild:
	docker build \
		--tag $(IMAGE_NAME):$(APP_VERSION) \
		--file dockerfiles/development/Dockerfile \
		"."

devspin:
	docker run \
		--rm -it \
		--name $(CONTAINER_NAME) \
		--entrypoint /bin/sh \
		$(IMAGE_NAME):$(APP_VERSION)


build:
	docker build \
		--build-arg NODE_VERSION=$(NODE_VERSION) \
		--build-arg NPM_VERSION=$(NPM_VERSION) \
		--build-arg VERCEL_CLI_VERSION=$(VERCEL_CLI_VERSION) \
		--file dockerfiles/production/Dockerfile \
		--tag $(IMAGE_NAME):$(APP_VERSION) "."

preparemulti:
	mkdir -vp ~/.docker/cli-plugins
	curl \
		-L \
		"https://github.com/docker/buildx/releases/download/v$(BUILDX_VERSION)/buildx-v$(BUILDX_VERSION).linux-amd64" \
		> ~/.docker/cli-plugins/docker-buildx
	chmod a+x ~/.docker/cli-plugins/docker-buildx
	docker buildx version
	docker run --rm --privileged tonistiigi/binfmt:$(BINFMT_VERSION) --install all
	docker buildx ls
	docker buildx rm multiarch
	docker buildx create --name multiarch --driver docker-container --use
	docker buildx inspect --bootstrap --builder multiarch

multi:
	preparemulti
	docker buildx build \
		--platform linux/arm64/v8,linux/amd64,linux/arm/v6,linux/arm/v7 \
		--tag $(IMAGE_NAME):$(APP_VERSION) \
		--tag $(IMAGE_NAME):latest \
		--file dockerfiles/production/Dockerfile \
		"."

test:
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) cat /etc/os-release | grep "Alpine Linux"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) cat /etc/os-release | grep $(ALPINE_VERSION)
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) node -v | grep $(NODE_VERSION)
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) npm -v | grep $(NPM_VERSION)
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) vercel -v | grep $(VERCEL_CLI_VERSION)

destroy:
	docker image rm node:$(NODE_VERSION)-alpine3.19
	docker image rm $(IMAGE_NAME):$(APP_VERSION)