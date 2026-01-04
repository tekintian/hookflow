## `refetch`

**Default:** `false`

Force remote config refetching on every run. Hookflow will be refetching the specified remote every time it is called.

**Example**

```yml
# hookflow.yml

remotes:
  - git_url: https://github.com/tekintian/hookflow
    refetch: true
```
