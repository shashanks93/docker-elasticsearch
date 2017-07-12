IMAGE=lukess/docker-graphite-grafana
VERSION=0.2.0

all:

.PHONY: build

.SILENT:

build:
	docker build --rm -t "$(IMAGE):$(VERSION)" .
