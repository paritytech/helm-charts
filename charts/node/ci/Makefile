cluster-create:
	kind create cluster --config ../../chart-testing/kind-config.yaml --name node-testing --wait 5m
test:
	docker build -f addons/nginx-assets-server/nginx-assets-server.Dockerfile -t nginx-assets-server:latest addons/nginx-assets-server
	kind load docker-image --name chart-testing docker.io/library/nginx-assets-server:latest
	./run-tests.sh
clean:
	kind delete cluster --name node-testing
