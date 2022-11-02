#!make
DEST=tree-sitter-reason
grammar=$(DEST)/grammar.js

all: clean pull

.PHONY: clean
clean:
	rm -rf $(DEST)/*
include .env
export


$(grammar): $(TS_REASON_DIR)/grammar.js
	$(cd ${TS_REASON_DIR} && make)

.PHONY: pull
pull: $(grammar)
	@if [ -z "$${TS_REASON_DIR}" ]; then \
	    echo "Environment variable TS_REASON_DIR not set"; \
	    exit 1; \
	fi
	cp -R ${TS_REASON_DIR}/{binding.gyp,Cargo.toml,grammar.js,bindings,src} $(DEST)/
	cp ${TS_REASON_DIR}/queries/* queries/reason/
