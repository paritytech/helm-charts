cluster-create:
	kind create cluster --config ../../chart-testing/kind-config.yaml --name node-testing --wait 5m
test:
	docker build -f tick-collator-backup.Dockerfile -t tick-collator-backup:latest .
	kind load docker-image --name chart-testing docker.io/library/tick-collator-backup:latest
	./run-tests.sh
clean:
	kind delete cluster --name node-testing
