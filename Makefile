hosts:
	./scripts/hosts.sh

run:
	docker-compose up -d

wait:
	./scripts/wait.sh	

test: hosts run wait
	./scripts/test.sh

deploy:
	./scripts/deploy.sh
