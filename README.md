# devshells


# Python  
## - python-flake.nix 

> Implements python flake with automatic .venv implementation with pip install and stuff (flake is self explanatory)

## Devenv Implementation

https://devenv.sh/supported-languages/python/#languagespythonversion

### `languages.python.enable`
### `languages.python.poetry.enable`

### + .package siblings 

### `languages.python.libraries`  (probably not that thing)

Additional libraries to make available to the Python interpreter.

This is useful when you want to use Python wheels that depend on native libraries.

Type: list of path

Default: ` [ "${config.devenv.dotfile}/profile" ] `

Declared by: - https://github.com/cachix/devenv/blob/main/src/modules/languages/python.nix

### ` languages.python.venv.enable `

Whether to enable Python virtual environment.

Type: boolean

Default: false

Example: true

Declared by: - https://github.com/cachix/devenv/blob/main/src/modules/languages/python.nix

### `languages.python.venv.quiet`

Whether pip install should avoid outputting messages during devenv initialisation.

Type: boolean

Default: false

Declared by: - https://github.com/cachix/devenv/blob/main/src/modules/languages/python.nix

### `languages.python.venv.requirements`

Contents of pip requirements.txt file. This is passed to pip install -r during devenv shell initialisation.

Type: null or strings concatenated with “\n” or path

Default: null

Declared by: - https://github.com/cachix/devenv/blob/main/src/modules/languages/python.nix

### `languages.python.version`

The Python version to use. This automatically sets the languages.python.package using nixpkgs-python.

Type: null or string

Default: null

Example: "3.11 or 3.11.2"

Declared by: - https://github.com/cachix/devenv/blob/main/src/modules/languages/python.nix
