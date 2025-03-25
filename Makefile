PHONY: run
run:
	npm run dev

PHONY: run-docker
run-docker:
	docker run -it --rm \
		--workdir /home/node/riptides.io \
		-v $(PWD):/home/node/riptides.io:rw \
		-p 4321:4321 \
		node:latest \
		bash -c 'npm install && npm run dev -- --host'
