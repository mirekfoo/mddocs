
"""MDDocs main entry point."""

import sys
import argparse
from pathlib import Path
import yaml
import shutil
import subprocess
from typing import List, Dict, Any
from jinja2 import Template, Environment

from pyutils import config_util, jinja2_util

jinja2_env = None

def relative_to(master_path: str, slave_path: str) -> str:
    """
    Calculate the relative path from master_path to slave_path.

    Args:
        master_path: The base directory path.
        slave_path: The target path to make relative.

    Returns:
        The relative path from master_path to slave_path.
    """
    
    rel_path =  Path(slave_path).relative_to(master_path, walk_up=True)
    return rel_path


def run() -> int:
    """
    Run the main function.

    This function performs the following steps:
    1. Initializes the Jinja2 environment and global functions.
    2. Parses command-line arguments.
    3. Loads the 'mddocs.yml' configuration file.
    4. Prepares the documentation output directory.
    5. Expands templates in the configuration and writes 'pydoc-markdown.yml'.
    6. Ensures a 'sidebar.json' exists to work around pydoc-markdown issues.
    7. Executes the 'pydoc-markdown' tool.
    8. Generates the reference index markdown table.

    Returns:
        The exit code of the program.
    """
    # 1. Initializes the Jinja2 environment and global functions.
    global jinja2_env
    jinja2_env = Environment()
    jinja2_env.globals["relative_to"] = relative_to

    # 2. Parses command-line arguments.
    p = argparse.ArgumentParser(
        description=(
            "Generate markdown docs for python project.\n"
            "See https://github.com/mirekfoo/mddocs/blob/main/README.md for more information."
            ),
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    args = p.parse_args()

    # 3. Loads the 'mddocs.yml' configuration file.
    mddocs_yml = Path("mddocs.yml")
    if not mddocs_yml.exists():
        raise SystemExit(f"File not found: {mddocs_yml}")

    config = yaml.safe_load(mddocs_yml.read_text())

    src_root = config_util.read_config_arg(config, "src_root", "src")
    docs_root = config_util.read_config_arg(config, "docs_root", "docs-md")
    index_md = config_util.read_config_arg(config, "index_md", "index.md")
    docs_dir = config_util.read_config_harg(config, "pydoc_markdown.renderer.docs_base_path", "docs")    
    docs_reference_dir = config_util.read_config_harg(config, "pydoc_markdown.renderer.relative_output_path", "reference")    
    pydoc_markdown = config_util.read_config_arg(config, "pydoc_markdown", {})

    # 4. Prepares the documentation output directory.
    docs_root_path = Path(docs_root)
    docs_root_path.mkdir(parents=True, exist_ok=True)

    # 5. Expands templates in the configuration and writes 'pydoc-markdown.yml'.
    pydoc_markdown = jinja2_util.expandTemplates(pydoc_markdown, config, jinja2_env)

    with open(Path(docs_root, "pydoc-markdown.yml"), "w") as f:
        yaml.dump(pydoc_markdown, f)

    docs_path = Path(docs_root, docs_dir)
    docs_reference_path = Path(docs_root, docs_dir, docs_reference_dir)
    docs_reference_path.mkdir(parents=True, exist_ok=True)

    # 6. Ensures a 'sidebar.json' exists to work around pydoc-markdown issues.
    sidebar_json_empty_file = Path(Path(__file__).parent, "sidebar.json")
    if not sidebar_json_empty_file.exists():
        print(f"Error: Missing install file: {sidebar_json_empty_file}")
        sys.exit(1)

    # This is workaround for pydoc-markdown bug:
    #  if none python module has any object docstrings (module docstrings do not help) -> no doc info is collected -> no {docs_root}/docs/reference/sidebar.json is created,
    #  then internal error is thrown
    # So here we put empty {docs_root}/docs/reference/sidebar.json if it does not exist yet
    docs_reference_sidebar_json_file = Path(docs_reference_path, "sidebar.json")
    if not docs_reference_sidebar_json_file.exists():
        shutil.copy(sidebar_json_empty_file, docs_reference_sidebar_json_file)

    # 7. Executes the 'pydoc-markdown' tool.
    print(f"Running pydoc-markdown in {docs_root} ...")
    result = subprocess.run(["pydoc-markdown"], cwd=docs_root)
    if result.returncode != 0:
        return result.returncode
    
    # 8. Generates the reference index markdown table.
    docs_reference_index_md_file = Path(docs_path, index_md)
    print(f"Generating {docs_reference_index_md_file} ...")
    result = subprocess.run([sys.executable, "-m", "mddocs.gen_index_md_table", "--sidebar", docs_reference_sidebar_json_file, "--docs-dir", docs_path, "--out", docs_reference_index_md_file])
    if result.returncode != 0:
        return result.returncode

    return 0

def main() -> int:
    """
    Main entry point of the program.

    Returns:
        The exit code of the program.
    """
    try:
        return run()
    except Exception as e:
        print(f"Error: {e}")
        return 1


if __name__ == "__main__":
    sys.exit(main())
