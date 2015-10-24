DOCKER_IMG="kkleidal/lamp"

CID := $(shell cat run 2>/dev/null)

build:
	docker build -t $(DOCKER_IMG) . && touch build

run: build
	docker run -d -p '0.0.0.0:8080:80' --volume '$(pwd)/app:/app' "$(DOCKER_IMG)" > $@

stop: run
	docker stop $(CID)

rm: run
	$(RM) $<
	docker rm $(CID)

forceclean:
	$(RM) run build

all: build
