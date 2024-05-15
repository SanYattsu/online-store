FROM golang:1.22.2-bookworm
WORKDIR /opt/app

COPY . .

ENTRYPOINT [ "go" ]
CMD [ "run", "./cmd/api" ]