## `no_auto_install`

**Default: `false`**

Disable automatic installation and synchronization of git hooks when running hookflow. By default, hookflow automatically installs and updates hooks when you run `hookflow run` if the configuration has changed. Setting this to `true` disables that behavior.

This can also be controlled with the `--no-auto-install` option for the `hookflow run` command.

**Example**

```yml
# hookflow.yml

no_auto_install: true

pre-commit:
  commands:
    lint:
      run: npm run lint
```
