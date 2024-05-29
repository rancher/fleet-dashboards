build: dashboard.jsonnet
	jsonnet -J vendor dashboard.jsonnet | tee dashboard.json

deps-grafonnet:
	jb install github.com/grafana/grafonnet/gen/grafonnet-latest@main

deps-json-bundler:
	go install -a github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

deps-jsonnet:
	go install github.com/google/go-jsonnet/cmd/jsonnet@latest
	go install github.com/google/go-jsonnet/cmd/jsonnet-lint@latest


deps: deps-grafonnet deps-json-bundler deps-jsonnet

