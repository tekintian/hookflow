## `hookflow install`

Creates an empty `hookflow.yml` if a configuration file does not exist.

Installs configured hooks to Git hooks.

> **Note:** NPM package `hookflow` installs the hooks in a postinstall script automatically. For projects not using NPM package run `hookflow install` after cloning the repo.

### Installing specific hooks

You can install only specific hooks by running `hookflow install <hook-1> <hook-2> ...`.
