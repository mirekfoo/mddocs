
"""MDDocs main entry point."""

import sys
import argparse
from pathlib import Path
import yaml

def main() -> int:
    p = argparse.ArgumentParser(description="Generate markdown docs for python project.")
    args = p.parse_args()

    mddocs_yml = Path("mddocs.yml")
    if not mddocs_yml.exists():
        raise SystemExit(f"mddocs.yml not found: {mddocs_yml}")

    config = yaml.safe_load(mddocs_yml.read_text())
    print(type(config))
    print(config)

    return 0


if __name__ == "__main__":
    sys.exit(main())
