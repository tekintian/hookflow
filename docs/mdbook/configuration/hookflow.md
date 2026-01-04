## `hookflow`

**Default:** `null`

> Added in hookflow `1.10.5`

Provide a full path to hookflow executable or a command to run hookflow. Bourne shell (`sh`) syntax is supported.

> **Important:** This option does not merge from `remotes` or `extends` for security reasons. But it gets merged from hookflow local config if specified.

There are three reasons you may want to specify `hookflow`:

1. You want to force using specific hookflow version from your dependencies (e.g. npm package)
1. You use PnP loader for your JS/TS project, and your `package.json` with hookflow dependency locates in a subfolder
1. You want to make sure you use concrete hookflow executable path and want to defined it in `hookflow-local.yml`

### Examples

#### Specify hookflow executable

```yml
# hookflow.yml

hookflow: /usr/bin/hookflow

pre-commit:
  jobs:
    - run: yarn lint
```

#### Specify a command to run hookflow

```yml
# hookflow.yml

hookflow: |
  cd project-with-hookflow
  pnpm hookflow

pre-commit:
  jobs:
    - run: yarn lint
      root: project-with-hookflow
```

#### Force using a version from Rubygems

```yml
# hookflow.yml

hookflow: bundle exec hookflow

pre-commit:
  jobs:
    - run: bundle exec rubocop {staged_files}
```

#### Enable debug logs

```yml
# hookflow-local.yml

hookflow: hookflow --verbose
```
