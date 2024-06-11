build: dashboards/*.jsonnet
	mkdir -p out; \
	for file in $(shell ls dashboards/*.jsonnet); do \
		echo "Building $${file}"; \
		filename=$$(basename $${file%.jsonnet}); \
		jsonnet -J vendor $$file > out/$${filename}.json; \
	done

cm: configmap

configmap: build
	kubectl create configmap rancher-fleet-dashboards \
		--from-file=out/ \
		--dry-run=client \
		-o yaml > configmap.yaml || (echo "Error: Failed to create configmap"; exit 1)

configmap-debug-labels: configmap
	yq eval " \
		.metadata.labels.app = \"rancher-monitoring-grafana\" | \
	  	.metadata.labels.\"app.kubernetes.io/instance\" = \"rancher-monitoring\" | \
	  	.metadata.labels.\"app.kubernetes.io/managed-by\" = \"Helm\" | \
	  	.metadata.labels.\"app.kubernetes.io/part-of\" = \"rancher-monitoring\" | \
	  	.metadata.labels.\"app.kubernetes.io/version\" = \"104.0.0-rc1_up45.31.1\" | \
	  	.metadata.labels.chart = \"rancher-monitoring-104.0.0-rc1_up45.31.1\" | \
	  	.metadata.labels.grafana_dashboard = \"1\" | \
	  	.metadata.labels.heritage = \"Helm\" | \
	  	.metadata.labels.release = \"rancher-monitoring\" | \
	  	.metadata.namespace = \"cattle-dashboards\" \
	" -i configmap.yaml

cma: configmap-apply

configmap-apply: configmap-debug-labels
	kubectl apply -f configmap.yaml

clean:
	rm -rf out/
	rm configmap.yaml

clean-deps: clean
	rm -rf vendor/

deps: deps-json-bundler deps-jsonnet deps-grafonnet

deps-jsonnet:
	go install github.com/google/go-jsonnet/cmd/jsonnet@latest
	go install github.com/google/go-jsonnet/cmd/jsonnet-lint@latest

deps-json-bundler:
	go install -a github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

deps-grafonnet:
	jb init || true
	jb install github.com/grafana/grafonnet/gen/grafonnet-latest@main
