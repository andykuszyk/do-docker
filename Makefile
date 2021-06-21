hosts:
	./scripts/hosts.sh

run: hosts
	docker-compose up -d

restart: down run

down:
	docker-compose down

wait:
	./scripts/wait.sh	

test: run wait
	./scripts/test.sh

deploy:
	./scripts/deploy.sh

release-service:
	./scripts/release-service.sh $(SERVICE) $(TAG)

install-yq:
	wget https://github.com/mikefarah/yq/releases/download/3.4.0/yq_linux_amd64
	chmod +x yq_linux_amd64
	sudo mv yq_linux_amd64 /usr/bin/yq

clean-data-volumes:
	rm -rf ./volumes
	mkdir -p ./volumes/opencart
	mkdir -p ./volumes/mariadb/data
