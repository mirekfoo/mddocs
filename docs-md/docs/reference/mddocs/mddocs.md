---
sidebar_label: mddocs
title: mddocs.mddocs
---

MDDocs main entry point.

#### relative\_to

```python
def relative_to(master_path: str, slave_path: str) -> str
```

Calculate the relative path from master_path to slave_path.

**Arguments**:

- `master_path` - The base directory path.
- `slave_path` - The target path to make relative.
  

**Returns**:

  The relative path from master_path to slave_path.

#### expandTemplatesInStr

```python
def expandTemplatesInStr(s: str, args: Dict) -> str
```

Expand Jinja2 templates in a string using the provided arguments.

**Arguments**:

- `s` - The string containing Jinja2 templates.
- `args` - A dictionary of arguments to use for template expansion.
  

**Returns**:

  The rendered string with templates expanded.

#### expandTemplates

```python
def expandTemplates(o: Any, args: Dict) -> Any
```

Expand Jinja2 templates in an object using the provided arguments.

**Arguments**:

- `o` - The object containing Jinja2 templates.
- `args` - A dictionary of arguments to use for template expansion.
  

**Returns**:

  The rendered object with templates expanded.

#### read\_config\_arg

```python
def read_config_arg(args: Dict, arg: str, defval: Any) -> Any
```

Read a configuration argument from a dictionary.

**Arguments**:

- `args` - The dictionary containing configuration arguments.
- `arg` - The key to look for in the dictionary.
- `defval` - The default value to return if the key is not found. If None, the argument is required.
  

**Returns**:

  The value associated with the key or the default value.

#### read\_config\_harg

```python
def read_config_harg(args: Dict, arg: str, defval: Any) -> Any
```

Read a hierarchical configuration argument from a dictionary.

**Arguments**:

- `args` - The dictionary containing configuration arguments.
- `arg` - The dot-separated key to look for in the dictionary.
- `defval` - The default value to return if the key is not found. If None, the argument is required.
  

**Returns**:

  The value associated with the key or the default value.

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

