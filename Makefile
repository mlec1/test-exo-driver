NAME:=exo2

# local build, use user and timestamp it
BINARY_NAME ?= ${NAME}
VERSION:=$(shell  date +%Y%m%d%H%M%S)

DIST_DIR:=dist
GO ?= go

.PHONY: all
all: build

#
# Docker-related tasks
#
build:
	mkdir -p ${DIST_DIR}
	GO111MODULE=on GOOS=linux GOARCH=amd64 go build -buildvcs=false -o ${DIST_DIR}/docker-machine-driver-${BINARY_NAME}-linux .
	GO111MODULE=on GOOS=linux GOARCH=arm64 go build -buildvcs=false -o ${DIST_DIR}/docker-machine-driver-${BINARY_NAME}-linux-arm64 .
	GO111MODULE=on GOOS=darwin GOARCH=amd64 go build -buildvcs=false -o ${DIST_DIR}/docker-machine-driver-${BINARY_NAME}-darwin .
	shasum -a 256 ${DIST_DIR}/*