help:
	@echo "Available targets:"
	@echo "  help                                     - Show this help message"
	@echo ""
	@echo "  mkdocs CMD=build|serve|gh-deploy         - [Build / Serve/ Deploy to GitHub Pages] web docs using mkdocs"
	@echo "  mkdocs-clean                             - Clean the web docs"
	@echo ""
	@echo "  mddocs-build                             - Build markdown docs using mddocs"
	@echo "  mddocs-clean                             - Clean the markdown docs"
	@echo ""
	@echo "  bumpver LEVEL=major|minor|patch          - Bump version"
	
# --------------------------------------------------

MKDOCS_INSTALL = mkdocs-install.done

$(MKDOCS_INSTALL):
	pip install mkdocs mkdocs-material mkdocstrings[python] mkdocs-gen-files 
	touch $(MKDOCS_INSTALL)

MKDOCS_DIR = docs-web

$(MKDOCS_DIR):
	@if [ ! -d "$(MKDOCS_DIR)" ]; then mkdir -p "$(MKDOCS_DIR)"; fi

mkdocs: $(MKDOCS_INSTALL) $(MKDOCS_DIR)
	PYTHONPATH=./src mkdocs $(CMD)

mkdocs-clean:
	rm -rf $(MKDOCS_DIR)
	rm -rf docs-web-site

# --------------------------------------------------

MDDOCS_INSTALL = mddocs-install.done

$(MDDOCS_INSTALL):
	pip install pydoc-markdown 
	touch $(MDDOCS_INSTALL)

MDDOCS_DIR = docs-md

#$(MDDOCS_DIR):
#	@if [ ! -d "$(MDDOCS_DIR)" ]; then mkdir -p "$(MDDOCS_DIR)"; fi

#mddocs-bootstrap: $(MDDOCS_INSTALL) $(MDDOCS_DIR)
#	pushd $(MDDOCS_DIR) && pydoc-markdown --bootstrap docusaurus && popd

PROJECT_SRC := $(wildcard src/mddocs/*.py)

MDDOCS_GENERATE = mddocs_generate.done

PYDOC_MARKDOWN_GENERATE = pydoc-markdown_generate.done

pydoc-markdown-generate: $(MDDOCS_INSTALL) $(MDDOCS_DIR) $(PYUTILS)
	pushd $(MDDOCS_DIR) && pydoc-markdown && popd 

$(MDDOCS_GENERATE): $(MDDOCS_INSTALL) $(PROJECT_SRC)
	PYTHONPATH=./src python -m mddocs 
	touch $(MDDOCS_GENERATE)

#MDDOCS_INDEX_MD_TABLE = mddocs_index_md_table.done

# $(MDDOCS_INDEX_MD_TABLE): $(MDDOCS_GENERATE)
# 	python scripts/mddocs/gen_index_md_table.py \
# 		--sidebar $(MDDOCS_DIR)/docs/reference/sidebar.json \
# 		--docs-root $(MDDOCS_DIR)/docs \
# 		--out $(MDDOCS_DIR)/docs/index.md

mddocs-build: \
	$(MDDOCS_GENERATE)

mddocs-clean:
	rm -rf $(MDDOCS_DIR)
	rm -f $(MDDOCS_GENERATE)

mddocs-run: \
	mddocs-clean \
	$(MDDOCS_GENERATE)

# --------------------------------------------------

BUMPVER_INSTALL = bumpver-install.done

$(BUMPVER_INSTALL):
	pip install bumpver 
	touch $(BUMPVER_INSTALL)

bumpver: $(BUMPVER_INSTALL)
	bumpver update --$(LEVEL)
