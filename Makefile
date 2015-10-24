DOCKER_IMG="kkleidal/lamp"

CID := $(shell cat run 2>/dev/null)

ifndef $(HOST)
	HOST := 0.0.0.0
endif

ifndef $(PORT)
	PORT := 80
endif

build:
	docker build -t $(DOCKER_IMG) . && touch build

run: build
	docker run -d -p '$(HOST):$(PORT):80' --volume '$(shell pwd)/app:/app' "$(DOCKER_IMG)" > $@

stop: run
	docker stop $(CID)

rm: run
	$(RM) $<
	docker rm $(CID)

forceclean:
	$(RM) run build

all: build
