IMAGE_NAME=sineverba/vercel-cli
CONTAINER_NAME=vercel-cli
APP_VERSION=1.3.0-dev
BUILDX_VERSION=0.11.1
BINFMT_VERSION=qemu-v7.0.0-28

build:
	docker build --tag $(IMAGE_NAME):$(APP_VERSION) "."

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
		"."

test:
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) cat /etc/os-release | grep "Alpine Linux v3.18"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) cat /etc/os-release | grep "3.18.2"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) node -v | grep "18.16.1"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) npm -v | grep "9.8.0"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) vercel -v | grep "31.0.3"

destroy:
	docker image rm node:18.16.1-alpine3.18
	docker image rm $(IMAGE_NAME):$(APP_VERSION)