IMAGE=heinrichhartmann/jupyter

docker-build:
	docker build . -t $(IMAGE)

docker-push:
	docker push $(IMAGE)

docker-rm:
	docker rmi $(IMAGE)

docker-run: jupyterc
	./jupyterc

jupyterc: jupyterc.sh.in
	sed 's|@IMAGE@|$(IMAGE)|g' < $< > $@
	chmod a+x $@

install: jupyterc
	install -m 755 $< ~/bin/
