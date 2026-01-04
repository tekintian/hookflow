## `ref`

An optional *branch* or *tag* name.

> **Note:** If you initially had `ref` option, ran `hookflow install`, and then removed it, hookflow won't decide which branch/tag to use as a ref. So, if you added it once, please, use it always to avoid issues in local setups.

**Example**

```yml
# hookflow.yml

remotes:
  - git_url: git@github.com:tekintian/hookflow
    ref: v1.0.0
```
