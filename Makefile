build:
	docker build --tag sineverba/testdockervercel .

test:
	docker run --rm -it sineverba/testdockervercel vercel -v | grep "23.1.2"

destroy:
	docker image rm sineverba/testdockervercel