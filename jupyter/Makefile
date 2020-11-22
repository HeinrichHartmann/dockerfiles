IMAGE=heinrichhartmann/jupyter
REPO=docker.heinrichhartmann.net:5000/

docker-build:
	docker build . -t $(REPO)$(IMAGE)

docker-push:
	docker push  $(REPO)$(IMAGE)

docker-rm:
	docker rmi  $(REPO)$(IMAGE)

docker-run: jupyterc
	./jupyterc

jupyterc: jupyterc.sh.in
	sed 's|@IMAGE@|$(IMAGE)$(REPO)|g' < $< > $@
	chmod a+x $@

install: jupyterc
	install -m 755 $< ~/bin/
