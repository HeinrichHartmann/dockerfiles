IMAGE=heinrichhartmann/conda
REPO=docker.heinrichhartmann.net:5000/

docker-build:
	docker build . -t $(REPO)$(IMAGE)

docker-push:
	docker push  $(REPO)$(IMAGE)

docker-rm:
	docker rmi  $(REPO)$(IMAGE)
