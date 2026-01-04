---
sidebar_label: mddocs
title: mddocs.mddocs
---

MDDocs main entry point.

#### run

```python
def run() -> int
```

Run the main function.

This function performs the following steps:
1. Initializes the Jinja2 environment and global functions.
2. Parses command-line arguments.
3. Loads the &#x27;mddocs.yml&#x27; configuration file.
4. Prepares the documentation output directory.
5. Expands templates in the configuration and writes &#x27;pydoc-markdown.yml&#x27;.
6. Ensures a &#x27;sidebar.json&#x27; exists to work around pydoc-markdown issues.
7. Executes the &#x27;pydoc-markdown&#x27; tool.
8. Generates the reference index markdown table.

**Returns**:

  The exit code of the program.

#### main

```python
def main() -> int
```

Main entry point of the program.

**Returns**:

  The exit code of the program.

