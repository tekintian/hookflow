## `HOOKFLOW_BIN`

Set `HOOKFLOW_BIN` to a location where hookflow is installed to use that instead of trying to detect from the it the PATH or from a package manager.

Useful for cases when:

- hookflow is installed multiple ways, and you want to be explicit about which one is used (example: installed through homebrew, but also is in Gemfile but you are using a ruby version manager like rbenv that prepends it to the path)
- debugging and/or developing hookflow
