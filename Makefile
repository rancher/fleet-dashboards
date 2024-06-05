build: dashboards/*.jsonnet
	mkdir -p out
	for file in $(shell ls dashboards/*.jsonnet); do \
		filename=$$(basename $${file%.jsonnet}); \
		jsonnet -J vendor $$file | tee out/$${filename}.json; \
	done

clean:
	rm -rf out/

clean-deps: clean
	rm -rf vendor/

deps-jsonnet:
	go install github.com/google/go-jsonnet/cmd/jsonnet@latest
	go install github.com/google/go-jsonnet/cmd/jsonnet-lint@latest

deps-json-bundler:
	go install -a github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

deps-grafonnet:
	jb init || true
	jb install github.com/grafana/grafonnet/gen/grafonnet-latest@main

deps: deps-json-bundler deps-jsonnet deps-grafonnet
