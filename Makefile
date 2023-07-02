# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOMOD=$(GOCMD) mod
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test -race -test.timeout 120s -v
GOGENERATE=$(GOCMD) generate
GOINSTALL=$(GOCMD) install
GOGET=$(GOCMD) get
BINARY_NAME=cmd/client/client.go cmd/server/server.go cmd/pkg/datos/datos.go
BINARY_UNIX=$(BINARY_NAME)_unix

all: test build

build: generate
	$(GOBUILD) -o . ./...

test: generate
	$(GOTEST) ./...

generate: 
	$(GOGENERATE) ./...

clean: 
	$(GOCLEAN) -i ./...

clean-cache: 
	$(GOCLEAN) -cache

clean_cache: 
	$(GOCLEAN) -cache
	$(GOMOD) tidy

install: 
	$(GOINSTALL) ./...

run:
	$(GOBUILD) -o $(BINARY_NAME) -v ./...
	./$(BINARY_NAME)

deps:
	$(GOGET) github.com/markbates/goth
	$(GOGET) github.com/markbates/pop


# Cross compilation
build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_UNIX) -v
docker-build:
	docker run --rm -it -v "$(GOPATH)":/go -w /go/src/bitbucket.org/rsohlich/makepost golang:latest go build -o "$(BINARY_UNIX)" -v
