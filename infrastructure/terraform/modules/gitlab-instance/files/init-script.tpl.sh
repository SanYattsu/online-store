# Make certs

mkdir -p /run/secrets

## root
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
    -subj '/C=RU/O=MOMO Store/CN=Tarot CA' \
    -keyout /run/secrets/ca_root.key -out /run/secrets/ca_root.crt
## postgres
openssl req -new -nodes -text -out /run/secrets/gitlab.csr \
    -keyout /run/secrets/gitlab.key -subj "/C=RU/O=MOMO Store/CN=gitlab" \
    -addext "subjectAltName=IP:${host_ip},DNS:${dns}"
openssl x509 -req -in /run/secrets/gitlab.csr -text -days 365 \
    -CA /run/secrets/ca_root.crt -CAkey /run/secrets/ca_root.key -CAcreateserial \
    -extfile <(printf "subjectAltName=IP:${host_ip},DNS:${dns}") -out /run/secrets/gitlab.crt
## nginx
openssl req -new -nodes -text -out /run/secrets/nginx.csr \
    -keyout /run/secrets/nginx.key -subj "/C=RU/O=MOMO Store/CN=${host_ip}" \
    -addext "subjectAltName=IP:${host_ip},DNS:${dns}"
openssl x509 -req -in /run/secrets/nginx.csr -text -days 365 \
    -CA /run/secrets/ca_root.crt -CAkey /run/secrets/ca_root.key -CAcreateserial \
    -extfile <(printf "subjectAltName=IP:${host_ip},DNS:${dns}") -out /run/secrets/nginx.crt

chmod -R og-rwx /run/secrets