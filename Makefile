build: *.jsonnet
	mkdir -p dashboards
	for file in $(shell find . -name '*.jsonnet'); do \
		jsonnet -J vendor $$file | tee dashboards/$${file%.jsonnet}.json; \
	done

deps-grafonnet:
	jb install github.com/grafana/grafonnet/gen/grafonnet-latest@main

deps-json-bundler:
	go install -a github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

deps-jsonnet:
	go install github.com/google/go-jsonnet/cmd/jsonnet@latest
	go install github.com/google/go-jsonnet/cmd/jsonnet-lint@latest

deps: deps-grafonnet deps-json-bundler deps-jsonnet

