# Manual: https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/
# Debug: https://www.sslshopper.com/article-most-common-openssl-commands.html
# Files: https://serverfault.com/questions/9708/what-is-a-pem-file-and-how-does-it-differ-from-other-openssl-generated-key-file
# Tutorial: https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309

CN=heinrichhartmann.net
CACRT_NAME=${CN}-ca.crt
CAKEY=secrets/${CN}-ca.key
CACRT=ssl/${CACRT_NAME}
CACRT_INSTALL_DIR=/usr/local/share/ca-certificates
CNKEY=secrets/${CN}.key
CNPEM=secrets/${CN}.pem
CNCSR=ssl/${CN}.csr
CNCRT=ssl/${CN}.crt
KEYLEN=8192

.PHONY: ca keys cert
cert: ${CNCRT} ${CNPEM} 
ca: ${CACRT}
keys: ${CAKEY} ${CNKEY}

%.key:  # used for creating CA- and CN-keys
	mkdir -p "$$(dirname $@)"
	openssl genrsa -out $@ ${KEYLEN} # Generate key as above
	openssl rsa -in $@ -noout -text > $@.txt # print key contents for human inspection

${CACRT}: ${CAKEY}
	mkdir -p "$$(dirname $@)"
	openssl req -x509 -new -nodes -key $< -sha256 -days 365 -out $@ --subj '/C=DE/CN=${CN}/'
	openssl x509 -in $@ -text -noout > $@.txt # print certificate text for human inspection

${CNCSR}: ${CNKEY}
	mkdir -p "$$(dirname $@)"
	openssl req -new -key $< -out $@ --subj '/C=DE/CN=*.${CN}/' -reqexts SAN -config req.cfg
	openssl req -in $@ -noout -text > $@.txt # for human inspection

${CNCRT}: ${CAKEY} ${CACRT} ${CNCSR}
	printf "subjectAltName=DNS:*.${CN}" > extfile
	openssl x509 -req -in ${CNCSR} -CA ${CACRT} -CAkey ${CAKEY} -out $@ -days 365 -sha512 -CAcreateserial -extfile extfile
	openssl x509 -in $@ -noout -text > $@.txt # for human inspection

${CNPEM}: ${CNKEY} ${CNCRT}
	cat ${CNKEY} ${CNCRT} > $@

################################################################################

.PHONY: install-ca-debian
install-ca-debian: ${CACRT}
	# https://superuser.com/questions/437330/how-do-you-add-a-certificate-authority-ca-to-ubuntu
	sudo mkdir -p ${CACRT_INSTALL_DIR}
	sudo cp $<  ${CACRT_INSTALL_DIR}/${CACRT_NAME}
	sudo update-ca-certificates
	# Check if this worked:
	grep "$$(cat $< | head -n 2 | tail -n 1)" \
		/etc/ssl/certs/ca-certificates.crt > /dev/null && echo OK || echo NOT FOUND

.PHONY: remove-ca-debian
remove-ca-debian:	
	sudo rm  ${CACRT_INSTALL_DIR}/${CACRT_NAME}
	sudo update-ca-certificates
	# Check if this worked:
	grep "$$(cat ${CACRT} | head -n 2 | tail -n 1)" \
		/etc/ssl/certs/ca-certificates.crt > /dev/null && echo ERROR Cert still active || echo OK



################################################################################

install-ca-osx: ${CACRT}
	# https://manuals.gfi.com/en/kerio/connect/content/server-configuration/ssl-certificates/adding-trusted-root-certificates-to-the-server-1605.html
	# sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" $<
