## `git_url`

A URL to Git repository. It will be accessed with privileges of the machine hookflow runs on.

**Example**

```yml
# hookflow.yml

remotes:
  - git_url: git@github.com:tekintian/hookflow
```

Or

```yml
# hookflow.yml

remotes:
  - git_url: https://github.com/tekintian/hookflow
```
