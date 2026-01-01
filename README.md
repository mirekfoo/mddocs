# mddocs
Markdown Documentation generator for python projects

# Intro

...

* This solution is build on top of [pydoc_markdown](https://github.com/NiklasRosenstein/pydoc-markdown) [docusaurus]() .

# Usage

## Setup

* Install mddocs:
```bash
pip install git+https://github.com/mirekfoo/mddocs.git
```

* Create `mddocs.yml` file in the root of your project. 
    - See examples:
        - [mddocs.yml](./mddocs.yml) for this project.
        - [mddocs.yml](https://github.com/mirekfoo/mddocs-test/blob/main/mddocs.yml) for [test](https://github.com/mirekfoo/mddocs-test) project.
    - For `pydoc_markdown` section refer to [pydoc_markdown docs](https://niklasrosenstein.github.io/pydoc-markdown/) .
    - 

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

Docs|
---|
[Markdown docs](docs-md/docs/index.md)

# Project Development

* Type `make help` for available **dev** procedures
