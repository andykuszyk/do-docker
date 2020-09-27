hosts:
	./hosts.sh

run:
	docker-compose up -d

sleep:
	sleep 5

test: hosts run sleep
	./test.sh
