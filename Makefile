build-dashboards: dashboards/*.jsonnet
	mkdir -p out; \
	for file in $(shell ls dashboards/*.jsonnet); do \
		echo "Building $${file}"; \
		filename=$$(basename $${file%.jsonnet}); \
		jsonnet -J vendor $$file > out/$${filename}.json || exit 1; \
	done

build-configmap:
	kubectl create configmap rancher-fleet-dashboards \
		--from-file=out/ \
		--dry-run=client \
		-o yaml > configmap.yaml || (echo "Error: Failed to create configmap"; exit 1)

patch-configmap:
	yq eval " \
		.metadata.labels.app = \"rancher-monitoring-grafana\" | \
	  	.metadata.labels.grafana_dashboard = \"1\" | \
	  	.metadata.labels.release = \"rancher-monitoring\" | \
	  	.metadata.namespace = \"cattle-dashboards\" \
	" -i configmap.yaml

configmap-apply:
	kubectl apply -f configmap.yaml

configmap: build-configmap patch-configmap configmap-apply

debug: build-dashboards configmap

clean:
	rm -rf out/
	rm configmap.yaml

clean-deps:
	rm -rf vendor/

clean-all: clean clean-deps

deps: deps-json-bundler deps-jsonnet deps-grafonnet

deps-jsonnet:
	go install github.com/google/go-jsonnet/cmd/jsonnet@latest
	go install github.com/google/go-jsonnet/cmd/jsonnet-lint@latest

deps-json-bundler:
	go install -a github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

deps-grafonnet:
	jb init || true
	jb install github.com/grafana/grafonnet/gen/grafonnet-latest@main
