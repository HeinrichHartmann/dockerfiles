build:
	docker build --tag hh-mail .

run:
	docker run --rm -it -p 1025:25 \
	--mount type=bind,source="$$(pwd)"/etc,target=/etc/postfix \
	--mount type=bind,source="$$(pwd)"/home,target=/home \
	--mount type=bind,source="$$(pwd)"/var,target=/var/lib/postfix \
	hh-mail
