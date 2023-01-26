IMAGE_NAME=sineverba/vercel-cli
CONTAINER_NAME=vercel-cli
APP_VERSION=1.2.0-dev
BUILDX_VERSION=0.10.0
BINFMT_VERSION=qemu-v7.0.0-28

build:
	docker build --tag $(IMAGE_NAME):$(APP_VERSION) "."

preparemulti:
	mkdir -vp ~/.docker/cli-plugins
	curl -L "https://github.com/docker/buildx/releases/download/v$(BUILDX_VERSION)/buildx-v$(BUILDX_VERSION).linux-amd64" > ~/.docker/cli-plugins/docker-buildx
	chmod a+x ~/.docker/cli-plugins/docker-buildx
	docker buildx version
	docker run --rm --privileged tonistiigi/binfmt:$(BINFMT_VERSION) --install all
	docker buildx ls
	docker buildx rm multiarch
	docker buildx create --name multiarch --driver docker-container --use
	docker buildx inspect --bootstrap --builder multiarch

multi:
	docker buildx build \
		--platform linux/arm64/v8,linux/amd64,linux/arm/v6,linux/arm/v7 \
		--tag $(IMAGE_NAME):$(APP_VERSION) \
		--tag $(IMAGE_NAME):latest \
		"."

test:
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) cat /etc/os-release | grep "Alpine Linux v3.17"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) cat /etc/os-release | grep "3.17.0"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) node -v | grep "18.13.0"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) npm -v | grep "9.4.0"
	docker run --rm -it $(IMAGE_NAME):$(APP_VERSION) vercel -v | grep "28.13.1"

destroy:
	docker image rm $(IMAGE_NAME):$(APP_VERSION)