hosts:
	./hosts.sh

run:
	docker-compose up -d

wait:
	./wait.sh	

test: hosts run wait
	./test.sh
