## `exclude_tags`

[Tags](./tags.md) or command names that you want to exclude. This option can be overwritten with `HOOKFLOW_EXCLUDE` env variable.

**Example**

```yml
# hookflow.yml

pre-commit:
  exclude_tags: frontend
  commands:
    lint:
      tags: frontend
      ...
    test:
      tags: frontend
      ...
    check-syntax:
      tags: documentation
```

```bash
hookflow run pre-commit # will only run check-syntax command
```

**Notes**

This option is good to specify in `hookflow-local.yml` when you want to skip some execution locally.

```yml
# hookflow.yml

pre-push:
  commands:
    packages-audit:
      tags:
        - frontend
        - security
      run: yarn audit
    gems-audit:
      tags:
        - backend
        - security
      run: bundle audit
```

You can skip commands by tags:

```yml
# hookflow-local.yml

pre-push:
  exclude_tags:
    - frontend
```
