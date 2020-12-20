# Manual: https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/
# Debug: https://www.sslshopper.com/article-most-common-openssl-commands.html
# Files: https://serverfault.com/questions/9708/what-is-a-pem-file-and-how-does-it-differ-from-other-openssl-generated-key-file
# Tutorial: https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309

CN=heinrichhartmann.net
CACRT_NAME=${CN}-ca.crt
CACRT=ssl/${CACRT_NAME}
CACRT_INSTALL_DIR=/usr/local/share/ca-certificates
KEY=secrets/host.key


.PHONY: ca keys
ca: ${CACRT}
keys: ${KEY}

${KEY}:
	# Private keys, etc. are kept in a separate directory that MUST not be published
	mkdir -p secrets
	# Generate private key
	openssl genrsa -out $@ 8192
	# Print key
	openssl rsa -in $@ -noout -text

${CACRT}: ${KEY}
	mkdir -p ssl
	openssl req -x509 -new -nodes -key $< -sha256 -days 3650 -out $@ --subj '/C=DE/CN=${CN}/'
	# print certificate text
	openssl x509 -in $@ -text -noout

.PHONY: install-ca-ubuntu
install-ca-ubuntu: ${CACRT}
	# https://superuser.com/questions/437330/how-do-you-add-a-certificate-authority-ca-to-ubuntu
	sudo mkdir -p ${CACRT_INSTALL_DIR}
	sudo cp $<  ${CACRT_INSTALL_DIR}/${CACRT_NAME}
	sudo update-ca-certificates
	# Check if this worked:
	grep "$$(cat $< | head -n 2 | tail -n 1)" \
		/etc/ssl/certs/ca-certificates.crt > /dev/null && echo OK || echo NOT FOUND

.PHONY: remove-ca-ubuntu
remove-ca-ubuntu:	
	sudo rm  ${CACRT_INSTALL_DIR}/${CACRT_NAME}
	sudo update-ca-certificates
	# Check if this worked:
	grep "$$(cat ${CACRT} | head -n 2 | tail -n 1)" \
		/etc/ssl/certs/ca-certificates.crt > /dev/null && echo ERROR Cert still active || echo OK



install-ca-osx: ${CACRT}
	# https://manuals.gfi.com/en/kerio/connect/content/server-configuration/ssl-certificates/adding-trusted-root-certificates-to-the-server-1605.html
	sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" $<
