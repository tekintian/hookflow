## `configs`

**Default:** `[hookflow.yml]`

An optional array of config paths from remote's root.

**Example**

```yml
# hookflow.yml

remotes:
  - git_url: git@github.com:tekintian/hookflow
    ref: v1.0.0
    configs:
      - examples/ruby-linter.yml
      - examples/test.yml
```

Example with multiple remotes merging multiple configurations.

```yml
# hookflow.yml

remotes:
  - git_url: git@github.com:org/hookflow-configs
    ref: v1.0.0
    configs:
      - examples/ruby-linter.yml
      - examples/test.yml
  - git_url: https://github.com/org2/hookflow-configs
    configs:
      - hookflows/pre_commit.yml
      - hookflows/post_merge.yml
  - git_url: https://github.com/org3/hookflow-configs
    ref: feature/new
    configs:
      - configs/pre-push.yml

```
