# mddocs
Python project API Markdown Documentation generator.

# Intro

* Since modern platfroms such as **code repoitories**, **IDE**(s), **web browsers** can render Markdown files - the project docs just in Markdown become an alternative to HTML docs.
* This project focuses on providing a complete set of markdown files for full navigation to all documentation pages.
    - In it's final step it will generate the main `index.md` file upon [pydoc_markdown](https://github.com/NiklasRosenstein/pydoc-markdown) [docusaurus](https://niklasrosenstein.github.io/pydoc-markdown/api/pydoc_markdown/renderers/docusaurus/) generated `sidebar.json` file.
* This solution is build on top of [pydoc_markdown](https://github.com/NiklasRosenstein/pydoc-markdown) [docusaurus](https://niklasrosenstein.github.io/pydoc-markdown/api/pydoc_markdown/renderers/docusaurus/).


# Usage

## Setup

* Install `mddocs`:
```bash
pip install git+https://github.com/mirekfoo/mddocs.git
```

* Create `mddocs.yml` file in the root of your project. 
    - See examples:
        - [mddocs.yml](./mddocs.yml) for this project.
        - [mddocs.yml](https://github.com/mirekfoo/mddocs-test/blob/main/mddocs.yml) for [test](https://github.com/mirekfoo/mddocs-test) project.
    - For `pydoc_markdown` section refer to [pydoc_markdown docs](https://niklasrosenstein.github.io/pydoc-markdown/).

## Generate docs

* Run:
```bash
mddocs
```

## Tips

* Set `pydoc_markdown.loaders.search_path` to include your source code directory.
* You can use [jinja2]() templates in the `pydoc_markdown` section of `mddocs.yml`.
* Your source module(s) must have `__init__.py` file to be detected for the docs generation.
* Set `pydoc_markdown.processors.skip_empty_modules` to `true` to include modules without *docstrings*.

## Example projects using mddocs

* [mddocs-test](https://github.com/mirekfoo/mddocs-test)

# Dev Docs

Docs|Remarks
---|---
[Markdown docs](docs-md/docs/index.md)|Generated using [mddocs](https://github.com/mirekfoo/mddocs)

# Project Development

## Submodules

The following submodules were added to this project:

```bash
git submodule add https://github.com/mirekfoo/pyutils.git deps/pyutils
```

## Clone repository
```bash
git clone --recurse-submodules https://github.com/mirekfoo/mddocs.git
```

## Run procedures
* Type `make help` for available **dev** procedures
