IMAGE_NAME=sineverba/vercel-cli
CONTAINER_NAME=vercel-cli
VERSION=1.1.0-dev

build:
	docker build --tag $(IMAGE_NAME):$(VERSION) .

test:
	docker run --name $(CONTAINER_NAME) --rm -it $(IMAGE_NAME):$(VERSION) cat /etc/os-release | grep "Alpine Linux v3.16"
	docker run --name $(CONTAINER_NAME) --rm -it $(IMAGE_NAME):$(VERSION) node -v | grep "18.12.1"
	docker run --name $(CONTAINER_NAME) --rm -it $(IMAGE_NAME):$(VERSION) npm -v | grep "9.2.0"
	docker run --name $(CONTAINER_NAME) --rm -it $(IMAGE_NAME):$(VERSION) vercel -v | grep "28.10.1"

destroy:
	docker image rm $(IMAGE_NAME):$(VERSION)