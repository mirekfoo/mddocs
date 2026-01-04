help:
	@echo "Available targets:"
	@echo "  help                                     - Show this help message"
	@echo ""
	@echo "  deps-dev-install                         - Install dependencies for development"
	@echo "  deps-dev-update                          - Update dependencies for development"
	@echo ""
	@echo "  pyutils-dev-update                       - Update pyutils for development"	
	@echo ""
	@echo "  mkdocs CMD=build|serve|gh-deploy         - [Build / Serve/ Deploy to GitHub Pages] web docs using mkdocs"
	@echo "  mkdocs-clean                             - Clean the web docs"
	@echo ""
	@echo "  mddocs-build                             - Build markdown docs using mddocs"
	@echo "  mddocs-clean                             - Clean the markdown docs"
	@echo "  mddocs-run                               - Run again mddocs to update docs"	
	@echo ""
	@echo "  bumpver LEVEL=major|minor|patch          - Bump version"

# --------------------------------------------------

STAMP = @if [ ! -d ".stamps" ]; then mkdir -p ".stamps"; fi && touch $@

# --------------------------------------------------

PYUTILS_DEV_INSTALL = .stamps/pyutils-dev-install.done

$(PYUTILS_DEV_INSTALL):
	pip install -e deps/pyutils
	$(STAMP)

pyutils-dev-install: $(PYUTILS_DEV_INSTALL)

pyutils-dev-update: $(PYUTILS_DEV_INSTALL)
	pushd deps/pyutils && git switch main && git pull && popd

deps-dev-install: pyutils-dev-install
deps-dev-update: pyutils-dev-update

# --------------------------------------------------

PYUTILS_INSTALL = $(PYUTILS_DEV_INSTALL)

# --------------------------------------------------

MDDOCS_INSTALL = .stamps/mddocs-install.done

$(MDDOCS_INSTALL):
	pip install pydoc-markdown 
	$(STAMP)
MDDOCS_DIR = docs-md

PROJECT_SRC := $(wildcard src/mddocs/*.py)

MDDOCS_GENERATE = .stamps/mddocs_generate.done

PYDOC_MARKDOWN_GENERATE = .stamps/pydoc-markdown_generate.done

$(PYDOC_MARKDOWN_GENERATE): $(MDDOCS_INSTALL) $(MDDOCS_DIR) 
	pushd $(MDDOCS_DIR) && pydoc-markdown && popd 
	$(STAMP)

$(MDDOCS_GENERATE): $(PYUTILS_INSTALL) $(MDDOCS_INSTALL) $(PROJECT_SRC)
	PYTHONPATH=./src python -m mddocs 
	$(STAMP)
	
mddocs-build: \
	$(MDDOCS_GENERATE)

mddocs-clean:
	rm -rf $(MDDOCS_DIR)
	rm -f $(MDDOCS_GENERATE)

mddocs-run: \
	mddocs-clean \
	$(MDDOCS_GENERATE)

# --------------------------------------------------

BUMPVER_INSTALL = .stamps/bumpver-install.done

$(BUMPVER_INSTALL):
	pip install bumpver 
	$(STAMP)

bumpver: $(BUMPVER_INSTALL)
	bumpver update --$(LEVEL)
