IMAGE_NAME=sineverba/testdockervercel
CONTAINER_NAME=testdockervercel

build:
	docker build --tag $(IMAGE_NAME) .

test:
	docker run --name $(CONTAINER_NAME) --rm -it $(IMAGE_NAME) npm -v | grep "8.5.1"
	docker run --name $(CONTAINER_NAME) --rm -it $(IMAGE_NAME) vercel -v | grep "24.0.0"

destroy:
	docker image rm $(IMAGE_NAME)