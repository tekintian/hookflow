COMMIT_HASH = $(shell git rev-parse HEAD)
BINARY_NAME = hookflow$(if $(filter windows,$(shell go env GOOS)),.exe,)

.PHONY: build
build:
	go build -ldflags "-s -w -X github.com/tekintian/hookflow/v1/internal/version.commit=$(COMMIT_HASH)" -o $(BINARY_NAME)

.PHONY: build-with-coverage
build-with-coverage:
	go build -cover -ldflags "-s -w -X github.com/tekintian/hookflow/v1/internal/version.commit=$(COMMIT_HASH)" -o $(BINARY_NAME)

.PHONY: jsonschema
jsonschema:
	go generate gen/jsonschema.go > schema.json
	go generate gen/jsonschema.go > internal/config/jsonschema.json

install: build
ifeq ($(shell go env GOOS),windows)
	powershell -Command "Copy-Item $(BINARY_NAME) $(shell go env GOPATH)\bin\$(BINARY_NAME)"
else
	cp $(BINARY_NAME) $$(go env GOPATH)/bin
endif

.PHONY: test
test:
	go test -cpu 24 -race -count=1 -timeout=30s ./...

.PHONY: test-integration
test-integration: install
	go test -cpu 24 -race -count=1 -timeout=30s -tags=integration integration_test.go

.PHONY: bench
bench:
	go test -cpu 24 -race -run=Bench -bench=. ./...

.PHONY: lint
lint: bin/golangci-lint
	bin/golangci-lint run --fix

bin/golangci-lint:
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b bin/ v2.7.1

.ONESHELL:
version:
	@read -p "New version: " version
	sed -i "s/const version = .*/const version = \"$$version\"/" internal/version/version.go
	sed -i "s/VERSION = .*/VERSION = \"$$version\"/" packaging/pack.rb
	sed -i "s/hookflow-plugin.git\", exact: \".*\"/hookflow-plugin.git\", exact: \"$$version\"/" docs/mdbook/installation/swift.md
	sed -i "s/go install github.com\/tekintian\/hookflow\/v1.*/go install github.com\/tekintian\/hookflow\/v1@v$$version/" docs/mdbook/installation/go.md
	sed -i "s/go install github.com\/tekintian\/hookflow\/v1.*/go install github.com\/tekintian\/hookflow\/v1@v$$version/" README.md
	ruby packaging/pack.rb clean set_version
	git add internal/version/version.go packaging/* docs/ README.md
